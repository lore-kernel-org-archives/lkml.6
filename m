Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5F16DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CCC20891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iit/tlsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CCC20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933744AbeFLUMv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:12:51 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34818 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932768AbeFLUMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:12:49 -0400
Received: by mail-pg0-f51.google.com with SMTP id 15-v6so99994pge.2;
        Tue, 12 Jun 2018 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e9+HDJI/6y96+y3/axQMHGtWZ8mT66z+/BghfnOpr4E=;
        b=iit/tlsC5hOIo7Uxz+LYkLiGa4WoMIJFfp84SW3LMNqDIs8eaoj+AnZD5FqJXyNtoW
         MBel23Nt8E7q9gbRyESvvlI2p2b4g/yU414nFUBB/1sjpD6clxm1slZZJnf7AbyJuzIQ
         IVax2Fh6PqeIEwTmiPd1BFVwPEXx2sO52WUQJo7KNqF7KSKO0NSpa1YYxCTEZQqMQidb
         9nqd+T1Sm5d8Y8a0KbV6u2vgpF8tottOTJA/iNGzOc2gLhrMCDExSpQge/c6Eno/AQ7z
         qkSAbXwAFn+vjCux2xuEbjRNBT9qkrCmBglWj8EgbTqVE2bMOIrg4c4+LFvl4aLpCPX/
         FfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e9+HDJI/6y96+y3/axQMHGtWZ8mT66z+/BghfnOpr4E=;
        b=cWai4UOAc+AKvfhk1I7nxUfD67TQkqKfU8juZ7h3KWDNPorVsbvg4nYXfIRMa7vFmW
         csZ1Li8KGYazvO092ZHjc1od7QHqnER8RmZQtx1Pk2BBqRoARSNPjy3j4+7sl7/NEb+3
         +yl64014RHela1bf2YduzHa86vJ7LbgokMb/GGTFRbgmMZRtjdzqxUbJ990F2yzWgNwm
         pVr4FluCJVgdriKPnX08Xsyh+dGboRCJMo9IwMKFi7A+gjOLcHrichHVKp+VSe0xh18i
         NUiOVwN8eL/WbbPkDkkgx+5UbJC78cTwhn0Xtod39upZyRUu/6bLm4BE1Ofxrgw6EWHz
         JXOw==
X-Gm-Message-State: APt69E3pdKFVUiqKlj+nZ3e5qDCxHuTokEvgQzQB/sdVIKFEC5rCCVEX
        ukN6cUG9I0ADhMBQTVOv7r1qTLN3AsoxKG8sK3o=
X-Google-Smtp-Source: ADUXVKKS6R5RzTamGuhzsEozH8hWehTPhHR8P7KWKWjHjFrOCJHogyxRf+GE5juk1NIxjq6vmNCFQ3tWa/Omeewyc04=
X-Received: by 2002:a63:7255:: with SMTP id c21-v6mr1499108pgn.99.1528834369300;
 Tue, 12 Jun 2018 13:12:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:14e5:0:0:0:0 with HTTP; Tue, 12 Jun 2018 13:12:48
 -0700 (PDT)
In-Reply-To: <6c1205cb-7d65-8b30-c4df-59a0ed041313@redhat.com>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
 <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
 <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com> <m2h8mc4ejw.fsf@linux-m68k.org>
 <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com> <alpine.LNX.2.21.1806092140410.26@nippy.intranet>
 <3490f7d6f45ec2586858e4547e97474d93bd2d4d.camel@kernel.crashing.org>
 <alpine.LNX.2.21.1806120911370.34@nippy.intranet> <6c1205cb-7d65-8b30-c4df-59a0ed041313@redhat.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Date:   Wed, 13 Jun 2018 08:12:48 +1200
Message-ID: <CAOmrzkLwv0aWna_Puru6QHvRRDO5y5v9jSvoZ+mwBh7XbJ=t7A@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 12, 2018 at 6:53 PM, Laurent Vivier <lvivier@redhat.com> wrote:
> On 12/06/2018 01:47, Finn Thain wrote:
>> On Sun, 10 Jun 2018, Benjamin Herrenschmidt wrote:
> ...
>> I don't know what the bootloader situation is, but it looks messy...
>> http://nubus-pmac.sourceforge.net/#booters
>>
>> Laurent, does Emile work on these machines?
>>
>
> No, Emile doesn't work on pmac-nubus, I tried to implement the switch
> from m68k to ppc, but it has never worked.

On the PowerMac 6100 that I installed Linux on many years ago, I'm
pretty sure I used Apple's mkLinux boot loader.

Not sure how that would work with modern kernels and initrds though.
Haven't got that hardware anymore so no way try.

Cheers,

  Michael

>
> Laurent
