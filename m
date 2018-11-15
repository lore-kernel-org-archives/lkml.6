Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F56C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FDF2086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAgbl+zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FDF2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeKOPm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:42:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39938 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeKOPmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:42:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so8481046pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 21:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K3UQ6qRsAXwfyaXxAGgu9zBEijeG59KSwrtSjdKQGvA=;
        b=XAgbl+zqJjyPfXArCUN8V6u13wFfu1s/WnPXxLcv6MdR8VE6K3/+ukIEQ6YRFu8aXU
         b9g8TUMAGxm0RHPDRjSDsDdPLEPEfRle0cOLIXQk9Yt7zSeAbmeI03U7VM4intTF1Khs
         lAZlBCUikUWeIpugRLp+NOKmSjmQnbggmGu8uR/VB7yjWHSuK6+wOPP4Qs0f1UFHK9aE
         JoZyHglNrGBfHM6HmgIVldNThMVgy/YJklY1OqPBDf1Z+EQtKQVJ9ClioyTi0lxsART9
         K/nh8uCAtPAgm7rGs6/RLLlsV9KqRzxN1rampmi15Q9TRZbTNcsa6J7D5uV61G9BBLbo
         Hvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=K3UQ6qRsAXwfyaXxAGgu9zBEijeG59KSwrtSjdKQGvA=;
        b=SgspwK5jQYx7in/2DTppFXHoUVotZBoymBmEYJBMgyHY7Y39hEiFDxvU545fiDcNA9
         S3Zm9ZpIuUhmE6CmNXzMWSaVWf9ccRbAZ9C0ut9oWmg915t1NcJ4wwY+/h07OQn9R7mP
         pEnHKbvEZuBryu6inf+KY7pMQLpE9Ey9gIVNbPRJwq6r6C5vicZllahODH4rXGfarJuj
         0Bl2dFjZXOtdzZuW90chI4NMhvk3h6AnvOBRB/o4SevTg+YjvgMqu1Vrf6wa8Z2gXe0q
         i+DnE4PN8jGVBhSbIyBZ+F9O0UN6soncR6b/PbldyRguxOoixBcJIXEDOtO/G0AMnWv2
         jhZQ==
X-Gm-Message-State: AGRZ1gKVFtVDE2PXFy1Wkd0FNPpMNFL1CQH1AKMUOSb2gYiYuWSZ5u1e
        sii8HisPdnIcavH1HbyFI+7/f4whsOw=
X-Google-Smtp-Source: AJdET5eXZIjOomr1RmTfpf3i5jAd4I0rDDQrn6Cq06yKRZ7stR0hhgPRFgBJmZupANGt4xbKn8/aQQ==
X-Received: by 2002:a63:a064:: with SMTP id u36mr4563661pgn.145.1542260162001;
        Wed, 14 Nov 2018 21:36:02 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t3sm5949684pgv.31.2018.11.14.21.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 21:36:01 -0800 (PST)
Date:   Wed, 14 Nov 2018 21:36:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
Message-ID: <20181115053600.GB5535@roeck-us.net>
References: <20181115011125.GA32556@roeck-us.net>
 <29E7A6C0-7829-4650-93C6-7220FECAA6EF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29E7A6C0-7829-4650-93C6-7220FECAA6EF@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 07:56:47PM -0800, Florian Fainelli wrote:
> 
> 
> On November 14, 2018 5:11:25 PM PST, Guenter Roeck <linux@roeck-us.net> wrote:
> >On Thu, Nov 01, 2018 at 11:26:06AM -0700, Florian Fainelli wrote:
> >> It is way too easy to miss enabling SERIAL_OF_PLATFORM which would
> >> result in the inability for the kernel to have a valid console
> >device,
> >> which can be seen with:
> >> 
> >> Warning: unable to open an initial console.
> >> 
> >> and then:
> >> 
> >> Run /init as init process
> >> Kernel panic - not syncing: Attempted to kill init!
> >exitcode=0x00000100
> >> 
> >> Since SERIAL_OF_PLATFORM already depends on SERIAL_8250 && OF there
> >> really is no drawback to defaulting this config to the value of
> >> SERIAL_8250.
> >> 
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> >This patch results in situations where CONFIG_SERIAL_OF_PLATFORM is now
> >defined where it was not previously. Example mpc85xx_defconfig. This in
> >turn results in boot failures for those configurations, with an error
> >message of
> >
> >of_serial: probe of e0004500.serial failed with error -22
> >
> >which wasn't seen before.
> 
> Do you know which Device Tree is being used here? The most obvious thing that could be done is to add a !PPC condition but this might be missing other platforms doing their own 8250 registration yet being OF aware (sparc?).

This is a qemu boot test. No, I don't know what exactly is happening,
except that this (emulated) system obviously does not expect
CONFIG_SERIAL_OF_PLATFORM to be enabled and, afaik, the devicetree
is generated internally by qemu. I would have thought that just enabling
a configuration by default out of the blue might be considered problematic
by itself, but maybe I am wrong.

> 
> >
> >Not sure if replacing a potential problem with a real one is really an
> >improvement.`
> 
> That comment is not particularly helpful though I have an appreciation for when a change breaks things in unexpected ways and how frustrating that can be.

What is really frustrating (and let me think about dropping all those
boot tests) is that one ends up having to argue if the problem is real
or only applies to a presumably or possibly wrong qemu emulation, and
that one ends up having to discuss the validity of the test case. 

Since this is "only" an emulation and thus not a "real" system,
please feel free to ignore this report. I'll just drop all boot tests
using this configuration once the patch hits mainline.

Guenter
