Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9739C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D19C20873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="b8qfzftv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D19C20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbeLLWQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:16:03 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46177 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeLLWQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:16:02 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so17667368ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 14:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R3s3/uDbmK5xVBGG9Mu8VuBAJIRcLJVL+0J8S7pa9Ok=;
        b=b8qfzftvTMWCTX0/ufGPmx6TClH6f/VZQMOPKm5+LwPkAUAnhudmadXkMCOniktF5f
         3b7qwoAGhjFWdXiwTpge3F4nkodsZO3MvO0kc7Rtq1UT2Z9qw9j3lba99vMHd24swaqp
         lSMlPYLQ8fdxLxGV61kleaoA44jUg3br0WeRhzEjE0HIgi5mfCPhgxOSUUusppQAJ4nt
         4hxO+Glywkpy0ikSxrnXkMlsiFuj9o6HkPL7f2TPsmzvmarr6/cyjg+nBx4boAt7DL9L
         w4yQz3ivi79qZsx/CxNWlJPWvP/5yYJRxJnXQ9wZ5hdwYEpaPxc64QyVldOFN2URARC2
         Vq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R3s3/uDbmK5xVBGG9Mu8VuBAJIRcLJVL+0J8S7pa9Ok=;
        b=NQzfCtLXuGX6zJ7XjrbUGAfFwSr5hSWrR/+85yWZP9vAoFwO2ainuO9mAxZQox1HSO
         hy+Unuh92FvMl1H7uAfP6lqxBMzTE9ynaLYD+ZkcYj0UQhHjMmsfbgtqemPPha4ne2wn
         faqha5JdtavpyVnX0BE9fIi+Dtkp3Yl3jne8WiGt7jeRtHvnTo8RRIIlqbU3DeJv66JN
         6nboIZ4/OxvdTOwXtK9RysMTHDJS9GdjgNogN+bM49Jt1hKsL147dMxquNQTvFpYBKK9
         gQiCaoJ0CZuke56EQE452j81TbqgUJIbE4y336fgmKZ3ytjdXZT0gJTTcq7EVdBO4FDP
         RXng==
X-Gm-Message-State: AA+aEWagIfYdialPmwT5Hfo1kXVXShdZ8iZnMESKePQ9ZlFqoUOIVP56
        wzHBbGQChvXzle3PAM38qBFvsQ==
X-Google-Smtp-Source: AFSGD/XbMHY39wLCj2dgNUr7mCKBSpNZhc/IrH+VT2Am20OhxXGqa6ql0mIutSCCbYrJPFcMuoiPVg==
X-Received: by 2002:a2e:4442:: with SMTP id r63-v6mr13208033lja.79.1544652959493;
        Wed, 12 Dec 2018 14:15:59 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id d2sm5146lfg.16.2018.12.12.14.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 14:15:57 -0800 (PST)
Date:   Wed, 12 Dec 2018 13:36:17 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] tee driver fix for v4.21
Message-ID: <20181212213617.mltwlxfcbap4prlj@localhost>
References: <20181212122800.GA29450@jax.ideon.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212122800.GA29450@jax.ideon.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 01:28:00PM +0100, Jens Wiklander wrote:
> Hello arm-soc maintainers,
> 
> Please pull this tee driver fix for a possible double list_del() in the
> OP-TEE driver while uninitializing.
> 
> Thanks,
> Jens
> 
> The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:
> 
>   Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-subsys-fix-for-4.21
> 
> for you to fetch changes up to b2d102bd0146d9eb1fa630ca0cd19a15ef2f74c8:
> 
>   tee: optee: avoid possible double list_del() (2018-12-11 14:38:21 +0100)
> 
> ----------------------------------------------------------------
> Avoid possible double list_del in supplicant comms
> 
> A fix for the OP-TEE driver to avoid possible double list_del during
> tee-supplicant communication while the system is shutting down.

Do you want this for 4.20 or 4.21? Seems like .20 material to me but the tag
name is 4.21. 


-Olof

