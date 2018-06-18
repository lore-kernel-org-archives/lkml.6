Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BF2C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B295520874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B295520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936020AbeFRSaT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:30:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39348 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935792AbeFRSaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:30:18 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OwJgGZZ3q_Fy; Mon, 18 Jun 2018 20:30:17 +0200 (CEST)
Received: from zn.tnic (p200300EC2BE29C00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2be2:9c00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3FA5B1EC01D4;
        Mon, 18 Jun 2018 20:30:17 +0200 (CEST)
Date:   Mon, 18 Jun 2018 20:30:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 8/8] x86/microcode/AMD: Don't scan past the CPU
 equivalence table data
Message-ID: <20180618183016.GF24921@zn.tnic>
References: <cover.1526767245.git.mail@maciej.szmigiero.name>
 <04a252b1e06673b8a1f62196093d0573d302fc1b.1526767245.git.mail@maciej.szmigiero.name>
 <20180605085506.GB27701@nazgul.tnic>
 <957d6884-f24b-0d40-7584-d4386d05af21@maciej.szmigiero.name>
 <20180618164434.GC24921@zn.tnic>
 <2de6c090-6927-e976-55f4-5ef29bd148f2@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2de6c090-6927-e976-55f4-5ef29bd148f2@maciej.szmigiero.name>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 08:11:53PM +0200, Maciej S. Szmigiero wrote:
> The equivalence table size can be computed in the late loader - there is
> no problem there.
> 
> However, this computed size needs to be passed somehow to functions
> scanning the equivalence table.

Ok, then let's make a compromise with a proper global descriptor which
gets passed around:

static struct equiv_cpu_table {
        struct equiv_cpu_entry *table;
        unsigned int size;
} *equiv_table;

But make that conversion in a prepatch pls.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
