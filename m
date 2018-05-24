Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527155540-2-13057116968946913168
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
    1527155540; b=kPrvWKNYzYfkJoiMS6Q1CzNNYV/hoKhY8/HmmyIPANPqKS6aGe
    itYKqiey/gJ5T8wZhNAhCYI1fLtxGLS5oiGG9pzrEbI07RiEde0I8KJHWXLywXIm
    CThLnu6E7ISj1UQuP1dGfPqnS5WasoYjFzPOQ96mKv8bGY3OV/h16rbrg9koCF2k
    8TJwwMqh3orduDWn+G6ypFydazr03o0EhDduQ/8vLvKhJUn9km2fP8u7p5H/KSkv
    fcYT9eKnxW0g6rbm6Z843YEAPRnlwCLw3Rd8O5Ie4sXsZ7h8qYHqXW3XamZjRajo
    WmWGo7rFHzAQYWaXbvDzwFF1Q/OTDcb9zwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155540; bh=mggcbjxF8LuHdM7fDH6jscEQMDQSyd
    dyfsAxBHE0dmw=; b=drXoYY3bP7hIbIjJD50++faPKJtfMIDtw3ijFuOAucDqPn
    632VKs13qiXIdrDlN0aOkuCcvXilGZ9ikq1RJ4XINRdrBh+2NK3qVJ25bO9fu6Zs
    rKCkpF+R14YckXO2bXUKvhdE7LmAWS2GTA5TERcmV5Ag3SQxNBY2/nVUxL31Izo3
    GJMRCW5cpCKNB8OcDIjVR9X9K4ql3LyDA9xZx83aCyn463OLN2K9WzN+Ef9F624h
    FwnOPpLjaBy3F2atBYPXMYqZ7BQWgFGumTjfhQICiQZ7VjtZpmqBRTcV5xztb1JV
    bnr1teKSxEGKHpOwdfIeB8rg0kXIcLKz9vUO4bPw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=V6XkdS22 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=V6XkdS22 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKWu+DzpxCNO4yDpV4yqJHJSlqK1cYO8og0ITwkcNLp5f0m2vdYG1xt20FYGuv5L/Ls9J8HkIRa/ooZzsaRICNQkVbbEapgCCJG/PZXM/QYYVU6sw/yT
    V3+NYAE3fXp8Bw7VgdxSIPJFN2uwVZZs/u2BN3a/BA98uZmYTkpsxsgaH+tM3ptT98nTNc+PNhums0+j7jnDEmhasow0/Go9ITNpqeqMmGCNRMcWoenFcnBc
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jZVsG21pAAAA:8 a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=rUbgVXzP1iQr2j_3wrkA:9 a=QEXdDO2ut3YA:10 a=3Sh2lD0sZASs_lUdrUhf:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967194AbeEXJwR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967007AbeEXJwO (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 023/165] hv_netvsc: fix error unwind handling if vmbus_open fails
Date: Thu, 24 May 2018 11:37:09 +0200
Message-Id: <20180524093622.916036459@linuxfoundation.org>
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

[ Commit fcfb4a00d1e514e8313277a01ef919de1113025b upstream. ]

Need to delete NAPI association if vmbus_open fails.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -1288,7 +1288,6 @@ struct netvsc_device *netvsc_device_add(
 			 net_device->chan_table);
 
 	if (ret != 0) {
-		netif_napi_del(&net_device->chan_table[0].napi);
 		netdev_err(ndev, "unable to open channel: %d\n", ret);
 		goto cleanup;
 	}
@@ -1321,6 +1320,7 @@ close:
 	vmbus_close(device->channel);
 
 cleanup:
+	netif_napi_del(&net_device->chan_table[0].napi);
 	free_netvsc_device(&net_device->rcu);
 
 	return ERR_PTR(ret);
