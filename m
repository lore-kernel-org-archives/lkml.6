Return-Path: <kernel-hardening-return-12916-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49EouKYfmt22tUMUsn8u/naHheH3hZuA/5j8i5eo69KLN75oSTgAEdtSNrCL3wLPnGoDTff
ARC-Seal: i=1; a=rsa-sha256; t=1523279659; cv=none;
        d=google.com; s=arc-20160816;
        b=IoqjU70+6qWkyowKkHc9PQm0olHk1YJdQFAe/pMKp3WoUyM5UDuY8McmYh+gJe99AI
         Snks81j2guLJ0qMX5f5OGRessN/aD9LsJQAdYzaHNxlnTKp7RJ3vRMuWqo7wVGNPZzHa
         8XlsbBbO9E/TKgFFMmqX/xgdAbjD2orTXFKIbR38gPLO87tyJ3+ZkIS+cCWvFahQZcgj
         D3ffOmAgXltt0st9MqSRG4g0Sys/uLdLjVj5CB8YDqLVzeM7vw2WFWCwfECup0rPswa8
         lGPd4TNgRMzzNiUOsYy6f77n8kV3gZ8fMTqHYlLxVdgeBT+pWJ7H2QDLmQFgolxlw/4K
         /hfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=2AUdWCIXsaanpDpWSP0+0Fy0EGXFfrEKCgM0GvXwSDo=;
        b=sTQ1Tw0fDRPJXIiJOJn5LNMGugd1SZaYyg+06KUezMxcUmn1Dq1t7J4WXqwc3duHLX
         47Mij7oAcP2Tyeh4Kf9h41b5TJJTKqJ+ZIr70wOozzmzKpALWFQBsMeVBcu4uYCpdlPj
         ZU1ow6Gyru5DDipwo8/CoRlHO5ih/27lTkNMYyvYc/v75f4BNTPMIV8BbgOZyWiZmA6D
         BYeq4VaPYDwlFYbO9j4tQdj8GfgO5tE/HHN6DfuwjfaI6seBLljEoZT6vemvhy8zR6XD
         oMCfjU+c2+RW+UJqHpmfDKS8if3K9aF7MdUDiMqVPK9tcqQBxm5LW3DZnn97p8UTLeNi
         pL+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12916-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12916-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12916-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12916-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: David Laight <David.Laight@ACULAB.COM>
To: "'kpark3469@gmail.com'" <kpark3469@gmail.com>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>, "will.deacon@arm.com"
	<will.deacon@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "panand@redhat.com"
	<panand@redhat.com>, "keun-o.park@darkmatter.ae" <keun-o.park@darkmatter.ae>,
	"psodagud@codeaurora.org" <psodagud@codeaurora.org>, "jpoimboe@redhat.com"
	<jpoimboe@redhat.com>, "mingo@kernel.org" <mingo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] x86: usercopy: reimplement
 arch_within_stack_frames with unwinder
Thread-Topic: [PATCH v3 3/3] x86: usercopy: reimplement
 arch_within_stack_frames with unwinder
Thread-Index: AQHTz/sSAuKS/MpI00yCw1px+eBQn6P4ZtyQ
Date: Mon, 9 Apr 2018 13:14:58 +0000
Message-ID: <a59b818d84b74c13a4f25f757eba1f93@AcuMS.aculab.com>
References: <1523275156-29087-1-git-send-email-kpark3469@gmail.com>
 <1523275156-29087-2-git-send-email-kpark3469@gmail.com>
 <1523275156-29087-3-git-send-email-kpark3469@gmail.com>
 <1523275156-29087-4-git-send-email-kpark3469@gmail.com>
In-Reply-To: <1523275156-29087-4-git-send-email-kpark3469@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593731067679840173?=
X-GMAIL-MSGID: =?utf-8?q?1597274492326962702?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: kpark3469@gmail.com
> Sent: 09 April 2018 12:59
>
> The old arch_within_stack_frames which used the frame pointer is
> now reimplemented to use frame pointer unwinder apis. So the main
> functionality is same as before.

How much slower does this make the code?
Following stack frames using %bp is reasonably quick.
I can't imagine some of the other unwinder APIs being any where
near that fast.
While fine for fault tracebacks, using them during usercopy
is likely to have measurable performance impact.

	David
