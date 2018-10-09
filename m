Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8F5C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47D221479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPNk5unh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47D221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeJIPD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:03:59 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:34774 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJIPD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:03:58 -0400
Received: by mail-wr1-f43.google.com with SMTP id l6-v6so252417wrt.1;
        Tue, 09 Oct 2018 00:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GEsLnqxKRvF8uA8is7YgA4tp498odlxkNHlD9XhTc/o=;
        b=uPNk5unhUQm3Vt9tmkLX+L6qBexanT2MrHmbXGeR1BjoJrlfrGVwJjfIPup4DjcUOX
         RwteUVYnNiTsoGOPhnyjE6Sh8oyM5MVxpAhqe8+jiF5en3E8b6Nm+ECDo97TLAXR6cN/
         qkDHmAik7ccFcYWj7jqzAiyNBMZY+ruOEl/HRIbhuo+LCExLQ1VD4hy42XOgy9ASKVIZ
         Rf3D7KRaLTg4WAJWZ+GqSgkaj9aN6K1d6tOSpo5vzqBcCEh8s4E97E1dC+41BfW4weYs
         Kd8OFImjX1dTWttuSWK+xZyRJYf8pLecHeUgIUSMYcg0u8Yc7oYprtb3Ki+94e1QOUVt
         fQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GEsLnqxKRvF8uA8is7YgA4tp498odlxkNHlD9XhTc/o=;
        b=JM/8pCRV3Drx1Ygf314ImoIqE9SoH4fRr5ePowEEhmZ57D6VmjuXPYPasFSe+YBp4L
         sGu0/heoYLGyAdwRrgcrUH93nJzN6NUBeosi8VqqgVuij+C+hSy3ks7p3xyMErGCcxNx
         CKsWMpzpeQH7ngcvth2I+OZJJrgXRCfrjVAH99+TJJN0cghwNEB56UTzRbE4IDrdt135
         EnBvFnVI5+qB0oohaPSCv520nFndAuo2PSJ1E7xtWf/shO8D5Sdj9ujq2GhYX5PSE7xS
         eG8Cr/W26o5v+wPT+SWzpwDeAH1Njz/oBcTqwFW1F+U8xAmCLDk4Hrx4+dlBI2BD+oeP
         JEGw==
X-Gm-Message-State: ABuFfoid/75XFJ8MPa6WnZcrUPicChe+r/waAjqd3Tj3I5Nxc4rrdyGb
        oHoL1Q6vWFTQfe2Qp1f5oMo=
X-Google-Smtp-Source: ACcGV6272YtGCAT4tOGe1wcQH8zb+UnMMEaZlWha6gH0Qgi3asWiB4aCqxprm4Od/bOtm+TK3TgSBA==
X-Received: by 2002:adf:b743:: with SMTP id n3-v6mr19351111wre.274.1539071299436;
        Tue, 09 Oct 2018 00:48:19 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 2-v6sm11985001wro.96.2018.10.09.00.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 00:48:18 -0700 (PDT)
Date:   Tue, 9 Oct 2018 09:48:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        linux-tip-commits@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Toshimitsu Kani <toshi.kani@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [tip:x86/urgent] x86/mm: Avoid VLA in pgd_alloc()
Message-ID: <20181009074816.GA114187@gmail.com>
References: <20181005161333.765973-1-arnd@arndb.de>
 <tip-1be3f247c2882a82279cbcf43717581ea943b692@git.kernel.org>
 <20181008202209.GA6597@zn.tnic>
 <CAGXu5j+4hjJSFpYi=5SqDmkonJ79J=hcb65qJC8+_r6+5NHewg@mail.gmail.com>
 <CAK8P3a2KTzTD5d10KkmcKh=_E7J7EJkE48wrcUe4AAwDiBVuEQ@mail.gmail.com>
 <20181009073913.e4r7qwzb2c6qrji4@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009073913.e4r7qwzb2c6qrji4@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Joerg Roedel <jroedel@suse.de> wrote:

> Hi Arnd,
> 
> On Tue, Oct 09, 2018 at 09:33:56AM +0200, Arnd Bergmann wrote:
> > Ah, cool, thanks for the analysis. Is the patch already reverted?
> > I.e. should I send a replacement patch, or a relative fix, or is
> > someone else already on it?
> 
> Kees sent a fix which is already in tip-tree:
> 
> 	https://lore.kernel.org/lkml/20181008235434.GA35035@beast/

Yeah, decided to rebase and squash the two patches together into a single commit and credit 
everyone in a single patch (hopefully correctly), the original patch is pretty recent and I 
didn't want a bisection breakage.

Thanks,

	Ingo
