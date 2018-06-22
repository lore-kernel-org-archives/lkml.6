Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19BEC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DC3241F1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DC3241F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeFVMp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:45:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751191AbeFVMp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:45:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39DC081663FD;
        Fri, 22 Jun 2018 12:45:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-238.rdu2.redhat.com [10.10.120.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F22111166E8;
        Fri, 22 Jun 2018 12:45:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <e6a26908-67b2-e32e-06b5-d2e62acce305@intel.com>
References: <e6a26908-67b2-e32e-06b5-d2e62acce305@intel.com> <20180622115346.1e9cc433@canb.auug.org.au>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dhowells@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with the vfs tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29410.1529671523.1@warthog.procyon.org.uk>
Date:   Fri, 22 Jun 2018 13:45:23 +0100
Message-ID: <29411.1529671523@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 22 Jun 2018 12:45:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 22 Jun 2018 12:45:26 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reinette Chatre <reinette.chatre@intel.com> wrote:

> Thomas and David, please let me know what I can do from my side to help
> with this.

You could try basing on Al Viro's for-next tree which has the mount API
changes in it.  Sorry, I was hoping that this would go in the last merge
window, but I don't think Al has sufficient bandwidth available.

Note that it's likely to get rebased shortly as I have some patches to apply,
which given we're not at -rc2 yet, I'd like to roll into the original patches
to for bisectability reasons.

Also, Eric has some user_ns fixes that conflict with my procfs changes that he
wants to get upstream, though Linus said no - so I'm not sure what's going to
happen there.

David
