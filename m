Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1831005-1519102621-2-10942221245294836599
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519102620; b=Vh0ZriZDlL+fdYfSM1z5k5R1pCcWVxF9JN6XX6Q3OKU2Cqg
    RlihJE4LWyuK7vHLQgSZlDBR8fo5i+77kDIhwVT2GgENL08RHX0/HERWWZXEurvd
    oFAu5tS+kX/jFr2/J6U6jr9B+ba5KF2DxtAPBiNNnxLQH5TCdZvah/sceXbsflSt
    uqqIvgUJ1PddiT6u9WqdP8HClbCS/APYmZbsuqglJnBp/mF/0fiFtjPwqPdHqCXA
    pwBp1qkyyvaEefslGNsXY5ecPpLz8UVo/EnVO20CJ3AlluURj3JEb+4WU0PpIoo7
    RJidomLN9XFbUOF17Y8+M0Bs2PI98zLzcRhVYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    arctest; t=1519102620; bh=8KHr/CQ/eLVMYUtuuHXgu0BPRKB05QRDk3R13C
    0HaFk=; b=JQWA+8SJdD4DqiZaU4XfloPkeCmTyR1+s7MU+APTe4iqPnoeAjxxmZ
    q9l4qlsaF1tFFA04JlI43Q4oRtkHCWpU6j2593HK45NAMbP2V9q1NZAF3pwiG9Ke
    ULZOfhcOipQs/CKwgsox8psV9t/fRhp+m6UR9gnte8WutiMpfxA20+ROGGBaWHc8
    kyDZ2FmRCtYhghe6ySxpmX7fmEto3LgMvdAP3/XGfUfohb7mquyjhfNDrsu6muRA
    EDgQW0Xecg5Xd/MzVIeSV95/krnjT1SV2ABa3rWGKrcfWJVhIR2FdBM8+srh5jO/
    +doACLextXKywOdJzZvtQELkDw+D8klw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=hPnviPu+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=hPnviPu+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750985AbeBTE46 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 23:56:58 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56425 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750858AbeBTE45 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Feb 2018 23:56:57 -0500
X-ME-Sender: <xms:l6qLWvEFqdWABOIW1P1nHxWBE1fibUVjf1IbowSpGFkHtL89cRi5cA>
Subject: Re: [PATCH 1/2] xen: xenbus_dev_frontend: Fix XS_TRANSACTION_END
 handling
To: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
Cc: stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20180207222236.7434-1-simon@invisiblethingslab.com>
 <ea0630bd-5139-5f79-847c-f88f733b5053@suse.com>
 <1fbf69f9-f835-897e-144f-8c6f8b94cd26@suse.com>
From: Simon Gaiser <simon@invisiblethingslab.com>
Message-ID: <1d10edc6-8ad6-bc58-432c-d1867f0ab57a@invisiblethingslab.com>
Date: Tue, 20 Feb 2018 04:56:00 +0000
MIME-Version: 1.0
In-Reply-To: <1fbf69f9-f835-897e-144f-8c6f8b94cd26@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="BCNRGoU7u99MhOmENERYQD81uMIzqsj9q"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BCNRGoU7u99MhOmENERYQD81uMIzqsj9q
Content-Type: multipart/mixed; boundary="UrcEycLHHCAXawABUXRgY4RJQDH6yYJTM";
 protected-headers="v1"
From: Simon Gaiser <simon@invisiblethingslab.com>
To: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
Cc: stable@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linux-kernel@vger.kernel.org
Message-ID: <1d10edc6-8ad6-bc58-432c-d1867f0ab57a@invisiblethingslab.com>
Subject: Re: [PATCH 1/2] xen: xenbus_dev_frontend: Fix XS_TRANSACTION_END
 handling
References: <20180207222236.7434-1-simon@invisiblethingslab.com>
 <ea0630bd-5139-5f79-847c-f88f733b5053@suse.com>
 <1fbf69f9-f835-897e-144f-8c6f8b94cd26@suse.com>
In-Reply-To: <1fbf69f9-f835-897e-144f-8c6f8b94cd26@suse.com>

