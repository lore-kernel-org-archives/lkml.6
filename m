Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4B2C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF152146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF152146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbeLFW1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:27:49 -0500
Received: from mail.hallyn.com ([178.63.66.53]:53444 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbeLFW1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:27:48 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id AAA6DA67; Thu,  6 Dec 2018 16:27:46 -0600 (CST)
Date:   Thu, 6 Dec 2018 16:27:46 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Colascione <dancol@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
Message-ID: <20181206222746.GB9224@mail.hallyn.com>
References: <20181206121858.12215-1-christian@brauner.io>
 <87sgzahf7k.fsf@xmission.com>
 <CAKOZuet4ayDu-54u2tO9tRDCgxa9JQ4avAiYS8xEtReN4MMhAA@mail.gmail.com>
 <878t12efg3.fsf@xmission.com>
 <20181206174129.taakmwekysbkaosu@brauner.io>
 <CAGXu5jL8PciZAXvOvCeCU3wKUEB_dU-O3q0tDw4uB_ojMvDEew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jL8PciZAXvOvCeCU3wKUEB_dU-O3q0tDw4uB_ojMvDEew@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 10:30:40AM -0800, Kees Cook wrote:
> On Thu, Dec 6, 2018 at 9:41 AM Christian Brauner <christian@brauner.io> wrote:
> > I feel changing the name around by a single persons preferences is not
> > really a nice thing to do community-wise. So I'd like to hear other
> > people chime in first before I make that change.
> 
> I don't think the name is hugely critical (but it's always the hardest
> to settle on). My preference order would be:
> 
> taskfd_send_signal()
> pidfd_send_signal()
> procfd_send_signal()
> fd_send_signal()

imo, either procfd_send_signal() or taskfd_send_signal()

It seems to me that using flags later to specify sending to pgrp vs thread
is fine:  it's specifying how to interpret the 'fd' in 'procfd_send_signal()'.

> But, agreed, I think fdkill() should not be used.
> 
> -- 
> Kees Cook
