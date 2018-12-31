Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB5FC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2BB218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="wCM1TfAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeLaVer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 16:34:47 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47023 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeLaVer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 16:34:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id f23so18811043lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 13:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I2/qCgYLXayyRSHBQROXp/5HG/DXr2r6/XD1qd/3LX0=;
        b=wCM1TfAbirfuY+HNX0sczBbEDaKkyYfMY4aFPDB5DAoAv/KD1To/hkOfJ+5zoTmNZs
         0zB7ARIJ0d5SCfGT+hP73NYz6RJfuFx1+ohkURWtFdMm1JOPy6J16mElzputHApHGJJZ
         Pz1LFnOox+p1Akb4+lQG0DwDyFQXDC2qDrnREYcL3n3S62MpUlXTuUzjVTk7bkyylP1n
         3qkH/dipvB5AHfmH+SwcGnAvXkfrLhpTPnNb/+s18LP5wp4YiSJbivEJ06QouGBrcJWG
         d80yDCEBTyplBva+o5T21fDj9fy7hchEkdRhkvZHfnPk9yiUuwQ+99s4eKHI/SQfyutR
         TAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I2/qCgYLXayyRSHBQROXp/5HG/DXr2r6/XD1qd/3LX0=;
        b=saM6DD67rbTh72IVGcWMNdY5fOflGLhvdTD24VOMLhNdOagL56Rc1PS4umIQBYec0r
         nghNIMNPgsMt0W1PADWuGMX8IRlPYIsJzjWE5vnl7t61QRpEJ///ZA15nQ6bSBkN3uD0
         kP1OMofgTkP97AvFOGdkCYaFpxBDJeDI0VWrLYjWyh7MakUp76IiWVTOxrXBEPWfZ0WM
         eUSHmFpLJzfmWwI1gBpoDVXF07pK9K8pnFhg94zWC6ftfJw5cNub3PYYpwoToUisT9/A
         758Q0a8qC8/09ZziJdsbS4GhcvlKxiEVxSO21ZAr2CVgJ3xRWe+qP2rYAnrSwaTN02/M
         Ml9A==
X-Gm-Message-State: AA+aEWZE3TzTQloMacQQuSXcJ1MIk0sfcr1f3VOw8Xc2L+ymzqsCH+3N
        qvrIjHyFX9QNPbmmy/KY4sagZQ==
X-Google-Smtp-Source: AFSGD/XAYAQUQPyaH6uiZxmNj7KrkY4Q+vAtPh5vdB7AJWLInSoWk7oAVBBZ696X3bye+yFLeHpurg==
X-Received: by 2002:a19:574d:: with SMTP id l74mr18863752lfb.5.1546292083919;
        Mon, 31 Dec 2018 13:34:43 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id 11sm9511314lfq.89.2018.12.31.13.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Dec 2018 13:34:42 -0800 (PST)
Date:   Mon, 31 Dec 2018 13:06:41 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] tee subsys for v4.21
Message-ID: <20181231210641.zzamntcmvc542avg@localhost>
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
>   https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-subsys-optee-for-4.21
> 
> for you to fetch changes up to 3c15ddb97c77f34ba009910becd5921f169770a2:
> 
>   tee: optee: log message if dynamic shm is enabled (2018-12-11 14:38:40 +0100)

Same as the other branch, queued this in next/late for now. Will send at end of
week.


-Olof

