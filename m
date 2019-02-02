Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4218C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9ED20823
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZN/bb0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfBBQgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 11:36:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33006 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfBBQgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 11:36:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id a16so4671947wrv.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 08:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nXLI8J5mAYp38Uy55BxCgwyVS0uxNhpnnCfoO+B+9ro=;
        b=SZN/bb0HNhPZmNuCmr6xLE8mg6Vbifn4+dOzkzx9sPsJ7JsWF4WgK9LpvUWT9Bi6DK
         9ejnopo8mfcfXGwx5GZcCJ+KdCzudj9WUjlfjiDagxVv0pZgzc+T2P9drRr3B23Vu6eg
         dkFhoqebTgFRZQPB5T//pj1fVqaGUtl6sQIROGglOo1DtJ1BXZy2Mn42baQuKmi+csuy
         lgUmYJH7xCL5PUQCAfBoLY0yh9cs81CxU1mcyse1U/KrRiNtvw2SrmklBdc+ePnm5srN
         pSGqccDA6kul3FgeKtCkGfvQ5Zwz1SBVTQVI8lcwEILg1sAjFumLgIsLOHzNfte5HzGZ
         lIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nXLI8J5mAYp38Uy55BxCgwyVS0uxNhpnnCfoO+B+9ro=;
        b=iPEuTcqiTsqmRs1CrvxlAXhMh87nA3Vs8g1nkKB9v0wW878DwAUY5O8E6hDF5ilMxO
         PPC6Cnth2KaWrk1p0jRvEe3XSAm9pVJNdcLMDYHpJyyr0pNwe+C4ThhFc3xyxilV1myz
         avJPUymnUYBlE1YxMY1HrbOy+9ZUR9bZpR+vwtN7Il94lV8ndTwY0e103pA+qkZmWJz/
         KAbDGTssQWgtnLRmNmmh7rlj0nFSettJRN3eZ4hVvxtdC2bYkVf5LWX4fhr6dPftPUwL
         I68Q/jMKcCbgszdkrk8o/7h0B81qKdqQ6ZaCHAndXreYkMqBwyQUTsgrgo9c2Oo84nJR
         L07Q==
X-Gm-Message-State: AJcUukcCaFqmDUbECfvp32gaU3Vh3T2IY/4f80ExHmpXcIAwJtQNV6Fw
        ZgXtsJ1LQj5OmFyMpKxoYQ==
X-Google-Smtp-Source: ALg8bN4x9hydasl3iGZMt9bjU3sQS1lejsX8LIKm2Oobdb1qzb9EMHSaOX6kIs62spl7lESqhW6TBw==
X-Received: by 2002:adf:9061:: with SMTP id h88mr42632146wrh.65.1549125407331;
        Sat, 02 Feb 2019 08:36:47 -0800 (PST)
Received: from avx2 ([46.53.245.251])
        by smtp.gmail.com with ESMTPSA id z11sm6885423wmb.45.2019.02.02.08.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 08:36:46 -0800 (PST)
Date:   Sat, 2 Feb 2019 19:36:44 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Zhang Yanmin <yanmin.zhang@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] linux/kernel.h: use 'short' to define USHRT_MAX,
 SHRT_MAX, SHRT_MIN
Message-ID: <20190202163644.GB28518@avx2>
References: <1549123585-13800-1-git-send-email-yamada.masahiro@socionext.com>
 <20190202163105.GA28518@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190202163105.GA28518@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 07:31:05PM +0300, Alexey Dobriyan wrote:
> On Sun, Feb 03, 2019 at 01:06:24AM +0900, Masahiro Yamada wrote:
> > The log of commit 44f564a4bf6a ("ipc: add definitions of USHORT_MAX
> > and others") did not explain why it used (s16) and (u16) instead of
> > (short) and (unsigned short).
> > 
> > Let's use (short) and (unsigned short), which is more sensible, and
> > more consistent with the other MAX/MIN defines.
> > 
> > As you see in include/uapi/asm-generic/int-ll64.h, s16/u16 are
> > typedef'ed as signed/unsigned short. So, this commit does not have
> > a functional change.
> 
> > -#define USHRT_MAX	((u16)(~0U))
> > -#define SHRT_MAX	((s16)(USHRT_MAX>>1))
> > -#define SHRT_MIN	((s16)(-SHRT_MAX - 1))
> > +#define USHRT_MAX	((unsigned short)(~0U))
> 					 ^   ^
> 					 +---+
> 					   unnecessary ()
> > +#define SHRT_MAX	((short)(USHRT_MAX>>1))
> > +#define SHRT_MIN	((short)(-SHRT_MAX - 1))
> 
> "short" and "unsigned short" are probably the most useless C types.
> I doubt their usage should be promoted.

OTOH, U16_MAX etc exist and cast to u16, so using "short" would be
the right thing to do.
