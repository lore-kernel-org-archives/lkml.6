Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4151933-1522302742-14-5671397284885363426
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522302742; b=EWkZgY3Cj/E2BJJrzB0JLsK0l54IHaAUs/P1uTfQPK6HED5
    21YL18U20iiWORTQu6ElvBeHqJPZFDFHvlF9RKbFRQu+9uEBeJP1HHFU8BzyLBIy
    1pgWbKo4JpzIUKlJXaR1jbjvIikibEGZX60uQcQyVtSUud/22ZkMsdAPr1zCo1UB
    eX1kByBl/GEPF6MwhZ/+e5fiV2U++SAPe2sRya1mEAzaLcvhXzJBVaRPZF4iSMF0
    6EHa/rscO5gSriog+ad+VKgFNG1M2oJwOy1O3Cf9jXH0w5yLQQd6Dw54QyYuoLay
    CvZDf7VLYVQoKdpaBo/uQT9+hKn1jW1hCxruIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522302742; bh=6
    tHqYmzJMgPSsn+YkvFpg7kE/ujTFPWLgomxkog7od4=; b=pCMnNp1OA60NnaF0K
    5D8ZAYWVsOu1cmeZsQ1acRyPE4YW9C9AxOB1DypwYHJCFeNUd0vJ0wv32hJuxq1N
    0UEae7Htj1Hb2F1TqKybWSvmJb5KdGePDENxTQviqpgIMErmS5Lb1CxG04fUXn1f
    +aX8bdDCKDSOZSSJXkf3WsPWXyi8PCS3dGe2m/QwE331CG3vNu1iC+M5pqezVRmA
    EL314RCRQPSlmBOCXbedeGxfly6cWrfDzYYLBV0BeTjo5B1SPvtgtae3x3350CLO
    HdqXycmBlLlPk4lIay6hHPzmqYfOHQm7gQQ7tBTMbSwF4bJHOSMRylUpBNDPJDEl
    zfhtg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLSaTndxAjlFmV7qgZN8MyNnFEIMZ8Wg+KTcdSBMIwcjS51NrXsXCizFwETSjde1YWPlBW19UKETRBefHr80vled+Txf5Cuy8QadQkD0/vxi5FZPXCXY
    lSRBimvAYTpq8qr7D5uvm0WfMwQsO9jCw/dgvXrtaBeicpT/wp6VBKbD0CSB3a1JMAC3Z1Q6oZkR5rmOJ0+ebuMtlwvTxT7lJR106V4swf+mSD5GMY/sbEJh
    GzWJnN6f6CyE1lo/RzECNg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=cwik_FzxO5pWwJNOveAA:9 a=AUzTJ_VtHuwZaDiL:21 a=D_GfnP_hIqyXqNfL:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 4/9] staging: ks7010: Rename ks_wlan_set_multicast_list()
Date: Wed, 28 Mar 2018 22:51:47 -0700
Message-Id: <20180329055152.13059-4-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329055152.13059-1-quytelda@tamalin.org>
References: <20180329055152.13059-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:ZAliOxnwE2qF2Z37XXddrLP9ZeZ9DMx2ntaIYN2HyYei3lRkAvs
 jO5Du+KLmBh5l9Q45yPKepMSVMuA43ru9s5rpBhpCB2JFxZUR13bn274gV30bt4lf2OczHw
 LFIdX01rjtM91x+4UuSneamta3UaFxY5m28avbG/Wu3GJQ63ErSJfdlQtpZhmYBxuRLwrj/
 DY53g60wbPzT497ajGpSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MI6y2r5EgeU=:iD0En2SO34W5FmZxcKw6Zb
 2yP/X2PQJVQ27VbJDfawUEmPTUcVf8siqQXYVEwGbWBHQmLy2N+DScvESPjTdq7rGaVDEJLPZ
 g7p23gqvMrOttaLFol1lzyyWEyyVuQa+VLphOkdrLkR++VkMacManygG3mX3I5aho9o07F2AU
 ALYB+HUB2nQuBGw9HiaOZ7yqva1FHxzKWtoiZtOxK0jXlst3WU+gn4HpS7YfSrR+O2Jw1ocUD
 5HRLTwNMNCq8lycIf0eP74Q4Mugbd/SOExomYT7+f58sfCj3ZvN0MJ9gnuvBymAPz7ac47tER
 n/BT+oHVjTrDYI0AoffqsDCMjh0wxKKUss+Ra9ifmMuxlJyYILEgswCvEpMsdER/cMxDT8y1x
 y3+71p0IEIdLsr6tcAp6nP7ELKY2UbX9/OWVzHnwlCVfwrceAZkYay/+GR8tlrX94J/PRGHBK
 tahWyeVuSdoBuUTlmzid2QGMb0r7lu5kBsAB/boD2KVMWnxnqmoMsOAH2q7kAKIqulIxcAuO4
 PL6FWVXqFY5qJfF69c4fph9IVcvhHSLP+VK+aSM3/hRV3aeS+oi/9Zc0WuvxNNewKjHsymrcM
 ujdLsU92ME3wkA90qdByLiNMb5oH8MjelzKyKYWp0aXWVsJy+zKLkhmdA7HTOY8x0qB5NknIp
 Aq8y3DTIOpjaSvXRHODW2y5tSot8IZx+v34GjkgDDQQSRY9ERbZKa6YAuzS/rLRSn+1y1KuRR
 WTH82h8tMMwmrsr1gV8Q+oahw2XVTQx9p66zOA==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

All of the net_device_ops callbacks are named after their counterparts
in the kernel's 'struct net_device_ops', except
ks_wlan_set_multicast_list().  Rename it to ks_wlan_set_rx_mode() for
greater consistency.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 2f84c5dc1324..41f89f930f50 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -72,7 +72,7 @@ static const struct iw_handler_def ks_wlan_handler_def;
 static int ks_wlan_open(struct net_device *dev);
 static int ks_wlan_close(struct net_device *dev);
 static int ks_wlan_start_xmit(struct sk_buff *skb, struct net_device *dev);
-static void ks_wlan_set_multicast_list(struct net_device *dev);
+static void ks_wlan_set_rx_mode(struct net_device *dev);
 static int ks_wlan_set_mac_address(struct net_device *dev, void *addr);
 static int ks_wlan_netdev_ioctl(struct net_device *dev, struct ifreq *rq,
 				int cmd);
@@ -2833,7 +2833,7 @@ void send_packet_complete(struct ks_wlan_private *priv, struct sk_buff *skb)
  * This routine is not state sensitive and need not be SMP locked.
  */
 static
-void ks_wlan_set_multicast_list(struct net_device *dev)
+void ks_wlan_set_rx_mode(struct net_device *dev)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
@@ -2877,7 +2877,7 @@ static const struct net_device_ops ks_wlan_netdev_ops = {
 	.ndo_open = ks_wlan_open,
 	.ndo_stop = ks_wlan_close,
 	.ndo_start_xmit = ks_wlan_start_xmit,
-	.ndo_set_rx_mode = ks_wlan_set_multicast_list,
+	.ndo_set_rx_mode = ks_wlan_set_rx_mode,
 	.ndo_set_mac_address = ks_wlan_set_mac_address,
 	.ndo_do_ioctl = ks_wlan_netdev_ioctl,
 	.ndo_tx_timeout = ks_wlan_tx_timeout,
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
