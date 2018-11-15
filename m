Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B49C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335F5214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335F5214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeKOMFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 07:05:54 -0500
Received: from ale.deltatee.com ([207.54.116.67]:45516 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeKOMFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 07:05:54 -0500
Received: from [64.114.255.114] (helo=[192.168.36.130])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gN6wv-00076v-DY; Wed, 14 Nov 2018 19:00:06 -0700
To:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181112150215.508-1-namit@vmware.com>
 <20181112150215.508-2-namit@vmware.com> <20181113113000.GB4788@gmail.com>
 <40E4E1B4-EF5F-43A1-B42C-C4CF6349FC62@vmware.com>
 <48577A3F-0F76-4CCA-A959-965344D7259F@vmware.com>
 <7ff5de62-d1df-9a67-1c86-497ce00a4de4@deltatee.com>
 <7072A2D8-30F8-45CB-AB0C-B1BE4A30259A@vmware.com>
 <db8293cf-9abc-e899-8f43-6e42039006d9@deltatee.com>
 <521458D7-A27C-4112-81ED-1974EFE96A76@vmware.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9c1f58b9-6750-bd90-28b6-b00296525c6e@deltatee.com>
Date:   Wed, 14 Nov 2018 19:00:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <521458D7-A27C-4112-81ED-1974EFE96A76@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 64.114.255.114
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, x86@kernel.org, hpa@zytor.com, bp@alien8.de, tglx@linutronix.de, michal.lkml@markovi.net, yamada.masahiro@socionext.com, mingo@redhat.com, mingo@kernel.org, namit@vmware.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/2] Makefile: Fix distcc compilation with x86 macros
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/11/18 06:57 PM, Nadav Amit wrote:
> As long as the argument was *required* to get distcc to work at all, you
> could expect people would figure out an argument is needed. In this case, I
> suspect nobody will ever know about this argument (except you).

I agree with this completely.

> Eventually, if you get a fix into icecc, we will need to change the
> Makefile, consider the version number and act accordingly.

Yeah, that's probably a sensible way forward.

> Anyhow, I’ll add an argument as you asked, and let Ingo (& others) be the

An argument to force it to a regular compile would at least help with
experimenting with this stuff.

Logan
