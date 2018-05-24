Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527156251-2-417129198907676553
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527156250; b=ZWYws0k0puPun9LxWQNnGgqEiZCbqpg8HEIE7qtXluR1AkJeoW
    VFxRapykStQ9/miK7kyj9ljWN1Ehq+DGASENn/Zw6NBqYobQA1tG/txlAkpGYBFJ
    GWiswPifLFIedBJs82FAtnPyhTD+RC/9zeB4e2MOyH/sW0dMdbj+hsqSsmi0yFQ7
    YeK8rtGdHMUP3XkwsqFqFdWhpa1HPU0SfQGbAgbKq4QvfSUEirqnDkp8s83cU2NO
    Rb3AA5hRjUZo79ys78mMzci3otsrAJ3/PL+ujSyefpyVE692ZvfvcmPTLaEe4DSq
    NV8TsyAcikgdrgbvD48ObfVRX40diUkICwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156250; bh=Tsln+yD6a3FG4kL51k4nsI69ycvkoI
    IILfB5KQ+mJF0=; b=A1uFe+MXOw72Zgh5zzEWsc6OqO9raMTBVbx4SjuyCxqrtH
    s/mirP9vnlsSls9YH1ZkPyzl9ndJfzWr4eS9haszjeeDscpEtVttG4zNTVbvASj+
    dodZ5GZH6x+jvDnWx0r2rceCbRTowf0jM1GmJQAmVsLTdfs6ESc7dMezVumzfrS0
    KgIGLkAdXC2eqXZ/b85JpcEz+f8tCMe8Tf0BYjKJC1qwl2PB3Rbr2aEai5L76KF3
    jtWAt9dMDNMe6H2bfGW4nL0ovJ2zHGAJkLRM2YI/wcc2AWVTp87bwtb/LYoRn8/g
    OM9qRra0Yk1LoGTVDDTqwCKDkpM0CKAnfAs878mw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=jXs1ahlg x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=jXs1ahlg x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGuNIge0PeqJXn9QOg6ZEg/MYYy7GA6A8BtbovCHqIn95KZJFEy1emZbVOflBSyzpR/ggTYHQyrub1dT8Fn0noahZfeevthkdrw0KFqYV+vBw5ZMaG32
    2n+7+4TfNoX5Gcgv3ruHWDUNEk0NIuev9aIGMwhMX+z8Ek2p/FdQ1458C/JOgeySGLr5L0BcWuFDvP1GzoiTYBciFT3njRkIx2KulT8XzQ8IgcDUsIYcGWRa
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P-IC7800AAAA:8 a=M5GUcnROAAAA:8 a=FNyBlpCuAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=ZFebjw2IMqqkrzxeGdgA:9 a=QEXdDO2ut3YA:10
    a=d3PnA9EDa4IxuAV0gXij:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=RlW-AWeGUCXs_Nkyno-6:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031377AbeEXKEG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031344AbeEXKEC (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:04:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ofer Heifetz <oferh@marvell.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 098/161] crypto: inside-secure - wait for the request to complete if in the backlog
Date: Thu, 24 May 2018 11:38:43 +0200
Message-Id: <20180524093030.148542659@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 4dc5475ae0375ea4f9283dfd9b2ddc91b20d4c4b ]

This patch updates the safexcel_hmac_init_pad() function to also wait
for completion when the digest return code is -EBUSY, as it would mean
the request is in the backlog to be processed later.

Fixes: 1b44c5a60c13 ("crypto: inside-secure - add SafeXcel EIP197 crypto engine driver")
Suggested-by: Ofer Heifetz <oferh@marvell.com>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/inside-secure/safexcel_hash.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -845,7 +845,7 @@ static int safexcel_hmac_init_pad(struct
 		init_completion(&result.completion);
 
 		ret = crypto_ahash_digest(areq);
-		if (ret == -EINPROGRESS) {
+		if (ret == -EINPROGRESS || ret == -EBUSY) {
 			wait_for_completion_interruptible(&result.completion);
 			ret = result.error;
 		}
