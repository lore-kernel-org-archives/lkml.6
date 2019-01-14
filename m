Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F305C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61B42070B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfANS6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:58:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfANS6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:58:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E535C05FEF1;
        Mon, 14 Jan 2019 18:58:33 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62DA2608E5;
        Mon, 14 Jan 2019 18:58:32 +0000 (UTC)
Received: from zmail24.collab.prod.int.phx2.redhat.com (zmail24.collab.prod.int.phx2.redhat.com [10.5.83.30])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 3D90F4ED25;
        Mon, 14 Jan 2019 18:58:32 +0000 (UTC)
Date:   Mon, 14 Jan 2019 13:58:32 -0500 (EST)
From:   Dave Anderson <anderson@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        linux-doc@vger.kernel.org
Message-ID: <2126185079.69727846.1547492312033.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190114180142.GO2773@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com> <20190110121944.6050-2-lijiang@redhat.com> <20190111123300.GE4729@zn.tnic> <4AE2DC15AC0B8543882A74EA0D43DBEC035661E8@BPXM09GP.gisp.nec.co.jp> <20190114180142.GO2773@zn.tnic>
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.17.201, 10.4.195.19]
Thread-Topic: kdump: add the vmcoreinfo documentation
Thread-Index: OZlyqBKuhECC5AsJ7Gtu5R02sg8UoA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 14 Jan 2019 18:58:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> On Mon, Jan 14, 2019 at 05:48:48PM +0000, Kazuhito Hagio wrote:
> > As for makedumpfile, it will be not impossible to remove the
> > init_uts_ns.name.relase (OSRELEASE), but some fixes are needed.
> > Because historically OSRELEASE has been a kind of a mandatory entry
> > in vmcoreinfo from the beginning of vmcoreinfo, so makedumpfile uses
> > its existence to check whether a vmcoreinfo is sane.
> 
> Well, init_uts_ns is exported in vmcoreinfo anyway - makedumpfile
> can simply test init_uts_ns.name.release just as well. And the
> "historically" argument doesn't matter because vmcoreinfo is not an ABI.
> 
> So makedumpfile needs to be changed to check that new export.
> 
> > Also, I think crash also will need to be fixed if it is removed.

Preferably it would be left as-is.  The crash utility has a "crash --osrelease vmcore"
option that only looks at the dumpfile header, and just dump the string.  With respect
to compressed kdumps, crash could alternatively look at the utsname data that is stored
in the diskdump_header.utsname field, but with ELF vmcores, there is no such back-up.
What's the problem with leaving it alone?

Dave


> 
> Yes, I'm expecting user tools to be fixed and then exports removed.
> 
> --
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
> 
