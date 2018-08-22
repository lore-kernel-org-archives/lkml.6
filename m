Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7C7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3832D206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG/osBXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3832D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeHVMxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:53:02 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35238 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbeHVMxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:53:02 -0400
Received: by mail-vk0-f45.google.com with SMTP id w193-v6so572538vke.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LfnPXIVY0w4Vah+h3Qix6eITdiDEsLRcPZ/kAE53N/0=;
        b=GG/osBXovEUOA3/uCiSgARDPt6fsRr2wzimal2+rtyzFCKw6ntIwggO4CK143UMsLE
         Ht5HU3KeAOE1tlpvWlHts0DH5wcr0JAOnxcL1anHMnEUpYN+ZVdpTdYXCrDRlxX+p/lY
         nuUJrFuHxh528hct2s5oh6l49Yf/ZzT09KyXwAQ77EQbHcq1XiuCu2lD03JoHpQ9ZRoy
         3b9huNdJv+2ML1SSELYtonsTCYvLaezUe4BIGIljINZeSWDsUBQxEW4HlEWla53maF5H
         ZqgRlT4NxIgVjazrYtxO9ZugBqyfRTuDdLf2kfRslixenY+lI1lCKXReXKuitgn0ab+3
         Xesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LfnPXIVY0w4Vah+h3Qix6eITdiDEsLRcPZ/kAE53N/0=;
        b=ceCBKU5SW8ZKICzhscqLeC0ToFOscMABVcdLNuAyY7jzdtPv573+q0xMt5rhEHPGj4
         FMrSBPyIp1S+2PpccSwKFY/D8wMmfAtQCYVtRbn0VjOBDIRFLttlkATkpyhLCYBnYRhm
         tvGOmQOCsNww1Tk4dkI0IP9XoafMKBt+KTLKGxCqN7Ndpgxlru14HsfxN+KBdSXWz0Y8
         D5m2wK6FQ1S56EFIRqpgy5P/XS49PVmc4ii9HuLsIMd6LAnwkssDc/8ZUGq//tCtx1GU
         L7DuA7siQ/1XHSjHPHYQtvJZ6NOF3v/XoNSQKd9TfRldBhJVfZZT+fZdA3hiVigyHA4y
         inxA==
X-Gm-Message-State: APzg51A3VbJ6ApV7h/+ef4XkK5HOW/Eu1VejelOVf0VKHTmTrm6DNe9f
        4hdb7UzbWo4fV4e2igUhFgUcuM9h7f37HTwrcrD4KPSDzoI=
X-Google-Smtp-Source: ANB0Vdbo2MNvRSkgfOSEcYrYKkag5K6WqyNL3JIBkD2wqw/rnwX8xJgpNUIU9uJfm7xgCfHaig+pK36lzRYmCbg2/+k=
X-Received: by 2002:a1f:144:: with SMTP id 65-v6mr1032048vkb.13.1534930137268;
 Wed, 22 Aug 2018 02:28:57 -0700 (PDT)
MIME-Version: 1.0
From:   Marcus Linsner <constantoverride@gmail.com>
Date:   Wed, 22 Aug 2018 11:25:35 +0200
Message-ID: <CAKYFi-4a=H+vT+vo5s6mpKXAv+0W0pyTj1WtEr6xfjoFVFmtJQ@mail.gmail.com>
Subject: Howto prevent kernel from evicting code pages ever? (to avoid disk
 thrashing when about to run out of RAM)
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. How to make the kernel keep(lock?) all code pages in RAM so that
kswapd0 won't evict them when the system is under low memory
conditions ?

The purpose of this is to prevent the kernel from causing lots of disk
reads(effectively freezing the whole system) when about to run out of
RAM, even when there is no swap enabled, but well before(in real time
minutes) OOM-killer triggers to kill the offending process (eg. ld)!

I can replicate this consistently with 4G (and 12G) max RAM inside a
Qubes OS R4.0 AppVM running Fedora 28 while trying to compile Firefox.
The disk thrashing (continuous 192+MiB/sec reads) occurs well before
the OOM-killer triggers to kill 'ld' (or 'rustc') process and
everything is frozen for (real time) minutes. I've also encountered
this on bare metal myself, if it matters at all.

I tried to ask this question on SO here:
https://stackoverflow.com/q/51927528/10239615
but maybe I have better luck on this mailing list where the kernel experts are.

Just think of all the frozen systems that you'll be saving(see related
question in the above link, for one), if you figure out the answer to
this, whether be it a kernel patch, or some .config options needing
change, or whatever. Just consider it, whoever you are, reader :)
(probably a kernel god xD 'cause who else would know howto) - I'm
actually selfish, I want this for myself, but I'm more than willing to
share it with all, once I'm aware of it. (this = this howto: let the
OOM-killer kill the offending process asap, without first passing
through disk-thrashing hell freezing the OS ;-) er, I mean Hi, and
how's life? 'll be even better after you've read this, I guarantee it
;-) just believe! synergize)
