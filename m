Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7350BECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B1A2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz0InVUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B1A2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeGOVP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 17:15:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36084 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeGOVP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 17:15:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id u7-v6so25609594lji.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 13:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Mw57Anu3QyN4JXAmQqKKWYE58NNgh7vOoLxTehHcDAc=;
        b=iz0InVUanNe7LkNdv/TJJTvrCsIStHV5WkBfLUr9UF9OuTZHR/aXVLbi59XPOFXZmQ
         VXgcEaTeMv1uiAhBrgiupBChGNNvDTxJjynwnRQ+2+MP//zmEHl+KjDgKT6+iFuJqu5Q
         dCdpRxw21OMwynVU+vMxiTc2nh+ecK7eUWrLey5dn1utn/HAH0jwzbOOcLyRBAdtQ7zt
         lcm21HH222WhR/L+2Qff9D8UxwBzbAPpNKXOaMVorGzyTuLCA0GHemt6F8fO//kIKFpl
         FXeBrByDawwJtUd5uDxWK4T+xzo26WwofYowosLUM1fLYSaI7BMShw2Glulxj3FYKpqN
         h4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Mw57Anu3QyN4JXAmQqKKWYE58NNgh7vOoLxTehHcDAc=;
        b=oSgx5JASHHrwKFmBpC5NncqbRN/z+ujXxDAMMyAZN/YYO1Umy6GfwDLdT4uhSGUaqV
         MVf5ChpVKNbEMXos5UYxBTk5cH+F4hYsQT+HkWbE6a/Pr5lEQOIrOjFi0o0r+BrCd7mx
         /xh50bxw0g6QT18AbiGM2khZAw/SJbR//GqYHa2P/7JUp5JTZfbAb4WAs6bQBEgKLGjF
         VqkiZF9R5cr19+F3qLhkbW+EpOPSsoZQCWNwXi4zljlvCv0yLVcMEhYphtNY6MAxt0Fw
         DzQo5H0FCKAXkmUEkgIe7bB/ucLbi1hAlch4Dwt4qHtXpt5geua8Wu7se+Itm13ZrUC7
         ysOw==
X-Gm-Message-State: AOUpUlG989f3UERIiqJALsFWXCG2XwyYAcZvrJYAeqkk/oRMzenjlXA6
        9/Nm/jtlgN0MM9e8BQyPIPkCpZOhR/TDiY5zqp4rv0Ze
X-Google-Smtp-Source: AAOMgpcdczan51kFwTbeeSQL3AmI9EksALLmSDlHrFbySHDH5h9Q6UbaPeLOWkdGh1iQJwBVPGmVRH7OCyO+cB43U6M=
X-Received: by 2002:a2e:40c6:: with SMTP id r67-v6mr8636528lje.41.1531687903884;
 Sun, 15 Jul 2018 13:51:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Sun, 15 Jul 2018 13:51:43
 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.21.1807151803010.17406@math.ut.ee>
References: <alpine.LRH.2.21.1807041414080.3671@math.ut.ee>
 <CAK8P3a1RkNc_kShHBJ6QENrQheQi=C93DmnknC1S_uJDcTDqww@mail.gmail.com>
 <alpine.LRH.2.21.1807051254050.21817@math.ut.ee> <alpine.LRH.2.21.1807151803010.17406@math.ut.ee>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 15 Jul 2018 22:51:43 +0200
X-Google-Sender-Auth: H7164EGotxtdlKzYLko2j4OTHE8
Message-ID: <CAK8P3a2NtB_FmiSjrzZb=HoshEzo+MP2xwafC3QcMg79rffipg@mail.gmail.com>
Subject: Re: 4.18-rc* regression: x86-32 troubles (with timers?)
To:     Meelis Roos <mroos@linux.ee>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 5:05 PM, Meelis Roos <mroos@linux.ee> wrote:

