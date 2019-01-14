Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C7AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D9D2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfANTgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:36:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbfANTgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:36:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76DEABAEC;
        Mon, 14 Jan 2019 19:36:47 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5700661D19;
        Mon, 14 Jan 2019 19:36:47 +0000 (UTC)
Received: from zmail24.collab.prod.int.phx2.redhat.com (zmail24.collab.prod.int.phx2.redhat.com [10.5.83.30])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 27A331800540;
        Mon, 14 Jan 2019 19:36:47 +0000 (UTC)
Date:   Mon, 14 Jan 2019 14:36:47 -0500 (EST)
From:   Dave Anderson <anderson@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        linux-doc@vger.kernel.org
Message-ID: <134663991.69764038.1547494607008.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190114192144.GQ2773@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com> <20190110121944.6050-2-lijiang@redhat.com> <20190111123300.GE4729@zn.tnic> <4AE2DC15AC0B8543882A74EA0D43DBEC035661E8@BPXM09GP.gisp.nec.co.jp> <20190114180142.GO2773@zn.tnic> <2126185079.69727846.1547492312033.JavaMail.zimbra@redhat.com> <20190114192144.GQ2773@zn.tnic>
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.17.201, 10.4.195.21]
Thread-Topic: kdump: add the vmcoreinfo documentation
Thread-Index: br070a/lHN4Qz+xrY/Hw7icxEWLpbQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 14 Jan 2019 19:36:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




----- Original Message -----
> On Mon, Jan 14, 2019 at 01:58:32PM -0500, Dave Anderson wrote:
> > Preferably it would be left as-is.  The crash utility has a "crash
> > --osrelease vmcore"
> > option that only looks at the dumpfile header, and just dump the string.
> > With respect
> > to compressed kdumps, crash could alternatively look at the utsname data
> > that is stored
> > in the diskdump_header.utsname field, but with ELF vmcores, there is no
> > such back-up.
> 
> Well, there is:
> 
> 00000000  4f 53 52 45 4c 45 41 53  45 3d 35 2e 30 2e 30 2d |OSRELEASE=5.0.0-|
> 00000010  72 63 32 2b 0a 50 41 47  45 53 49 5a 45 3d 34 30 |rc2+.PAGESIZE=40|
> 00000020  39 36 0a 53 59 4d 42 4f  4c 28 6d 65 6d 5f 73 65 |96.SYMBOL(mem_se|
> 00000030  63 74 69 6f 6e 29 3d 66  66 66 66 66 66 66 66 38 |ction)=ffffffff8|
> 00000040  34 35 31 61 31 61 38 0a  53 59 4d 42 4f 4c 28 69 |451a1a8.SYMBOL(i|
> 00000050  6e 69 74 5f 75 74 73 5f  6e 73 29 3d 66 66 66 66 |nit_uts_ns)=ffff|
>                                                                          ^^^^
> 00000060  66 66 66 66 38 32 30 31  33 35 34 30 0a 53 59 4d  |ffff82013540
>                                                              ^^^^^^^^^^^^
> 
> This address has it.

There's no reading of the dumpfile's memory involved, and that being the case,
the vmlinux file is not utilized.  That's the whole point of the crash option, i.e.,
taking a vmcore file, and trying to determine what kernel should be used with it:

  $ man crash
  ...
       --osrelease dumpfile
              Display the OSRELEASE vmcoreinfo string from a kdump dumpfile header.
  ...


> 
> > What's the problem with leaving it alone?
> 
> The problem is that I'd like to get all those vmcoreinfo exports under
> control and to not have people frivolously export whatever they feel
> like, for obvious reasons, and to get rid of the duplicate/unused pieces
> being part of vmcoreinfo.

Well, I just don't agree that the OSRELEASE item is "frivolous".  It's been in place,
and depended upon, for many years.

Dave

