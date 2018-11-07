Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26052C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55B12086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55B12086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeKHHQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:16:16 -0500
Received: from ale.deltatee.com ([207.54.116.67]:50270 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbeKHHQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:16:16 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gKVbz-0006fO-FZ; Wed, 07 Nov 2018 14:43:44 -0700
To:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-3-namit@vmware.com>
 <89262174-6f15-6116-e67f-436f7c1bfe99@deltatee.com>
 <6651971B-E3AB-4CDD-868C-2338593F7D83@vmware.com>
 <d0812681-4a8f-8cc4-24ce-d02002ee34d2@deltatee.com>
 <DC1EA50F-FAC3-4750-BCF7-0622D1FB4756@vmware.com>
 <a3902c4c-64b1-9c49-02fb-d5e4c9b04314@deltatee.com>
 <192946CF-8543-4CF5-B2A3-93674FCD07E2@vmware.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7bc80811-8ab3-d26a-6fb3-b7aeebcfce43@deltatee.com>
Date:   Wed, 7 Nov 2018 14:43:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <192946CF-8543-4CF5-B2A3-93674FCD07E2@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, linux-kbuild@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de, michal.lkml@markovi.net, sam@ravnborg.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, namit@vmware.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v9 02/10] Makefile: Prepare for using macros for inline
 asm
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-11-07 11:56 a.m., Nadav Amit wrote:
> HPA indicated more than once that this is wrong (and that was indeed my
> initial solution), since it is not guaranteed that the compiler would put
> the macro assembly before its use.

Hmm, that's very unfortunate. I don't really understand why the compiler
would not put the macro assembly in the same order as it appears in the
code and it would be in the correct order there.

In any case, I've submitted a couple of issues to icecc[1] and distcc[2]
to see if they have any ideas about supporting this on their sides.

Thanks,

Logan

[1] https://github.com/icecc/icecream/issues/428
[2] https://github.com/distcc/distcc/issues/312


