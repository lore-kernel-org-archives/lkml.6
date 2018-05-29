Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2038058-1527597148-2-14296603244813153315
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527597148; b=UsOH6OgqATr0Pj5wwWHwFGil/IDkV2ecRjn7fOmS1Nr1uAiRKH
    rDuqvnhKnvUq8De3gjepx/R9DqnttlR5JsfZR2FsrskBsElkR/m52BYi8qj4a/D4
    6hfkmOfpJIGqGnAejI/x0qYmEoKoko5UhZ+ie/i2VzFt+X++fbeL/x20/MJSTkVT
    LwyeDJ/l+FdPz3JP2NNSWYV2GZJa5R9kssBmy+JFPYnvQ1SWLm2mqVctj1LIVqex
    Aw7Yk6EMaYAeaxZ6G1NOBqcduCPoZw0c2T6nFnG6o2nXhyy1RCSed+qnWrkb0Zzm
    81bdG41M2t59Td20DWLD7a3eIodrPlIjMSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527597148; bh=Kwpr8Tp3s4QlC7nKwZh1tdFE211U7L
    J8HfiiCc4doWY=; b=TlYs0Q+b4SPGpq9LMmLn+wDRw9OU7TnSm22ZPQHfF/gdHX
    0A6zE74/90I+70NF7YwftZrBGo+XlA+sn2V3M1Y9Fu+cirz3J+Yzx4YvGSFBB/sH
    aPlEbklQNf7KdpA+Xla+s/P0AeA7hEvsturjGHczqfB60g4CAaVaFeReKzY6ma6c
    oOeIufxUD02hZCfI3cwqcDs9nRdPsyG/9fCb+HCS0e77+GVsoDBkYcvd/2Rsj5Wn
    YMpYmnunqAdr0zkLy6VFoG9CJL/ab1GP942nU+hAkVvkOV3DNFBXDEwO8HliH+E5
    HPAveW+z39xWLnh6JeukJyQq/fEqFj4z/9le8KdA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amarulasolutions.com
    header.i=@amarulasolutions.com header.b=Sv8mMt7F header.a=rsa-sha256
    header.s=google x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=amarulasolutions.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=criK57n7;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=amarulasolutions.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amarulasolutions.com
      header.i=@amarulasolutions.com header.b=Sv8mMt7F header.a=rsa-sha256
      header.s=google x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=amarulasolutions.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=criK57n7;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=amarulasolutions.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKbDeubT78S+yei9IK2vH7nnmBcALikYnvw5DTBMoYOZkDOki3QL7lYcGnD3f8lzeheiYwG/VPRZJpgjhpvk89e3rLfsuBrr65a7NBdnGlp0ZnXUzXRR
    2KzdN8HtcioeGvXEbCLiPxmRMgIW+IcSZs/n7ujfzTHaJXP55+ixj6T6Ay1pkGqfrvMf4l465PFPNzUlLXefSnEFZwF8/lcDgsD7MAQ8SUpOuniLK8tJBaFW
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=xB7911u2hZRMw3IvlAYA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933716AbeE2McZ (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 08:32:25 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42450 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933653AbeE2McY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 May 2018 08:32:24 -0400
X-Google-Smtp-Source: AB8JxZrnDX054o8GxU7qSuSvFzafhwJqMadi4AqAotLJma7B0zUa0jeVQOfMll4QosboBywSXocrrA==
Date: Tue, 29 May 2018 14:32:16 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        stern@rowland.harvard.edu, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, mingo@kernel.org
Subject: Re: [PATCH RFC tools/memory-model] Add litmus-test naming scheme
Message-ID: <20180529123216.GA11608@andrea>
References: <20180525191020.GA5914@linux.vnet.ibm.com>
 <20180528112010.GA8801@andrea>
 <20180528214838.GZ3803@linux.vnet.ibm.com>
 <20180529093350.GA5803@andrea>
 <20180529121941.GG3803@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529121941.GG3803@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[...]

> > Right, thanks.  Ah, maybe we should strive to meet the 80-chars bound
> > by splitting the command with "\"?
> 
> We could, but combined with your later request for indentation, we end
> up with something like this:
> 
> 	$ norm7 -bell linux-kernel.bell \
> 		Rfi Once PodRR Once Fre Once Rfi Once PodRR Once Fre Once | \
> 	  sed -e 's/:.*//g'
> 	SB+rfionceonce-poonceonces
> 
> In the immortal words of MSDOS, are you sure?  ;-)

I find it more readable, but it's just taste ;-)  Commands are indented
with 2 spaces in the other README.


> > Well, "Rfi" produces "rfi" while "PosWR" produces "pos" for a name...
> 
> Right you are!  How about this, then?
> 
> Rfi: Read-from internal.  The current process wrote a variable and then
>         immediately read the value back from it.  For the purposes of
>         litmus-test code generation, Rfi acts identically to PosWR.
>         However, they differ for purposes of naming, and they also result
>         in different "exists" clauses.
> 	Example:  ???

LGTM, thanks.

  Andrea
