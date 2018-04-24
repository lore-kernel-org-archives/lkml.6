Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3069549-1524575914-2-9490868924805062317
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524575914; b=oTuAmW5M0qSDwAmI1AVHcQzI40m4TfruJZrlITOXzo9L1zlPiI
    XST55zYIZowPxl1LmaXDxMCxFhMnoTWBXIparg8JxTpGCz2LchDVAoovVPzjN1CZ
    V2aZADxYItrRARFvlwOD/SGlBj56FNFMeuHnJ2u+MpOd/NkIWS3jqz8T/jJzWPuZ
    NujlcruZH/G5HEECQDp4fFjG+MT6jBcovz05KYf8852C5xomkCWLd+y6+PXEjSKl
    r+GMU5DnYPn0LtuKvsLyCxoKcKp6aqkPrKAaK5aCgfy++Cp1brcpjrKGc5huKZOB
    F2RrXbBV6l9kOsZyWCPCd97SxHgNmqyWxZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524575914; bh=zrcwk
    4Pq81lNnIuOljSSHri1cfM68zy1jSNNK7/R1ck=; b=Ykee893tK/+RxtM5NiAbn
    E80sZ4/b+QDL0TfAFfdiEdy0UBFG7uvlsZX0205aSgmXyoFhesK/cHPdt9MKfj9k
    AHcVWVPlNG/ndiiTkt79j9IuaaiY2k2Wj4aXVxowaecSiSveGZGotxaiL5CHYPt7
    mHRFX9CeiHyegi9c3NDTQzkUJY8FOrob+ZP2Xgneu4I0pOnzj0B/4ho9P3C6ShW/
    qm3IwQ0lcbUHjoRUt03eYvR6ccECMfbkJf3VQq+qmxVVWaSM+InN//rUp8MTd8BO
    oR9obBB9bp7umu+HBmAgo/DQkk2d+5jQUgzaoVwNwpFfWQSoV1MrQZy2tGTxIUwS
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vYK141wK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FFcV3PSI;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vYK141wK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FFcV3PSI;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCxMVw4N1RSFSzziDn/MR0vIjX0yKEWI1x+cWQtDWCQcJcge/E4SkrkbkzEaVAQ1JOLNEhhJDsMCmxCaM78tJXZxbU+gpLKTq+BTIgqiuwqsmMmqHVaT
    LOrplkP06H2ujI2Bcgd/zEO74Vk+oKt0yqabfhV1pr5Cq2rlCMzG4P3pQuvxG8loZ34k7ET9FB4RKYYGGvZiDYWbZTpY++rA27xjMxR9C0EwVxXGWZc9gD+Y
    ec8d4Vnu5S4QK1p7ZguTBQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=UWLGKgljVrAA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=4XxD8r021ChNIGXyfM4A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx487RoIj7TKUxphLHRUw/5NVfLhUZE8AaLw6mp8qSZH9oduddK2SR6w3Utx8R0a4tRPTlxq0vQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ks7010: fix ks_wlan_start_xmit()'s return type
Date: Tue, 24 Apr 2018 15:18:21 +0200
Message-Id: <20180424131824.5164-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Janusz Lisiecki <janusz.lisiecki@gmail.com>,
 SUNIL KALLUR RAMEGOWDA <kallur.sunil@gmail.com>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 Quytelda Kahja <quytelda@tamalin.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/staging/ks7010/ks_wlan_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 9078e13b0..57412caac 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -71,7 +71,7 @@ static const struct iw_handler_def ks_wlan_handler_def;
  */
 static int ks_wlan_open(struct net_device *dev);
 static void ks_wlan_tx_timeout(struct net_device *dev);
-static int ks_wlan_start_xmit(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t ks_wlan_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static int ks_wlan_close(struct net_device *dev);
 static void ks_wlan_set_multicast_list(struct net_device *dev);
 static struct net_device_stats *ks_wlan_get_stats(struct net_device *dev);
@@ -2772,7 +2772,7 @@ void ks_wlan_tx_timeout(struct net_device *dev)
 }
 
 static
-int ks_wlan_start_xmit(struct sk_buff *skb, struct net_device *dev)
+netdev_tx_t ks_wlan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 	int ret;
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
