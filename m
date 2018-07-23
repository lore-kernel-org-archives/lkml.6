Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C68ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3510B20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3510B20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388191AbeGWKaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:30:03 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:45150 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388080AbeGWKaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:30:02 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w6N9Sfve029815;
        Mon, 23 Jul 2018 10:28:41 +0100
Date:   Mon, 23 Jul 2018 10:28:41 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, linux-s390@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
Message-ID: <20180723102841.58ea373b@alans-desktop>
In-Reply-To: <ae3e5320-b389-e8af-2905-1ccc37953da3@oracle.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
        <20180718022211.6259-21-pasha.tatashin@oracle.com>
        <20180719103340.GA2494@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1807191300150.1602@nanos.tec.linutronix.de>
        <4295075b-8a0f-1723-2e80-1bbd2f038846@oracle.com>
        <alpine.DEB.2.21.1807191817080.1693@nanos.tec.linutronix.de>
        <CAGM2reYpApca9v-2qpVbTGXGVWiEEL5mkEWzTAvXFiztmtkh1Q@mail.gmail.com>
        <CAGM2rebBN0v0epfTssM=ShiWZ4GTDaN_cgGWdKE4+k+jV6CxyA@mail.gmail.com>
        <alpine.DEB.2.21.1807192240260.1693@nanos.tec.linutronix.de>
        <ae3e5320-b389-e8af-2905-1ccc37953da3@oracle.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> If we determined tsc early in boot using one of the quick methods:
> >> from cpuid/msr/quick_pit, can we assume that frequencies of all other
> >> CPUs will be determined the same way? Or do we still have to fallback

Not on 32bit at least. You can have a mixed slot 1 SMP system such as
an ASUS BP6 with cores at say 300 and 450MHz.

Now whether you'll find any such system in the world today is another
question.

Alan
