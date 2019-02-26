Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B16C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7FB217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai7DxOn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfBZSVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:21:02 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40478 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfBZSVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:21:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id j36so16016521qta.7;
        Tue, 26 Feb 2019 10:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rXhPxCyfwc/K+JPxZkycecoAUFiC126VMt5sJ0MB4Es=;
        b=Ai7DxOn9Q/vUeG3c6omQbwHjCarG8U+AyDwppqidt3ZvTEzewR6mjd1xNAAETbJYhn
         HVHL3xLf9owR+p2Yhm7TMT1zP+imzT4BRHrQcJ0WOW6KLnw4eXQMsgPuvB3ZRMBsriAH
         zHgSacq9RYe0rwPy2QPkIOWwL9sf5crYRGEOPGjIAjgg/RZlc08MeGw2eAnHD4EaQVvS
         zXERVipfgEai5lTKNkBhJYsk/SHlw3ra7WlWJ94BzlntSu1TmZeWisdjbQIS9Ibt9lRD
         2HgfUQ5pnwFIXsgdC4C/9rtPzZIaO2smNCV/k6HJLctm48G/djZ4TsCcs1l1pafapP8Y
         n+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rXhPxCyfwc/K+JPxZkycecoAUFiC126VMt5sJ0MB4Es=;
        b=MNnqBICqpaaVh4/E2vvvaWIii3mkDZ5e3qVu2+N/7paf/9mdBu0WokGBNrv2/AZPY1
         XKGwq3e9QHS8ery7ik8VpF9t8P9hSsbY3TQl5BUkQ7GX1Xp0w1BA54f6Rm0J0j37GbMa
         4nb0r2FU/wATUCdPfFRkVF3SyqTOkktupvgITlr8i2sa19Y8KF7HkWxz5ezzLuqVfnAH
         vSUGuGUyHSjt8l4L/byDZKDz3lb6h93LLgYwD05thLuEzmwvs8Wdcjxsn4HV7WQpLPoD
         xG6lP6zgqHoogNNLqIdj7Mj0idFLK8rObrDE/V/g7r9uNv/EEt1WLC2f+4TbxIEwnDOq
         77TQ==
X-Gm-Message-State: AHQUAuZlGF3iEI4WpuXHiSG39r5n1WLYRO7Blc92ko3gLR2zZW4SKph+
        DBA1cTPg1B3jKNrk86wCNqXeNgeMC4Ij0i68PcJwlNUb
X-Google-Smtp-Source: AHgI3IbmvKJxF/4f2wyG1b5a0Dg3QHvCzXrHMpdJk2ZGdmBVTRa56NXamoD8yyo24Nj0VuQw7pHQ+XMqz1ETmQOUpSI=
X-Received: by 2002:ac8:6887:: with SMTP id m7mr18745059qtq.381.1551205260288;
 Tue, 26 Feb 2019 10:21:00 -0800 (PST)
MIME-Version: 1.0
References: <20190221221941.29358-1-daniel@iogearbox.net> <20190222083131.5a141e23@carbon>
In-Reply-To: <20190222083131.5a141e23@carbon>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Tue, 26 Feb 2019 19:20:50 +0100
Message-ID: <CAJ+HfNhs_hBhHhNhaw9Aywh-bK7vyLAQ-t4sXada9xRpPfwnaA@mail.gmail.com>
Subject: Re: [PATCH] x86, retpolines: raise limit for generating indirect
 calls from switch-case
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, tglx@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 at 08:32, Jesper Dangaard Brouer <brouer@redhat.com> wr=
ote:
>
> On Thu, 21 Feb 2019 23:19:41 +0100
> Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> > Recent work on XDP from Bj=C3=B6rn and Magnus additionally found that
> > manually transforming the XDP return code switch statement with
> > more than 5 cases into if-else combination would result in a
> > considerable speedup in XDP layer due to avoidance of indirect
> > calls in CONFIG_RETPOLINE enabled builds. On i40e driver with
> > XDP prog attached, a 20-26% speedup has been observed [0]. Aside
> > from XDP, there are many other places later in the networking
> > stack's critical path with similar switch-case processing. Rather
> > than fixing every XDP-enabled driver and locations in stack by
> > hand, it would be good to instead raise the limit where gcc would
> > emit expensive indirect calls from the switch under retpolines
>
> I'm very happy to see this.  Thanks to Bj=C3=B6rn for finding, analyzing =
and
> providing hand-coded-if-else code that demonstrated the performance
> issue for XDP.  But I do think this GCC case-values-threshold param is
> a better and more generic solution to the issue we observed and
> measured in XDP land. And hopefully other parts of the network stack
> and kernel will also benefit.
>
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
>
> Thanks for following up on this Daniel,

I definitely prefer a switch-statement over the if-else-messiness in
this context. Thanks for doing the deep-dive, Daniel!

FWIW,
Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
