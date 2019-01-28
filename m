Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2855BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 04:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0128217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 04:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfA1E4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 23:56:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfA1E4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 23:56:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50FDF369BC;
        Mon, 28 Jan 2019 04:18:28 +0000 (UTC)
Received: from treble (ovpn-120-147.rdu2.redhat.com [10.10.120.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD2CC1054FD4;
        Mon, 28 Jan 2019 04:18:27 +0000 (UTC)
Date:   Sun, 27 Jan 2019 22:18:25 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     valdis.kletnieks@vt.edu
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: next-20190125 - objtool complains about dumpstack
Message-ID: <20190128041825.db2fsdktmisvzq72@treble>
References: <27806.1548647103@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27806.1548647103@turing-police.cc.vt.edu>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 28 Jan 2019 04:18:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 10:45:03PM -0500, valdis.kletnieks@vt.edu wrote:
> Seen in a build:
> 
>   CC      arch/x86/kernel/dumpstack.o
> arch/x86/kernel/dumpstack.o: warning: objtool: oops_begin()+0x9: undefined stack state
> arch/x86/kernel/dumpstack.o: warning: objtool: oops_begin()+0x0: stack state mismatch: cfa1=6+16 cfa2=7+8
> 
> Probably a gcc9 code generation that objtool doesn't know about?

Can you share the .o file?

-- 
Josh
