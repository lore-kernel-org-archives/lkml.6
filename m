Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF94CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C33C20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CPSklXgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C33C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeLKSK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:10:57 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:44770 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbeLKSK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:10:57 -0500
Received: by mail-pl1-f176.google.com with SMTP id k8so7270467pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 10:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=+nLizEF7z4NjnZ1JylKcr/Fx20yPoJl7lV43p3WkXbU=;
        b=CPSklXgYVySFaBzc2d3/Puc9ptcmq8EAbw3El4CMrOboO76F13H+vW8DtvHAXSdPwY
         9ssjWCoHAYlMKk0sSRih1gSIHFi0DYj6L26zgHaQcbWyeWa+LaLuFcBy9jmTlVqYmUKV
         hWNTMkBw7+BVaSAajD37JN5n/deDen4Xscm6rzIKjvPZovOPTXaSiKobhDYfwWcJcAGL
         S35cK2Z0T9fAiKrzBO739PM4iMcia6HkwNqVm1w8LTn7t5OL837JtjC4o46sxAWzqAAP
         f77hK3H/yuDtaTp6E4rOLmzuG/cIqMo01tq/a+udpt4PI8oXtIGu+GvzDebg3duehKvG
         Ux2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+nLizEF7z4NjnZ1JylKcr/Fx20yPoJl7lV43p3WkXbU=;
        b=iCzMgbbIzgKlnR8pVLWVmH8Zxm9Gd0BJ2+Wwm/zSiITz6QlasaBpo/d04eKf8wPXpA
         Lb3CT0G9wWeTpSFOPukf2AZUmCP3XPIi7HuvMcHen7V2H9LKEk/AEO8IKo+g+CDba0/v
         MtFCncagN7ts92E/QHa/CowLoNtzPNK+XlKCvMUrH1n3KbH1zXSTuA46oJbs3LHuKivb
         Xarh+ALc5Rk1aFWBaE7cBuxuOpgU6r2xyAFwQEm4rsmUkGDp40KOd6bzRomnYhyKkmAB
         3DP4r8nNpdRx42kx2tXoAmcgZKPri3Z6+Cvc/ZY010pd977z9OQLDkbX7kQQ3f4JuEij
         sXYQ==
X-Gm-Message-State: AA+aEWYr3wTqCFRIQj47QL2ymx9i8mb235C79v9WlrwSmrfHoJ/CfJk7
        MWax+VMe4rFjmAq5FrybWdRKcg==
X-Google-Smtp-Source: AFSGD/W21CFPoJXuLEPkzAR5Nmzxf0nKjmvt7z6iYdlaU+K1y7psBODzjoesLoXjvsBA1OcADFBxlw==
X-Received: by 2002:a17:902:365:: with SMTP id 92mr16088407pld.327.1544551856338;
        Tue, 11 Dec 2018 10:10:56 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 125sm38058560pfd.124.2018.12.11.10.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 10:10:55 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] PM / AVS: SmartReflex: Switch to SPDX Licence ID
In-Reply-To: <20181208160042.32587-1-nm@ti.com>
References: <20181208160042.32587-1-nm@ti.com>
Date:   Tue, 11 Dec 2018 10:10:54 -0800
Message-ID: <7h4lbkue6p.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> Fix up licensing to be inline with Linux conventions.
>
> Reported-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
