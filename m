Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81237C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF692086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="2R1253L0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF692086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeLLWQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:16:08 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:38615 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeLLWQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:16:06 -0500
Received: by mail-lf1-f51.google.com with SMTP id p86so5688lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 14:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oHBZzLgfxDGmIxVjOCMkhER4QZkXr1ho5yGIFdssy9g=;
        b=2R1253L0QW2jzxWqYlOCIYOdflq5CFjyBBB9/K9r6eaB42S2mNjqiy4rkpVrSl6B6x
         9MUIhgeHyAgtMwiG9Q+cBs2LcKhmbA4jxP9RZ7Uo1hlboQe4SoomYV3gdxIA0ZmEaaHw
         OyPU3B6y4Qup2Bs4TBGwdFWK8AXBsdKEt7aHQEDiEy42sF6r+VUIxGA84aa1K+pE4ep+
         t3BjVGLXjdMiXbQsOoHtzd0U2RcRq6Ko0kQqtZVXPbnLeg6FTH8rp8kqAXhhWHjbnnlb
         XXEN0tU6SBA2HVqBYgsJxHfl8XCjLYOkcR17Z72Jk9dvXRzY18Ux2G7fkqIWnC4LPu5A
         lMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oHBZzLgfxDGmIxVjOCMkhER4QZkXr1ho5yGIFdssy9g=;
        b=RKggWDRHTuc1jmKn4NimsPd8vyPxJZ5mUAgD/d/Nh4Ve1K7eQWK9orcn9njI4jj9SN
         Jgj+ztNa5NrcGN/Xn4429xc+IXgPIUjA8WEwJAJFxrsIAo+5HJZRE4dbPhv2b8XSLsSk
         gH9dl3Uto4366s/Bkh+af4SBozba3vNJlHR8BJfPbi8AsxgJe9u3eAqvI0kw6L8LtWNN
         HbtWzn59KLwCyvjckT3nNUMmnpBQn4pA/AnLpnqVnPMGt23pVSYOuDdtCYfxQB3/MjAq
         s5qB7YO863du1vWliQL2i4IZrUSvMCZjk4gLf27C6BBjHcMBtiGjZUT3cWqk0Ay5/VuR
         k+eA==
X-Gm-Message-State: AA+aEWbFem3+UeoXQrspnkSQoeW1HNHW/qSInuo3hwXXOB+8SbYiUmwb
        PuJ+ublOWdj2C2lfEjrc/D+rvQ==
X-Google-Smtp-Source: AFSGD/WzF5OJEml7uSJSgxWmpcTrGT+iwNiaJPuDE3ayQQqgoz2e5t9Fjm+WzyyS0HCh7Srd+NXwQw==
X-Received: by 2002:a19:739d:: with SMTP id h29mr3130584lfk.85.1544652962794;
        Wed, 12 Dec 2018 14:16:02 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id r26-v6sm3453lji.25.2018.12.12.14.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 14:16:00 -0800 (PST)
Date:   Wed, 12 Dec 2018 13:38:33 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] tee subsys for v4.21
Message-ID: <20181212213833.nretkviqn66bnxtf@localhost>
References: <20181212123121.GB29450@jax.ideon.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212123121.GB29450@jax.ideon.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 01:31:21PM +0100, Jens Wiklander wrote:
> Hello arm-soc maintainers,
> 
> Please pull this small OP-TEE driver enhancement. A friendly log message
> is added to inform that dynamic shared memory is used when initiazing
> the OP-TEE driver.

Hi Jens,

We generally try to keep our branches based on quite early -rc releases (rc
1/2/3), to avoid having to merge-back into our tree from upstream too much.

Your branch is unfortunately based on -rc6. Would you prefer to respin it with
an older base, or should I cherry-pick over the patch from it? Either is OK
with me.


Thanks!


-Olof

