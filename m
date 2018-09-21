Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05944C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC2921479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUFsCE5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC2921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389493AbeIUMJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:09:45 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:52784 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389203AbeIUMJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:09:44 -0400
Received: by mail-wm1-f45.google.com with SMTP id y139-v6so1770489wmc.2;
        Thu, 20 Sep 2018 23:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=T3IFshJtvhGABS6oxdWf1oWhhiG5UIiOoXvTAD746CU=;
        b=HUFsCE5XbmqN6eyP04i/qXtI4fE/9XjY2zZgiBr3cKQsOkq5Q+duFyaDwX7gt8Jwr8
         4VwE3G+q+9w4RzPQOADmuXqq1biyOQG/WHg7K+2b2OKRkECo9JGjZ/BR63Rrp8AOedwS
         QC+Ntg1MX0Ruj1+/Dmv4Cox8zUC8C5fETQ9f4qvORIe+Nl2WF+5hEonyRx3LOBmY2XVI
         rM3N6Ke2ekunvCGQTQcw2Ck8DQGFY6e51Yty14d2EGPwzRDP0KrTShUMcBXCniHf2g2A
         VJPJxIw2sTMKPiDMkc/CQK05PRCXXEo8fqgfZOzBbd7zUk4f3/61/xWvCyXGfLVXrxVs
         R/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=T3IFshJtvhGABS6oxdWf1oWhhiG5UIiOoXvTAD746CU=;
        b=SIUFleM+8JNH8qY+MnkpyfcSoxr3eU0M+uz9GnTQV9Eo00fpvzcJG8zQb/cOZv3Gd7
         9YIh8Cre4LrAcyaH2fJx0BTUZ/cFgCaAgPrn3fTOV+1sTKJ5a7LfOgGm9F8O3gy57mlh
         sNOj/uNAfjCBhrE35KjMyCKDGLxvMTclAWNPrC3KOXwlMgq2QGTE44fZWSIwcvFHgGMi
         YtbftXVjHKGbERYv5AqT8umOc0w8VyBHGpmJIX1LaunfMhdyIqsfI7/FEFeTgjDwKZmi
         0eEMG0ALpfie8lfMFksuKqtME9N4w0hVmau2ADMVRKrC0PSxizsu/uK+VI4aw8cQfLZX
         PJfw==
X-Gm-Message-State: APzg51AeKH7pjubYqcckzQ+1IZ2GY3l7vkpbZF5tXA7ZKpWozhPv5+MC
        h0OcH08eGFSBepUxQAqle07pwhivUD+u1e/O+0U=
X-Google-Smtp-Source: ANB0VdbAaubS2yBYHg4FLJqCYD+vz97jPMDFL16kNBNhg+nWBYp0gwQQ+GScFFRkj5ncRYiPC17sKoboCc4SrEyAB2M=
X-Received: by 2002:a1c:7301:: with SMTP id d1-v6mr5399265wmb.34.1537510941200;
 Thu, 20 Sep 2018 23:22:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:554c:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 23:21:59
 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 20 Sep 2018 23:21:59 -0700
Message-ID: <CAADnVQL8=8O1W8-G-UP1akLijdGN82hnOJAY=sknTH_S0Y1rVQ@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in _decode_session6
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+acffccec848dc13fe459@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 12:17 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>
>> but I have a hard time reproducing the issue, so will appreciate
>> if somebody can test the following patch:
>
> syzbot can:
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches

was the patch tested?

it seems to me syzbot doesn't care about kernel quality but rather
about the number of issues syzbot can find.
