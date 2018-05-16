Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3824249-1526450201-2-6066617175473586416
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526450200; b=dkz54I+w2I8du3pVahvfysRL5TSXZm23XHpKIQZKdnC+jctl8d
    D9XOngSpt3dSC7XLlch7S5OUXm/Eg+OQ6YFRvshnun1GXfWgqH9iERQGcSmGLPjh
    6cWu4gr5S5AFmQWmU5r84ANO+if3yx2+sHZ0AelNEpYm2GO2SLOyHhV0KVcLZ/w/
    Jn/3pvY7epTlgaTh+A5wC0DPoMGs7nPOVew3sMv4JcNhjjc9m4lD0e3g393u2HUK
    zcEgkHOfDK5fhIS0na4Kuw0K0xmm1ezZyYXgUzOJkKAJOdFHa5YhyTUNrFcXfe2a
    e+DKFUw9lVnB2Sl3KhBXvyE5mtmBhjcWyCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1526450200; bh=DuismqSskHSlDRnmq3bk0j7sRiM17+XtCAJW/cYnfC
    c=; b=ee4+WPagxygJFFRxjbGEuPb7+S2B+5TUpiR2RVYoTgguNBlPm3n3eKbAiU
    m/4k0d33+qSM8xJpHxZmFkG6UxPKf0+uyT2/cwuys4Bl1o36tWZsFIo0Kff1ptZh
    iUjaSwsF7MCu2aZNN5RHAdkTl/NMDYxKaPSLlCFcutIamW5r3ydEBSZF648MGfaA
    Gwmg3hDrBo7yE/71e5WYZEccJZuaDRb/DQr6IW2CgXLJSRCOmgC6khfjblWsDry1
    9qNm5x7HIDdWfJkcv9EOTLAdmZ2L1O9tlaJZPem3WCW482YC/4yceoR/JX3jTcHH
    HJphGoI7NexgJqjKppy6QFgXWtwg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJt08Tvt1aRbpEGq2KHM4ha6snFOl6ztR8FUY2kC8CFvH9eTECLjIBh9qqJXk3IfXB3eyPF/rR5C4nGhWdbRLlIJ40eEb0FZ3JnkjooNuwNnaa5O/Z17
    Eqvv8ufBfwQp5pPd7t3C4tCEE+tCOUN+4cqS7hPiW1XS52pCBCvXbc78s8k2NfdIxgXdJGWMhe3BzcFVn/jrxP1CoEC6NG2CyhTSiAc7a58FxlHdN/oYcFx2
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JfrnYn6hAAAA:8
    a=yMhMjlubAAAA:8 a=QyXUC8HyAAAA:8 a=JTN0j1bd27kgadtOW3QA:9 a=AI0AbJPrkmIA:10
    a=CStR4VEYoQNEvbX76N8A:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeEPF4U (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 01:56:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:3485 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751608AbeEPF4T (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 16 May 2018 01:56:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="asc'?scan'208";a="42175460"
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        qla2xxx-upstream@qlogic.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Subject: Re: [PATCH 1/2] Convert target drivers to use sbitmap
In-Reply-To: <20180515160043.27044-2-willy@infradead.org>
References: <20180515160043.27044-1-willy@infradead.org> <20180515160043.27044-2-willy@infradead.org>
Date: Wed, 16 May 2018 08:54:31 +0300
Message-ID: <8736ys9mco.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Matthew Wilcox <willy@infradead.org> writes:
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> The sbitmap and the percpu_ida perform essentially the same task,
> allocating tags for commands.  Since the sbitmap is more used than
> the percpu_ida, convert the percpu_ida users to the sbitmap API.
>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---

[...]

>  drivers/usb/gadget/function/f_tcm.c      |  8 +++---

for drivers/usb/gadget/function/f_tcm.c

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlr7x5kACgkQzL64meEa
mQZTNw/7BeARv5AHTU76jM8Zj2RGQnhmwK+vPHpdEEIiwl+eENFkYn8HCpxz6Fy/
8+ZLFWGD2OSNpenF/oHeMyuLjbD1nbeYk95GU3zXJbeTQp7Cl5m5j05mcAqziWD6
I+EExa95spRapO1A03KDnDsOgCe9nVM+j2BT/nXvUiSmyT3Z80XcuextwlpFCh0t
Lzw+k9HT8LfdgFKIY4d8fXBakn/Ezuvcm1thYlLJNACjePusCvo8Fv4R3jVTsmFJ
OdsgkEIPhHUJnyg13fAWatJU77mzxhH1wu+3gAUv5UuhAu7QEvLTlOMYRc/Jp5JG
U+y/wxeoY1VgmFlZDHPcm/W8wGGlM5Lv2KqPuwBjxErHxJ0Mzf4/MFatLj3g+QOK
pzmlRNpl+36e5+kifuQhZk+YiqgOwQIs96HmZlwCZy0E1IfZYY8d1mFky0aocqbG
Mi096aKi4JIhXJ/cbi4bWlq26P/LQdYQYa83WfZQN0pHKVdaI1baUbtU3EFqt1PV
/asEEy8d0bt4HD3kutz3Kv2wqKbKP4i3aR8voXhI9Er09EXjxtL6mM2y3z4jhYDa
SocWSQ88Y+vNhWWtZXOTKK1/lonuPjIdR8Xb4BOaWnJgb/XXNaj7nioloxjxA8It
sDGjUAaySMhhC2Ga2WcrkXOJRmbVL5lyBi9nJWm7viDHOJIfZLI=
=DXbr
-----END PGP SIGNATURE-----
--=-=-=--
