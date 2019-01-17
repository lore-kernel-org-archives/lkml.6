Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08EDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766F220851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rheFNBYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfAQUDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:03:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46451 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbfAQUDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:03:00 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so5209093ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 12:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=a5n+9cXuiReBmKMc3Oq/wS2cWI61cMsEiCRcODxIuWQ=;
        b=rheFNBYiKCzvOH8OmfbzsLYpEez+E/fcQ/Hy0hFQ3F5G4hwdCZFMYYsHHhk3EqnFfP
         hgD7dktKyzYmOIxw05MaOgQQp3QwTvQ8KTDuPDDioRkdcYMJ1fw28tAh89znodsuX3Og
         82m9G92rf+K2n3OuykUMdL1XSHw3Ni0E5fFkFav3Acq0nd8+9pQgn/z41R2omGQZuhfc
         gwd1VtjCsGG7drkyIlO0yhJnlAKettACdBSdEEqhOD6w9LHGFp7XkmQ5DttgRfWekCv7
         n2oerTjBO2L+2tUN0OCPQDjQjaf/lPgYMcgVrxFyjqzGUUu7Egb5QwMJ9fECJFyeUqbJ
         LvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=a5n+9cXuiReBmKMc3Oq/wS2cWI61cMsEiCRcODxIuWQ=;
        b=Y0tY3CfeSsxtEHESn8xW0PtwMUK+uIV1WtuL02zDCzu+bYl7S3PA80rN16sXZI3R6c
         Lhypm6UC3JwEuVfaGjjrUkvcqO2SnEg1nXgvkof7lg1u+0IekgkRWu9VXCvqe9hH4lC0
         ezPIg+fc+9CMpYlqch2RVJyulXd+3VK9k+QC6k3zVIu/3ifGH7fngj+8IF5zxMTVRQBl
         TkNckKN9ieihHVTfPebzJpG6IOjLchd76UOEHq+XVL1Uur77Bi/wi2QI6ID+MA7moVz+
         gTiFKPzeFCrqc2sa15ZzTOaN8Fxe3xN8iKAjq6pMYvcDHL4SGV+MxmVJyOheVUrEm9iP
         xVZg==
X-Gm-Message-State: AJcUukdeLW7IQH1GK9+WlmjYr2nbzvTlVu4BT1bVflHjWMRn7JAk5iq2
        n0VUeYuF+3l+m+Qw9NycCVg4uA==
X-Google-Smtp-Source: ALg8bN5TFo0cKp5d6oEjtLTGdCmWvWPYIxdF5b8A/fICP7RwXjsAXp5onkINseFCbKAToJAENcBHfQ==
X-Received: by 2002:a17:902:2aaa:: with SMTP id j39mr16687351plb.335.1547755379606;
        Thu, 17 Jan 2019 12:02:59 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:e076:9fe9:59e2:1e0b])
        by smtp.googlemail.com with ESMTPSA id v72sm4720928pfd.163.2019.01.17.12.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 12:02:58 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: fix g12a buses
In-Reply-To: <20190116165236.8330-1-jbrunet@baylibre.com>
References: <20190116165236.8330-1-jbrunet@baylibre.com>
Date:   Thu, 17 Jan 2019 12:02:57 -0800
Message-ID: <7hy37jaw7i.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> periph and hiu bus addresses/size are wrong.
> cbus, aobus and apb just don't exist in the memory map so remove them.
>
> Fixes: 9c8c52f7cb4f ("arm64: dts: meson-g12a: add initial g12a s905d2 SoC DT support")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued as a fix for v5.0-rc (branch: v5.0/fixes)

Kevin
