Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491A1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AA8206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AA8206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbeK2Bne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:43:34 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37912 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeK2Bne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:43:34 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gS123-0003yn-OO; Wed, 28 Nov 2018 14:41:39 +0000
Date:   Wed, 28 Nov 2018 14:41:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: oops when ext4 fs is full
Message-ID: <20181128144139.GG2217@ZenIV.linux.org.uk>
References: <20181128085038.iaklny2yuygrixhs@inc028000049.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128085038.iaklny2yuygrixhs@inc028000049.lancs.ac.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 08:50:39AM +0000, Willy Wolff wrote:
> Hi,
> I got a Oops when the hard drive was COMPLETELY full using a ext4 fs.
> After it, any command on the directory where the last write should have occurred freezes, while any other directory behave just fine.
> 
> If this email is not relevant for you, please point me what to do.
> 
> Best Regards,
> Willy
> 
> 
> $ cat /proc/version 
> Linux version 4.18.7-dirty (willy@inc028000049) (gcc version 6.3.0 20170516 (Debian 6.3.0-18)) #32 SMP PREEMPT Thu Sep 27 19:31:11 BST 2018
> 
> The kernel is dirty but the modifications are not related to the fs subsystem. The system is running on a Hardkernel Odroid-xu3 but running with the mainline linux at 8ea7eadbef2f7103d5871016f03fc38b3adeaddb
> Also, the fs is on a SD-card. I did a fs check after the oops, no errors are reported.

Disassembly of __d_instantiate in your build would obviously be useful...
_Presumably_ it's one of the spin_lock() inlined there, but it would be
useful to know which one...
