Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05E8C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC58A20823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VWhNVLJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfBEVOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:14:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44166 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfBEVOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:14:03 -0500
Received: from zn.tnic (p200300EC2BCB6B00797C377B31151E15.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:6b00:797c:377b:3115:1e15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A3A71EC056D;
        Tue,  5 Feb 2019 22:14:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549401241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZJHABn0dyh+t3i3sM6/EgOIuu4yVozC72rooMCM8MLA=;
        b=VWhNVLJEBdGCePlk8D/LcPnNKGAR0Z8VFLuP+34RBJ0tKaRMvtKiJvTyD3AN3AuHQ6S+j/
        sMpPRSfnT69babZEe+znpzRAQ7XcBKsLh0bAyulzuHEfpSFFtK47ymBRm1eAK2BfMjC5R3
        /sMgPmmPZcCqY/GTg4GZcrStAlJa+Fg=
Date:   Tue, 5 Feb 2019 22:13:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V4 2/9] jump_label: Add the jump_label_can_update_check()
 helper
Message-ID: <20190205211348.GV21801@zn.tnic>
References: <cover.1549308412.git.bristot@redhat.com>
 <36237a0ee38d6c98d080d3fee2921501d8788e4d.1549308412.git.bristot@redhat.com>
 <20190205072220.GD21801@zn.tnic>
 <cb65e500-44dd-873c-622f-b49b9336b6a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb65e500-44dd-873c-622f-b49b9336b6a2@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 02:50:39PM +0100, Daniel Bristot de Oliveira wrote:
> >> +		if (jump_label_can_update_check(entry, init)) {
> >> +			arch_jump_label_transform(entry,
> >> +						  jump_label_type(entry));
> > 
> > Yeah, let that one stick out.
> 
> I did not get this part...

Just let the line stick outside of the 80 cols rule which is not a hard
one:

+          if (jump_label_can_update_check(entry, init)) {
+                  arch_jump_label_transform(entry, jump_label_type(entry));


:-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
