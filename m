Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1279864-1521018039-2-14564101264957444554
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES ensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521018038; b=sPGLkSvMzdWUiyLmNTE4BoCMIeSAfOVwMDNqqveUpG13F8u
    fsbkboXPOAXYvw0Sya3TmYQBhD91g6TF4DJEkrQBSD7WtOZzOqD5h49//KbHY+gW
    uJnaHYSrQQRFmVMY/lB7Ohz46KF1mQ5F9UFYJMyc4M70vxMb7s2qEI3M9gslbyvO
    ngRRpxuY3NLdEIuuImkdOkmyD5i6vkgNCuiVw9VSYVL7O7gccpFC4VqiEbeX5cyf
    5/xX/AbidHraoOwN2f8Uv21rJjsV8uAWYDp+vWgQ1Vc8AqkCg27JiWIuHDKt5pOG
    PjMfjBxpbONbU7idKA38df4FRLjIUeKY7z4+zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1521018038; bh=ZH3ZU7i53Kd216VxuC2l6prq0QIwjuxWYJ+u4j
    jrnx8=; b=uaQEedUj7RTLE0Fx37a1nf+sCtIsWpOmgek7RM2duu8kI48mcRoUKR
    qcG6staCAAuWYZsxNvHhJhr1U0KpV4zs4jzN5/N8JBgXAEsVP6Esrl6HtPhBS1BY
    TzYsdd8RjG29rzwf3I0Qxf5/KeIQNje395hLV4qauHu5sZV+Rvh1UgitjWgR9+EB
    fWRPWdefSj1a9PPZks4veG98atkSbqDw3R7FPwHCc7R7jtnPcsxLWKExatCAsou8
    PtZknOmouMGW/qZmRWch+4aegwh3DuNz0wKwz71lcKLYdxdyygZqLaiMOu2TTke0
    R78TjIrg5Od8uetxpuCeEyQ7ly7xnPyQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=spam score=150 state=1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=spam score=150 state=1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbeCNJAd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 05:00:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:2306 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751366AbeCNJAc (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 14 Mar 2018 05:00:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,469,1515484800";
   d="asc'?scan'208";a="41884037"
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Colin King <colin.king@canonical.com>,
        John Youn <johnyoun@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][usb-next] usb: dwc2: ix spelling mistake: "genereted" -> "generated"
In-Reply-To: <20180313155024.1195-1-colin.king@canonical.com>
References: <20180313155024.1195-1-colin.king@canonical.com>
Date: Wed, 14 Mar 2018 11:00:15 +0200
Message-ID: <87muzbrq00.fsf@linux.intel.com>
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

Colin King <colin.king@canonical.com> writes:
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in dev_warn warning message text.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

seems like we need a patch to fix your subject ;-) I'll fix it when applying

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqo5J8ACgkQzL64meEa
mQaMGRAAgBXFw43h4TsG4zIyVGBDijgGcKPOybeklrTbbM8LT1mrOuIH7BVqAj0G
m5HXsd/nM0whm+wp1yBcHTPqqhBX/JaZfCESN2WJo2xumHZiy/xpdYCWcayQlOjK
SK8kGkBFY4nw2MGxPKkHjMsMaOoERKf44MpIpapnppoo9lb5mqVOteANUM75nBZj
lj/PeoXEg52xE9/ifjImHpIqf1t5KPU9yyNwkjXRuzpyAZhuYSrHaAZuQXiTyngk
VjqxKWhnPBvmWIS6cJW/ZYR1xrz4Z9Zk759JQJ/6jY9w1mhGpjqcHDuL4+MtfKMb
MEzJKHc8jUORnEzfgc9fWS7jJ+p1eZ3eil69W78C8diNOY7eI6eiHNr0oEp5kgTo
bjLxBHNqIhRSTm1Ihs8F/dmW0oik3ILej2LHddHM7tbju06TrZW2jralb23exIqP
vJ2hQMLtcVB1N6u+wBfjUfYOFo0iZp2frK4pbOk2xSXc/yseApBggfS1X6B+H8O+
9j5qtwwvKqBegSyKzPPwnDaf1p4pzN95QNyyBWr3uhjaivIGR4V343/XInDIQKJR
oZtcQtK3/XIGDBLF2puMbFPguyxmvvsI1bapmN77XQ029b8AouUsDZpCc/Vtjntf
VMVHsX+lJV2nllmDDOdghJJMtHRGSsPx2X54xy9Qm5+v1jhyjwk=
=+EXf
-----END PGP SIGNATURE-----
--=-=-=--
