Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5121DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F66C206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeBFC7o3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F66C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbeKVKQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:16:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43290 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387894AbeKVKQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:16:48 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so7636010plb.10;
        Wed, 21 Nov 2018 15:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7vwji9zRdUSFQpro0xJ8CsV8UZRVCjAVvzwxJ+nZsqM=;
        b=qeBFC7o3j32Z5IX0m0D8dUMuWBBPsQEcz18Vu8n8I9K1r6jJV7cyxHMI4DPfUefcv2
         2IU15x2fCkX4U7Q7PpLfJGKTKaiJOltFgSFf8wu2+AR3WZJsmrjWY/LO7rx8nuG60nnS
         rxkmsfSPde2XZ4QehpfHvm0ILKeJ5LdwA9A65XjIQ8ZUUjsbnp1BZHks/+GD5TrdsHOO
         +E76pQ3zMsM3jqwYzVhr6vGsgA4wzDDlz1VdWEFp9fq4+MmGoc5D33ZznVyOrgCOkoPa
         y+e9bP9pY21HfUV4m47cfbE/rYfvrjADNBBH5bZzBTHSVrWSIvI4Y/ogy4vmaPDDcZOY
         P0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7vwji9zRdUSFQpro0xJ8CsV8UZRVCjAVvzwxJ+nZsqM=;
        b=RR9CY5yOVlY43HJIMd8NAbMciOoMlM9HoyIf8rXd9sgf4dQvUkqDIl7m8WJbwzEux+
         dHVQ06A90qRVjxO69q/h0Ha8BbP9eLjYiaD1Kd0NfKSc4gt6ug/JqMFvXN+0QrQe7tzC
         sU8+PJI1W4A9UUji/h4aTFQTENG+WmZ4lbqU2dPz5OyH5EoG0pxEI8+YDJiMHFS9aJhK
         hXm0uzOzhqkN8axtZizT3MHi0QFlFFsGl+rW1KcIgEGm4i/usnRTxoe2bQxBNTR8Jdk5
         UyIBNrJ21gspVsxCRltaBZk0BzDDb+/3jZuWOibfVKbzlaqGQCB2jmdj6oURqTE+Db/w
         mJSQ==
X-Gm-Message-State: AA+aEWaOO1EmAdnLP4nK8WsN5nTQsg6OBb60fK6hgZOIPpLDTo/ckFJx
        PdJEHLnVHKWsOzNycosTceU=
X-Google-Smtp-Source: AFSGD/V2lfC05+YvySjbv7/vQefmxEdKEyluoC/aJbqNehVRLhiCDnj2XbFdV4mTpP6x3htQaSTS1Q==
X-Received: by 2002:a63:8441:: with SMTP id k62mr7800520pgd.392.1542843614815;
        Wed, 21 Nov 2018 15:40:14 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x12sm47627269pgr.55.2018.11.21.15.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 15:40:13 -0800 (PST)
Date:   Wed, 21 Nov 2018 15:40:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/90] 3.18.126-stable review
Message-ID: <20181121234012.GA4451@roeck-us.net>
References: <20181119162620.585061184@linuxfoundation.org>
 <20181120203829.GA19385@roeck-us.net>
 <20181121103733.GA9476@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121103733.GA9476@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:37:33AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 20, 2018 at 12:38:29PM -0800, Guenter Roeck wrote:
> > On Mon, Nov 19, 2018 at 05:28:42PM +0100, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 3.18.126 release.
> > > There are 90 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed Nov 21 16:25:28 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Build results:
> > 	total: 138 pass: 134 fail: 4
> > Failed builds: 
> > 	i386:allyesconfig 
> > 	i386:allmodconfig 
> > 	sparc64:allmodconfig 
> > 	sparc64:defconfig 
> > Qemu test results:
> > 	total: 221 pass: 209 fail: 12
> > Failed tests: 
> > 	sparc64:sun4u:smp:initrd 
> > 	sparc64:sun4u:smp:ata:rootfs 
> > 	sparc64:sun4u:smp:mmc:rootfs 
> > 	sparc64:sun4u:smp:nvme:rootfs 
> > 	sparc64:sun4u:smp:scsi[MEGASAS]:rootfs
> > 	sparc64:sun4u:smp:usb-xhci:rootfs 
> > 	sparc64:sun4u:smp:usb-uas-xhci:rootfs 
> > 	sparc64:sun4u:smp:virtio-pci:rootfs 
> > 	sparc64:sun4v:smp:ata:rootfs 
> > 	sparc64:sun4v:smp:nvme:rootfs 
> > 	sparc64:sun4u:nosmp:ata:rootfs 
> > 	sparc64:sun4v:nosmp:ata:rootfs
> > 
> > Details are available at https://kerneltests.org/builders/.
> 
> Ok, sorry about that, I think these should now all be fixed.  I've
> pushed out a -rc2 with some changes.
> 

For v3.18.125-88-ge2a8617f7c3c:

Build results:
	total: 138 pass: 138 fail: 0
Qemu test results:
	total: 221 pass: 221 fail: 0

Guenter
