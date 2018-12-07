Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CE8C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBB0208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBB0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLGQeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:34:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeLGQeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:34:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82E5F30016E7;
        Fri,  7 Dec 2018 16:34:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.131])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6C81D1974D;
        Fri,  7 Dec 2018 16:34:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  7 Dec 2018 17:34:16 +0100 (CET)
Date:   Fri, 7 Dec 2018 17:34:10 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] powerpc/ptrace: replace ptrace_report_syscall() with
 a tracehook call
Message-ID: <20181207163410.GA19110@redhat.com>
References: <20181116121701.14359da0@akathisia>
 <87ftw12nyn.fsf@concordia.ellerman.id.au>
 <20181119210139.GA8360@altlinux.org>
 <87efbe166y.fsf@concordia.ellerman.id.au>
 <20181203031823.GE11573@altlinux.org>
 <20181207011946.GA18558@altlinux.org>
 <87y391k2tq.fsf@concordia.ellerman.id.au>
 <20181207154255.GA28964@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207154255.GA28964@altlinux.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 07 Dec 2018 16:34:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07, Dmitry V. Levin wrote:
>
> On Fri, Dec 07, 2018 at 10:12:49PM +1100, Michael Ellerman wrote:
>
> > > Sorry, this patch does not work, please ignore it.
> >
> > Hmm OK. Why exactly?
>
> Unfortunately, I have no idea why it doesn't work.
> All I can say is it breaks strace because the kernel no longer sends
> syscall entry stops.

May be because TIF_SYSCALL_EMU/etc is a bit number, not a mask? IOW, rather
than

	whatever & TIF_XXX

you should do

	whatever & _TIF_XXX

intstead?

Oleg.

