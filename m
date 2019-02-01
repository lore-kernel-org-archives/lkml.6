Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1DAC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ED320870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WHoUDOTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfBAHiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:38:19 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:46691 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfBAHiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:38:19 -0500
Received: by mail-lf1-f46.google.com with SMTP id f5so4276601lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 23:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9PwWNdYk99s1XiVFCbbI2TIH7NUhKU+WAIZzLBcrTY=;
        b=WHoUDOTjbKU//tqjtZ31mi3yl4meT6K9aA3LboDcQeezDQGNIdvTYH4eGqRcwnEVMD
         HOKtQTUlnk88vrfzzaJ0At3HoFMYDNoN8jdwcUe2eyvoPt5JPunAOyODkSppLPgxf7DD
         nKErCiFOxAYawx7qf0DlC7PpPtKVjsKhwpKbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9PwWNdYk99s1XiVFCbbI2TIH7NUhKU+WAIZzLBcrTY=;
        b=Xoc2JNU77Pu5O96jmXpXlBfeHCndJ4ETX9QCTZHQreubX3WMyC2UBL2Jt6M5OSMqTD
         lOInbrzjE6/wSx8EtbHHbrQBlN/irAXJKxtpobj5mIJG3FtzDNnxRXVi6jLyAZ34s5xi
         G8g/iqYOmsSdnqX2EKsczVbaH57oSBf1dxMTd8z1ckwPvb2tpoUJyXa+c0AXWuTodoPE
         ESfPbI5Orb//WtU/xHMzAlEPLpzzZjX+lh/pxbVdei58tSEMUaYsP1LL+2PU5E1Qz6jc
         WFXRMunffWT0QN/ZexF4VvvS1NNPnCGdPE8aqI8rn0moxIrbp15xOuYiGleVD3KE0r4h
         gUTQ==
X-Gm-Message-State: AJcUukeQXFjY1N3DhIe174yTb0X4/ul18wyMh1DPW5UdNXxaLkGH2Ou7
        nhKIJa0+F5yL2zvkf2ylZ/6UYNSb7rw=
X-Google-Smtp-Source: ALg8bN4vOImP+rXqtbqNZuPY/8Qtmzqg0EL23/IHQfheW3FlFP0iqVAp/uHevC1f4H2GbrX/8t9ATA==
X-Received: by 2002:a19:9508:: with SMTP id x8mr29368928lfd.112.1549006696347;
        Thu, 31 Jan 2019 23:38:16 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id a127sm1237795lfe.73.2019.01.31.23.38.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 23:38:15 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id f5so4276503lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 23:38:15 -0800 (PST)
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr29545951lfg.117.1549006694740;
 Thu, 31 Jan 2019 23:38:14 -0800 (PST)
MIME-Version: 1.0
References: <20171128230929.GA17783@gondor.apana.org.au> <20171222064931.GA27068@gondor.apana.org.au>
 <20180105073808.GA14405@gondor.apana.org.au> <20180212031702.GA26153@gondor.apana.org.au>
 <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au> <20180622145403.6ltjip7che227fuo@gondor.apana.org.au>
 <20180829033353.agnzxra3jk2r2mzg@gondor.apana.org.au> <20181116063146.e7a3mep3ghnfltxe@gondor.apana.org.au>
 <20181207061409.xflg423nknleuddw@gondor.apana.org.au> <20190118104006.ye5amhxkgd4xrbmc@gondor.apana.org.au>
 <20190201054204.ehl7u7aaqmkdh5b6@gondor.apana.org.au>
In-Reply-To: <20190201054204.ehl7u7aaqmkdh5b6@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Jan 2019 23:37:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whHKxA4kA8eHd+h6Zmq269usaxCoGiC+b-_bcfYCQOTbg@mail.gmail.com>
Message-ID: <CAHk-=whHKxA4kA8eHd+h6Zmq269usaxCoGiC+b-_bcfYCQOTbg@mail.gmail.com>
Subject: Re: Crypto Fixes for 5.0
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 9:42 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> This push fixes a bug in cavium/nitrox where the callback is invoked
> prior to the DMA unmap.

This is not so much a comment about the pull itself (which I did half
an hour ago), as about the fact that it looks like the pr-tracker
robot doesn't seem to trigger for your pull requests, even if they are
cc'd to lkml.

Maybe you don't care, but while I stopped doing the manual "ack"
emails for pulls, I've continued to try to notice when some pull of
mine doesn't get the attention of the pr-tracker. I've probably missed
several cases of them...

The reason seems to be that the pr-tracker bot only tracks pull
requests from emails with one of

  - ^[GIT
  - ^[PULL
  - ^[PLEASE PULL

in the subject line (case insensitive, afaik), and so your plain
"Crypto Fixes for 5.0" doesn't trigger it.

(My list of what triggers the pr-tracker bot may be old, I suspect
Konstantin has ended up tweaking the bot more since the early
descriptions he gave, so take the above more as a rough guide than any
set-in-stone rules)

Anyway, if you do care, maybe whatever script or workflow you use for
pull requests could just add that "[GIT PULL]" to the subject line,
and you'd get that automatic ack email when I've pulled and pushed
out?

               Linus
