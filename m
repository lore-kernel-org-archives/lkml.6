Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1633200-1519999891-2-18185798083846339211
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519999890; b=eNeReRt0kF6ZJ5ronXFZz0812dcJl1HViyrZJdzjPSNxhLa
    q9N85arFEMzBFtqNiHBqzUEvMlJc4nKULsPdDuXy45YUNyStNZ5PfZG206Bsac3z
    vcOY87RNcumYGjiPxL3QQWSKS9izHzEIiaAko0kYdCGUqjWJ6d15BcK/7okiY9/W
    TE1XJlEGWHkUFU2ihFDLn+a2Zn9C3twiTgPcDk4nzfPBuXgCVjXxFjQl+BRtgJ6z
    RWWwi/KnNT8ex0t/CanxTmclxTLPU6AE9vBdGf+vVDtj54ylpthmysInabJ/QX68
    inRKFuzU8fa6hVbOaRXi/gAtndKHi3i2DitniKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519999890; bh=LyNz1qK+OkiTaitV2gwOHHtGz6
    z1YN8A4OewPhC62+Y=; b=myza4gB/WIAGJ4461BNJMyrnjNKYmlwhhdywhccx50
    xsI3Ufx2vynVww3iLc+JrcT511NB7kNyiikitdpopb/IJfwOoy4F4x5RKDNdyf9x
    SG+87t0U1mJ6JEvKJkrKRr4D8fVF8zzPOFmrtGIp7k0CReGVgVrWrfGyYNg3EnOP
    uySE92btpaoNO7oNKr0BnApH5Pj4O9RH4fY3T7CNDhICXAZAEdCUa9kgsEutKdLH
    aIVwjtnQZEwjKYJqc0tq5jPZ0AdPGbej7sdQ0i/cHngsetb+K5H6aUW6AaJX1Fwh
    gkaldaBLoLXDiyBRd3F2qw1R24+c//WowPj8wdepkXvw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=uEx2VnqQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=uEx2VnqQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425011AbeCBOJ4 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 09:09:56 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33410 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424525AbeCBOJy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 09:09:54 -0500
Date: Fri, 2 Mar 2018 17:09:01 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
Message-ID: <20180302140901.lrjqiaa2k4nxkqco@mwanda>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
 <20180302124647.sfhnto77wgdh5sv6@katana>
 <20180302125907.GA9418@n2100.armlinux.org.uk>
 <20180302135854.76ue5jzsg7lvxjxw@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302135854.76ue5jzsg7lvxjxw@katana>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=628
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020167
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 02:58:54PM +0100, Wolfram Sang wrote:
> 
> > It needs platform maintainers to be motivated to fix it, and one way to
> > provide that motivation is for subsystem maintainers to say no to patches
> > like this.  If patches like this get accepted, then the "problem" gets
> > solved, and there is very little motivation to fix the platform itself.
> 
> Yes, I can see this. I will drop / revert the patch.
> 

TBH, I can't find the threads from November so I feel a bit lost and
there is no documentation for platform_get_irq().

regards,
dan carpenter
