Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4046593-1527899338-2-1837455182629169456
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527899338; b=Uf2g6R5cejb6vWFXVqQoWF54uU6aH5t90moiwSA7TUCXATUxc0
    TKcKY73QVG+GF0xHmGGiHwoS4cY9AtVR8bTDJApFpNmPUmk/RtSD+jTl8ev/PREn
    MqErKsY0HcxcwEOv9qhrJBpY8sreL/3bSU9H7zNMkm/flxRafXWWKcALXUcMrdwE
    BkDJOdtXIQZKIP3YuwANrUzujJmSSqNLJnybhKOmNIFF9xGjrFd8ICnO2SfV2sA7
    +M11dKIH6FL9/xMO1Rb29pAuymx/r7BAiU+POog3vi0bp82as2UrW8yLMkU9A93f
    TAQ0OZxbBfZPJk9snznnXO6wn0YRiyvKVNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:cc:subject:in-reply-to
    :references:message-id:mime-version:content-type:sender:list-id;
    s=fm2; t=1527899338; bh=sV8njANxhUeDYas/H4MTf7uIEYnDlpEuqhtmB7U
    PbGM=; b=lMHPxFfyJ5rGmPaDUV98AFttxAUo94mQGEqNsXaX1Tn2apPsoYL+nAQ
    vq3WHelb9csxO1owpuUuC6nMmTpo2XCJPUufKM5dIDLCnejOipIwZMZfAPhwXiN+
    ORNGHdo9lmgexpyOTY6i0rzzheB3usTxp7fsNas6kn5iwKmMaWESxXE/dwKzP6yH
    YefMcm909ibXJ9VrYtB3knUsuRT0stzcMC/ziezwVmDiiyNDNoXFkB6W7Up3eyta
    zlSghaKonMkthOPwHH+WQ5znc3seBmRMynbfgCoJ0PaR01nErMam7+JjJaCe+TbT
    4zpvXlte4zKtgBEv/RcRrLQ4YMzX5Vw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLzFlRI0v1qHfipl4dJbv82/7njOK03KV2ZpwsllZY9T6M+EX2NxpvCpaOl3TnlijgowLJmNu2JrEKjWgT0GvCNk7irmC9Y+Xzja5Z2RNacgPh8wVUZ7
    0qsfMGfiTephEqTH4dL5qnPr7gz9A0yS6PSGUNYy9whcutKnB51Gdf+WseT8YaxWRRIA5l/c97qihOERRGS27gShtw0PNvRAzDrTFJsfJcQgjhFZ/Hu/OfC6
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=1oJP67jkp3AA:10 a=7mUfYlMuFuIA:10
    a=ZZnuYtJkoWoA:10 a=JNnVQ18BiwWbli6gJyEA:9 a=wyNy-UJlUM6FxSWO-CQA:9
    a=ONNS8QRKHyMA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751005AbeFBA2w (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 20:28:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:43648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750758AbeFBA2v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jun 2018 20:28:51 -0400
From: NeilBrown <neilb@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        James Simmons <jsimmons@infradead.org>
Date: Sat, 02 Jun 2018 10:28:38 +1000
Cc: linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        lustre-devel@lists.lustre.org
Subject: Re: [lustre-devel] [PATCH] staging: lustre: delete the filesystem from the tree.
In-Reply-To: <20180601091133.GA27521@kroah.com>
References: <20180601091133.GA27521@kroah.com>
Message-ID: <87bmcurpzd.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain

On Fri, Jun 01 2018, Greg Kroah-Hartman wrote:

>
> So, let's just delete the whole mess.  Now the lustre developers can go
> off and work in their out-of-tree codebase and not have to worry about
> providing valid changelog entries and breaking their patches up into
> logical pieces.

I find it incredible that anyone would think that not having to "worry
about providing valid changelogs" and not "breaking their patches up
into logic pieces" could ever be seen as a good idea.  I hope that if
lustre development is excluded from mainline for a time, that we can
still maintain the practices that demonstrably work so well.

For the record: I'm not in favor of ejecting this code from mainline.  I
think that the long term result may be that it never comes back, and
will like at least delay the process.
But you must do what you think is best.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsR5LcACgkQOeye3VZi
gbmPsxAAvr7MWTuOxOV9FtPuu+c6OuCKo35Mg5WG3X4OpEUSqSitN8cmEB/2kAWX
kPkXgWBeoczSOCLG+hJgUD87iDgGqAn6A/D3vDlHOmcKWAipu7DurZhPKEt6qC3S
GjtNSejb98G/tAgeVnPAyTFXdQBx6KPCMeg+MfbNzzxQKCXfmUxNuASx1EmXQH6z
zuDERm9jnF5jbTIox53D4in0i5GEUBbUOiD4K+MnDNhiyh02Kr8dCkUoKs1UJOJX
H7sfaYJZumJuP9fL8GSqBk+AB1SJH/Box4o1JyI/u4XKHNxVw+BuT2ptWUA6vyBb
Snja80L/LDH0Mm/AgWZYt+yR5NSc1onAU1LgfwnRj/UFVMFJvc2ZWBSBzvVGG7eB
Uj2uBqCFYJ6az8wVWzWjhZfHlcemyTCR+nHIm+AwFXxmK5m5+hRbsJC9+sK3IWIv
zl9gGrfLJK1FBAAGzMZ5hyyQkAlHFoSN2lo/HxknfT6SLrMsjWgR2KnyiajdXVEs
rKF2/F8T4QeMaSMbWtpu2qtcV49v3/qpIC6L1ysWFHcLRhduFguunQjQOJdnJHHL
WReoEYi9ianU5tXrfDzJNZZOW5z9DaWSgxJAQ/MDxw1dREDN468xsIXf9GrVvKMv
nA4w+ADktG3het9Z6Hv3dHSq+Ffvi7ynuRW43r/Tj/BoGGk1N80=
=zyLF
-----END PGP SIGNATURE-----
--=-=-=--
