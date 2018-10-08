Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFDBC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3233F20882
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqjx1KFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3233F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeJHNIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:08:44 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:41750 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeJHNIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:08:44 -0400
Received: by mail-wr1-f52.google.com with SMTP id x12-v6so19318205wru.8;
        Sun, 07 Oct 2018 22:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+C1ZrK0nf2V1FEmvA44MT/f9YxVbGtVdHk1cVB4Q9DU=;
        b=pqjx1KFs+oLTL3k5Nt+jPW9whAHi+/H2g8RO2pWFblC8sIEZb/IVKwkokqaL9z3yHL
         FpLp5hcObyi3e277euKECrtqXf3yqkRENmCkUm7kG8Z2IYkGPF6/XCgcbJOzBvqEKjHX
         Jq1vJiYcttTEL5WnxzkNzYVaZ+qPW2G3WydOdktnedzV/wsliAi3vAV66mfWw5nzbFsb
         TigpkQjlBZwVdwIj+WDxsVw//9/ICxgwYiBMVOb3p+SuKH/bsaOLDIizBnjtwoPe0ONE
         mZEiHuV+O1HnWQnUar6Pe3yGeAE0b+AaBJTjsvz9TtDR+IQfxuBR0RihIKyPgpS6VZyU
         ly7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+C1ZrK0nf2V1FEmvA44MT/f9YxVbGtVdHk1cVB4Q9DU=;
        b=MvprTSR39CiZoxKjZhGoAMQH+AYgekS5DGSvFf9yel5x+AeD5smr+hyDnpOijdq+H2
         chfqIw/6AHxKNHjHgjm4w0qcjnPeNMG2HCe2EjtorB3ZcleEhSluj53risbkcryiBNzF
         PRQ851odqS/PTTdQlPUWB5vLq6Uj2OP8zwHthxMGOPKgkDc0KXmr+1fqzixyCyt0cFDl
         UHsSFXSfY/3QtCbUHXtp6PI5eZEi5nEnfxlImSKYX+orUDnAirFMuN7IEqTNVAnEESdE
         H0V+ur4qHDZuw21GtrkgdHsuHDUcZbddiELiYzh6MXrx1DjIF5wFY9r2zdOq2TVkY+KE
         iVuA==
X-Gm-Message-State: ABuFfojZhWb4xXGhxzZtKEsFyy/3CxUZpwdHw8rxKSG6DcFHHdY+Diy2
        LnV8YSTUkHgrJYVlb+KkUsU=
X-Google-Smtp-Source: ACcGV60gvZzNzygU6xr9pHT68wMI0D363h9iArV45U7eK92h4bYm0QWQv6Z2gGPXXknQsuoOLyRaYA==
X-Received: by 2002:adf:f802:: with SMTP id s2-v6mr15487664wrp.172.1538978322431;
        Sun, 07 Oct 2018 22:58:42 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z89-v6sm37796832wrb.3.2018.10.07.22.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 22:58:41 -0700 (PDT)
Date:   Mon, 8 Oct 2018 07:58:38 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Borislav Petkov <bp@alien8.de>, gcc@gcc.gnu.org,
        Richard Biener <rguenther@suse.de>,
        Michael Matz <matz@suse.de>, Nadav Amit <namit@vmware.com>,
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
        linux-xtensa@linux-xtensa.org
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Message-ID: <20181008055838.GA66819@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181007091805.GA30687@zn.tnic>
 <20181007132228.GJ29268@gate.crashing.org>
 <20181007141349.GD30687@zn.tnic>
 <20181007151427.GK29268@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181007151427.GK29268@gate.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Segher Boessenkool <segher@kernel.crashing.org> wrote:

> > > More precise *size* estimates, yes.  And if the user lies he should not
> > > be surprised to get assembler errors, etc.
> > 
> > Yes.
> > 
> > Another option would be if gcc parses the inline asm directly and
> > does a more precise size estimation. Which is a lot more involved and
> > complicated solution so I guess we wanna look at the simpler ones first.
> > 
> > :-)
> 
> Which is *impossible* to do.  Inline assembler is free-form text.

"Impossible" is false: only under GCC's model and semantics of inline
asm that is, and only under the (false) assumption that the semantics
of the asm statement (which is a GCC extension to begin with) cannot
be changed like it has been changed multiple times in the past.

"Difficult", "not worth our while", perhaps.

Thanks,

	Ingo
