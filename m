Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527160925-2-12656880294959275071
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
    1527160925; b=WZRyQcebW2Fvzy38hVRyGpTGMaiKB7bpfA5LRP5CW/MpOiQr9M
    JX4xZbuGXJF9f+ADdsNeUbR0GG2OqJPArEM3Gy1F0FXU3cXMqHEiiMXWcNgFM66y
    PfYVu3X1ViZ8X5dWP+iRa4rM9Oewd1piqDtzPmGtwsAbOFYSqseDG5CthK8A33z/
    4+nFTb8+aoBGv8Zct786AdgjQZfTsY+lw304WEtu5MDaslYKS9nPDKArbh7i3vdc
    OMe3+ppkc5l+eLVMpaZ9C4wWQSOeaeic/JpZVE6RqMEEx4vfcVmEquYc5xGS51Jv
    hjxPV5HxvwJe/Z6iZd7bXXB9XTbqBnvPZMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160925; bh=mzt1xezCEISljU65SWrBJBTZbIVeVh
    Tu24L+Ywo9iHc=; b=W3RAcd+UgZHUf6oZbSNgA/9fFPa4hm6S17uo2eskxl4Pky
    NW3zCQcTdeeZEty/4jDDHjGvZRkzbOESCeIY/jcBYc4+h8KkMX8i9Oxz3ZflhQhr
    I16J9T4+cid0lOv180nbWB34VhYKbWJq3D3ADeVZ6TUvXJ1REnr3bza8Psqfh/X2
    QC/ot8xZGhyLd0EgwsBAkSKGq7QP3ptKO2MTatAcSNUhZNMNQsAzeEZr6HpEVP6T
    +oz4QgV33juMs/LFs9NY28N/J5vBoswYyawRts+z2Ipsw9vgt1NIJ96rEwADCvkE
    Pv3lp52sj4k3Xajh4vZ+URJjCDatonQAu6pChWYA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=13jKpPnJ x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=13jKpPnJ x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfGAGUcVC4Nur5MfnKlMXwiGYtMAMCQji1FUyi+Nr6MPMe1zC9lk9UwtRD+laxG3I92yV/37lNZuDJjq5BxDMIMdJMRZPooysv/IRX6RT1Jr0lGc915aN
    gSN7ie/8DS2FknVmkDlJ8vkpZxYkyK3XeHk4cbljzNbBCmQYK4WCOpEv7jolC0tIeyokLviPYP82LQoe4AhNtuETMYIjWSfjXdVtDpYyIw0NYm6LzTvFD+zn
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jZVsG21pAAAA:8 a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=qZl5N7MTnlUFlRfjbUMA:9 a=i0FrSAJdI9wZdYGY:21 a=FJIQxi0y3wYaM5T0:21
    a=QEXdDO2ut3YA:10 a=3Sh2lD0sZASs_lUdrUhf:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967877AbeEXLVs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:21:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967854AbeEXJwY (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 027/165] hv_netvsc: disable NAPI before channel close
Date: Thu, 24 May 2018 11:37:13 +0200
Message-Id: <20180524093623.079465971@linuxfoundation.org>
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

From: Stephen Hemminger <stephen@networkplumber.org>

[ Commit 8348e0460ab1473f06c8b824699dd2eed3c1979d upstream. ]

This makes sure that no CPU is still process packets when
the channel is closed.

Fixes: 76bb5db5c749 ("netvsc: fix use after free on module removal")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -567,6 +567,10 @@ void netvsc_device_remove(struct hv_devi
 
 	RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
 
+	/* And disassociate NAPI context from device */
+	for (i = 0; i < net_device->num_chn; i++)
+		netif_napi_del(&net_device->chan_table[i].napi);
+
 	/*
 	 * At this point, no one should be accessing net_device
 	 * except in here
@@ -578,10 +582,6 @@ void netvsc_device_remove(struct hv_devi
 
 	netvsc_teardown_gpadl(device, net_device);
 
-	/* And dissassociate NAPI context from device */
-	for (i = 0; i < net_device->num_chn; i++)
-		netif_napi_del(&net_device->chan_table[i].napi);
-
 	/* Release all resources */
 	free_netvsc_device_rcu(net_device);
 }
