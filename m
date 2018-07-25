Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60A0C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FD220852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p91YA/ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FD220852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbeGYOXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:23:52 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43251 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbeGYOXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:23:51 -0400
Received: by mail-qt0-f195.google.com with SMTP id f18-v6so7500795qtp.10;
        Wed, 25 Jul 2018 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jGj9s/g4GLrYFxbyFC0AOyW5LdQ4r/aEycEFCxeJLCA=;
        b=p91YA/ffQah5rkSeyKFZKx9fc6ktMNTr0YNmrP28/YNzCzKBjaG61wEJlB1Rf/TG61
         2cNcBiFfBCb4uAb6PmBjRiuoGGMGPCSXnHoZV5xfJ42a0PADtWhUjvekZNQw53y51ZQd
         RyfKjOfA0K4rpBOummR/j41wqxVV0zmODY4KQNZmDOh9PQevwQNMXdkCMwEYiis7kHVZ
         jRHRwsLjQgFQfAAif7OHcddeuu9Zb892fgc2t6bWU6Z8asv1nEkmLvAreSkWW57p98t+
         RFiUIaHioQLZjHlRVmh6FdgrZdtwtMfFoRZ5atNWfeXrDQpc+K96STXafuRPUsH2eQhy
         J2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jGj9s/g4GLrYFxbyFC0AOyW5LdQ4r/aEycEFCxeJLCA=;
        b=rx55sPjs7jEIjQcxKO3x3xf+Dp/qVEPHltQMsvcvj/UYTLugwrM2UApKJ8O5kHj3yw
         l5NHnxt6MxfCZNCP4XnE//zIxSq4ySjI8DpFzqdRJVp1xLBUO0nwZCYXEHA4GPmrdBOJ
         nqRcRlSy7TLYzQvJIwc0vzmdGy6g33K/cdGdMrKOwk498jYN44TBFAd9HlzeT4rVEqAp
         cV0wM/kk8FJpGnzf76ySzRTg8OJlIvBenFhYDBA0rORJuXvB8PD8OufNGLEnSlJHYdw6
         /u8zgsJoawOIke6Zwt37o1SMH+FH5mucty7dm4Tzk/Xn7SFXMNAU9zIChZH+jHdIT0x2
         pYUg==
X-Gm-Message-State: AOUpUlHhrb3UzipLCf/i/U+hkCkd1C87+1g7UV65f3scMQkcQgDoLR/H
        9gWmdX1J9Z9LduufZChWkypf9FPKOHlcRm3zGY7VV4J8
X-Google-Smtp-Source: AAOMgpf7yNY8m1agev6T6pHKQDblZweWXtwEGnDGISP2wYUG3YKqyDkchlcMwe1ZhrWEYFX+A/Gqx+yDpIdFhZcYk5M=
X-Received: by 2002:ac8:3676:: with SMTP id n51-v6mr20403800qtb.163.1532524332155;
 Wed, 25 Jul 2018 06:12:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 06:12:11
 -0700 (PDT)
In-Reply-To: <20180724175531.75276cf4e539124aa9e27177@linux-foundation.org>
References: <20180724111600.4158975-1-arnd@arndb.de> <20180724140010.e24a9964fd340afe2d98a994@linux-foundation.org>
 <aa39b6d15f44555cb79d5ebdef74aeab19003d6a.camel@perches.com> <20180724175531.75276cf4e539124aa9e27177@linux-foundation.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 25 Jul 2018 15:12:11 +0200
X-Google-Sender-Auth: OoKVbvWVbmSl4jK_VaAj-vDRpNA
Message-ID: <CAK8P3a3tOuP1FVS7oD1UhO5s4C+fLkL8VT3eCpRnSxBZxKzf6A@mail.gmail.com>
Subject: Re: [PATCH 1/4] treewide: convert ISO_8859-1 text comments to utf-8
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-iio@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tools/perf/tests/.gitignore:
                            LLVM byte-codes, uncompressed
On Wed, Jul 25, 2018 at 2:55 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 24 Jul 2018 17:13:20 -0700 Joe Perches <joe@perches.com> wrote:
>
>> On Tue, 2018-07-24 at 14:00 -0700, Andrew Morton wrote:
>> > On Tue, 24 Jul 2018 13:13:25 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>> > > Almost all files in the kernel are either plain text or UTF-8
>> > > encoded. A couple however are ISO_8859-1, usually just a few
>> > > characters in a C comments, for historic reasons.
>> > > This converts them all to UTF-8 for consistency.
>> []
>> > Will we be getting a checkpatch rule to keep things this way?
>>
>> How would that be done?
>
> I'm using this, seems to work.
>
>         if ! file $p | grep -q -P ", ASCII text|, UTF-8 Unicode text"
>         then
>                 echo $p: weird charset
>         fi

There are a couple of files that my version of 'find' incorrectly identified as
something completely different, like:

Documentation/devicetree/bindings/pinctrl/pinctrl-sx150x.txt:
            SemOne archive data
Documentation/devicetree/bindings/rtc/epson,rtc7301.txt:
            Microsoft Document Imaging Format
Documentation/filesystems/nfs/pnfs-block-server.txt:
            PPMN archive data
arch/arm/boot/dts/bcm283x-rpi-usb-host.dtsi:
        Sendmail frozen configuration  - version = "host";
Documentation/networking/segmentation-offloads.txt:
        StuffIt Deluxe Segment (data) : gmentation Offloads in the
Linux Networking Stack
arch/sparc/include/asm/visasm.h:                              SAS 7+
arch/xtensa/kernel/setup.c:                                         ,
init=0x454c, stat=0x090a, dev=0x2009, bas=0x2020
drivers/cpufreq/powernow-k8.c:
TI-XX Graphing Calculator (FLASH)
tools/testing/selftests/net/forwarding/tc_shblocks.sh:
                            Minix filesystem, V2 (big endian)
tools/perf/tests/.gitignore:
                            LLVM byte-codes, uncompressed

All of the above seem to be valid ASCII or UTF-8 files, so the check
above will lead
to false-positives, but it may be good enough as they are the
exception, and may be
bugs in 'file'.

Not sure if we need to worry about 'file' not being installed.

       Arnd
