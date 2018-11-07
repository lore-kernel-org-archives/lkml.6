Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4FDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547892086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547892086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeKHHXV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:23:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46247 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbeKHHXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:23:21 -0500
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wA7LoawS1655004
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 7 Nov 2018 13:50:36 -0800
Date:   Wed, 07 Nov 2018 13:50:28 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <7bc80811-8ab3-d26a-6fb3-b7aeebcfce43@deltatee.com>
References: <20181003213100.189959-1-namit@vmware.com> <20181003213100.189959-3-namit@vmware.com> <89262174-6f15-6116-e67f-436f7c1bfe99@deltatee.com> <6651971B-E3AB-4CDD-868C-2338593F7D83@vmware.com> <d0812681-4a8f-8cc4-24ce-d02002ee34d2@deltatee.com> <DC1EA50F-FAC3-4750-BCF7-0622D1FB4756@vmware.com> <a3902c4c-64b1-9c49-02fb-d5e4c9b04314@deltatee.com> <192946CF-8543-4CF5-B2A3-93674FCD07E2@vmware.com> <7bc80811-8ab3-d26a-6fb3-b7aeebcfce43@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v9 02/10] Makefile: Prepare for using macros for inline asm
To:     Logan Gunthorpe <logang@deltatee.com>,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>
From:   hpa@zytor.com
Message-ID: <85B77A64-5FF3-4B82-8A07-E045E259C985@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 7, 2018 1:43:39 PM PST, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>On 2018-11-07 11:56 a.m., Nadav Amit wrote:
>> HPA indicated more than once that this is wrong (and that was indeed
>my
>> initial solution), since it is not guaranteed that the compiler would
>put
>> the macro assembly before its use.
>
>Hmm, that's very unfortunate. I don't really understand why the
>compiler
>would not put the macro assembly in the same order as it appears in the
>code and it would be in the correct order there.
>
>In any case, I've submitted a couple of issues to icecc[1] and
>distcc[2]
>to see if they have any ideas about supporting this on their sides.
>
>Thanks,
>
>Logan
>
>[1] https://github.com/icecc/icecream/issues/428
>[2] https://github.com/distcc/distcc/issues/312

Apparently gcc will treat them like basic blocks and possibly move them around.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
