Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1828776-1523303777-2-8329621908248955850
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523303777; b=ExZ3nYNANgptlFCQkaeMrSbuCh7iD4mKzSphtoltOUaITbqY4k
    bEAgmqoA2G2bvRyOUDzy3vmfwSkfk9xcB4gRFZNhasxzrG2DHdkpU0tN/0RNDcv3
    PTESKqfyHJGsty+/PtssQ84gfdVHIya41jPaAg4noCzjsOUjNFz7eL3Aprcgj9iC
    18vS+INIV5birBM+87gw6v1v/thcbKCoM12p2Y0Xw/ZM8i+QjcHo6E5NvWabaKIH
    kmdir4nf9iXnvOypu+fidX6jmOl9vZxUGUeXDW3PfVukW2iWNeQL2uiXEZqNrhNF
    fL0uSM91I8TdNKizfyplf1CkSMOY9eWC5z/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1523303777; bh=uonp6hwZaGUVzSe3Coh0Oi5cR1kTWUZG0/hhkyC0TU
    c=; b=hmGy3+0fztbp2Jt8FQ760JGo+8j4632En6pI2n9IckEbugYfeurPRz20JZ
    uK7jyyh3+aLxRFeJpk2Yo/AFHcfxELAm+N0jP4XdiHq/0bGcILyvIJATEgp+pugD
    RGYiyo+UK3wRDOwnf/Ye3x1qIwCYlkiakNvRwZQ/RzvlFt1QsHXxTHm6u83Su2S0
    QA3BxnzRus2zT9w89Zsg9TQ8EN9KaJRfQ7pAaKP3c66ii1edDTYMmiSKfbO7JzH7
    rlNzrAJib/iE7gmzmeadT9gxAHjPG+TR3IwX2m7x+cGsGw8R7flznSFIYB4oDHJb
    +XVJiEyzsdvQys7OcxSOV5Qo0ZYw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=anholt.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=anholt.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBGEUJMWy3DZdtlETiID/GbppS+83Wf9i7iiGn+BguR5zdzysmwm9ZUKRi0Uv8W7wEJA/yyexfAJ6hH1SuMtxVROdmeuqpxtDdWRDvtUsgc0WBeEJnu2
    PndOVJTpnbxjVNWTSiKjE9vdPDLgOdM0jszPAmbwnWMMjE8K6TnfM7EzyykHDdLZE7B4g9+q+yYnGgPMktnEmoe7GJvnJMtzEmTjVIFZZexah+mOzBPdwGhP
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=t9ty7G3lAAAA:8
    a=s_uo5L-vQgGiULz8UDQA:9 a=Tesf_VNEwa0A:10 a=CcjT3zwZE0iadevw2IUA:9
    a=ONNS8QRKHyMA:10 a=CsAS6f0m0zARWR-uHzm3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753530AbeDIT4P (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 15:56:15 -0400
Received: from anholt.net ([50.246.234.109]:53558 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbeDIT4P (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 9 Apr 2018 15:56:15 -0400
From: Eric Anholt <eric@anholt.net>
To: Daniel J Blueman <daniel@quora.org>, linux-kernel@vger.kernel.org
Cc: Daniel J Blueman <daniel@quora.org>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: Fix memory leak during BO teardown
In-Reply-To: <20180402071035.25356-1-daniel@quora.org>
References: <20180402071035.25356-1-daniel@quora.org>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Mon, 09 Apr 2018 12:56:12 -0700
Message-ID: <87in90w3vn.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain

Daniel J Blueman <daniel@quora.org> writes:

> During BO teardown, an indirect list 'uniform_addr_offsets' wasn't being
> freed leading to leaking many 128B allocations. Fix the memory leak by
> releasing it at teardown time.

Reviewed, added a Fixes tag, and pushed to drm-misc-fixes.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlrLxVwACgkQtdYpNtH8
nujpIQ/7BQVTpsscUF18PveYd+8y9mL2en6wNEqKO8oXta166lSKzJ/8bT+MImbI
5cl56hu4uM/u7hys2hABRVfNp/IhLbY815uFBG79uOJQtYEuK4+i9RRaSs8tHh4h
eLMZgJhJEMVy7gJ0+NmafGbndIVB6rxCQ6GZIqE7Z3PQwZtITNPkDG5KOkhDBS7X
gKMVI/jPK/HkTfi1f6FSowIk2TPcyQiysyO54sFkEcWqp/DUjDmmxRljQYZn3xUC
QUC8SGuOSoryH8/GCUScOS408IYAx6Qm9xkz92ets6OYQWDwTPmedgiONX2hi7Ue
taAG8AJ345drHwu2Y4qZcNInZcdR0aKcveRhsAP1nibOwhFHSxltt2T/SichqJWC
Oubr8esuqtx2sRINBnx4KR1fbyn7l4sPsk4SuinPVEmMf0r2M/G1JKj5tJjlC3uc
eZ4cRVIHX8ba9rIBfqMoJyOfdM6WUxQvHUEIN10M6ShqkH0vPd6Urb4fmr/wqYN0
0cSLM2zvb4CtmWwAblW9jubCPpmIfavOb8SjYURFWhKVnZPwI8eC7uI/eNUMRuQJ
EMw7wZQZs8LWtui5ZklgiSf0NXgmcBJA0vhHepF6KpFykVkDIEFt0TUO0TOe/jfl
t86n7EtPcPvWoxjvWnMR2rjEHHFIshXgWN8kUDlTj7eQIp/GlWQ=
=JkeT
-----END PGP SIGNATURE-----
--=-=-=--
