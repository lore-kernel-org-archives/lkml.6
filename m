Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04DAC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7053420825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7053420825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeKJBkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:40:09 -0500
Received: from foss.arm.com ([217.140.101.70]:33822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbeKJBkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:40:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D822B80D;
        Fri,  9 Nov 2018 07:58:58 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DA8A3F5BD;
        Fri,  9 Nov 2018 07:58:58 -0800 (PST)
Date:   Fri, 9 Nov 2018 15:58:56 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Jan Glauber <Jan.Glauber@cavium.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dcache_readdir NULL inode oops
Message-ID: <20181109155856.GC2091@brain-police>
References: <20181109143744.GA12128@hc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109143744.GA12128@hc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 02:37:51PM +0000, Jan Glauber wrote:
> I'm seeing the following oops reproducible with upstream kernel on arm64
> (ThunderX2):

[...]

> It happens after 1-3 hours of running 'stress-ng --dev 128'. This testcase
> does a scandir of /dev and then calls random stuff like ioctl, lseek,
> open/close etc. on the entries. I assume no files are deleted under /dev
> during the testcase.
> 
> The NULL pointer is the inode pointer of next. The next dentry->d_flags is
> DCACHE_RCUACCESS when this happens.
> 
> Any hints on how to further debug this?

Can you reproduce the issue with vanilla -rc1 and do you have a "known good"
kernel?

Will
