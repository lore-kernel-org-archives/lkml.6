Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8901C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCC62085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti3rUWRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BCC62085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeJJOYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:24:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44608 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeJJOYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:24:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id v6-v6so3849885ljc.11;
        Wed, 10 Oct 2018 00:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TnneXrSTs9EAPeLL/QnFlKTqpwck/2HpDg6uUEsy0CU=;
        b=Ti3rUWRPxlfO3oeQqKvk3PWUSKc/4dyAEI40TxWeAGEmVI+GxYZBaINGoCaPuNONaE
         y0GwKLgdpAZ4MWZXCOVutnjWpge+BAbgYLRuKtqAuXq+3FepZb9BE9RgRLPAka6cLCqI
         YLNZ0hjyvuQBQRLzL2M42pWXsk4CXNYameg316hgVctW1h+voiiBuYwflWKGVWWGUYas
         wX0P9/pXCX0Cc8odPx2tEhSxgnj604+PtOovBJBsZ7J8bm3i5//qwPzC9h+btDk6n0XN
         MYtPQVcr2oc0yIQOZAVJg66JRbdr7i/TtYkkwIBwzyKZlR4jPxxFWoEgNU+GJulxCOcP
         q9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TnneXrSTs9EAPeLL/QnFlKTqpwck/2HpDg6uUEsy0CU=;
        b=pIRDzSyZ5pSNSNdM+FMPxr1VY2SaLwFnR73uCCIehDarBZFoVUcH5vkyaDzP9xWByB
         zAV36GyJgDScYPvgm1idXDauqPyat2DjFXeLLx6Wq50DcPVaek7BI9mWG2ioADvHW8dJ
         mDTipFVudeZgQ2lb35UqudWE/ufWXq67UqemFEIlWzTeBLDdn1no2OgG9FyZbjFJPVRf
         1z/b6nT3Hf95ioE8lFo6WKmK8Ng0BLXJpm3yK1VTR9eIVM6r1XYyXVo4K+D41r+PVmtM
         Y+zL0BlPyFtU6dCWLv/alevzX6Z9vQGGS4SK6EEZo/PCmptPrfbvL4KY3kSYAeuRvobD
         OobQ==
X-Gm-Message-State: ABuFfohTtauwt6p3wpvlbcz4q3a69pFvB0jwqe5dd2rCqKH8kt7fVosJ
        gcpre7PsQYMKG8bKS1Xq78delpxy2F7K1+9CUMM=
X-Google-Smtp-Source: ACcGV61uwL9llDF7E7tUBTKG0UWbh9ARpyuHYNKlq0/syHNwwpnuL3LX4NGVNncIKoGo65obZBCo7KUO/WPzmEmTC6s=
X-Received: by 2002:a2e:9615:: with SMTP id v21-v6mr19501228ljh.150.1539155034717;
 Wed, 10 Oct 2018 00:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com>
 <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com> <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
 <CAKwvOdnyA=Y_+KnJrDc5mu7twTAEOMXvb8cAZhwzsXTi7a9sEA@mail.gmail.com>
 <20180926180019.GD22824@google.com> <CAKwvOd=xYG+r4KU+QurUTyaxkPB2AMane4YfWxuvKtONvVtLxQ@mail.gmail.com>
 <CAGXu5jLBz1YanL5X4HFZjhb8NZe5QK=Q1ySfBkBDNWqEg4hs5g@mail.gmail.com>
 <20180926184259.GB14797@kroah.com> <CAGXu5jJaJ+1Sg3uwaZ8hzw3wFbiLrftpZDO8vdjY9_tB+P-HPQ@mail.gmail.com>
 <20180926190303.GA18293@kroah.com> <CAKwvOdnx6D+_LeSZ-1v_s8dLErXq4B5Nx1UQozdr1+ZaGYWnrA@mail.gmail.com>
 <CAGXu5jKRn2EsPwNMtVTPyKyDnt+vqHZF=jdr+DajN_iN1DWjSw@mail.gmail.com> <CACPK8XeAbiMk_yW-t+8HdW_WLqaFJFX-xnNnDSZJ5ZfhK63euA@mail.gmail.com>
In-Reply-To: <CACPK8XeAbiMk_yW-t+8HdW_WLqaFJFX-xnNnDSZJ5ZfhK63euA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 10 Oct 2018 09:03:43 +0200
Message-ID: <CANiq72nGrNMEqnPrxGXCp_iKf1_FuJLMvoV1+bbfYYCKnfTPVw@mail.gmail.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
To:     Joel Stanley <joel@jms.id.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christopher Li <sparse@chrisli.org>,
        linux-sparse@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        daniel.santos@pobox.com, chris@chris-wilson.co.uk,
        jani.nikula@intel.com, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:12 AM Joel Stanley <joel@jms.id.au> wrote:
>
> On Thu, 27 Sep 2018 at 05:07, Kees Cook <keescook@chromium.org> wrote:
> >
> > Yeah, that's what I'd linked to in the patchwork URL. Andrew, can you take this?
>
> clang built -next is blowing up now that Kees' -Wvla patch has been
> included. This patch fixes it.
>
> Kees, perhaps it should go in your tree along side of the -Wvla patch
> if no one else wants to take it?
>

I can take it along in the compiler attributes tree, since that
touches the compiler*.h stuff. Although that would make it
not-only-attributes, i.e. slightly lying :-)

Cheers,
Miguel
