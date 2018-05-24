Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527159837-2-3846336874478992970
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
    1527159836; b=estlCDqrVYpCK+EYA3zVz1bEAKPaSJcvvmSobDag1MpxJtrfP3
    JuQLg2UrxtyfgARLt9nu9NrR5iHnr8bkllRu9X9mEtRbme5+lXDszkgyOyrYnruG
    1ESSswSpNrjV2hK8EmIgK8x7xdLbEclw9+vyAkPH2NwvsH4YWWNiubDgHIr/Qa1H
    uRFfqk9fHBwi1/Ocs9LxAshtH6m+1fLIkD2wfUf/in6RMf7Eb2+8fy4UcFbFCX/O
    yhI0nLcmzIxIoJCEoCD93dmQaMsXfx01DRegHzkKJ3Yt2kHSy12aukWGHX11JPAK
    t7twsV+kNs3aDVJrSeU/k5J3nm7bjU5JnWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159836; bh=3jT90In2JIUiiGDZUrPl1vuBoaeaRu
    c4Q+KdL8LfEEg=; b=k0DMLb8r//CZtd2qzavBLh008i1OM6oayGnDI5kOT3NuSj
    RIutFsb6uEVlH6jlyd6AJiU4w22gY8jad00z6OEGEIfJPhlsbuu9D4KuZUkWePZz
    Ok31+pjSUKGcYLKf8/ax/GpUBOAjC1UUkBZIb1Tz6qz28LaNfO2I/TepZq3pata4
    o6YfkJKRvLQqCle1mYxpp7spFwDXHhGuuAXdm3pqOgmNZvxcuTSP/KLIXiyL/1zD
    Jd3tijxUCa7dCH5iarpdtjyxIY4rhAeK8zU/MChT5kvi+PLgBqc3sI2BUpgmHR3b
    JbmdYx3xOirCZkrvB2B319p2hFt+XNppbou30JRQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Zi6ZBvJl x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=Zi6ZBvJl x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfMY9RZiTjTxiwJ6avHxCdZAm2zKrWj63hixDPndckN26aIKkqJ3Nm8nPvtpxrEjw3HpnnNZ8cruYmXB1I06mvdHbPDbohPLcW6pW9YQW91yphbugnQyT
    +ZUTeFp8q/s+1Z6+c0BLBciWMCGA7als5qYGiqgd/PY6YH99fCZK6nalEpgUODLesJrReWmqXGNqHbI67ZuBdyHs84hWULmmtOhiLoFYnWkBQUrynO1gMEmS
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P-IC7800AAAA:8 a=FNyBlpCuAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=Mwc-CdAr3abN8VHC810A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
    a=RlW-AWeGUCXs_Nkyno-6:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968361AbeEXJzl (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968389AbeEXJzh (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:55:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 098/165] crypto: inside-secure - fix the invalidation step during cra_exit
Date: Thu, 24 May 2018 11:38:24 +0200
Message-Id: <20180524093625.981448838@linuxfoundation.org>
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

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit b7007dbccd92f7b8c00e590020bee542a48c6a2c ]

When exiting a transformation, the cra_exit() helper is called in each
driver providing one. The Inside Secure SafeXcel driver has one, which
is responsible of freeing some areas and of sending one invalidation
request to the crypto engine, to invalidate the context that was used
during the transformation.

We could see in some setups (when lots of transformations were being
used with a short lifetime, and hence lots of cra_exit() calls) NULL
pointer dereferences and other weird issues. All these issues were
coming from accessing the tfm context.

The issue is the invalidation request completion is checked using a
wait_for_completion_interruptible() call in both the cipher and hash
cra_exit() helpers. In some cases this was interrupted while the
invalidation request wasn't processed yet. And then cra_exit() returned,
and its caller was freeing the tfm instance. Only then the request was
being handled by the SafeXcel driver, which lead to the said issues.

This patch fixes this by using wait_for_completion() calls in these
specific cases.

Fixes: 1b44c5a60c13 ("crypto: inside-secure - add SafeXcel EIP197 crypto engine driver")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/inside-secure/safexcel_cipher.c |    2 +-
 drivers/crypto/inside-secure/safexcel_hash.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -446,7 +446,7 @@ static int safexcel_cipher_exit_inv(stru
 	if (!priv->ring[ring].need_dequeue)
 		safexcel_dequeue(priv, ring);
 
-	wait_for_completion_interruptible(&result.completion);
+	wait_for_completion(&result.completion);
 
 	if (result.error) {
 		dev_warn(priv->dev,
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -494,7 +494,7 @@ static int safexcel_ahash_exit_inv(struc
 	if (!priv->ring[ring].need_dequeue)
 		safexcel_dequeue(priv, ring);
 
-	wait_for_completion_interruptible(&result.completion);
+	wait_for_completion(&result.completion);
 
 	if (result.error) {
 		dev_warn(priv->dev, "hash: completion error (%d)\n",
