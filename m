Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887C5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE392087E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ryg5eYXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE392087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeKUQCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:02:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45969 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeKUQCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 11:02:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so3741465plm.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 21:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NM9vglVj9ao7Nk/teK/169b9hfw7yTqoLUZa5n+nE4U=;
        b=Ryg5eYXmSAEtRyC+cJqnKhReX3+YI3gp7b0nU6aHn92jgTLp2dfMpRuygOOvhpOzMk
         /eb9v0Wu0prOVhrP5a9vrr+Sy3RGS339yQIfVYROYYKwwpIQt+PoZ2nlNk3/EjnincOQ
         fl6FDiwAqZnbFenWLyeGswtLNx4NMgaUChA+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NM9vglVj9ao7Nk/teK/169b9hfw7yTqoLUZa5n+nE4U=;
        b=c//vKcoARUriJvw8q4C2mG22uaT93U3KLCujDPD6Eov+EsM4eJj3y9ytJlPZaVyUEm
         3oZVoOMjVTlonAEqR6LiqzsEm4f9BlR87S3S4S9tzqftUmMokLlx+DI8gwVPOsUvn/Oq
         nNAaHv2xUp5pgnmTI6iM+sEvMpsPbTCM/1/IomiJ+ujVKbpaQWqoX/e2u7xKVO/9J1UH
         OmPpkcUPRqHl98NhoWdbJ2pUo8+KKfzOPsJ27iidlhuSNJLp9s9la3Je0whYe0QsN3Zn
         kV5fxp7qve2ihI2uoXUvLR4wRvhOGdQJUH9WEhvEZuifOl3UlEm2dvMahrOU+urQ3LCP
         DHUw==
X-Gm-Message-State: AGRZ1gLVm3ApTAy+rGjl1cizbl0Rz/WV7fBaCIu9BLxCFbar/ADo6tts
        mWJtYy/5NQd4FRqpZwKiRrJIOA==
X-Google-Smtp-Source: AJdET5e2G+hMZVtHay6GMKePwgtaNgV25fbv6pd2AZfGZLfL5E9DTolpS64FcZlBpLpO8oTCH0Mhnw==
X-Received: by 2002:a62:6d83:: with SMTP id i125-v6mr5422776pfc.184.1542778195866;
        Tue, 20 Nov 2018 21:29:55 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id e126-v6sm40005626pfe.67.2018.11.20.21.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 21:29:55 -0800 (PST)
Date:   Wed, 21 Nov 2018 10:59:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V4] thermal: imx: fix for dependency on cpu-freq
Message-ID: <20181121052953.oqzdncf5dm7fwhsd@vireshk-i7>
References: <1542776563-6716-1-git-send-email-Anson.Huang@nxp.com>
 <20181121052053.hcc3xgfx4dgkydd2@vireshk-i7>
 <DB3PR0402MB3916E94B9CF644707801AE74F5DA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916E94B9CF644707801AE74F5DA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-18, 05:28, Anson Huang wrote:
> Since there is similar case of DEFER PROBE for the case of imx_init_from_nvmem_cells
> check, should I create another patch of same fix for it in V5 patch set?

Send that as a separate patch please. Thanks.

-- 
viresh
