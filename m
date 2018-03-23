Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804188-2-4573069885808985320
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804187; b=edzilITzkyBf1Ua2gjuVAkF+Y4jEyynvJ60Kcb9wpCcpopN
    tjdRo7FBUzXAEKoWjeb8Pbf5iqWesXU9vF/2rwQqlnXudkc9W2x9hisjGQsB82/9
    Vsm4R01zbMlyKO/3BIELVy3f90wGadYirwdpyqaTLX7j5zSXIFunSXDqELBDwPAm
    +DU5L9K0RsR5nYakbm8bL8ZOKQmzzu3nnUKXADm1klH7Zo3tHiVSVpGa3wPLyhoy
    JSiy+TcDben0XwX7wiqBIx2N1esGYQh3fQb/8j5JpV/EsjHLsVPtJu6NllyVARNn
    PT0q8Vpbk+uUuiLQcERriJ+UgHP2XLvNet5O07g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804187; bh=CMwMzeuTlrv6UUqukNk65+shKX
    LX1ikoFOIbHqYDRrU=; b=XsUWnm61xA9C7rZHHf1I7Xr4PgM2wHz5k4iQp5Uu6B
    QIFXsvDSYMlQqG0Zpff8r1X1mCDXUkI4CDJ/8ZEJaOhaa+OfufRsBw4tz/dlLcj3
    6Q7AeALEqlcIrt7e/+lhKBrzTrc5HAgwFiWLkX9JkXznx9JqNcq2mlLKzV2ZaSfU
    DAEcex5FaNaNU8b9dSW6dIcEdtb8diqdnm5b0SKHZ4b9QLhBGJ6zyIHYxDQ5RY6V
    0I9SrOzqva5AUfmGwYPJR6aNYptXrkxXe0zHKToBowjEu4AMqrSKuEYs6DeTH8k2
    guV5g9D97Ix5SSlLRvqWye63luxSlnmeDaZfG4uV7Kuw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeCWLXD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:23:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41544 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755445AbeCWKIE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 075/177] rndis_wlan: add return value validation
Date: Fri, 23 Mar 2018 10:53:23 +0100
Message-Id: <20180323094208.626137451@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pan Bian <bianpan2016@163.com>


[ Upstream commit 9dc7efd3978aa67ae598129d2a3f240b390ce508 ]

Function create_singlethread_workqueue() will return a NULL pointer if
there is no enough memory, and its return value should be validated
before using. However, in function rndis_wlan_bind(), its return value
is not checked. This may cause NULL dereference bugs. This patch fixes
it.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/rndis_wlan.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -3427,6 +3427,10 @@ static int rndis_wlan_bind(struct usbnet
 
 	/* because rndis_command() sleeps we need to use workqueue */
 	priv->workqueue = create_singlethread_workqueue("rndis_wlan");
+	if (!priv->workqueue) {
+		wiphy_free(wiphy);
+		return -ENOMEM;
+	}
 	INIT_WORK(&priv->work, rndis_wlan_worker);
 	INIT_DELAYED_WORK(&priv->dev_poller_work, rndis_device_poller);
 	INIT_DELAYED_WORK(&priv->scan_work, rndis_get_scan_results);
