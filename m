Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A10ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FA0208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FA0208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeJRKty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 06:49:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40860 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeJRKty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 06:49:54 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCyNb-0005ic-Nl; Thu, 18 Oct 2018 02:49:43 +0000
Date:   Thu, 18 Oct 2018 03:49:43 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     NeilBrown <neilb@suse.com>, Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-tip-commits@vger.kernel.org, jsimmons@infradead.org
Subject: Re: in_compat_syscall() returns from kernel thread for X86_32.
Message-ID: <20181018024943.GD32577@ZenIV.linux.org.uk>
References: <1460987025-30360-1-git-send-email-dsafonov@virtuozzo.com>
 <tip-abfb9498ee1327f534df92a7ecaea81a85913bae@git.kernel.org>
 <87h8hkc9fd.fsf@notabene.neil.brown.name>
 <CALCETrXB8PE4Ue0BeD0wUS9psLLjpv_pt+nj=SEaj+Nb_dZzUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXB8PE4Ue0BeD0wUS9psLLjpv_pt+nj=SEaj+Nb_dZzUA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 07:37:42PM -0700, Andy Lutomirski wrote:

> I could get on board with:
> 
> ({WARN_ON_ONCE(current->flags & PF_KTHREAD); true})
> 
> The point of these accessors is to be used *in a syscall*.
> 
> What on Earth is Lustre doing that makes it have this problem?

	Plays with timestamps from a kernel thread, perhaps?
See the old .su joke about adenoidectomy with rectal access
for possible reasons for doing it that way...
