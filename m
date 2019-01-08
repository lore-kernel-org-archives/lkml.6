Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E42C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FE8206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfAHKOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:14:14 -0500
Received: from ozlabs.org ([203.11.71.1]:58921 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbfAHKON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:14:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Yp5D5H79z9sDr;
        Tue,  8 Jan 2019 21:14:08 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh+dt@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Mackerras <paulus@samba.org>, devicetree@vger.kernel.org,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: build dtb even without COMPILE_TEST
In-Reply-To: <CAL_Jsq+Wo7kWTHg6f+HkTfq1=JN8r4iBrwSz9JRdJ0rhjyKSpg@mail.gmail.com>
References: <1546595897-33291-1-git-send-email-clabbe@baylibre.com> <CAL_Jsq+Wo7kWTHg6f+HkTfq1=JN8r4iBrwSz9JRdJ0rhjyKSpg@mail.gmail.com>
Date:   Tue, 08 Jan 2019 21:14:07 +1100
Message-ID: <87bm4rtq1c.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh+dt@kernel.org> writes:
> On Fri, Jan 4, 2019 at 3:58 AM Corentin Labbe <clabbe@baylibre.com> wrote:
>>
>> I wanted to test the virtex440-ml507 qemu machine and found that the dtb
>> for it was not builded.
>
> Just do:
>
> make virtex440-ml507.dtb

I actually thought you had to do that, so I've never done anything different.

>> All powerpc DTB are only built when CONFIG_OF_ALL_DTBS is set which depend on
>> COMPILE_TEST.
>> But building DTB is not related to a "compile build test".
>
> But it is. We normally only build the dtbs for enabled platforms just
> like we only build platform/driver code for enabled platforms. It's
> hidden behind COMPILE_TEST so it only gets enabled for
> allmodconfig/allyesconfig builds.
>
>> So this patch made building of DTB independent of COMPILE_TEST (by
>> depending only on the PPC arch)
>> A better selection of which DTB to build could be done in the future
>> like that do the ARM arch.
>
> No reason you can't start that now for the platform you care about.
> You don't have to convert everyone.

Yeah that seems like the best option. I'm happy to take a patch just for
that target.

cheers
