Return-Path: <bp@alien8.de>
X-Google-Smtp-Source: AH8x227qJ8on+LnvhQsag8iRDJKiWzcQ0+2Swsc3ZD6EL7WVaiczVkhADI/piWfNCw1ZJy5g55it
ARC-Seal: i=1; a=rsa-sha256; t=1518101652; cv=none;
        d=google.com; s=arc-20160816;
        b=bSwQuklri0ELMnI5u4u0Jb7/54+zsuhH1RwmqEHABYJ0rk1ndsCMuIOpWHlSiOM1Ai
         6+Feymtl2U2lgnapz1bPdHjbxeLQT9kkALFlComNzkalxI6Yd5iRbS4ainf4nbYQRnbO
         UH0kuWYHskzvYHqg97v0wZ1rAP4+tH8WtYi/FLnWkgMuB4crF0gjhi16wT/a4yFm86uO
         3ZERny+yvPp47ns33gbSaaL0iRupcH2jNzQUVh62ufpx46i3VUhlAZOVgeJ8Yci0/6ZL
         tARrPFZmV7G1Cfh9+NBfibTWY+yRt7H8WhA3lHPjlxT06d8AZg78P30e1QvnMnyZLMNU
         P60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=B3OUSZJdVgKU1Aw4s+JJ++LpkHnfxuxZVtDIyZZdD0Y=;
        b=maSrLbGwgU7rUYuJQtcb41H61ZmXKL5ghgaakY0HvmQE9u39BQZudpaDBwRZmlGjJ5
         ohhxmwoLcG6T+E3hcKvFOnMoAGWlVT2rRdbOmadSHotSF0M/tPoqLzPfTUM2BiS9++6W
         BmK/Lzh6/AGVW+qhyv6NNLPgrn0ya2kWDKYClLUUvq3O1muDq2MaqtmNI0bnd3/I2qN4
         liumg1lY3QntGgmsvzIipz2LYF9Ponagj1hDJtJ54ZhIX+V40MT2UWz2A2b7hYoz5nA3
         B9YPHSMQvBcWV89TB7sInkuwNDHOLsqT16++Z7cD9Q08HXzSa6knrU56VDKErrsK7tXJ
         wJdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 2a01:4f8:190:11c2::b:1457 as permitted sender) smtp.mailfrom=bp@alien8.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 2a01:4f8:190:11c2::b:1457 as permitted sender) smtp.mailfrom=bp@alien8.de
Date: Thu, 8 Feb 2018 15:53:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rolf Neugebauer <rolf.neugebauer@docker.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Jia Zhang <zhang.jia@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: x86/microcode/intel: Division by zero panic in 4.9.79 and 4.4.114
Message-ID: <20180208145348.GC7964@pd.tnic>
References: <CA+pO-2c6z6uc8EO7LwWkGe3g_ygMwfS=VfQPNHzvS4H7RJOt-w@mail.gmail.com>
 <20180206142444.7xxegyyyfwskwrxl@pd.tnic>
 <20180207143428.GA31944@kroah.com>
 <CA+pO-2eiim-6E8VLAV2K3s=pqEv7QcV1f8znLeQWqZh=zKWVVQ@mail.gmail.com>
 <20180207181254.GC8698@pd.tnic>
 <CA+pO-2e=nZJeAR2j8Pukb=E4aHgvDXc9Tw4poatrUcD15Wi1Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+pO-2e=nZJeAR2j8Pukb=E4aHgvDXc9Tw4poatrUcD15Wi1Jg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591660958258362388?=
X-GMAIL-MSGID: =?utf-8?q?1591844957816273090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 01:55:48PM +0000, Rolf Neugebauer wrote:
> On the 4.4 kernel, 1f161f67a272c ("x86/microcode: Do the family check
> first") does not apply cleanly. Looks like it relies on 309aac77768c0
> ("x86/microcode: Decrease CPUID use") and 7a93a40be23e5
> ("x86/microcode: Remove local vendor variable") as well. These don't
> apply cleanly either.

It figures. The backporting game is hm, well, a fun one. :-)

> Should I just manually backport the functionality of 1f161f67a272c?

Yeah, try that first.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
