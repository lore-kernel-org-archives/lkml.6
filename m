Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142F7C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75202087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75202087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeJHQJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:09:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:52790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726096AbeJHQJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:09:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1CE97B020;
        Mon,  8 Oct 2018 08:59:15 +0000 (UTC)
Date:   Mon, 8 Oct 2018 10:59:09 +0200
From:   Borislav Petkov <bp@suse.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/mm] kdump, proc/vmcore: Enable kdumping encrypted
 memory with SME enabled
Message-ID: <20181008085909.GC6490@zn.tnic>
References: <be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com>
 <tip-992b649a3f013465d8128da02e5449def662a4c3@git.kernel.org>
 <21eab36e-d113-cf88-e497-7dd620981544@redhat.com>
 <20181007084742.GA30797@zn.tnic>
 <58270f3f-f17c-8996-09cd-6da3481beb40@redhat.com>
 <20181008053714.GA6490@zn.tnic>
 <710b9d95-2f70-eadf-c4a1-c3dc80ee4ebb@redhat.com>
 <20181008080013.GB6490@zn.tnic>
 <8147597a-f8e0-7f1a-bd2b-e914b18c5c74@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8147597a-f8e0-7f1a-bd2b-e914b18c5c74@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 04:47:34PM +0800, lijiang wrote:
> It looks like a good way to avoid the 'ifdefined', and it's also good enough for i386.
> 
> But for other architectures, such as POWERPC/ARM..., we will also have to add the same 
> function for every architecture. Otherwise, i guess that they also have a same compile
> error on other architectures.

Yap, just realized that and looking at the rest of fs/proc/vmcore.c -
such functions are defined with the __weak attribute. Lemme see if that
works better.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
