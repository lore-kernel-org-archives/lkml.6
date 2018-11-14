Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EA1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CED2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CED2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbeKNRby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:31:54 -0500
Received: from ale.deltatee.com ([207.54.116.67]:39404 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbeKNRbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:31:53 -0500
Received: from [64.114.255.114] (helo=[192.168.36.130])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gMpcS-0001Lx-AB; Wed, 14 Nov 2018 00:29:49 -0700
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
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7ff5de62-d1df-9a67-1c86-497ce00a4de4@deltatee.com>
Date:   Wed, 14 Nov 2018 00:29:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <48577A3F-0F76-4CCA-A959-965344D7259F@vmware.com>
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



On 13/11/18 11:34 AM, Nadav Amit wrote:
> Just one question before I send v2, since I have second thoughts. Does it
> make sense to require the “DISTCC” make parameter, or should it be set in
> the Kconfig? It can be detected automatically, the same way gcc/clang are
> detected or manually through a config option.

I very much prefer the make variable as it can be set in the environment
without having to change the Kconfig.

Logan