--UrcEycLHHCAXawABUXRgY4RJQDH6yYJTM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Juergen Gross:
> On 07/02/18 23:22, Simon Gaiser wrote:
>> Commit fd8aa9095a95 ("xen: optimize xenbus driver for multiple
>> concurrent xenstore accesses") made a subtle change to the semantic of=

>> xenbus_dev_request_and_reply() and xenbus_transaction_end().
>>
>> Before on an error response to XS_TRANSACTION_END
>> xenbus_dev_request_and_reply() would not decrement the active
>> transaction counter. But xenbus_transaction_end() has always counted t=
he
>> transaction as finished regardless of the response.
>=20
> Which is correct now. Xenstore will free all transaction related
> data regardless of the response. A once failed transaction can't
> be repaired, it has to be repeated completely.

So if xenstore frees the transaction why should we keep it in the list
with pending transaction in xenbus_dev_frontend? That's exactly what
this patch fixes by always removing it from the list, not only on a
successful response (See below for the EINVAL case).

[...]
>> But xenbus_dev_frontend tries to end a transaction on closing of the
>> device if the XS_TRANSACTION_END failed before. Trying to close the
>> transaction twice corrupts the reference count. So fix this by also
>> considering a transaction closed if we have sent XS_TRANSACTION_END on=
ce
>> regardless of the return code.
>=20
> A transaction in the list of transactions should not considered to be
> finished. Either it is not on the list or it is still pending.

With "considering a transaction closed" I mean "take the code path which
removes the transaction from the list with pending transactions".

=46rom the follow-up mail:
>>> The new behavior is that xenbus_dev_request_and_reply() and
>>> xenbus_transaction_end() will always count the transaction as finishe=
d
>>> regardless the response code (handled in xs_request_exit()).
>>
>> ENOENT should not decrement the transaction counter, while all
>> other responses to XS_TRANSACTION_END should still do so.
>=20
> Sorry, I stand corrected: the ENOENT case should never happen, as this
> case is tested in xenbus_write_transaction(). It doesn't hurt to test
> for ENOENT, though.
>=20
> What should be handled is EINVAL: this would happen if a user specified=

> a string different from "T" and "F".

Ok, I will handle those cases in xs_request_exit(). Although I don't
like that this depends on the internals of xenstore (At least to me it's
not obvious why it should only return ENOENT or EINVAL in this case).

In the xenbus_write_transaction() case checking the string before
sending the transaction (like the transaction itself is verified) would
avoid this problem.


--UrcEycLHHCAXawABUXRgY4RJQDH6yYJTM--

--BCNRGoU7u99MhOmENERYQD81uMIzqsj9q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE3E8ezGzG3N1CTQ//kO9xfO/xly8FAlqLqp8ACgkQkO9xfO/x
ly+XExAApdIgnsM6xkHjK8kBhDK57fz+xLyU6htNsOgamX4c94ZroOG3GhHXVGq0
zdyy/p/UCMwV/ySUfENZtbzzIj7uY+XJkgDBb5l/h39baok5AXGvBxch7AiFDTVp
MtgcgPYuBZwgtuIJiwF7HdrHyCQ+DurHQ9MRIxBeDesoJRNYfYHeady7QrPtBk4I
fZZ0n7SfTepI73h8mpnht8NWkwt8KgGFT6iJxItr7oqjbEC09lFRwvOddtX2zs5e
BGaDlgUAarrf8lFhy03BBJisGA8iWnlrxLRoLY1mS4WrBZDwyuLLSt1oswLE5J/w
yVYb3mnyABoEjZMw6nHnVBQmtPKzkyt9i/CSZFc31cqE+sPIvBBtoFZaS08m06Op
MHueVEaf1Gaa8LWZpen7vUhDd7bbxS/MioHu7Z354L1H7fRBEzLY59zMyvQPlpvw
5F6WPrFngrb1Q1qzH3FXt81MI8bnzGZj85SJXm5EOqxszMizHvpoF38aEI4p+Dv9
mRWKlNJC+GK93LAI8Bb6MclDb+F0cxlSWO32d4GDokJGJ45ZjRxJrZ5B9yWWalBp
3xsszLTBLx8+CH+IK09n2fCSqmUU4G17zSJqNiNciswpbpEmSNt4xyh44l/zHs9X
nWakkPtyXGuCbsY5ey0DpEk/gp/p8U+mwHrivWjuDI81mkwKBdo=
=3Gxv
-----END PGP SIGNATURE-----

--BCNRGoU7u99MhOmENERYQD81uMIzqsj9q--
