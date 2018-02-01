Return-Path: <sam@ravnborg.org>
X-Google-Smtp-Source: AH8x22788M5Ty0q0MKX9RNrvGW8wWfYdpnHPz0w1UcUfuGPVZZfbZSFUqMfTERZQTaLrigyZBI3X
ARC-Seal: i=1; a=rsa-sha256; t=1517521778; cv=none;
        d=google.com; s=arc-20160816;
        b=JJ3UjDAffIZZ3vOsKN8i0MoMlSzp9n9agG+RSC946cnx3KcWS9C0yNgOg4jEggW4vC
         YSZzhzJfRTM7FuEUqBWjy4iiuTTwuv7eyuLPbbsyzbF56bifqJGNcBGcbH+wdwKCUR3o
         v/g66Jz9LEEsqfbuvXEfJ4ygskFFq7JwK9JfNIp4rfKI8ubLPrfjjkk4s1/cHc/OSTbt
         Gi/AUoscnzDS/jeFXvg0v4sUhTwli5iZScHp8Qfgtr5jL1hPa2ZhpnRUI3y/O+WQeY7a
         e2pt0BtO5NWMEiKnZJtDRcZD5J/d2F5Q042r26c9bY8baXJNUlJ34OKRyoGLJMxdvqc6
         Ykwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=eB1BVVjLns6AYiUkB1mYqveMZ/qEMV/6fX/W36dJaj4=;
        b=ObGEY59f2FFhHrewIftVkAypToKi0hnQb4V32Ko6k206ZU7Pfjkc8u/Iaqo8dmZm4a
         o3vfsfvi1SjXaxo0RKkGSS/wGjJK8LW1CAaMamyZ/Aqm7ccsVNJcfujK3y5QhWe3BMIm
         UVBvuE/fba9hCbkMqYG/hvvsoNKJCEMv+1xnZGwpPASJY43pV67slgnVFgH/V6JfWGjs
         8qdrJyYmVjCizimxGtouo5Ohu35/RFZOJgG4ar8dCSWLGUjtctev3XyxCpE2Kncsk9NM
         3MfUplFV6MXBEbbh3f8bOrL4Lq9evSf/qIZwXFRP4uoRZMg9c+lpwJN36KFHlRBvR7mO
         Q+vw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 109.247.116.14 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 109.247.116.14 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Date: Thu, 1 Feb 2018 22:49:32 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Joe Perches <joe@perches.com>
Cc: Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net,
	dave.hansen@linux.intel.com, mhocko@suse.com, mingo@kernel.org,
	gregkh@linuxfoundation.org, glx@linutronix.de,
	kstewart@linuxfoundation.org, vijay.ac.kumar@oracle.com,
	kirill.shutemov@linux.intel.com, nitin.m.gupta@oracle.com,
	tom.hromatka@oracle.com, allen.pais@oracle.com,
	rob.gardner@oracle.com, david.j.aldridge@oracle.com,
	babu.moger@oracle.com, bob.picco@oracle.com,
	steven.sistare@oracle.com, pasha.tatashin@oracle.com,
	vegard.nossum@oracle.com, pombredanne@nexb.com, jane.chu@oracle.com,
	anthony.yznaga@oracle.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
Subject: Re: [PATCH v11 03/10] sparc64: Add support for ADI register fields,
 ASIs and traps
Message-ID: <20180201214932.GA25218@ravnborg.org>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
 <e4ad304a57afeff9e3bd6f1fc57a927c943506b0.1517497017.git.khalid.aziz@oracle.com>
 <1517517122.7489.47.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517517122.7489.47.camel@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.2 cv=WJY9ZTkR c=1 sm=1 tr=0
	a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
	a=kj9zAlcOel0A:10 a=lvk2KqW98G_tGuEBF4gA:9 a=CjuIK1q_8ugA:10
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591222601953119188?=
X-GMAIL-MSGID: =?utf-8?q?1591236916388715971?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> >  #define _PAGE_E_4V	  _AC(0x0000000000000800,UL) /* side-Effect          */
> >  #define _PAGE_CP_4V	  _AC(0x0000000000000400,UL) /* Cacheable in P-Cache */
> >  #define _PAGE_CV_4V	  _AC(0x0000000000000200,UL) /* Cacheable in V-Cache */
> > +/* Bit 9 is used to enable MCD corruption detection instead on M7 */
> > +#define _PAGE_MCD_4V      _AC(0x0000000000000200,UL) /* Memory Corruption    */
> 
> trivia:
> 
> There are some whitespace alignment issues here
Looks like you are fouled by the use of tabs.
When you apply the patch it is fine.

> 
> > diff --git a/arch/sparc/include/asm/ttable.h b/arch/sparc/include/asm/ttable.h
> []
> > @@ -219,6 +219,16 @@
> >  	nop;						\
> >  	nop;
> >  
> > +#define SUN4V_MCD_PRECISE				\
> > +	ldxa	[%g0] ASI_SCRATCHPAD, %g2;		\
> > +	ldx	[%g2 + HV_FAULT_D_ADDR_OFFSET], %g4;	\
> > +	ldx	[%g2 + HV_FAULT_D_CTX_OFFSET], %g5;	\
> > +	ba,pt	%xcc, etrap;				\
> > +	 rd	%pc, %g7;				\
> > +	ba,pt	%xcc, sun4v_mcd_detect_precise;		\
> > +	 nop;						\
> > +	nop;
> 
> and here and elsewhere.
> 
> It would be nicer to make all these use
> similar indentation.

The patch uses the sparc idiom to indent instructions
in the delay slot after a branch with one space.
So the space before the nop is mandatory and not a bug.

	Sam
