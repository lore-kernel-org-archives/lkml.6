Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC89C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356952086D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GhyNrPbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbfAQTz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:55:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33137 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbfAQTz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:55:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so5234555plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 11:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=csQggusV1GzapS3sXNMHO+HD7Rj7X0rB6/zfWAOTf3Y=;
        b=GhyNrPbVU9/8YNOylzm8TzhUpbBKOApsQiQUUDiEvRTkwgtdm52EnV7mOTP1rJX0Tf
         zGi2H7ZXKFxM3kD2gQtM8NWyFV/RxIUDoSuxFk93BkfDFquqWjnnE/z7Jk37Z+gxXi3W
         P+OCLfctWLvPCxd1KIPU2NcVFvNy/RcjPIbGiLwBCQpGkbLj8dKLELgzBKHjGD8n+Mog
         Dw1cEGZEh21f+GfREJAq8tKbmFHcprlw2dlVVIJNMr+qVOoNAUxu3pBzHK8pXEVEmNjw
         C+gIEEbHocKCViQ80gHin0raNJUGmznJZ8QNLG/l3l+URcfZNEeLtloTOaIB3OapdFrh
         5EAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=csQggusV1GzapS3sXNMHO+HD7Rj7X0rB6/zfWAOTf3Y=;
        b=bdIqRamJr6dHLcCZG83NQ/aRuiHLGN2HW5Z0l7a699KBYYQTwVaqwu/jhEYIxdbOj+
         r3GmqTS4tIjy1nqJzi/Tq4i/CWePierxGCXsmEJkNoZN4MjG9Kyzl7M/cfTKmNV4tLgI
         hBdVLy9rifrIaco1Cfw9tob64UQeesqYjkcAygMFrWgDHM/9AO3MB6j12jK+qF8ZDam0
         7O6hyqB7127lRix/Poa9rVD5VR54Gz6B9hdCM4DhjQElx5MCaLXSF0dRb50EW/uoo+Ww
         9N9oDhmgpZRHRpkJrQ7OTkEoUbHOK/wx+aDSnSy05G+mtyPI+hferhUOCYnmSGMQlATS
         C7Yg==
X-Gm-Message-State: AJcUukddcc3m/uvov8FiVmmXMCQ6bnKXTQVvSq6KbSHG/74omr282a6Q
        97SniovQ85D1rqf1iWkI4h9mAQ==
X-Google-Smtp-Source: ALg8bN6WdiKwhYTb4tEhhFmDAoA18VVr7IjBKmiFO7DwHctLWsARsosOX96UkLz+xvxvhwzEVWP7GQ==
X-Received: by 2002:a17:902:24e7:: with SMTP id l36mr16323822plg.61.1547754957086;
        Thu, 17 Jan 2019 11:55:57 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:e076:9fe9:59e2:1e0b])
        by smtp.googlemail.com with ESMTPSA id a15sm3083799pgb.1.2019.01.17.11.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 11:55:56 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: fix g12a buses
In-Reply-To: <20190116165236.8330-1-jbrunet@baylibre.com>
References: <20190116165236.8330-1-jbrunet@baylibre.com>
Date:   Thu, 17 Jan 2019 11:55:55 -0800
Message-ID: <7h36prcb3o.fsf@baylibre.com>
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

Queuing as a fix for v5.0-rc,

Thanks,

Kevin
