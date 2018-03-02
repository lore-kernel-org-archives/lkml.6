Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1525519-1519993683-2-14564615044392270916
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519993683; b=LKZh5Yy661pR5XBN3OxWqVN5rdTOZDn5AzLluReNJW6VObq
    lE4+ed+vvA/dslI4w4A/a8ssFpjfSgJkPIEZIwnkUCdGyCKZHMf02aLBW2WWXPnn
    x6Z189POVVqyrEjM7vp77SCXzIZkLmJp5GRaWLEEC27lCzhJ6LB2IV50smX3naIP
    2/zoXVA+sMe/ZxIkGED3lUJIEzJDw0LiDG9mu6KbnqUBU2i36w1y/aJXFHcIrUwi
    24DRGmbJmFp3dkqQqQYKWzog3c/rkicrrbl7qfn8hAk8MSTVITjTRmgGJNaKMFNE
    Si2z5jUp/W/aEzEAQEPal3JbA9B9mAfuo99aD9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519993683; bh=ZNSkU/1S/8xcoxVZGEt+LqMYYM
    ajRfQR/TZKQ9vzeII=; b=BHxXFGVgxkJF3qEtauBSaH66haXIDaY1Ivd92Alrmm
    0dHSnExTCeurpoEz1oqu2xuwRGp3/nXKKDu+1ajtaAF7fdxIbRBErFxRk/osQTfd
    ldZo2Yvc3bwV5fgVekRsX6BqSXMYS6a+E0nU+K5R+gy/IyptPS6FTzJOV9hDe9VO
    Dot1U+KSE9y2xfQbMowGkyunISsd5D402vHfx3P0vCUTdwWr/4+o4EnXupWbYi5K
    /3yJT0buFoafzDzSn2FS3RKYiFCzUhUS2udj/hlelhRK1Rk7VnxGCRjdNj/m8/Mm
    9QQNum1qa7I2oZOK/DyKeMEJeAUck1q0TZ253gnDy5JQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=N7+1FKp0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=N7+1FKp0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424022AbeCBM2A (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 07:28:00 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43616 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424003AbeCBM16 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 07:27:58 -0500
Date: Fri, 2 Mar 2018 15:26:56 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
Message-ID: <20180302122655.uckejonjyzt4vjd3@mwanda>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
 <20180302114909.u6kqdszt3aew2io2@mwanda>
 <20180302121929.GY9418@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302121929.GY9418@n2100.armlinux.org.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=332
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020147
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Ok, but in that case the original code is still wrong because it returns
early with success.  I guess it could be changed to:

	if (irq <= 0)
		return -ENXIO;

regards,
dan carpenter
