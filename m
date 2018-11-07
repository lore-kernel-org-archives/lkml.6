Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E109C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F062086A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F062086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389048AbeKGKvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:51:04 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10500 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388065AbeKGKvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:51:04 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="47459736"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Nov 2018 09:22:55 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 29AA24B714AF;
        Wed,  7 Nov 2018 09:22:55 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 7 Nov 2018 09:22:59 +0800
Date:   Wed, 7 Nov 2018 09:21:45 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <mingo@redhat.com>, <hpa@zytor.com>, <keescook@chromium.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <ard.biesheuvel@linaro.org>, <indou.takao@jp.fujitsu.com>,
        <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181107012145.GA2683@localhost.localdomain>
References: <20181015005035.z3xym6nx43hogdge@gabell>
 <20181016151353.punyk7exekut2543@gabell>
 <20181016191113.GI5212@zn.tnic>
 <20181016195429.tovdgqq77gz3eek2@gabell>
 <20181016195902.GK5212@zn.tnic>
 <20181022154204.kagmdb55jtoez4ca@gabell>
 <20181025103345.GF14020@nazgul.tnic>
 <20181025134050.ggiir77ehntikbwg@gabell>
 <20181106121023.GF13712@zn.tnic>
 <20181106140731.GO27491@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181106140731.GO27491@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 29AA24B714AF.AC36C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 10:07:31PM +0800, Baoquan He wrote:
>On 11/06/18 at 01:10pm, Borislav Petkov wrote:
>> > I have another idea to solve this issue. Adding a SRAT parsing code
>> > to arch/x86/mm/kaslr.c. It is useful for both EFI and BIOS and
>> > also we don't need a new kernel parameter...
>> > Dose the idea make sense?
>> 
>> The more automatic stuff we do and we don't have to involve the user,
>> the better.
>> 
>> However, lemme look at Chao's current patchset first - we should not go
>> nuts by putting SRAT parsing everywhere :)
>
>arch/x86/mm/ident_map.c is a good example, it's shared between
>arch/x86/boot/compressed and arch/x86/mm/init_64.c

Thanks to Baoquan, I think we can try this idea.
How about you, Masa?

Thanks,
Chao Fan

>
>


