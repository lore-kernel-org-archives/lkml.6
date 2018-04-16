Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4109416-1523910163-2-9799349980715460481
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523910163; b=gkhWos4cRdEU0lW7wXHZbM4rsqbSMMAiLNMBmgFbmORmwlC3Ce
    Ggogzxn39vc3VLD6aK3TnehbbnLQW9ARxTijY+BugSlb23MxknnyVRdwY7steWRj
    DIAMTYPJdrzXJqbTn4/GJF7gpbMzbSg5BPQvVi/3WO0F4oB+cvWJdTKO2rxYIa8l
    oolnIbrF+eO30R4gR97Ib17NlgMdtRYJ4DT8y+sOBnJE5wmMeGtDPfr+RZg8hemQ
    TVpBd9kKTn134lkjm8u5V/lbCdzI4Eubf8ncR/QZTp+34hbsd1LkvDyWS7cSmM+u
    nz2PFvR9ggkzJXT0/Al/MftqT7tHSrGkm4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523910163; bh=4R3MO1GFWO8ODFts6d8VwSlwgPmHyg
    ADKcdSfq2GdlA=; b=XLBXarbgI+ImP+NpJx3njTVHeOU+GqlAnnpe+9Lc7P7PVz
    ZhMtsd8Zhnuy65xgjT2haJN6g/+P9rqYKLYKxY760UwtbKWXLuj+0/b2GKmDoHdR
    MrIMdQvSyriohQkmqescYpjBBnva5rmu5rAHPYYBhlGwchbj3UBxBOV8a3lpvR/2
    8hUccH6UXg3UrLcnnHc8O/SvZV8NoB0hIZQodlzsM1NnpPXyKYF28/m1WA++KtL2
    bXSIH8Qc3LNciSptfiSYBnK2P2j+hdK70aCWM1nkJRZIAODJAAHooO2ex0AxnaB5
    ZatA4Spceq+u/EaHpoi69OcZIgfXXms61C4bVIfw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJPkEZf6vlrzE1f8Q8cfrOLXSNhzlxbAKmoKX9nAykfcWk5MoI1nr4ZmWLZ58vrFoRFLxOsbb1e0HYU8Jr9QE+vVC8OUgwT9vZLX46KPxXJ7xIphNTfI
    m//YwdBKsV2L7Yf8ojB874JYfmCW76lujeL7siUnZQK5rPq4KX2MPxENdHeR4iPK/DXikho6H6B7DzkhEAMPKR4IojbKrkT28ktz9dLQ22NGVfbpRnYE+KUq
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=rx-IT5NbzXXkOTQU-6IA:9
    a=QEXdDO2ut3YA:10 a=x97gqs7I8A5_YvsSKOkA:9 a=ONNS8QRKHyMA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeDPUWk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 16:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbeDPUWk (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 16:22:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732D221789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Mon, 16 Apr 2018 21:22:34 +0100
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: memset.S: EVA & fault support for small_memset
Message-ID: <20180416202234.GA23881@saruman>
References: <1522315704-31641-1-git-send-email-matt.redfearn@mips.com>
 <1522315704-31641-2-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <1522315704-31641-2-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2018 at 10:28:23AM +0100, Matt Redfearn wrote:
> @@ -260,6 +260,11 @@
>  	jr		ra
>  	andi		v1, a2, STORMASK

This patch looks good, well spotted!

But whats that v1 write about? Any ideas? Seems to go back to the git
epoch, and $3 isn't in the clobber lists when __bzero* is called.

Cheers
James

> =20
> +.Lsmall_fixup\@:
> +	PTR_SUBU	a2, t1, a0
> +	jr		ra
> +	 PTR_ADDIU	a2, 1
> +

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrVBgMACgkQbAtpk944
dnqvdBAAwBaYV+JZiOrwbkIvv8vAlcGA+5W0c4ZPrnV7TLRJScb8LJxo7DGdEQ1v
fci8MHYpi+atntziEbiHbhDAhI4qCApDt+AnWyTPq2KVOo8TTU7rltS+8eBeQFAs
Wqhcke0/uCntBj9vJDjfKmts4i16rG+9egNaxbIvo3iSsS8AnSkhMjMajm5Mvr/Z
eS6YAMGPLbTVgTSGCRxgs707/23a+uiqq3hGfHan1ktO+124DPGwPSQw7JeW13Nt
t9PCQI0FEQGAHKGhkCzIFWxPdq6KK1UdytmQApzZ3RZ7w21u9iaWPuxMTXzPADcb
9GObjHhJ+vedOQsbiw6+For/0pXf/L8iM5YazIKp0xWv7VY8eQ/A1C2e9319Qmi0
GERR09nWkTY31oG7eg3MyxLKUrxvvUUpNHJVzHtg9TN+b50ratBWEbxgxW3Njwsa
QYBj9EChn5g9zjBE0tkPS4wShh0yVBi9WxlAyQY4Emf/pjy6yZaayKrTSRpsaqk+
oCRbIIfr6/b+vA6Xg2YVytz+PfeJuBZCHUDpqMIgZ3W0RNvwnO6NJmoyX5iZKQat
gbPrXvOXT4cz0L4q4FIPoC0HtAlhy9Dz9NjB3StZ27EChYwulnP7fNBhPOgYlBhG
kd2mgzaBl92kJFtqG0MdbSJBwv/xWFxLXd/6Jl8u6KtX22Mt71I=
=wPSw
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
