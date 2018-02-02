Return-Path: <Maciej.Rozycki@mips.com>
X-Google-Smtp-Source: AH8x226hRVc8BIm96vp9uXv3xI8P+Uvx95AY6fM8iYg+DCJ1lT26CQhS/+KyZ1/4H6MSEYaiaF7K
ARC-Seal: i=1; a=rsa-sha256; t=1517593342; cv=none;
        d=google.com; s=arc-20160816;
        b=SsU//bUZ0Hp3OQvJnH2mQS/rMjwUJqaXlUWRZ4Pn0miWOVJoa4liomOKzFqDaVk2BL
         /2QFgtjky/eubTpOLTuTagaj5pdJt/75aZPY7Sl8ofaRGvVZgJXMoEdFeJAK04OJkUGN
         NGTn0rNg3Q3mxY/ULEUXEliXkLHL3k7oduTAn+0V9NDWEbswzKlwpJvxNM2YvWSSNI0z
         yRnx8QRbmEoWqpY7zrOsCKbtcv20OsmYcICjjDtWfohY1T9LBGJ4Eb3HWta7/bHq+DI0
         lgrqsbHSbjq/2H8Z8q01J7rXrp94g3cl4nQ16yqxNcA6ZicSzYIWIr2CCNZwg3SwHE8I
         jzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=1UCjeR8GHMiU0jqjexd5kUJ/nq/3QFHqlbJWGHFcWeA=;
        b=FFsf61rO/+fld9vLs/dh70SIqGNIUPjQJcGu/93FxgTQH8HIgi8Wprn9+dYsrbxU4L
         tMG95am9cA3rGtrXlEk4hGlg6stMeyGW5NDidnOmSVYFRq1WnhaLnHe+CtYTSkzNaMal
         uSKmV3nbGVTenlQl4pOJ3hTMqWNjPJ4Fd6HGUhPeLm3rS7+JbUJAUajt7y6sF78SP4eH
         5QG9ww7pFe/Vno5f6XBUkar56S6iqK3kYR3jDxxT1bPx93W55Upxjq9ertb7NAN2z9P9
         ckZt/XzlN1053oc4jZrg5VrtTDNU4fPlvcN3zHkDpYXwQ8T5YHoSPQlRjAUGhQqatDV3
         h68A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of maciej.rozycki@mips.com designates 64.235.154.210 as permitted sender) smtp.mailfrom=Maciej.Rozycki@mips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of maciej.rozycki@mips.com designates 64.235.154.210 as permitted sender) smtp.mailfrom=Maciej.Rozycki@mips.com
Date: Fri, 2 Feb 2018 17:38:00 +0000
From: "Maciej W. Rozycki" <macro@mips.com>
To: Florian Fainelli <f.fainelli@gmail.com>
CC: <linux-mips@linux-mips.org>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Ralf Baechle <ralf@linux-mips.org>, "Kevin
 Cernekee" <cernekee@gmail.com>, James Hogan <jhogan@kernel.org>, Paul Burton
	<paul.burton@mips.com>, Matt Redfearn <matt.redfearn@mips.com>, Huacai Chen
	<chenhc@lemote.com>, Kate Stewart <kstewart@linuxfoundation.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Marcin Nowakowski
	<marcin.nowakowski@mips.com>, Andrew Morton <akpm@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>,
	David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>,
	Thomas Meyer <thomas@m3y3r.de>, Bryan O'Donoghue
	<pure.logic@nexus-software.ie>, Robin Murphy <robin.murphy@arm.com>, "Michal
 Hocko" <mhocko@suse.com>, Lucas Stach <l.stach@pengutronix.de>, "Vladimir
 Murzin" <vladimir.murzin@arm.com>, Bart Van Assche
	<bart.vanassche@sandisk.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 3/6] MIPS: BMIPS: Avoid referencing CKSEG1
In-Reply-To: <1516758426-8127-4-git-send-email-f.fainelli@gmail.com>
Message-ID: <alpine.DEB.2.00.1802012034400.4191@tp.orcam.me.uk>
References: <1516758426-8127-1-git-send-email-f.fainelli@gmail.com> <1516758426-8127-4-git-send-email-f.fainelli@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1517593241-321458-20196-2127-13
X-BESS-VER: 2018.1-r1801290438
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189619
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590436518604633531?=
X-GMAIL-MSGID: =?utf-8?q?1591311956324444027?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 23 Jan 2018, Florian Fainelli wrote:

> bmips_smp_movevec() references the CKSEG1 constant, which is about to be
> updated in order to support processors that might enable eXtended
> KSEG0/1. In doing so, we will generate a reference to a function, which
> is obviously not permissible within assembly. Fortunately,
> bmips_smp_movevec() is only used on BMIPS4350 which does not support
> eXtended KSEG0/1.

 Can you please avoid replacing the macro with a hardcoded magic number 
though, so that it retains the high-level meaning?

 Define another macro, say MIPS_ARCH_CKSEG1, and use it here instead, and 
possibly elsewhere too.  You could complement it with BMIPS_XKS01_CKSEG1 
if necessary too (I haven't thoroughly looked through your patches).

  Maciej
