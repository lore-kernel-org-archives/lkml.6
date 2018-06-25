Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA1DC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473D725B00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qb0/+fZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473D725B00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934275AbeFYOG5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:06:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55782 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934074AbeFYOGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:06:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5PE450X028744;
        Mon, 25 Jun 2018 14:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=7ndiITZ+2qweKohVfD8O03LlwPBea3Eg9F3AGiqEUu0=;
 b=qb0/+fZIpx6xjocuq0f6a8L6KATV0j92v/AJ1bcW4JoJpVJN6NVWct31+k/ZECb/qlem
 WJkpnpcwnGAkW+WqQT0ozxz4i6OzBL2r47Fahx8VxmkzZsM803Bc96lks09r4R9mkPLa
 X77GRTfCIXp/M7Nqel0+/BA5K0Fsqf5kXWY+5e6wBzWkt0Hp1BaoCNC9P6bAEe1rXC1w
 fQmDjPcApvWhKS83BS1W9fE0vJEdxCgCiitYL6clonJWiuK0WXj4RYaoVs3qyj5wREqJ
 eGMXeiScUe2Ssgf3iwexk6hp73A6dyPzZisjj7mSM9eQN8vXN4CtDKJ7QFvWJILaeqEp UA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jt8a7jv3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 14:06:54 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5PE6lLU025571
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 14:06:47 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5PE6l3t010999;
        Mon, 25 Jun 2018 14:06:47 GMT
Received: from mail-oi0-f51.google.com (/209.85.218.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Jun 2018 07:06:47 -0700
Received: by mail-oi0-f51.google.com with SMTP id 21-v6so1927416oip.8;
        Mon, 25 Jun 2018 07:06:46 -0700 (PDT)
X-Gm-Message-State: APt69E35RXv8v4d2KiPPg5CrYUWim3wNiTHPCCaMWVTgEsAQetnlWKzd
        iWYsh9qYySv7GlGvaGYQscLc45hYwXpEZ3V3aNM=
X-Google-Smtp-Source: ADUXVKLjeG0TIKvXJ1AN0OFOCMlGgDktHbT4Kf00mK0/d6v6tqzHbiNB/tH3c+kc8Fe+n9SGIYXsvUzCWxJWdqYhC1E=
X-Received: by 2002:aca:3b09:: with SMTP id i9-v6mr7467357oia.156.1529935606442;
 Mon, 25 Jun 2018 07:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-2-pasha.tatashin@oracle.com> <20180625081429.GS2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806251038190.8650@nanos.tec.linutronix.de>
 <20180625090915.GV2494@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1806251112460.8650@nanos.tec.linutronix.de>
 <20180625092229.GW2494@hirez.programming.kicks-ass.net> <CAGM2rebqeEwQfYBAQT=SNLceMQ1fruG2zMqQN6hM1JA_KedR0A@mail.gmail.com>
 <20180625134851.GB2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180625134851.GB2494@hirez.programming.kicks-ass.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 25 Jun 2018 10:06:10 -0400
X-Gmail-Original-Message-ID: <CAGM2reaOZiCsJbLonrZH0-uPQFLG4Xek0mJ4gNZe7K6iJFU=Xw@mail.gmail.com>
Message-ID: <CAGM2reaOZiCsJbLonrZH0-uPQFLG4Xek0mJ4gNZe7K6iJFU=Xw@mail.gmail.com>
Subject: Re: [PATCH v12 01/11] x86: text_poke() may access uninitialized
 struct pages
To:     peterz@infradead.org
Cc:     tglx@linutronix.de, Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8934 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806250164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, I think the better condition is @early_boot_irqs_disabled, until
> we enable IRQs for the first time, text_poke_early() should be fine. And
> once we enable interrupts, all that other crud should really be working.

Sure, I will use early_boot_irqs_disabled flag. I think, we still want
to have BUG_ON(!after_bootmem); in text_poke(). I could do
BUG_ON(early_boot_irqs_disabled), but I am worried that there are call
sites that might be using text_poke() between mem_init() and
local_irq_enable() in start_kernel().

>
> This gives:
>
> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
> index e56c95be2808..425ba6102828 100644
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -46,6 +46,9 @@ static void __jump_label_transform(struct jump_entry *entry,
>         const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
>         const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
>
> +       if (early_boot_irqs_disabled)
> +               poker = text_poke_early;
> +
>         if (type == JUMP_LABEL_JMP) {
>                 if (init) {
>                         /*
>
> > Also, modify text_poke_early to call sync_core().

Also, we still need to add __ref to __jump_label_transform as
text_poke_early() is __init
