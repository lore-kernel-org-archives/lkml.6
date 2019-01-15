Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6F1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6675D20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfAOLbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 06:31:34 -0500
Received: from ozlabs.org ([203.11.71.1]:39345 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbfAOLbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 06:31:33 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43f7TG5sg3z9sCh;
        Tue, 15 Jan 2019 22:31:30 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Will Deacon <will.deacon@arm.com>,
        "Koenig\, Christian" <Christian.Koenig@amd.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michel =?utf-8?Q?D=C3=A4nz?= =?utf-8?Q?er?= 
        <michel@daenzer.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Carsten Haitzler <Carsten.Haitzler@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Huang\, Ray" <Ray.Huang@amd.com>,
        "Zhang\, Jerry" <Jerry.Zhang@amd.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bernhard =?utf-8?Q?Rosenkr=C3=A4n?= =?utf-8?Q?zer?= 
        <Bernhard.Rosenkranzer@linaro.org>, benh@kernel.crashing.org
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
In-Reply-To: <20190114193548.GB29600@fuggles.cambridge.arm.com>
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org> <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net> <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com> <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com> <CAKv+Gu_JyO2KNtdN1-_TcoL_kqs0yswdwBrpAXA6-jyWuDrj+g@mail.gmail.com> <9f956898-7973-98ee-6bf1-e1d445e9d365@amd.com> <20190114191350.GA29600@fuggles.cambridge.arm.com> <a6d9d0ad-d1c0-9e60-17c6-a42f7bde258c@amd.com> <20190114193548.GB29600@fuggles.cambridge.arm.com>
Date:   Tue, 15 Jan 2019 22:31:29 +1100
Message-ID: <87a7k2yx66.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Will Deacon <will.deacon@arm.com> writes:
> [+ BenH and MPE]
>
> On Mon, Jan 14, 2019 at 07:21:08PM +0000, Koenig, Christian wrote:
>> Am 14.01.19 um 20:13 schrieb Will Deacon:
...
>
>> > The Arm architecture (and others including Power afaiu) doesn't
>> > guarantee coherency when memory is accessed using mismatched cacheability
>> > attributes.
...
>
>> As far as I know Power doesn't really supports un-cached memory at all, 
>> except for a very very old and odd configuration with AGP.
>
> Hopefully Michael/Ben can elaborate here, but I was under the (possibly
> mistaken) impression that mismatched attributes could cause a machine-check
> on Power.

That's what I've always been told, but I can't actually find where it's
documented, I'll keep searching.

But you're right that mixing cached / uncached is not really supported,
and probably results in a machine check or worse.

cheers
