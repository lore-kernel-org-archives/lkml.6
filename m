Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4036657-1527895206-5-15796372750569346505
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527895206; b=OxxajTnqvmAv52TrunzNTltkxOEDd44UsJZS5j3QzTvwqZoeW8
    dHH8EBB3sJpIVRHvTZjArcqKyEu5kjmt7sh7EspyGsQ6kUbUUsQ8YQpJezToZg4j
    X3FZPRzT7tHXkBD3i0PYmKdtQB+nuM9dhZZ+A91kpWmEBbcUKTsokFAa/u/sw+Wr
    e0ZeTcAv9qidhAL4P8hEQiG3SPlnFlUXVvL5WZ1dA2v8Sc1tomVOJ2OA2WV5HRL2
    6hLLECLQ0R/ugHEnb7ySPeHePttwD2CK3HZaqajM34MP1sp36sXoWNzhTqgyLDcA
    s1Lp/2qNkS6gkLplXYDMYsgPs7QGRSkOZWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:cc:subject:in-reply-to
    :references:message-id:mime-version:content-type:sender:list-id;
    s=fm2; t=1527895206; bh=viyqcXhZ13uYAb9dJR3odtJsZygUiCoJ2/wmVIX
    waEs=; b=RLzDKovB3W4P1SJRoaQXu09AiuSx5aFMBfo/kFXLVL725YsIVq83o3P
    zYxXbp3zJYdYFscBiSgUnBjbBP+BZKwcGLdtfT3jJzfFmwsE2Rzefe0BIHg+uGwk
    hLqeaHIxbEAFRtpfZFg5DyOKogU5oa7r6tL8OQintf3AOuaNHl/L7YLadUsvnSP/
    XK8p6fdL0v1X8EkRRZ4j8EKAS+wyXhGm3gAz9RenNrT/iCQUoXO6w0mA/Ytk+A1r
    zOyYTJfPoeZp+afDDeFJr5izDrRH73TsKhkTrLX746rvG2Bwym9BDIiRK9fVBBE9
    Cq7otYsJzXfvl09NJD3ruMcTseF6O6A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfPW9M++h4KrxvIxz34FWYeNz+XbAvte5/P+u3NzUoCenJP2qMCY12gAjalDK/VuXczm0VUKkMRGhhaCqtybniLJasTQ1rfDKT+e7cX+6gaP8Yt8XjUrr
    qPO3QZoY0i7Ox7+y4CTUyYUme+UMu1DmzpVKsGcYIAwhSGu66UIaxin60qkR66R+UzEMMp+aiNOqpIC7azsQdGo24RCy4XNTlrI8MQ9f7dmmx5TZBgp8pdgt
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=1oJP67jkp3AA:10 a=7mUfYlMuFuIA:10
    a=ZZnuYtJkoWoA:10 a=pRq-apYgK8S3EMxT_psA:9 a=3EPvW9MMHeNLPmOCN-IA:9
    a=ONNS8QRKHyMA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbeFAXT4 (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 19:19:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:34543 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750736AbeFAXTz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jun 2018 19:19:55 -0400
From: NeilBrown <neilb@suse.com>
To: Doug Oucharek <doucharek@cray.com>,
        Andreas Dilger <adilger@dilger.ca>
Date: Sat, 02 Jun 2018 09:19:40 +1000
Cc: "devel\@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Oleg Drokin <oleg.drokin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "selinux\@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        lustre-devel <lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH] staging: lustre: delete the filesystem from the tree.
In-Reply-To: <29ACF5A8-7608-46BB-8191-E3FEB77D0F24@cray.com>
References: <20180601091133.GA27521@kroah.com> <20180601114151.GA25225@infradead.org> <E5BF8501-35EB-4DDF-ADBE-6016CF31A502@dilger.ca> <29ACF5A8-7608-46BB-8191-E3FEB77D0F24@cray.com>
Message-ID: <87h8mmrt6b.fsf@notabene.neil.brown.name>
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

On Fri, Jun 01 2018, Doug Oucharek wrote:

> Would it makes sense to land LNet and LNDs on their own first?  Get
> the networking house in order first before layering on the file
> system?

I'd like to turn that question on it's head:
  Do we need LNet and LNDs?  What value do they provide?
(this is a genuine question, not being sarcastic).

It is a while since I tried to understand LNet, and then it was a
fairly superficial look, but I think it is an abstraction layer
that provides packet-based send/receive with some numa-awareness
and routing functionality.  It sits over sockets (TCP) and IB and
provides a uniform interface.

That is almost a description of the xprt layer in sunrpc.  sunrpc
doesn't have routing, but it does have some numa awareness (for the
server side at least) and it definitely provides packet-based
send/receive over various transports - tcp, udp, local (unix domain),
and IB.
So: can we use sunrpc/xprt in place of LNet?  How much would we need to
enhance sunrpc/xprt for this to work?  What hooks would be needed to
implement the routing as a separate layer.

If LNet is, in some way, much better than sunrpc, then can we share that
superior functionality with our NFS friends by adding it to sunrpc?

Maybe the answer to this is "no", but I think LNet would be hard to sell
without a clear statement of why that was the answer.

One reason that I would like to see lustre stay in drivers/staging (so I
do not support Greg's patch) is that this sort of transition of Lustre
to using an improved sunrpc/xprt would be much easier if both were in
the same tree.  Certainly it would be easier for a larger community to
be participating in the work.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsR1IwACgkQOeye3VZi
gbmuWxAAmeiHWBGFeXsoL5nX2bx2Vw0CRQKDJIa8bLndEDRpjMxjisBXCuQ3vcTk
eTdKbk5c0LNZ5TwKtn/sPLIGQRCleq+6yCW/8TKb98q95BxoAEudJAW8ra2oxRUQ
qDxfGKr/ytQkkDswxITsxYGNb1JThX0ajvS0DHzlwzzlrMgA7Ebwj9PJqRsCks8C
QDfLN4q+wee5DMbpYlfkEcZsbUl2FS6igq92W4+QO0HhdTatpV0+17gXKLHey5pL
os/PF7oD2rX8AXvu03GCjVp56jzxIUKiXZrAT1woSxqW/q4a/1v6o1PlgCQjaal0
ehVso1dZB2ZaU+VCI+x68sK+Fi3Kb3zPahhS43ot2zmZAypzMWhB2DYuPvby+r5J
HbDbx1gun+tAMqahv8Bhd755NbskKqif30GXDqj16cPXJIN4NEM3Eb+1b+C6YCkN
5gQWAy1i2/PXyeMVUpt+fp98JN30mAVtdaeCmsn6V7mYDw3riAcbIFFs0jrij6aZ
hMqDwySAksuad4+cJpE6K7WnYk4Af7ffa5jSPU4+nbdPZR3ogOqzqqmQKn928JuZ
Ihp2Xu7RXddZ/+2lr5AOP9qe09K8T8iF7cB2aG/SZgHdwQJuaNPr4FISTyP5UjLc
oR/pGNb6su9yRph6NBMjS0SgOb67LmMWCA1447RrbAHLM01d+hA=
=VwDY
-----END PGP SIGNATURE-----
--=-=-=--
