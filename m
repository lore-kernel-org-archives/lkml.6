Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F64C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE192245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE192245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeKMOw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:52:57 -0500
Received: from ale.deltatee.com ([207.54.116.67]:59672 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeKMOw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:52:57 -0500
Received: from [64.114.255.114] (helo=[192.168.36.130])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gMQkK-00072u-Vf; Mon, 12 Nov 2018 21:56:18 -0700
To:     Nadav Amit <namit@vmware.com>, "hpa@zytor.com" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-3-namit@vmware.com>
 <89262174-6f15-6116-e67f-436f7c1bfe99@deltatee.com>
 <6651971B-E3AB-4CDD-868C-2338593F7D83@vmware.com>
 <d0812681-4a8f-8cc4-24ce-d02002ee34d2@deltatee.com>
 <DC1EA50F-FAC3-4750-BCF7-0622D1FB4756@vmware.com>
 <a3902c4c-64b1-9c49-02fb-d5e4c9b04314@deltatee.com>
 <192946CF-8543-4CF5-B2A3-93674FCD07E2@vmware.com>
 <7bc80811-8ab3-d26a-6fb3-b7aeebcfce43@deltatee.com>
 <85B77A64-5FF3-4B82-8A07-E045E259C985@zytor.com>
 <3B824A03-AB76-4B34-B1CA-F27C0F1B0575@vmware.com>
 <2c022676-9299-bb5f-023b-5c114cd79f81@deltatee.com>
 <080748A5-2588-47C9-BC2A-E643630FB9A7@vmware.com>
 <3ae6dd1f-9b59-8552-f438-c40b08771226@deltatee.com>
 <C0187502-9FC0-4FE2-BCD3-81B8B992F3A2@vmware.com>
 <88901B62-7D98-45A2-8881-352A31802933@vmware.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <258e793a-a7a6-526d-6be5-edba1c701a24@deltatee.com>
Date:   Mon, 12 Nov 2018 21:56:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <88901B62-7D98-45A2-8881-352A31802933@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 64.114.255.114
X-SA-Exim-Rcpt-To: mhiramat@kernel.org, sbates@raithlin.com, linux-kbuild@vger.kernel.org, tglx@linutronix.de, michal.lkml@markovi.net, sam@ravnborg.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, namit@vmware.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v9 02/10] Makefile: Prepare for using macros for inline
 asm
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/18 03:04 PM, Nadav Amit wrote:
> Err.. I hate makefiles and distcc doesn’t make life easier. For instance, if
> it sees two source files on the command-line, it freaks out and compiles it
> locally. It also has an option to distribute assembly, but it is not enabled
> by default.
> 
> Anyhow, can you try the following patch?

Very nice, great work! It works as expected. I tested with both distcc
and icecc and both work well with DISTCC=y.

Also worth noting, is that distcc has a patch to work without DISTCC=y
in pump mode (though pump mode doesn't work super great with the kernel
as some of the include processing takes a long time). When I have some
free time, I may also try to patch icecc to work with it, as in my
experience, it performs better.

Regardless, I think your patch would be very valuable to be in upstream
so there's at least some way to use the existing versions of distcc and
icecc.

Thanks!

Logan
