Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42381C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04A320685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnGmBD8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04A320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbeGZNCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:02:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51122 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbeGZNCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:02:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so1681389wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 04:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tbsbLpjSqdW8YYLaaHy4b56EtmpyKT1quxl/XxB8W4I=;
        b=DnGmBD8Sb3VfAX2dYX/D85NGxRhsiBuQrUAq/TCfo97Zv9XUhy8VI+cLPIAHkK2hkU
         aqHUFSrtYiz5909drfTj5r2aGllXjU3q507ryf9tcZk4zR2qSL+pP4rNMCiXfxi/YiyM
         H9Ro3B5tynhvuMnhwQHXvVu2AY1aF+zipLuULjBAjGTSyOsq7N58/WcZgzV5prU3jij0
         5QcnxwteSXaufzZEbGFlTvjpjnvFNKQ5iMJENsp42RgscM4EudWdkw1od8EVnWH4AqiU
         EkGCKgZDokqww3Blb5sIQ3O8cHd5ze0ShrxizM9MVTXK3wtVduB5mDM1hGAVc7gTXUMs
         gBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tbsbLpjSqdW8YYLaaHy4b56EtmpyKT1quxl/XxB8W4I=;
        b=ZEXvTWWGaIkB2qRQ6E1wiaeQUYx9XpNeNlafn0guusEzQf25JNjdJRKirvwg6TPHoO
         hKkRBFB8aYlnkgD/rwEZlddU1ChvrAlKfxJXBArfdXSg4fCQZMZeOxi/NdZpALt7iHgC
         V8tmdKFnyzUadqIiuNBeOeeZe7vAm/G6r6opWu2QKOolG5v27hmB9MMdXw8u3uCZFZxY
         hKPI3cnRHpqFho2h3EYEmmOOabu4SO0jmw+FTESCaUhwQeq3yzp3ZAreduen1j6jKazO
         zYA8Hzf0aArbcyVdiv1uMp2GgpWbOGLijDfYo8lbJd7JTyFaWnOZ+9QWqhQyZy/wwT3D
         QrXQ==
X-Gm-Message-State: AOUpUlHGlmtiDTnDMIp23g5dvSL3ZiFitWdTiYrDJ8k2M/Xw/a7haB97
        hd5rlg7SXDIihgmKu7P0U5A=
X-Google-Smtp-Source: AAOMgpcygZknOfEgjUUW8rnUSHJwAXNdG+06KaGelwnqnE0UhCWqHkJIvNwNGOaRjMN5O5qceYcBmQ==
X-Received: by 2002:a1c:b484:: with SMTP id d126-v6mr1345699wmf.17.1532605540808;
        Thu, 26 Jul 2018 04:45:40 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1693441wma.18.2018.07.26.04.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 04:45:40 -0700 (PDT)
Date:   Thu, 26 Jul 2018 13:45:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Jan Beulich <JBeulich@suse.com>, mingo@elte.hu,
        rdunlap@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64: use 32-bit XOR to zero registers
Message-ID: <20180726114537.GA12408@gmail.com>
References: <5B30C32902000078001CD6D5@prv1-mh.provo.novell.com>
 <a68a703f-5d74-a2eb-4b26-0fe3e6e48705@infradead.org>
 <5B31DDFF02000078001CDC03@prv1-mh.provo.novell.com>
 <20180626113822.ch3erlyud5wsxvvg@khazad-dum.debian.net>
 <20180726091916.GA23471@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726091916.GA23471@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> On Tue 2018-06-26 08:38:22, Henrique de Moraes Holschuh wrote:
> > On Tue, 26 Jun 2018, Jan Beulich wrote:
> > > >>> On 25.06.18 at 18:33, <rdunlap@infradead.org> wrote:
> > > > On 06/25/2018 03:25 AM, Jan Beulich wrote:
> > > >> Some Intel CPUs don't recognize 64-bit XORs as zeroing idioms - use
> > > >> 32-bit ones instead.
> > > > 
> > > > Hmph.  Is that considered a bug (errata)?
> > > 
> > > No.
> > > 
> > > > URL/references?
> > > 
> > > Intel's Optimization Reference Manual says so (in rev 040 this is in section
> > > 16.2.2.5 "Zeroing Idioms" as a subsection of the Goldmont/Silvermont
> > > descriptions).
> > > 
> > > > Are these changes really only zeroing the lower 32 bits of the register?
> > > > and that's all that the code cares about?
> > > 
> > > No - like all operations targeting a 32-bit register, the result is zero
> > > extended to the entire 64-bit destination register.
> > 
> > Missing information that would have been helpful in the commit message:
> > 
> > When the processor can recognize something as a zeroing idiom, it
> > optimizes that operation on the front-end.  Only 32-bit XOR r,r is
> > documented as a zeroing idiom according to the Intel optimization
> > manual.  While a few Intel processors recognize the 64-bit version of
> > XOR r,r as a zeroing idiom, many won't.
> > 
> > Note that the 32-bit operation extends to the high part of the 64-bit
> > register, so it will zero the entire 64-bit register.  The 32-bit
> > instruction is also one byte shorter.
> 
> Actually, I believe that should be comment in code.

Agreed - mind sending a patch that adds it?

> But Ingo (?) told me everyone knows about this quirk...

I was wrong.

Thanks,

	Ingo
