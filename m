Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4689DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03A5214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piL+NEqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03A5214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeJJOnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:43:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35302 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeJJOnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:43:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id w5-v6so4446115wrt.2;
        Wed, 10 Oct 2018 00:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yPfb4YFX/q8A1De8WDJ42fxiXtE8tETkaUjFqrJDi5Y=;
        b=piL+NEqaqg6gBXyGHQIaVf1FhFJzuL8VebETWRlP8zfgWHtJpp76q0mSjs50tf7WK/
         A3p8qPJEyLxC9SXVhHHYsmtig0ZbFgvdH55x3rxn5IfZ0mAEJ3gJgYYRWyHEDEwEDhSu
         GTVbXF3eQ7sLFjLP9IOGVw2aIqm4pHqvTYdZNNL+gW/ZkrDDECuJP/LVArUWMBdbwWx+
         O/+z/yHzRo+9LhY1Y7LwG1oabEyVyydDcXr3EKNAH8A6iEtSdsucD+UmuwMRwSlx6MrI
         s3sUHDrgWnAkKMs670zSuCuzRmuuk76Xby179iX0+QxapF05JY5jr8slDShhKSJIEw3B
         T2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yPfb4YFX/q8A1De8WDJ42fxiXtE8tETkaUjFqrJDi5Y=;
        b=jXobpGZ2HWsV1LeOGq+a4iSAkYgI7hHGr53KbhFT4hZrkHJualPlXJxKV8/s3mH2Dg
         U36YHeKz/8/QWUI2B6CB1jNYktvZyKWLME/Hbai+PyU9d+aa3MRYP5oKy5zt5d5lSdap
         pHF8VW2IG/3mFmx/0Ax1VVYJf+wokuOmzFo5eqhtRO/alS8E08Pqt/916e9u4wdamELE
         gNcBNMCV4/GZKIvXW+ewxzhLWumNlSjYRB0KrlgP8ovBO+ghmazjsle77KIf6l+Uw+A2
         1ROOoQ6CH6y3cVRHj+2tGub6IbCj14OIJRCKMHL1NdcjzZB6Ea0ev4OIkDADiDMhn9O/
         68zQ==
X-Gm-Message-State: ABuFfojbhVORtelfD+uhdDhs1f8oFud61mKhRKwh58uYdIQLIlNmKBmF
        LdMUhNCKCXcEuKsKHxAJHrI=
X-Google-Smtp-Source: ACcGV62fgP7XfYVfp3TgSjA369t5RxOdw1gb9UG9juulhtaic7aTqZbFHaumSN/7Z9okOkHpCAw0Fw==
X-Received: by 2002:adf:bb02:: with SMTP id r2-v6mr22537206wrg.24.1539156164367;
        Wed, 10 Oct 2018 00:22:44 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y65-v6sm12725990wmg.40.2018.10.10.00.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 00:22:43 -0700 (PDT)
Date:   Wed, 10 Oct 2018 09:22:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Richard Biener <rguenther@suse.de>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>,
        gcc@gcc.gnu.org, Nadav Amit <namit@vmware.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-sparse@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Message-ID: <20181010072240.GB103159@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181007091805.GA30687@zn.tnic>
 <20181007132228.GJ29268@gate.crashing.org>
 <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
 <20181008073128.GL29268@gate.crashing.org>
 <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org>
 <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Richard Biener <rguenther@suse.de> wrote:

> Can kernel folks give this a second and third thought please so we
> don't implement sth that in the end won't satisfy you guys?

So this basically passes '0 size' to the inliner, which should be better
than passing in the explicit size, as we'd inevitably get it wrong
in cases.

I also like 'size 0' for the reason that we tend to write assembly code
and mark it 'inline' if we really think it matters to performance,
so making it more likely to be inlined when used within another inline
function is a plus as well.

Does anyone have any concerns about this?

Thanks,

	Ingo
