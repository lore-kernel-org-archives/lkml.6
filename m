Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AG47ELvfh4MZDT0cwmH1G1ZeYEBoUMBc8oHOVwpKQQDR2LXpe1xvDrCd+GMZzyUGKh1N0tFcYJEZ
ARC-Seal: i=1; a=rsa-sha256; t=1521225947; cv=none;
        d=google.com; s=arc-20160816;
        b=tzGJ8GHYU3ck4CSp7Mkc8EN0vgo6St2ZOgPuW6xQUUSAfQlLgWGZZW+2B2yhCCJQlr
         5deeCnNJXDDJrBX4G04TwQI8xCxc/DnRJdh9WUb1RYYi98rncb3EWLpmiNhCqeD4G7wJ
         ZikRyjMv0FW3+z2U/Tsw62J9kpBSSo7NbwvENP1LaipVc6Em7Ijhj+nlRmo9e0Dv5eg/
         +aSCoIFzeva9nF9s7SsTsb6HHRWtOJLgTBGrBlG2bVXE9wKBYAfTu12A6emDs8ot8No7
         bTtVx0MRL1mmtY2+A01/QWLLz/pI9M0tsr+URf+29OmcmQzzq5Xa/RtaVNurhjIso5uS
         zjXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=1aXfS18ZdTnpBrRbtQccLi7V1kcC42WKGfdxA2kCSz0=;
        b=X+T8f/2iKpo2zohLu9sqTvIElXN2Rndx2jjVEkI3ku9dDAko+BA3FT2zHoEz5U5rtS
         ODbxPjnH1H57W9A8UD4MPom6fg0MAiHhAnqzpINHVZxAD7uj88tC5eDf7cxSAfdR4dcm
         eMOhYVJ+GNJcPI/UVDVB7ijeYDxS8lett4zU4OVAF6SFO+TpPWFDSc2qVQoFFjW7Pxu4
         VAvGMIRSHl/p0NIxUGMQoLi9ekU+JEfv571nwwbVMOu3bAkoMFX0ODJDU4Ui4ZHGuFrY
         UAL2/vFKgv2CbYTWVi2YKXRN9hFGYnwTgmLXr6SxxmuWhRKcBFimEotUBArXXwLvbZGs
         OQoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.138 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.138 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6742:9025:10004:10400:10848:11232:11658:11914:12043:12296:12679:12740:12760:12895:13069:13311:13357:13439:13845:14181:14659:14721:21080:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: tub93_897ed32710c42
X-Filterd-Recvd-Size: 1808
Message-ID: <1521225943.6119.10.camel@perches.com>
Subject: Re: [PATCH][RFC] kernel.h: provide array iterator
From: Joe Perches <joe@perches.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Kieran Bingham
	 <kieran.bingham@ideasonboard.com>, linux-kernel@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-media@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Kees
 Cook <keescook@chromium.org>,  Herbert Xu <herbert@gondor.apana.org.au>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, Randy
 Dunlap <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>
Date: Fri, 16 Mar 2018 11:45:43 -0700
In-Reply-To: <b6af11b9-d697-59ec-6acc-80f0657a3e11@prevas.dk>
References: <1521108052-26861-1-git-send-email-kieran.bingham@ideasonboard.com>
	 <b6af11b9-d697-59ec-6acc-80f0657a3e11@prevas.dk>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594997409535098266?=
X-GMAIL-MSGID: =?utf-8?q?1595121019287592853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-16 at 16:27 +0100, Rasmus Villemoes wrote:
> On 2018-03-15 11:00, Kieran Bingham wrote:
> > Simplify array iteration with a helper to iterate each entry in an array.
> > Utilise the existing ARRAY_SIZE macro to identify the length of the array
> > and pointer arithmetic to process each item as a for loop.

I recall getting negative feedback on a similar proposal
a decade ago:

https://lkml.org/lkml/2007/2/13/25

Not sure this is different.
