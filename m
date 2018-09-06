Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1D0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E52B20857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTLXTr4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E52B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeIFHH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:07:29 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:45736 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeIFHH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:07:29 -0400
Received: by mail-vk0-f66.google.com with SMTP id b78-v6so3481111vka.12;
        Wed, 05 Sep 2018 19:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8GbrTSHm4Lsu+kJCxDeaCv1TtTTacTb81H9Kc/eTDp0=;
        b=vTLXTr4fC8fgQkLW5Sct4/hZIovSgg1d0neRS8hGoRgRfZS/tlb8K+8i3Xw32hblbt
         C4lcTRVOlKz2vBlPJVGEOOfshz0YsvxvCICvuy3q1PBdTNDJHAX/93kaEt8876fzg4b4
         SK4fZU5svelRQxgBRXOh6/ZfPp/o4YWR1xC20IKbB1IisRNs6UgN+9Jn/gfTzE4RPCv8
         RNwaNQ49LgzD+L8stF2xZA2RfNKqVFPltc8YTjygt3X6Kq9/lJPOIuEUpyus3AgIwu87
         Gfc0f7Qe356+NUawn9D9qZYGBg9X/jsDgxQ90kN/50hbjL9uzhXK8O1PZsa3IRLoBcev
         Y5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8GbrTSHm4Lsu+kJCxDeaCv1TtTTacTb81H9Kc/eTDp0=;
        b=TXDpWPKFVh9jxdFWSUlj6l5febIw0AjKpJrLCv7k+e184l1VkoGTUh1Ug9AiVpIQJS
         YDXPJgkOylRIN2UzUDQChkgptgS6CxvaULFLdBLYo00ESyALhQOoeLqCmwA+1ZO3vLSr
         2W8omdsaHOkq13+yJDGX7ZUSiO1AJfPMZw773qmzLoZq2Wu25YLHIqBILYA039NHW3vL
         2L9nGZlm8PUFQqhXbVVeFabryX6NT2c/vRclIzgvOXarnynB4I5qOScpGDrTdsNOM3D+
         HGO1dp3tnSQUIKjwweogGel/Alc0HhLEhlt6QyXoPQZ8xeU9FJTTcBlW+XlT78j/hHgJ
         lOMQ==
X-Gm-Message-State: APzg51Bfz53nfKqEjURdxrsenXxlqHpdDa7oKdaWjApNLdC4wWUye5jk
        vdanX6Bsj66mE7kxZmtD/jkqnvX7sCcO+XXInfU=
X-Google-Smtp-Source: ANB0Vdb8gvf/ZxS9AueOu1GlInJxPnckdmEb0TgyF7PbzKdJ8kWninxcZIqOjDuAdzlUvyI+i0lw7Pk4mbuCyNiR8KU=
X-Received: by 2002:a1f:f8c2:: with SMTP id w185-v6mr192338vkh.135.1536201265474;
 Wed, 05 Sep 2018 19:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Thu, 6 Sep 2018 10:33:48 +0800
Message-ID: <CAEbi=3dKL1zOYc0DC3yXm=7srw6tUfx-JR=o9n4pVrGp+Sosug@mail.gmail.com>
Subject: Re: [RFC PATCH 00/29] mm: remove bootmem allocator
To:     rppt@linux.vnet.ibm.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>, gregkh@linuxfoundation.org,
        mingo@redhat.com, mpe@ellerman.id.au, mhocko@suse.com,
        paul.burton@mips.com, Thomas Gleixner <tglx@linutronix.de>,
        tony.luck@intel.com, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@linux.vnet.ibm.com> =E6=96=BC 2018=E5=B9=B49=E6=9C=886=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:04=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi,
>
> These patches switch early memory managment to use memblock directly
> without any bootmem compatibility wrappers. As the result both bootmem an=
d
> nobootmem are removed.
>
> There are still a couple of things to sort out, the most important is the
> removal of bootmem usage in MIPS.
>
> Still, IMHO, the series is in sufficient state to post and get the early
> feedback.
>
> The patches are build-tested with defconfig for most architectures (I
> couldn't find a compiler for nds32 and unicore32) and boot-tested on x86
> VM.
>
Hi Mike,

There are nds32 toolchains.
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/=
x86_64-gcc-8.1.0-nolibc-nds32le-linux.tar.gz
https://github.com/vincentzwc/prebuilt-nds32-toolchain/releases/download/20=
180521/nds32le-linux-glibc-v3-upstream.tar.gz

Sorry, we have no qemu yet.
