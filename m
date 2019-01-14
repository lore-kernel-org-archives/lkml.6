Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95033C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A949206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfANUHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:07:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59561 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfANUHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:07:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ADDD13C2CF4;
        Mon, 14 Jan 2019 20:07:33 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9536160BEC;
        Mon, 14 Jan 2019 20:07:33 +0000 (UTC)
Received: from zmail24.collab.prod.int.phx2.redhat.com (zmail24.collab.prod.int.phx2.redhat.com [10.5.83.30])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 751A73F602;
        Mon, 14 Jan 2019 20:07:33 +0000 (UTC)
Date:   Mon, 14 Jan 2019 15:07:33 -0500 (EST)
From:   Dave Anderson <anderson@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        linux-doc@vger.kernel.org
Message-ID: <244986363.69770015.1547496453312.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190114195940.GS2773@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com> <20190111123300.GE4729@zn.tnic> <4AE2DC15AC0B8543882A74EA0D43DBEC035661E8@BPXM09GP.gisp.nec.co.jp> <20190114180142.GO2773@zn.tnic> <2126185079.69727846.1547492312033.JavaMail.zimbra@redhat.com> <20190114192144.GQ2773@zn.tnic> <134663991.69764038.1547494607008.JavaMail.zimbra@redhat.com> <20190114195940.GS2773@zn.tnic>
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.17.201, 10.4.195.29]
Thread-Topic: kdump: add the vmcoreinfo documentation
Thread-Index: 0Ciiy49e9Ln7f7dAvqAqpJJrb3q9Xw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 14 Jan 2019 20:07:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> On Mon, Jan 14, 2019 at 02:36:47PM -0500, Dave Anderson wrote:
> > There's no reading of the dumpfile's memory involved, and that being the case,
> > the vmlinux file is not utilized.  That's the whole point of the crash option, i.e.,
> > taking a vmcore file, and trying to determine what kernel should be used
> > with it:
> > 
> >   $ man crash
> >   ...
> >        --osrelease dumpfile
> >               Display the OSRELEASE vmcoreinfo string from a kdump dumpfile header.
> 
> I don't understand - if you have the vmcoreinfo (which I assume is part
> of the vmcore, yes, no?) you can go and dig out the kernel version from
> it, no?
> 
> Why should you not utilize the vmcore file?

That's what it *does* utilize -- it takes a standalone vmcore dumpfile, and 
pulls out the OSRELEASE string from it, so that a user can determine what
vmlinux file should be used with that vmcore for normal crash analysis.

Dave

> 
> (I'm most likely missing something.)
> 
> > Well, I just don't agree that the OSRELEASE item is "frivolous". It's
> > been in place, and depended upon, for many years.
> 
> Yeah, no. The ABI argument is moot in this case as in the last couple
> of months people have been persuading me that vmcoreinfo is not ABI. So
> you guys need to make up your mind what is it. And if it is an ABI, it
> wasn't documented anywhere.
> 
> --
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
> 
