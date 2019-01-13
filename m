Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE77C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76822086C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lawB02I0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfAMD4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 22:56:05 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:25547 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfAMD4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 22:56:05 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x0D3tfnP013694;
        Sun, 13 Jan 2019 12:55:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x0D3tfnP013694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547351742;
        bh=Cz+mUGPi0ZOxPey1yolKlUq6MURSCdMne9+w+ERo5Ak=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lawB02I0dftRjhCy1oxCzyP1EvnjWwU3KH6viCLfD2uWaz4PtVG31YUlYjTJv/hBU
         h8ujkG8bwd8TxIhU36NEZ0HkaznSHQCXlg/vxd83kGMUn6VnNbFNq8aH4DbPMjb6ij
         1bLTbd0D43/RiUg2RoZm2tcmVcT0RzEqn5DCVjgvlMo3DbgV4pY0Xg+6vqpG4JU+3i
         EEdbG7htwn+S24WJofHGLjOIsufEGtxUNlFoyRRGLIpSGui7APFP55hXpE67SjVZ9R
         GyOam0QP7suLHEQoS8LCl1H1j6pDPmBcLqVKui1KeOMMBIV2YeBA5xWUmTpqq0NPMR
         BJH7uriFv0/Cw==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id e7so11702184vsc.2;
        Sat, 12 Jan 2019 19:55:42 -0800 (PST)
X-Gm-Message-State: AJcUukfT6bUBuc+1XH0ka+OK4Iklr+W/qrgjCO0RqA8Wz1yYMDgxKJMS
        oyGi6MoKYvejvSHDSDHzv3s+wTVWdEjwXuGGJbo=
X-Google-Smtp-Source: ALg8bN7N71gml+jJp/1U/XZAmJ1kC92bwJzd+jIyywRaIW1ko99xdKOEOjueGdbcbGT57eNImTh1Y2gFhKegCfZUAKs=
X-Received: by 2002:a67:f1c2:: with SMTP id v2mr8377813vsm.181.1547351740782;
 Sat, 12 Jan 2019 19:55:40 -0800 (PST)
MIME-Version: 1.0
References: <1547175108-14744-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1547175108-14744-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 13 Jan 2019 12:55:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT6fB=97RMmxNxEc4vAJL8+3pS4SSpa8ntKXGqRAvPUSA@mail.gmail.com>
Message-ID: <CAK7LNAT6fB=97RMmxNxEc4vAJL8+3pS4SSpa8ntKXGqRAvPUSA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: clean generated *conf-cfg files
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 2:12 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I accidentally dropped '*' in the previous renaming patch.
>
> Revive it so that 'make mrproper' can clean the generated files.
>
> Fixes: d86271af6460 ("kconfig: rename generated .*conf-cfg to *conf-cfg")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild/fixes.




-- 
Best Regards
Masahiro Yamada
