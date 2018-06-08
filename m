Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id L6cEK0KmGlskfAAAmS7hNA
	; Fri, 08 Jun 2018 15:52:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8FD1E607A4; Fri,  8 Jun 2018 15:52:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teNO+Ve4"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 000DE601B4;
	Fri,  8 Jun 2018 15:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 000DE601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeFHPwb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:52:31 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46705 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbeFHPw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:52:28 -0400
Received: by mail-lf0-f68.google.com with SMTP id j13-v6so20776284lfb.13;
        Fri, 08 Jun 2018 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vvWSbYkDe2lVue95quDAA1y7dzReA+azzvIC43o54Io=;
        b=teNO+Ve4gHSMlRozuEuseRTDb6j8eL+iw/8Wh3vY2YF8JXbQB62V+qMQYJxo0//ptm
         bzpnGRf44GhG0nC3iNiaLMEElvgg/QZkUZg3ZZ2MTzjyyXFHKtJZsN5M0iLUGSWL5IM6
         ll1179L5xCNrCdyvc041UVIOCE7BlShFFD+H7wjZ5Q8vYf0TqrBXSWCdyLFn84ElvGKe
         MXn2DXsVEwgAKU2M1HFBu9Kl6wbnnki3zm2BEBfB8UyouZh/ThrwifRtbqpjy5EA9AHG
         ZPD347SEZclP2BVNA89pDasG1vhCGVzsNm46D9RHc5uCFkUrEybt39X5sE69wwKLDCKX
         fqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vvWSbYkDe2lVue95quDAA1y7dzReA+azzvIC43o54Io=;
        b=VnvHgYWClNYqe8LtYXoiU9t0Us3O38kIEdLoVLwqi0aXvA3cUa0DSRPPspQlUCCcgt
         eDxblQx3LhxlLQrSLSAycly2Cy78xDrXmduW8oJYppdcxc/JtzVcoM7R8JbqucS2+/40
         jK7LPCHc8wAEyQplI4q/gO9Ixu+CKFTK+y152jCOOXDgi/7yAodziDZ5JMpd1Z6HHzLd
         oJnChPEL6VTPYZyiReg9MTuouiTqaRopRCSO8VeH1HmeZMGjJAD/RIKfxyQn5hzvAmdY
         53IwHDwSeGVLikmpYq3bSpuecczYfcp/RCOYGGs5qo5WYOpV3zZrXuDLo/duuv+1fBeb
         YHFQ==
X-Gm-Message-State: APt69E1fIZpH+ky1tSyeeHtQwJ1/Tr7JQexegaRD0L7mKciB7LaUVULB
        RpB9mcjknZ0Mi2w/7ENwEsg=
X-Google-Smtp-Source: ADUXVKK6DpNnkb7RI81FyacFaQuMOyl1OLSRdbkKSbQsm2jgcZFCO5/huavAffgFEarqp6kz93Z/mA==
X-Received: by 2002:a2e:8605:: with SMTP id a5-v6mr3002011lji.43.1528473146844;
        Fri, 08 Jun 2018 08:52:26 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id o82-v6sm3037554lfi.50.2018.06.08.08.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 08:52:25 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 544C2460756; Fri,  8 Jun 2018 18:52:25 +0300 (MSK)
Date: Fri, 8 Jun 2018 18:52:25 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: "H. J. Lu" <hjl.tools@gmail.com>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
Message-ID: <20180608155225.GC2525@uranus>
References: <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com>
 <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
 <CALCETrV1GG5rq_kwxkS-o3x8Ldr72ThdYgkJKQ9cx9Q63SxgTQ@mail.gmail.com>
 <CAMe9rOpeDrkwi-AG0vsiZy4NwkmavhB5Empv58FSHxtr3rpapw@mail.gmail.com>
 <CALCETrWhMmqGWKx-yw55YKHMJwGyLZio5f8Pskh8X69zfQMy7A@mail.gmail.com>
 <CAMe9rOpLDzWk=xdZqN1QJVnP-c_dti5Fy=C_GqbeQpS_a=0ewA@mail.gmail.com>
 <CALCETrUyapFiiXrHH23NW8XbqEkfKdGGU2wMUZ2DU=A+GWGqvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUyapFiiXrHH23NW8XbqEkfKdGGU2wMUZ2DU=A+GWGqvw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 07:57:22AM -0700, Andy Lutomirski wrote:
> On Fri, Jun 8, 2018 at 5:24 AM H.J. Lu <hjl.tools@gmail.com> wrote:
> >
> > On Thu, Jun 7, 2018 at 9:38 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > > On Thu, Jun 7, 2018 at 9:10 PM H.J. Lu <hjl.tools@gmail.com> wrote:
> > >>
> > >> On Thu, Jun 7, 2018 at 4:01 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > >>
> > >
> > > By the time malicious code issue its own syscalls, you've already lost
> > > the battle.  I could probably be convinced that a lock-CET-on feature
> > > that applies *only* to the calling thread and is not inherited by
> > > clone() is a decent idea, but I'd want to see someone who understands
> > > the state of the art in exploit design justify it.  You're also going
> > > to need to figure out how to make CRIU work if you allow locking CET
> > > on.
> > >
> > > A priori, I think we should just not provide a lock mechanism.
> >
> > We need a door for CET.  But it is a very bad idea to leave it open
> > all the time.  I don't know much about CRIU,  If it is Checkpoint/Restore
> > In Userspace.  Can you free any application with AVX512 on AVX512
> > machine and restore it on non-AVX512 machine?
> 
> Presumably not -- if the program uses AVX512 and AVX512 goes away,
> then the program won't be happy.

Yes. In most scenarios we require the fpu capability to be the same
on both machines (in case of migration) or/and not being changed
between c/r cycles.
...
> As an aside, where are the latest CET docs?  I've found the "CET
> technology preview 2.0", but it doesn't seem to be very clear or
> entirely complete.

+1
