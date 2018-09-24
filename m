Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC0BECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 03:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A120821480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 03:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A120821480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeIXJnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 05:43:14 -0400
Received: from ozlabs.org ([203.11.71.1]:53899 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeIXJnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 05:43:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42JVR16ZX3z9s5c;
        Mon, 24 Sep 2018 13:43:09 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-next <linux-next@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Sep 20
In-Reply-To: <CAL_JsqLRRCdOWABiTYHp7jupdiLfPRv95OSKWVB-HX=cevdQMg@mail.gmail.com>
References: <20180920151243.5524c6ca@canb.auug.org.au> <87d0t8jvym.fsf@concordia.ellerman.id.au> <20180920210711.4561abee@canb.auug.org.au> <20180920211755.1fabd744@canb.auug.org.au> <CAL_JsqLRRCdOWABiTYHp7jupdiLfPRv95OSKWVB-HX=cevdQMg@mail.gmail.com>
Date:   Mon, 24 Sep 2018 13:43:09 +1000
Message-ID: <871s9j7e7m.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:
> On Thu, Sep 20, 2018 at 4:18 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> On Thu, 20 Sep 2018 21:10:08 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> > On Thu, 20 Sep 2018 20:37:37 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>> > > Oodles of:
>> > >
>> > >   # < make -s -j 48 ARCH=arm64 O=/kisskb/build/linux-next_arm64-allnoconfig_arm64 CROSS_COMPILE=/opt/cross/kisskb/br-aarch64-glibc-2016.08-613-ge98b4dd/bin/aarch64-linux-  allnoconfig
>> > >   # make -s -j 48 ARCH=arm64 O=/kisskb/build/linux-next_arm64-allnoconfig_arm64 CROSS_COMPILE=/opt/cross/kisskb/br-aarch64-glibc-2016.08-613-ge98b4dd/bin/aarch64-linux-
>> > >   /bin/sh: 1: pkg-config: not found
>>       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> > don't have it installed on my build machine either ...  do we have
>> > pkg-config installed in the build images?
>>
>> Duh! ;-)
>>
>> According to the commit message we gained a kconfig dependency on
>> pkg-config in 4.18.  I wonder what else depends on it.
>>
>> Ah:
>>
>> "pkg-config
>> ----------
>>
>> The build system, as of 4.18, requires pkg-config to check for installed
>> kconfig tools and to determine flags settings for use in
>> 'make {g,x}config'.  Previously pkg-config was being used but not
>> verified or documented."
>
> Looks like until a recent commit, this also included nconfig and
> menuconfig, but those were dropped after some complaints. I'll rework
> this to make things work with pkg-config.

OK thanks.

I'll install pkg-config in the kisskb builders anyway, so in future at
least that part will work.

cheers
