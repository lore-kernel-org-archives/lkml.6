Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D94C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DFF25920
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gDqrYbgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DFF25920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933720AbeFYMdY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:33:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43722 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932404AbeFYMdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:33:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5PCSlqg148661;
        Mon, 25 Jun 2018 12:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=hv9kgK4BvTix7pTyYy5PUrlPwxEkyZbVY8rE50tBZOU=;
 b=gDqrYbgK09UD0ZxIGYhPekkzipcmY7oDZuUsbSwAw7gHgjoljw7v20buaYkNAdcHsnSp
 4k0yRdhfYrfN1rP0HGqULysma6VMynPFwFuTVMgl+u2GooCvNcvanpUsv+xEXLTC5e+b
 nDkghRWZ/2dcnXa4T0aIIxaOnvoa5gGzv6bEkCoujR1XuKg87PkyMQm84IgEQBsXJbEL
 UxfpBL1Axk7WYRC9q08puLvUkYk9c3mh9LD9ySBAFvhUQXJkA0rPwBTev1RXUqfZgLQu
 r8ZnPgezRdyC7SCW2GAmJVbgpzi14+TCom9Jf0EOWhjrDynzXNPq4JmTWpHE5NGU63vH Jw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jt8a7jf8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 12:33:21 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5PCXIN7026265
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jun 2018 12:33:18 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5PCXIrq010631;
        Mon, 25 Jun 2018 12:33:18 GMT
Received: from mail-ot0-f169.google.com (/74.125.82.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Jun 2018 05:33:18 -0700
Received: by mail-ot0-f169.google.com with SMTP id w13-v6so14813920ote.11;
        Mon, 25 Jun 2018 05:33:18 -0700 (PDT)
X-Gm-Message-State: APt69E0y1T7rYHLtsz65PjThkV/uN8uec0DBzj2uG0YOyR6HNwzK3KBb
        I16ueYgb4k3WXS1qfcBZg756jKWLoNoo30r9IWI=
X-Google-Smtp-Source: ADUXVKIa7TQ+eLr2wMCp8kb1Vv7lEetTnjF2xp9avu9PD4jE9S6M86FT0oFp6drDKQRLZ88ayyodNsisvMPRo9rPsC4=
X-Received: by 2002:a9d:55d0:: with SMTP id z16-v6mr7700606oti.176.1529929997791;
 Mon, 25 Jun 2018 05:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-2-pasha.tatashin@oracle.com> <20180625081429.GS2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806251038190.8650@nanos.tec.linutronix.de>
 <20180625090915.GV2494@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1806251112460.8650@nanos.tec.linutronix.de>
 <20180625092229.GW2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180625092229.GW2494@hirez.programming.kicks-ass.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 25 Jun 2018 08:32:41 -0400
X-Gmail-Original-Message-ID: <CAGM2rebqeEwQfYBAQT=SNLceMQ1fruG2zMqQN6hM1JA_KedR0A@mail.gmail.com>
Message-ID: <CAGM2rebqeEwQfYBAQT=SNLceMQ1fruG2zMqQN6hM1JA_KedR0A@mail.gmail.com>
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
 engine=8.0.1-1806210000 definitions=main-1806250146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> It _should_ all work.. but scary, who knows where this early stuff ends
> up being used.

I have tested this patch, and the following patch, which moves the
jump label init early and it works as Thomas describes:
on_each_cpu() ends up calling only the current CPU.

Also, you mentioned:
> And I added a sync_core() in text_poke_early(), which I think we need
> for this.

text_poke_bp() ends up calling on_each_cpu(do_sync_core, NULL, 1);
which is called on boot CPU, and thus sync_core is called. If we keep
this patch we can remove sync_core() change from the next patch.

However, the other way to fix this bug is to change:
arch/x86/kernel/jump_label.c

-void arch_jump_label_transform(struct jump_entry *entry,
+void __ref arch_jump_label_transform(struct jump_entry *entry,
                               enum jump_label_type type)
 {
+       void *(*poker)(void *, const void *, size_t) = NULL;
+
+       if (unlikely(!after_bootmem))
+               poker = text_poke_early;
+
        mutex_lock(&text_mutex);
-       __jump_label_transform(entry, type, NULL, 0);
+       __jump_label_transform(entry, type, poker, 0);
        mutex_unlock(&text_mutex);
 }

Also, modify text_poke_early to call sync_core().

Of course, this way won't prevent us from having some other code
calling text_poke() in the future during boot where uninitialized
memory access is possible. If text_poke() is called sufficiently
early, it will fail because virt_to_page() will fail, but there is an
interval, where virt_to_page() succeeds (after paging_init()), but
pages are not yet initialized (before mem_init()). To safeguard us we
could add:

BUG_ON(!after_bootmem);

To text_poke()

Thank you,
Pavel
