Return-Path: <robh+dt@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825685-1518709274-2-14173012705142965312
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: robh+dt@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518709273; b=OjsIP9CKKmPRjFaP7H0kfCYwwvZyNd4tAgp9NBttq6sTZ/2
    ZPfpXc1+9OIiyEwUlCMf8h6NVihrDY8p73MR4BtXGujSdJXH9jNZA0fFtXUfjare
    nccrr7AkDLcEAJ0Nsr4daSjO7MHkV+xkVUD2QWrVR5DYG1YkssvHFRY5dTss4qEz
    ZfE64BIeuFPUu86L6HjAwgSTBmzjYX8kNVUIU1qAQ8332qUU4Ccs+M22NsVuI1ym
    O70+sQ3fPddPCJbo4xsIbBXS73/lH4PNsZoDolErNj10FITDAjkN7gQYjPq5s0C4
    ndpZqS40MDowftoirII9vtIHWcq7DOaSLql4FWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=arctest; t=
    1518709273; bh=SXHF2gbNY5BNNjL0TOOIoEE0jr22fAiAHEjbOTNeisc=; b=U
    3v0bZnPP3Jt2V9q89UXDmI2iRVSo9N7UMclGIhvOjlz9Oo6w4BD6/OGGUZ+pAHwr
    NPgxhRvEjz1e6N+rH/nZP7Ewd06L4CXMuNGial7KfTBQZ1JC/zIYmGaKmCWg1Kb4
    ck96toQVLSMTqPQvxuL28n898yI9TQHJTjNgIw5KVdgrLdu9Qe0w/K1hcaeX/3CN
    AZ+8gbVN66ntVvk542TjaZHC/L2hDjyP0KArljkQKrFMYCqxzgukf95WH9x9JG3Z
    eCRqrllV1zRt/UOZ/jPPD7fg2UiedYFeBG5R12gqUEHoozriwXEmDPMOTs3GohyY
    qRmgTIx7gGtL49Dn1ojzA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=robh+dt@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=pass;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=robh+dt@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=pass;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F0A2183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AH8x227SkHWLbdzFpeCEhvxZuAoO2r6Q5eiZ/3J7KOfPZfDV1cUwq0aQ1JfKfYzvq4+n9saqT+MDyPl95vF882eeKr0=
MIME-Version: 1.0
In-Reply-To: <968497070242f849dd70ab1fa81635451f8fda7f.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com> <968497070242f849dd70ab1fa81635451f8fda7f.1518505384.git.greentime@andestech.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 15 Feb 2018 09:40:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJteT1P2GJGdesTsz=PuXU1qxiyhtKLURkGwV9sSQ7XZQ@mail.gmail.com>
Message-ID: <CAL_JsqJteT1P2GJGdesTsz=PuXU1qxiyhtKLURkGwV9sSQ7XZQ@mail.gmail.com>
Subject: Re: [PATCH v7 04/37] earlycon: add reg-offset to physical address
 before mapping
To: Greentime Hu <green.hu@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greentime@andestech.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>, netdev <netdev@vger.kernel.org>, deanbo422@gmail.com,
	devicetree@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org,
	Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, ren_guo@c-sky.com,
	Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
	Peter Hurley <peter@hurleysoftware.com>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 3:09 AM, Greentime Hu <green.hu@gmail.com> wrote:
> It will get the wrong virtual address because port->mapbase is not added
> the correct reg-offset yet. We have to update it before earlycon_map()
> is called
>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Cc: stable@vger.kernel.org
> Fixes: 088da2a17619 ("of: earlycon: Initialize port fields from DT
> properties")

This should get applied now rather than sit in numerous revisions of
this series for nds32.

Acked-by: Rob Herring <robh@kernel.org>

Greg, can you apply?

Rob
