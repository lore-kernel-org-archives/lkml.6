Return-Path: <kernel-hardening-return-13227-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZqEKvF3NT8pjqSqTLLhxPzNo2gNiAm5pdMKxTfmU1iy9EhgsQEA3+hEYUaYnUYgpFyUX6HV
ARC-Seal: i=1; a=rsa-sha256; t=1525546609; cv=none;
        d=google.com; s=arc-20160816;
        b=E1fT+0K57QgSc2XezmfsaywHnenBakFRs3u1Xqh1b5iGsxnIR1Y2N4Js9cfaUOI1Bt
         VejnIx3SjPTQx3ULxwEkvIwz1idZT3i5GVamjWKjsffkN+pzO4eJ2abk3ohFrUPYQlAp
         5rpVyBVFvM0ogUsFbGEPIj5yJVVdEBduNaPQdLVlyu6h76HCT3B8OT8kot8iT6JxIiiu
         N08a4w/Uop9WOK4EnDkeduRGWvqoBZWmPI083ZlhhLKq5PCpisWezWurUlL6IOatskEw
         Sl5PlzUorYlLy5MN+KrW2RkgZsd7fdN6glvfjRuSMY1Ub5uVqyhaxuY7uoVEeWUxY4hU
         rOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=zpYAbkUTJtu7+XeUEET3HUK6lXygW++l9OTPHyCECiE=;
        b=w4xfw01LZD/4+x+ogdEGjGiEwVbXdgVqjU8oT80HESWYk+rZBTu8sGkLGY4zBxXi9b
         izvNI/caDVVUZeYrLluMI96UBIgHk8Jr+pWhtoe0qWivxkiEQhZy+0o3YW2CctSO4/tN
         40fw9vuZqKE1g/L7vjU+7yy08tFxkQC0HjCuzbc7Sw6KWzRNoENnEfxdG4etTZUt1weo
         lsxAiHldCO3RP7n+d5sAtTeiX87VYxSfGYGFLLRTRmEzPdei5XNVvrrpRD3QbePaF671
         iHZgIFZ+YQO+jR6USnpVwunXzbIPzfw73Y12X93Q2oKp1fmKXOyh/rB+Ahycr+OR6NYb
         km8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=p39dK68n;
       spf=pass (google.com: domain of kernel-hardening-return-13227-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13227-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=p39dK68n;
       spf=pass (google.com: domain of kernel-hardening-return-13227-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13227-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sat, 5 May 2018 20:51:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kees Cook <keescook@chromium.org>
Cc: Salvatore Mesoraca <s.mesoraca16@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Network Development <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] net: dsa: drop some VLAs in switch.c
Message-ID: <20180505185145.GB32630@lunn.ch>
References: <1520970647-19587-1-git-send-email-s.mesoraca16@gmail.com>
 <87fu5321du.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
 <b948ef55-8b16-fee4-b22f-4c6d09fea0cf@gmail.com>
 <CAJHCu1+V+khxvzhQdG=mo960b5ayiQcSaoMnm9A__51JdWkdig@mail.gmail.com>
 <20180505153905.GA30439@lunn.ch>
 <CAGXu5j+x3LU6ADYtvDiXHjw=wws=jjRzmMk9RC4BwWQYWd47bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+x3LU6ADYtvDiXHjw=wws=jjRzmMk9RC4BwWQYWd47bA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853343808183482?=
X-GMAIL-MSGID: =?utf-8?q?1599651562203073311?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> > You could make the bitmap part of the dsa_switch structure. This is
> > allocated by dsa_switch_alloc() and is passed the number of ports.
> > Doing the allocation there means you don't need to worry about it
> > failing in dsa_switch_mdb_add() or dsa_switch_vlan_add().
> 
> Are dsa_switch_mdb_add() and dsa_switch_vlan_add() guaranteed to be
> single-threaded?

Yes, that is the interesting question here.... against each other, or
themselves?

They are called from a notifier chain. It is the same notifier chain
for both dsa_switch_mdb_add() and dsa_switch_vlan_add().

notifier_call_chain() itself appears to not provide any guarantees
about the same handler being called in parallel.

It is dsa_port_notify() which is calling the notifier_call_chain().
This is being called by both dsa_port_vlan_add() and
dsa_port_mdb_add() in dsa_slave_port_obj_add(). This is a switchdev
op. switchdev_port_obj_add_now() does have ASSERT_RTNL(); So that
should serialize everything.

     Andrew
