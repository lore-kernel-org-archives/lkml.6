Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A764C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AE42133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fzhP/+On"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbeLQPp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:45:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37210 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbeLQPp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:45:59 -0500
Received: from zn.tnic (p200300EC2BC8CE00C4C70519B169D9D7.dip0.t-ipconnect.de [IPv6:2003:ec:2bc8:ce00:c4c7:519:b169:d9d7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 94EF01EC040F;
        Mon, 17 Dec 2018 16:45:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545061557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QA0vHWjI5u1277fwGrBmFsolGzwwOvCY9AD7CFaIK4o=;
        b=fzhP/+OnFTN7doBHJ7PTnWGg+4UrwTOfYFQ1xvv/+LuYCnJck9YAJq6B7m1SELjgpOXgYE
        5ElmIMt7lDBP2i58qi0MbdBHhAQmvBM/w6Kcp9tSfef7zC4NbO5D6FSh2BHgf/YWoMJisp
        9gjFUkLwuTSm6SBopcsDK26MeStSz3w=
Date:   Mon, 17 Dec 2018 16:45:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, keescook@chromium.org, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v13 1/6] x86/boot: Introduce kstrtoull() to boot
 directory instead of simple_strtoull()
Message-ID: <20181217154551.GF12165@zn.tnic>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-2-fanc.fnst@cn.fujitsu.com>
 <20181212041218.GA28286@localhost.localdomain>
 <20181212080312.GP17340@MiWiFi-R3L-srv>
 <20181213132603.GD25287@zn.tnic>
 <20181217012728.GA31775@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181217012728.GA31775@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 09:27:28AM +0800, Chao Fan wrote:
> Oops, I thought you agree with what Baoquan said, so I send the new version
> and use simple_strtoull() back.

I could've misunderstood him. Lemme repeat what I mean:

- we should make kstrtoull() work because it is the right function to
use. Which means, include this too:

https://lkml.kernel.org/r/20181216203113.GA23823@zn.tnic

- we should gradually start replacing simple_strtoull() in
arch/x86/boot/ and eventually get rid of it. But that's for the TODO
list, to take care of later.

- Take our time and stop with the hurrying and do the whole thing nice
and clean.

Ok?

Or have I forgotten something?

If not, I'll continue looking at your v13.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
