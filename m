Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A30DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD2321852
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545209062;
	bh=4r+dRctn9Elp8PUxd8G0AXxXAjon3w536tugtQqj0xY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=lgtoforghy5O/kUbCX93OjUoAEYk0Z7MKYxA+Cjd/uD+dRJyn7WT8EA0lNEIuQ7eg
	 1OGlFUmyid9NK7c6lg65Xczkpv0hrCh3m2iLgA/36kxJU/1kSXx92wRRrFp/XJb8K3
	 A7z1V5b9APjkbgr2u8PyoslwAVijaP1KXee3Q5HY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeLSIoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:44:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:47848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726631AbeLSIoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:44:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B1ABEAE88;
        Wed, 19 Dec 2018 08:44:18 +0000 (UTC)
Date:   Wed, 19 Dec 2018 09:44:17 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Zhou Chengming <zhouchengming1@huawei.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V2 5/9] x86/alternative: Split text_poke_bp() into tree
 steps
In-Reply-To: <0ae51df28b823b7ac22be513a65d8c24d3aabb10.1545149539.git.bristot@redhat.com>
Message-ID: <nycvar.YFH.7.76.1812190944040.17216@cbobk.fhfr.pm>
References: <cover.1545149539.git.bristot@redhat.com> <0ae51df28b823b7ac22be513a65d8c24d3aabb10.1545149539.git.bristot@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018, Daniel Bristot de Oliveira wrote:

> text_poke_bp() updates instructions on live kernel on SMP in three steps:
>  1) add a int3 trap to the address that will be patched
>  2) update all but the first byte of the patched range
>  3) replace the first byte (int3) by the first byte of
> 
> This patch creates one function for each of these steps.
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: Zhou Chengming <zhouchengming1@huawei.com>
> Cc: Jiri Kosina <jkosina@suse.cz>

Acked-by: Jiri Kosina <jkosina@suse.cz>

-- 
Jiri Kosina
SUSE Labs

