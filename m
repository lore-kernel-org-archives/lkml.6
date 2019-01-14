Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BEFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBE02064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfANU0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:26:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfANU0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:26:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0299599CE9;
        Mon, 14 Jan 2019 20:26:33 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E05C75C1B4;
        Mon, 14 Jan 2019 20:26:32 +0000 (UTC)
Received: from zmail24.collab.prod.int.phx2.redhat.com (zmail24.collab.prod.int.phx2.redhat.com [10.5.83.30])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id BBFCE1800540;
        Mon, 14 Jan 2019 20:26:32 +0000 (UTC)
Date:   Mon, 14 Jan 2019 15:26:32 -0500 (EST)
From:   Dave Anderson <anderson@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        linux-doc@vger.kernel.org
Message-ID: <221183717.69773903.1547497592624.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190114201812.GT2773@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com> <20190114180142.GO2773@zn.tnic> <2126185079.69727846.1547492312033.JavaMail.zimbra@redhat.com> <20190114192144.GQ2773@zn.tnic> <134663991.69764038.1547494607008.JavaMail.zimbra@redhat.com> <20190114195940.GS2773@zn.tnic> <244986363.69770015.1547496453312.JavaMail.zimbra@redhat.com> <20190114201812.GT2773@zn.tnic>
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.17.201, 10.4.195.15]
Thread-Topic: kdump: add the vmcoreinfo documentation
Thread-Index: XfbVibwlwdOZbF9bts4NjDtwe/BoTQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 14 Jan 2019 20:26:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> On Mon, Jan 14, 2019 at 03:07:33PM -0500, Dave Anderson wrote:
> > That's what it *does* utilize -- it takes a standalone vmcore dumpfile, and
> > pulls out the OSRELEASE string from it, so that a user can determine what
> > vmlinux file should be used with that vmcore for normal crash analysis.
> 
> And the vmcoreinfo is part of the vmcore, right?

Correct.

> 
> So it can just as well read out the address of init_uts_ns and get the
> kernel version from there.

No.  It needs *both* the vmlinux file and the vmcore file in order to read kernel
virtual memory, so just having a kernel virtual address is insufficient.

So it's a chicken-and-egg situation.  This particular --osrelease option is used
to determine *what* vmlinux file would be required for an actual crash analysis 
session.

Dave

 
