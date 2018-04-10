Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2999022-1523344436-2-17850025859684832183
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523344435; b=N4YpEr69slbZxpsW/etyhPvLrvbPMfDLv+Bc3AS4+qO6ewSRsW
    Xp97X2inXIceCy9ddwmOvNfjIVZgfHuOiwbcvkPjhMqBt8BrA1HIqbj8adllbxib
    ZpnK10FLPWQCU7fEs2wTzIi5qub9jyc6QN/ibJgZWNX9MhEEKcYEgL+two4o2NJJ
    J6tOe+0aqtQ2PHRkTqAZDqM0B1UwlJ3HA6v5PCrhkuhIlbaYMtmMoFCtIclUfbIn
    lKpxNm92pAr1s2jBAnQXDRnIwP8Nk4NZuoZUIYCGWqDdMg9+I63+6kVdxBlPpPdF
    9dUWbHy8Mm0bigl8CrPB3h7zMcxpwjFiY1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1523344435;
    bh=xcl0DHFKOTOfb+20CCBt/sT33niyrhcG5GvEflaoxvY=; b=Uz6vV6pLDuKm
    TjXqrrW9Z7CI5J3tU7v+cwWjt4iCmyWEC8mEwAYSse6zERUR561zE6SpdrsTg8pg
    DuQGBSjvcztbeGvXmqT2U7MC3rVev4i6IE6jJhjwJIAD86aEg4Jm7EwYXagGxGYf
    uzhvSUSoDHprZbv3mCgrI9J2EtvOvadrDIyJBShwOERr21L12avFYz9I5d42umww
    iyR/6ap9YxdtPkqSwdbngpO4A3nKLOK0FkAOBu6kvGR/3Bg+kCpNf8FK6aAgXVdp
    4R6A+mtTDEFXtEn+dJuiV70T1iI8Iv+3HBRKHtL/qud3z61gdLT+MJVSCY9EV2Ul
    p6cjhmch8Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCWZHCxIbICrEdhfqDipH8Bi/SGFshgi7zLl4QWAg62z3kwNtWUGmOp/Y8ax/n9pTLK5EGPKScx9Fp1imc6mixN7WNLsAAlxaNyjgrYqHpQwjhra3chP
    HwURceMmoyK339gih5wh2msv3+ibvyFlw7UcG/jurhKR0vCl6+o0b5yvpQAIxpCkiZTuoXBwZ6rlczU4qEIrU8kNn1P/GRlKViY0WWTRpqzWUPFc6aRpNoPp
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=e6k-HXK2HGb77VHfNkIA:9 a=CjuIK1q_8ugA:10 a=odyn7IioiYXqY3IkO80A:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeDJHNx (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 03:13:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35854 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeDJHNx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 03:13:53 -0400
Date: Tue, 10 Apr 2018 09:13:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.104
Message-ID: <20180410071346.GA31194@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 3.18.104 kernel.

Only users who had build errors in 3.18.103 need to upgrade, this is a
single-bugfix-only release.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                  |    2 +-
 drivers/net/ethernet/freescale/fec_main.c |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

Greg Kroah-Hartman (2):
      net: fec: fix build error in fec driver
      Linux 3.18.104


--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrMZCkACgkQONu9yGCS
aT4skw//SoHt6Tjmi17ou7IRcpxYDmmMtL3wJg/L4lJFslaceAulJVqTdueSNKcP
U45OK4BrnsUzGTyw5wIQfTiAbC53RXzCXqZXKeUghdBL5WrVnUEt0zQ8Uj6TD2S5
wQNSOsevb3KilrlGtoeMRwaMc5PL5vzauffa5SEhBZ2oqMR3/KEMFUXsguEGgsV6
CJZ/DypoTze9myZsUPMIp3bgcWbnSbgri71ot7OaHiVporyps54JvuwVwoGWJroE
C4BXWgZSZlvBmtm7gFWOWHqg+th5p74VN0/zM6xvPOdMdtZfhEGpTfYjiTkSnmsv
Iq1qVSiTyIGhscxkmIoXzM6RcfH+lcZiUF1YWZrv2X7uFkXCsMXV5FL4yhwQEq1w
IjQqJEVXZ9xpPtlhg5Ua+1TX/3Sx1nFyJYD0f9SaaKNOHBXyDtSu1InYU297UPgl
O3dtrnzorga7N48EPjvp2TSCKoyup6WSzIYAlB+IM9u4QitRCtjUvdrZ6HkWNJRu
JiF0pyUxchNNZjblPWrtxtUN4R0Q3a6vfuW5NousKhlR45pSdtf3+Uwz4ukZgUFi
MXqWEn0GM4RvfHHNFQRBVgymkzNKXzFuEzxUDuyTv8UvL8tBwIbJl6jRUMnirpky
IpWwBzDfgCdHUbbWd7Rf5VPmL1wXwFacGZ59rofmnHwmx32V60c=
=wzzS
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
