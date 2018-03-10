Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3746915-1520706232-2-7608728872680338236
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520706231; b=eqScBf016LLkeRr17zI/zORBWi+Txu/EL+FlFXtMJtscGw4
    cibP3daIAGuKnCwLTO0gNfCygK1D70nPHQkE4IZeWONjIj9vgJw22ZKrsSObdwUP
    U/hJmXzmVqFGu5udct9lW6xZqthgGVHf452uo/mJEoEWC8mRJKsh3TMHw4iTn9EM
    J1p8rJiHiX+fI3IoH3B5w++lknV7/2b2lH7C7SJDPsgnYJ/HdFe2Y4gvidqRJQQ1
    0y596A/44BkvGX+4PwejnMFqAwk//nV69TvGFeka+LWZNpyriUy1cSE+BoJ0mzql
    RcyJaZbdL9T+dRZstbJHBrQLprHrJLdmqlYSdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:from:subject:message-id:date
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1520706231; bh=bt2n4zD2vfqWohSooZm+eYO4/m
    75M6iOWx8w7E1H6rg=; b=vGEalRVFnJDEI+EAszvQyGNr4PyDQtr16nQN+WuO4e
    IxJ9vwtz8MCQJboO+caPfQ4z5ut0rAsuBxG8aHZHaBLCOiYqw3KUYBg7EXR0N+9t
    yQZd/z5kK+pBlorQ/TGTukKkAvqcI/7ggZwVGvsc12+uoAz2/39Fa/CVIZpVPjrI
    HRSW4FecedV4zrrQL+39XD4rfprquFAUFOX+/ef4yURUgsSj89pACOEyEVpB9Sbw
    pUc4oarmFNb8XRurJZPcqE82dZ0jdt45tK9msf68/hrJ0Iyn9ntgjY05sfCwaYQy
    0lFNfJF9b2C2yMG3VQjAYKwlvBRNtRr1sf8EH3jQDBgw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=none) header.from=users.sourceforge.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=users.sourceforge.net header.result=pass header_org.domain=sourceforge.net header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=none) header.from=users.sourceforge.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=users.sourceforge.net header.result=pass header_org.domain=sourceforge.net header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933036AbeCJSX0 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 13:23:26 -0500
Received: from mout.web.de ([212.227.15.4]:52567 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932844AbeCJSXX (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sat, 10 Mar 2018 13:23:23 -0500
To: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        "Andrew F. Davis" <afd@ti.com>,
        =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>,
        Philippe Reynes <tremyfr@gmail.com>,
        Yuval Shaia <yuval.shaia@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] net/usb/ax88179_178a: Adjustments for ax88179_chk_eee()
Message-ID: <b92bebdb-c1dc-a9d3-2e3a-845d8dc4998f@users.sourceforge.net>
Date: Sat, 10 Mar 2018 19:22:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:CoM+/lB2z7p+4ZniU88cu3aj0GkFHjc9WllkH1j2U/nobN2/ZrN
 A58qFiiFS6hQkkhW5UBwicarSMCGcBBG+bWfcMGv6THTPpNWsDfZC1+D/tN2TQYOxdMfzFF
 12DfT5ZLYsj94it4FEHrGPPD0BioBhdUHtJ0f0Xbo+LziQg3cTyLQ65H1OB0YW6FrII+W39
 1cYdIr3G+X55dBu5lCfIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3gbuS/zldG0=:RIo7dUAZJTIEpX6sHoSLq8
 yxIHAIHxO0UnEZRWC4cCbMEdx5xfN/ZR0UZbDJ+9O6coG8axQCJNNXkvfTaSxkUmPxlBuNIjW
 0/0eWnQAw2KHZAgOPnuXR6P31suX84gCliZBTKoFzHxpLVbiWEDYzLjoW6y9bsRcyXsPyXtmH
 lQIwgWvrSKNsR4JLSjXMfrsbE4pmC+Anh4creiQk6TxSWulmJD/FaKtRp7PYi+DXdHZBZANJ4
 eLKvhoIeMV/J5kTq9OIO8FlM+JLr6ELjcCi7qWnQDh1qQO0REs6uuyp3CFktJ8duX9Qt2eQie
 3DkX8nbeCQ7/p8fKq3LOST2BRjytBvswkG7dzUNJnpqQWS2q9epM4hCU93oGrgKlfe3SL491m
 3foMTi6ZFmwGAG7VyCmm1P/LmISU/A/xTkYdtF+I6pKRV2xu4TMa+z5K0G4siHscPljkRsldK
 zCg+RPYzefsgI6fSsFeOn8dfxtNoRKwpVsrivHqZM8Yb/qaZr0nlcnhm2D+4FkV4Tj2Q/qnxh
 sxphkU9YNp1dhOn0LvPEt54xTmk0d58PmwLluwxMzqECK91sKx3gGPS/v3omWWNAR4R7ELnsY
 sZxH06RXOy3/R8PNEaz/MnHZRIdkWUszRzQOCa+wYU+p9Z0czXG3RzL7oHJygwptDoAB7Hun5
 558eQbggJooUD2KfYis3vvP6Ll5o/3Xd7KLiaO9xbISRAM/z7lnjkQlSqK4QJkadk4Y7yS50z
 oABxn+A42lMA2Ktq/tRWKs2ZxALOdS62F56pXrz1tuh6jFefihhjZX3DAd9yM7p968IzOwHTr
 xhDA7rUoKaDn8vo41vJQY8zIRcUcbS3AqInmU+sbWyBmpvaijI=
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Mar 2018 19:05:45 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use common code
  Delete three unnecessary variables

 drivers/net/usb/ax88179_178a.c | 45 +++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

-- 
2.16.2

