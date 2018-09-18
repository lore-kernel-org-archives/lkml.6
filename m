Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF10ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080782086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080782086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbeIRVDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:03:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbeIRVDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:03:07 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26393C05D3F2;
        Tue, 18 Sep 2018 15:30:02 +0000 (UTC)
Received: from [10.36.116.28] (ovpn-116-28.ams2.redhat.com [10.36.116.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A888930912F4;
        Tue, 18 Sep 2018 15:29:56 +0000 (UTC)
Subject: Re: [RFC PATCH 04/10 v2 ] x86/fpu: eager switch PKRU state
To:     Rik van Riel <riel@surriel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20180912133353.20595-1-bigeasy@linutronix.de>
 <20180912133353.20595-5-bigeasy@linutronix.de>
 <8e5b64e4-b3e6-f884-beb6-b7b69ab2d8c1@redhat.com>
 <20180914203501.qibhpmueosvkr74w@linutronix.de>
 <a239e97a-d1a1-388e-5db9-10758c33d702@redhat.com>
 <20180918142701.atfb4ul45k7tl6ew@linutronix.de>
 <7e9a13f3-93f5-fe4a-20d2-f4f9407bd43b@redhat.com>
 <83e271e1298d603c1105dd0dbea32d67da9cf1fa.camel@surriel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <36e8493f-f994-e885-8fe6-2f0d4a9904a1@redhat.com>
Date:   Tue, 18 Sep 2018 17:29:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <83e271e1298d603c1105dd0dbea32d67da9cf1fa.camel@surriel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DQkdvl0tRkWIxugD6yZydc7q9ErHy0aBY"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 18 Sep 2018 15:30:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DQkdvl0tRkWIxugD6yZydc7q9ErHy0aBY
Content-Type: multipart/mixed; boundary="rSMNd3MX0PDfFWK28anIc1NOKRtBeAhHa";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: Rik van Riel <riel@surriel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Andy Lutomirski <luto@kernel.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>, kvm@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Message-ID: <36e8493f-f994-e885-8fe6-2f0d4a9904a1@redhat.com>
Subject: Re: [RFC PATCH 04/10 v2 ] x86/fpu: eager switch PKRU state
References: <20180912133353.20595-1-bigeasy@linutronix.de>
 <20180912133353.20595-5-bigeasy@linutronix.de>
 <8e5b64e4-b3e6-f884-beb6-b7b69ab2d8c1@redhat.com>
 <20180914203501.qibhpmueosvkr74w@linutronix.de>
 <a239e97a-d1a1-388e-5db9-10758c33d702@redhat.com>
 <20180918142701.atfb4ul45k7tl6ew@linutronix.de>
 <7e9a13f3-93f5-fe4a-20d2-f4f9407bd43b@redhat.com>
 <83e271e1298d603c1105dd0dbea32d67da9cf1fa.camel@surriel.com>
In-Reply-To: <83e271e1298d603c1105dd0dbea32d67da9cf1fa.camel@surriel.com>

--rSMNd3MX0PDfFWK28anIc1NOKRtBeAhHa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18/09/2018 17:11, Rik van Riel wrote:
> On Tue, 2018-09-18 at 17:07 +0200, Paolo Bonzini wrote:
>> On 18/09/2018 16:27, Sebastian Andrzej Siewior wrote:
>>>> Likewise, move this to fpu__clear and outside "if
>>>> (static_cpu_has(X86_FEATURE_FPU))"?
>>>
>>> okay. But if there is no FPU we did not save/restore the pkru
>>> value. Is
>>> this supposed to be an improvement?
>>
>> Honestly it just seemed "more correct", but now that I think about
>> it,
>> kernel threads should run with PKRU=3D0.  maybe there's a preexisting
>> bug
>> that your patch has the occasion to fix.
>=20
> I don't think it matters what the PKRU state is
> for kernel threads, since kernel PTEs should not
> be using protection keys anyway.

What about copy_from/to_user?

Paolo


--rSMNd3MX0PDfFWK28anIc1NOKRtBeAhHa--

--DQkdvl0tRkWIxugD6yZydc7q9ErHy0aBY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAluhGfAACgkQv/vSX3jH
roP3Vwf+MM30Lf/iyLCShv43CB8m1n47LowSdpcU4+Q3M4m8gWjKW1LLWmAwQ6dB
LchUeUqFzo+zf2xX+sp62ZbhXBQa4Y+1LVgodKbaS8MmjvbS3Ex1oleRbh1T1SFC
oEdrbCT5ZTKV25WKQWTEDzyIfYF5EOewJXhnmKGnOLbb9gomZqig7leIBdj47Gaa
0NTkDK2x6EaxdD69KafBll2YVdmH7WgNp0BB3yUKWkgX0X074QGfqBR51l6WIdBg
oaNdc2Z7apZ3AO3NIgUtySjo8yCUptc/6yBrRJyLYThO17wra7WXe/mRJu0s+2Xq
bSwNbR8N3DLyNVMs9ium9px8c9JAuQ==
=5sux
-----END PGP SIGNATURE-----

--DQkdvl0tRkWIxugD6yZydc7q9ErHy0aBY--
