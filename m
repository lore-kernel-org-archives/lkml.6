Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59966C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 00:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3239620854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 00:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfANAA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 19:00:29 -0500
Received: from ozlabs.org ([203.11.71.1]:45147 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfANAA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 19:00:29 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43dDBK2wNNz9s3q;
        Mon, 14 Jan 2019 11:00:25 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Breno Leitao <leitao@debian.org>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH 4.20 41/65] Revert "powerpc/tm: Unset MSR[TS] if not recheckpointing"
In-Reply-To: <20190113071140.GD5540@kroah.com>
References: <20190111131055.331350141@linuxfoundation.org> <20190111131102.136630542@linuxfoundation.org> <1547328527@msgid.manchmal.in-ulm.de> <20190113071140.GD5540@kroah.com>
Date:   Mon, 14 Jan 2019 11:00:25 +1100
Message-ID: <87pnt0ds6e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Sat, Jan 12, 2019 at 10:35:59PM +0100, Christoph Biedl wrote:
>> Greg Kroah-Hartman wrote...
>> 
>> > 4.20-stable review patch.  If anyone has any objections, please let me know.
>> >
>> > ------------------
>> >
>> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >
>> > This reverts commit d412deb85a4aada382352a8202beb7af8921cd53 which is
>> > commit 6f5b9f018f4c7686fd944d920209d1382d320e4e upstream.
>> >
>> > It breaks the powerpc build, so drop it from the tree until a fix goes
>> > upstream.
>> 
>> Is this necessary on 4.20? The build failures I reported were on 4.19
>> only. The 4.20.2-rc1 kernel for my Powermac G5 builds with and without
>> that patch, both boot fine, no visible differences. Again however, Breno
>> is authoritative here.
>
> If there's no difference on 4.20, then maybe it's not needed there?  :)
>
> And yes, I would like confirmation from Breno as well.

You shouldn't need the revert on 4.20.

In 4.20 we changed how MSR_TM_ACTIVE() is defined, which means commit
6f5b9f018f4c ("powerpc/tm: Unset MSR[TS] if not recheckpointing") should
build fine on 4.20.

For 4.19 and earlier MSR_TM_ACTIVE() is different and that's what's
causing the build error.

I have a fix queued in my fixes tree and will push it to Linus in the
next few days.

cheers