>> > > I then tried multiple other machines. All x86-64 machines seem
>> > > unaffected, some x86-32 machines are affected (Athlon with AMD750
>> > > chipset, Fujitsu RX100-S2 with P4-3.4, and P4 with Intel 865 chipset),
>> > > some very similar x86-32 machines are unaffected. I have different
>> > > customized kernel configuration on them, so far I have not pinpointed
>> > > any configuration option to be at fault.
>> > >
>> > > All machines run Debian unstable.
>> > >
>> > > 4.17.0 was working fine.
>> > >
>> > > Will continue with bisecting between 4.17.0 and
>> > > 4.18.0-rc1-00023-g9ffc59d57228.
>
> Bisection has been finished (I'm usually away from the problematic
> computers in summer), result is strange and seems unrelated:
>
> 0bc5fe857274133ca028ebb15ff2e8549a369916 is the first bad commit
> commit 0bc5fe857274133ca028ebb15ff2e8549a369916
> Author: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
> Date:   Sat May 5 18:42:59 2018 -0700
>
>     qed*: Refactor mf_mode to consist of bits.

Agreed, that isn't the one you were looking for.

>     `mf_mode' field indicates the multi-partitioning mode the device is
>     configured to. This method doesn't scale very well, adding a new MF mode
>     requires going over all the existing conditions, and deciding whether those
>     are needed for the new mode or not.
>     The patch defines a set of bit-fields for modes which are derived according
>     to the mode info shared by the MFW and all the configuration would be made
>     according to those. To add a new mode, there would be a single place where
>     we'll need to go and choose which bits apply and which don't.
>
>     Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
>     Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>
> :040000 040000 a3572846e1afb9ccfa9c4a84b0135a0057ade66f bdb7b28725a4f1bffe79ee384a3603b3127d6fdb M      drivers
> :040000 040000 f90c7f26fd8445afa48c6679ed68fed294b23d7f 52119c547a82b268b5c173d3df94e267cc1297a0 M      include
> mroos@rx100s2:~/linux$ nice git bisect log
> git bisect start# good: [29dcea88779c856c7dc92040a0c01233263101d4] Linux 4.17
> git bisect good 29dcea88779c856c7dc92040a0c01233263101d4
> # good: [e27c49291a7fe9dc415c9fcab5bd781ec82dfe04] x86: Convert x86_platform_ops to timespec64
> git bisect good e27c49291a7fe9dc415c9fcab5bd781ec82dfe04
> # bad: [1c8c5a9d38f607c0b6fd12c91cbe1a4418762a21] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
> git bisect bad 1c8c5a9d38f607c0b6fd12c91cbe1a4418762a21
> # bad: [1c8c5a9d38f607c0b6fd12c91cbe1a4418762a21] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
> git bisect bad 1c8c5a9d38f607c0b6fd12c91cbe1a4418762a21
> # good: [135c5504a600ff9b06e321694fbcac78a9530cd4] Merge tag 'drm-next-2018-06-06-1' of git://anongit.freedesktop.org/drm/drm
> git bisect good 135c5504a600ff9b06e321694fbcac78a9530cd4
> # bad: [ffbc9197b4721634dc6c0fefa9b31e565fa89cee] wcn36xx: improve debug and error messages for SMD
> git bisect bad ffbc9197b4721634dc6c0fefa9b31e565fa89cee
> # good: [3a443bd6dd7c43bf5763779309514bf3e7c1c3eb] net/9p: correct the variable name in v9fs_get_trans_by_name() comment
> git bisect good 3a443bd6dd7c43bf5763779309514bf3e7c1c3eb
> # bad: [93c65d13d8a0b7c272868d4a9779f96fc973df26] vmxnet3: Replace msleep(1) with usleep_range()
> git bisect bad 93c65d13d8a0b7c272868d4a9779f96fc973df26
> # good: [4bc871984f7cb5b2dec3ae64b570cb02f9ce2227] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
> git bisect good 4bc871984f7cb5b2dec3ae64b570cb02f9ce2227

Everything below here is is 'bad', which can be an indication that you
misclassified one of
the commits above as 'good' when it should have been 'bad'. The most likely
explanations are that you either typed the 'git bisect good' by accident, or
that the failure is not 100% reliable, and it sometimes works fine even on a
broken kernel.

0bc5fe857274133ca0 follows directly after 3a443bd6dd7c, "net/9p: correct the
variable name in v9fs_get_trans_by_name() comment", which is marked "good",
and can't really be good if 0bc5fe85727413 is bad and you are not using the
'qed' driver.

I'd retest 3a443bd6dd7c again to see if that should have been 'bad', and
if it was, test v4.17-rc4, which is what the net-next tree was based on.

        Arnd
