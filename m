Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2158426-1528168513-2-14749179259686061175
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528168513; b=lkQKAE2QRjfkbhr2r075pOJ9JDqufC76SvJnk5J2jxe5yXL7k6
    np5LRmXniWX4zAApTai56oxIWkr7WHPUKdyhE2YcPpoyGA1GJnk+a4sTeMF7YsS3
    8JPjnYib1YnEqNUTQK+5UfJBqZIqlXyoS40l+7sKpGZVnXQ74hrFgHBEnyEED+zH
    NaKghHin8SFDeAehqXBNxXfcNYptZ9hzhu2cb92pSw/ITZLFVm761QBKPWwyCe+x
    yGCf9UIjjl7X65DkTu5zwprKIWVClxF5+gnBtjBtlBCAAtP28R1nHfV4ZbpcStK+
    x6VthQvuUCKM15e7RIq06D6HIYCIyKN83lLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1528168513;
    bh=DTDUIqKHsboNlNjcWQDrSj9W8cFFcSAU5HyxhLCmwg8=; b=JfmFqD+djZtM
    S1UA0B5Na3T3KJRl0pAvgylmUXoO53z8oGdFspKJmUS3ex69srprlXqA3XTr+od/
    7oQpn2LDPMlALhfU300WZ9fyCup3C2ZeHc+bNDSLiyrHdSKnBXH93YixbBtJohhm
    PDdwvq4Zi5INKZELkXb5xGA62hMimDXsvojbX5eSGaGveQFFWXJ3ugoVQ73CqB9G
    AKvNHr4HcvpOxMMvN/p6msKUI5V9PGfttz6z6pIs1G/6ME4kO7K+wYIUVVqW/nli
    C7OH5GIny3vNgEbXY+gqn5iZSPVcz4C/4GEE60MjwsX34cKMe+sTiq6NljjsbjQ7
    t0ouM306ZA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=YdVuvOuL
    header.a=rsa-sha256 header.s=201702 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canb.auug.org.au header.result=pass
    header_org.domain=auug.org.au header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=YdVuvOuL
      header.a=rsa-sha256 header.s=201702 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canb.auug.org.au header.result=pass
      header_org.domain=auug.org.au header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNgOdQndJCR0B4Xbu8VsTjXAJW0vnhAAvyRCVFDG3SNlUgMUKP48HoguWbGbuLdenwdLg0XUd3IzocXOLPe7lKYl6f5RnCS3oR9/tvbNRc1M5nZhuwpH
    GEp0e/HBiU+9NljmbGLcVNkLGe5o0tp7sYzxLA2zR5ky2bpCH/9XpyTaTW9O235v+9DfgicQktA27c0VWWoMkrxUev8HXkb3wmC0hfdT5eWH7LQxdrU5sFnf
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=TWZ1Bk7qwUWYab66QjgA:9
    a=CjuIK1q_8ugA:10 a=4L7WvwWqrkebh_8zcG4A:9 a=VwQbUJbxAAAA:8
    a=fT6DY2neKoG22zCxINUA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbeFEDPK (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 23:15:10 -0400
Received: from ozlabs.org ([203.11.71.1]:58477 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbeFEDPJ (ORCPT <rfc822;linux-next@vger.kernel.org>);
        Mon, 4 Jun 2018 23:15:09 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 5 Jun 2018 13:15:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee.jones@linaro.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: linux-next: build warning after merge of the mfd tree
Message-ID: <20180605131507.3f217038@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1RNtq60.cfggJ2B5lzgeNCQ"; protocol="application/pgp-signature"
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/1RNtq60.cfggJ2B5lzgeNCQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lee,

After merging the mfd tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

drivers/mfd/cros_ec_dev.c:265:13: warning: '__remove' defined but not used =
[-Wunused-function]
 static void __remove(struct device *dev) { }
             ^~~~~~~~

Introduced by commit

  3aa2177e4787 ("mfd: cros_ec: Use devm_kzalloc for private data")

--=20
Cheers,
Stephen Rothwell

--Sig_/1RNtq60.cfggJ2B5lzgeNCQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsWADsACgkQAVBC80lX
0Gy1cAgAoM4S48TPh77ODjF8H8yGrNb+Ev4h/LiQ0OeBTruXb5E/6Ian644hY42Q
MfmvRMoJvPPvoKTxzjkNY62vVYnxjl5A3G0QbfFUVwo5/NfnpJ+EksObHQQK/VZr
p8qQgWg0t3tR6J9r9U1/zYtcx4fFzTyPxOzq6HHsLbY6vbaY9PfTw/UVyNBnQieQ
U/ZbLZrXgijPgF5qh1cHWud31P1TpztYUS1jddAO7p9wtZuy8rX/VKCoewpBiqe0
6EQ+rhMiUYZ4Dk97Wvvd8oc1iYUp8jp/WYb8NRcs6RrTQNx38Rue3Sc7LJO1SxuP
9vcObUnD7Qd+msTXDYdB2YJEIMn/Eg==
=GD2C
-----END PGP SIGNATURE-----

--Sig_/1RNtq60.cfggJ2B5lzgeNCQ--
