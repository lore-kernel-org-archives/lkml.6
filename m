Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE67AC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 13:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6635A2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 13:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6635A2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeJ0V7B convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 17:59:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36710 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbeJ0V7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 17:59:01 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 19h9vgsS5Hba; Sat, 27 Oct 2018 15:18:01 +0200 (CEST)
Received: from [10.0.0.178] (unknown [85.255.233.215])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 24FA01EC0469;
        Sat, 27 Oct 2018 15:18:01 +0200 (CEST)
Date:   Sat, 27 Oct 2018 14:17:58 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20181027110858.GB14493@MiWiFi-R3L-srv>
References: <20181026093630.8520-1-lijiang@redhat.com> <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de> <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com> <20181026182440.20a4b107@ezekiel.suse.cz> <20181026222517.GB26927@nazgul.tnic> <20181027081343.GA1884@MiWiFi-R3L-srv> <20181027091007.GB1046@nazgul.tnic> <20181027093917.GA14493@MiWiFi-R3L-srv> <20181027101221.GC1046@nazgul.tnic> <20181027110858.GB14493@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
To:     Baoquan He <bhe@redhat.com>
CC:     Petr Tesarik <ptesarik@suse.cz>, lijiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, mingo@redhat.com, tglx@linutronix.de,
        dyoung@redhat.com
From:   Boris Petkov <bp@alien8.de>
Message-ID: <C5F8ED8E-F361-4C6C-B9E2-E3C8BCD8E050@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 27, 2018 12:08:58 PM GMT+01:00, Baoquan He <bhe@redhat.com> wrote:
>OK, then it's fine to get the bit number, e.g calling
>find_first_bit(sme_me_mask, BITS_PER_LONG), and export it to
>vmcoreinfo. Thanks.

You can simply assign sme_me_mask for now...

-- 
Sent from a small device: formatting sux and brevity is inevitable. 
