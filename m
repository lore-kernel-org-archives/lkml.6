Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6901CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2CA20818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs5tPKam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2CA20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeKJB4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:56:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbeKJB4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:56:20 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C46520883;
        Fri,  9 Nov 2018 16:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541780106;
        bh=2r6r3JuZjRzV1HLIluJJ5J3ve4M1zuiZJ2WKd4/hjRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rs5tPKamPgwElSiE1PhQVbO/fz9KIPRMUbT5koWoEHWrKZMyFakhsA5nNyJqEsHy8
         1eDemrdaJreQzX2Mh78eNKh638e/2Wg9nLzkPuDwbwqtnuGUY3e0OOX6E86ViZnOga
         iTHHKnGvYbTgGt4B1Crmia0eO/X+dfbXiTkU6dB0=
Date:   Fri, 9 Nov 2018 08:15:05 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/114] 4.4.163-stable review
Message-ID: <20181109161505.GA24501@kroah.com>
References: <20181108215059.051093652@linuxfoundation.org>
 <86d97b16-dbbc-27bd-ad7b-9a96210070a4@roeck-us.net>
 <2c7054eb-6ad9-6531-c9c9-025f59070c74@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c7054eb-6ad9-6531-c9c9-025f59070c74@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 06:14:06AM -0800, Guenter Roeck wrote:
> On 11/9/18 5:50 AM, Guenter Roeck wrote:
> > On 11/8/18 1:50 PM, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.4.163 release.
> > > There are 114 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sat Nov 10 21:50:28 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Building i386:allnoconfig ... failed
> > --------------
> > Error log:
> > kernel/built-in.o: In function `cpu_startup_entry':
> > (.text+0x1a2e9): undefined reference to `cpuidle_devices'
> > make[1]: *** [vmlinux] Error 1
> > make: *** [sub-make] Error 2
> > 
> > 
> > Bisect results:
> > 
> > # bad: [70cfa9ca6595d3238b36b9f6b36cf6e18dfd2c3b] Linux 4.4.163-rc1
> > # good: [24c2342b8e51ab3185e68470709904150a1e3ee0] Linux 4.4.162
> > git bisect start 'HEAD' 'v4.4.162'
> > # good: [008f87b2e9c5db7dd3756832a9e449415d837c7d] ixgbe: fix RSS limit for X550
> > git bisect good 008f87b2e9c5db7dd3756832a9e449415d837c7d
> > # good: [5d92c564ec3dd9a5833974f3ce113cc7a94e0f6a] mtd: spi-nor: Add support for is25wp series chips
> > git bisect good 5d92c564ec3dd9a5833974f3ce113cc7a94e0f6a
> > # good: [71fba871e4a07400eb1400b1e6b45ca3a5487834] rtnetlink: Disallow FDB configuration for non-Ethernet device
> > git bisect good 71fba871e4a07400eb1400b1e6b45ca3a5487834
> > # good: [4d1024282b1259209bb4601f4b51dce367cf8a02] IB/ucm: Fix Spectre v1 vulnerability
> > git bisect good 4d1024282b1259209bb4601f4b51dce367cf8a02
> > # good: [fe9d47ae282ebd2bb10a36ec2bace1afd0ba050e] Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15IGM
> > git bisect good fe9d47ae282ebd2bb10a36ec2bace1afd0ba050e
> > # bad: [573e8431fe60169157440664f74c6af254b3b00e] x86/percpu: Fix this_cpu_read()
> > git bisect bad 573e8431fe60169157440664f74c6af254b3b00e
> > # good: [be0ac51f4181a18c458080d79919aeee17ce0c68] sched/fair: Fix throttle_list starvation with low CFS quota
> > git bisect good be0ac51f4181a18c458080d79919aeee17ce0c68
> > # first bad commit: [573e8431fe60169157440664f74c6af254b3b00e] x86/percpu: Fix this_cpu_read()
> > 
> > Full results will follow later, after builds are complete.
> > 
> > Guenter
> 
> Upstream commit 9bd616e3dbed ("cpuidle: Do not access cpuidle_devices
> when !CONFIG_CPU_IDLE") should fix the problem.

Thanks, you beat me too it!  Now queued up and I've pushed out a -rc2
with that fix added.

greg k-h
