Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E603C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D48B2087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D48B2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeJESxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 14:53:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37976 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeJESxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 14:53:44 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g8OhO-0008GW-VR; Fri, 05 Oct 2018 13:55:15 +0200
Date:   Fri, 5 Oct 2018 13:55:14 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 00/11 v3] x86: load FPU registers on return to userland
Message-ID: <20181005115514.acxsyghmzlhhqjx7@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
 <8ea44ae2bb4844df812ea4c6cb0c00ef12708c51.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ea44ae2bb4844df812ea4c6cb0c00ef12708c51.camel@surriel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-04 12:45:08 [-0400], Rik van Riel wrote:
> Wait, so any thread can bypass its memory protection
> keys, even if there is a seccomp filter preventing
> it from calling the PKRU syscalls?

We have SYS_pkey_alloc +free and SYS_pkey_mprotect. For read/ write of
the register value, libc is using and opcodes.

> Is that intended?

Either that or it ended like that because someone failed to attend a
meeting where this was discussed. Here is something from pkeys(7):

| Protection  keys  have  the  potential  to  add  a  layer  of security and
| reliability to applications.  But they have not been primarily designed as a
| security feature.  For instance, WRPKRU is a completely unprivileged
| instruction, so pkeys are useless in any case that an attacker controls the
| PKRU register or can execute arbitrary instructions.

Sebastian
