Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527158680-2-10531820092847293535
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
    1527158679; b=kWMjHtlF0mp3Qde4zUNEw3W7+rsOXm5iwFpgkZAT2rkbis/BoA
    EpbvN64ebKswVNgtN9bPIJutZaS5rcjxzS0DG9RX2u0EVltU5gB5ZqzbygToz7vz
    S5hDe1n/Ewvp4esdW29w82BNeN4D8ZjRvbA9VErYWTq3U9uRSiB+6GIFmeB6Rg8u
    InT75XF1B1IFHll+Ss1uNh7zblsXmEAnuUWAhf2XEkzyuKDxUGyxhbcfqJVH/VyO
    EYyfYCyHnWFtdM55tPsyvqjOTvKwQ0XeidWb2QQl/N3NUJzkD/LNbhZn7elq7n3y
    5cLKKaxUYbNBUPSGrDxRgAWAPYl4bKEKcXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158679; bh=2LGTe2dMrBTwSDktNbQCSwm16mmnTT
    +DAf4cZ29KgIo=; b=gsiILXC41N2uzlahe/O9RmNYQjVrfV7B5zOiZpA34Z3gNs
    Ivrr63SdQ9qP2ryfc5Nu/3JeIpoNjd0GbSywNYB8yCUjAyO5Od32K1SyA8hNU6ta
    aEpN+HFHxkUzU1LITJhEhHmf673ywPmoRc82SHEuOZoBWEYv7upHx67zJv4rLDtW
    drClpThSK02blqhVqxmBDJ614l9NW4uUWWr8E/apVFhEYydE3fgSfoOqyKDrI4TK
    Yac0YvV6/wqjGYo+snqKf4J6Yo48rJHIK6cMcb4X4zAmfgyl2qP14UW/Ds+qdLyy
    ir++aI3Vj32amaw2xGUp2ujQyldL3cAvExijqAZQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=w83xmRxk x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=w83xmRxk x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfEp92COW2kqLYsEMA9XhYYb6xrS6d662vjgtJzKRtaT8TYwGJSSeWiUwNdfdpb9XL5jvCJMCBrEwt7rPrJmqVgDV1+vP6whv2cFObic2d1x8IIoWtkqj
    BL1CtnGBjBanzgEjk6aZYmj5SWPvUlhP9JDa2FnXZjAv9irZiRAAeP+dlRnXVDQGeUveKXxGi+Ro1JknUbreKrTeQuwcC1tUNivbu+orEsr4rr3NPuryaQql
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=ATlqkBLompyTqWQ9KKQA:9
    a=QEXdDO2ut3YA:10 a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968298AbeEXJ56 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030466AbeEXJ5n (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:57:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brad Love <brad@nextdimension.cc>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 143/165] media: lgdt3306a: Fix a double kfree on i2c device remove
Date: Thu, 24 May 2018 11:39:09 +0200
Message-Id: <20180524093627.862684082@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit 94448e21cf08b10f7dc7acdaca387594370396b0 ]

Both lgdt33606a_release and lgdt3306a_remove kfree state, but _release is
called first, then _remove operates on states members before kfree'ing it.
This can lead to random oops/GPF/etc on USB disconnect.

Signed-off-by: Brad Love <brad@nextdimension.cc>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-frontends/lgdt3306a.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/media/dvb-frontends/lgdt3306a.c
+++ b/drivers/media/dvb-frontends/lgdt3306a.c
@@ -1767,7 +1767,13 @@ static void lgdt3306a_release(struct dvb
 	struct lgdt3306a_state *state = fe->demodulator_priv;
 
 	dbg_info("\n");
-	kfree(state);
+
+	/*
+	 * If state->muxc is not NULL, then we are an i2c device
+	 * and lgdt3306a_remove will clean up state
+	 */
+	if (!state->muxc)
+		kfree(state);
 }
 
 static const struct dvb_frontend_ops lgdt3306a_ops;
