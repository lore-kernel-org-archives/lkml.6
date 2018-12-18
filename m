Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801EFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B3520578
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeLRDVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:21:06 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:61985 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726296AbeLRDVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:21:05 -0500
X-IronPort-AV: E=Sophos;i="5.56,367,1539619200"; 
   d="scan'208";a="50029433"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Dec 2018 11:20:58 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id EC45E4B75BF7;
        Tue, 18 Dec 2018 11:20:58 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Dec 2018 11:21:04 +0800
Date:   Tue, 18 Dec 2018 11:20:35 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <keescook@chromium.org>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v13 1/6] x86/boot: Introduce kstrtoull() to boot
 directory instead of simple_strtoull()
Message-ID: <20181218032034.GC10386@localhost.localdomain>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-2-fanc.fnst@cn.fujitsu.com>
 <20181212041218.GA28286@localhost.localdomain>
 <20181212080312.GP17340@MiWiFi-R3L-srv>
 <20181213132603.GD25287@zn.tnic>
 <20181217012728.GA31775@localhost.localdomain>
 <20181217154551.GF12165@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181217154551.GF12165@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: EC45E4B75BF7.AE278
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 04:45:51PM +0100, Borislav Petkov wrote:
>On Mon, Dec 17, 2018 at 09:27:28AM +0800, Chao Fan wrote:
>> Oops, I thought you agree with what Baoquan said, so I send the new version
>> and use simple_strtoull() back.
>
>I could've misunderstood him. Lemme repeat what I mean:
>
>- we should make kstrtoull() work because it is the right function to
>use. Which means, include this too:
>
>https://lkml.kernel.org/r/20181216203113.GA23823@zn.tnic
>
>- we should gradually start replacing simple_strtoull() in
>arch/x86/boot/ and eventually get rid of it. But that's for the TODO
>list, to take care of later.
>
OK, got it.
And I tested your solution(rename div_u64 as __div_u64, and div_u64_rem
as __div_u64_rem)for the issue from test rebot, that works.
Thank you very much.

Thanks,
Chao Fan
>- Take our time and stop with the hurrying and do the whole thing nice
>and clean.
>
>Ok?
>
>Or have I forgotten something?
>
>If not, I'll continue looking at your v13.
>
>Thx.
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


