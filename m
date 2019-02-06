Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F97DC282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 02:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7D5217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 02:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfBFCQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 21:16:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfBFCQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 21:16:13 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C45B110F8F;
        Wed,  6 Feb 2019 02:16:13 +0000 (UTC)
Received: from treble (ovpn-119-156.phx2.redhat.com [10.3.119.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 629B560BEE;
        Wed,  6 Feb 2019 02:16:13 +0000 (UTC)
Date:   Tue, 5 Feb 2019 20:16:11 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: libelf-0.175 breaks objtool
Message-ID: <20190206021611.2nsqomt6a7wuaket@treble>
References: <20190205133821.1a243836@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190205133821.1a243836@gandalf.local.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 06 Feb 2019 02:16:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 01:38:21PM -0500, Steven Rostedt wrote:
> Just a FYI.
> 
> After a recent upgrade in debian testing, I was not able to build the
> kernel. I have a custom build of gcc, so I thought it was strange that
> I was getting something like this (took this from the web, as I don't
> have the error anymore with the work around, and currently doing a full
> build):
> 
> objdump: kernel/.tmp_signal.o: unable to initialize decompress status for section .debug_info                       
> objdump: kernel/.tmp_signal.o: unable to initialize decompress status for section .debug_info                       
> objdump: kernel/.tmp_signal.o: file format not recognized                                                           
>   CC      arch/x86/kernel/platform-quirks.o                                                                         
> objdump: arch/x86/kernel/.tmp_ebda.o: unable to initialize decompress status for section .debug_info                
> objdump: arch/x86/kernel/.tmp_ebda.o: unable to initialize decompress status for section .debug_info                
> objdump: arch/x86/kernel/.tmp_ebda.o: file format not recognized                                                    
> objdump: mm/.tmp_swap_slots.o: unable to initialize decompress status for section .debug_info                       
> objdump: mm/.tmp_swap_slots.o: unable to initialize decompress status for section .debug_info                       
> objdump: mm/.tmp_swap_slots.o: file format not recognized                                   

I installed debian testing on a VM, which has libelf 0.175-2, but I
can't recreate.  Can you share your config?

-- 
Josh
