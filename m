Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3076317-1524575910-2-3151907371364101212
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524575910; b=mtKvwsbvSVX698UWM/05wSuk1b/5f983Qh5RLvz4x7IlkGOm6A
    +Snzb9x9HmaVWA4Ry9hsX0AgxczCZP+c8d1jV5tu+Thx4+ADrEay8Y94C8wCX6dJ
    5gk8kX9X3pdOLMZpYncKZimZeN0WUJ/n7G9rNY9hlNBxVo+mYMI1yDLiTu5z2q05
    0nZS57ic4W9FosAmTJWUpgw33MEtgplVgkcrIEu20to/MUGlcN7o67132CJ+gBym
    i3dmZ+Wb6eP8Spl7nJKxf11oVscuLABlJowGHOWFRHGaVjB/iMrmoI+nVk7JJdsi
    Yk/+jK2GUh1eNX8KMH9eXiOJjUMJdSDNy2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524575910; bh=j1wR5
    0BiSk2tt8sBkcnDzu/I53lav8F15GLpzSuPrPQ=; b=UXeOU/brEx7fWqn65iS4I
    A7MfmmLOFDsmVDaaINtsE3YwhV7rzpppqQf7eGqyDYypnYulrJt+jfrzTXvJQKVb
    ZO7BSKBV9sN5wtqoOyjRTNMdtWJR9Uvv/w+qNYjmHPeRunPOlalE2tybedhqz3nQ
    TEPvP1oyPvXtb6uxugM5cy3r9/3ZFUDycxMyceGFmNcdIRInnwwDjngd2sIvizsY
    DlxOIvnN6OKULTFdFKnbKkja9ZSZ33cflaNT5g7kybr0E3Uv1+9pU4koJUEEIkpC
    ghIo7b9YV47rF1qck9Nlo2DiKsmontWh0pnO9nqsXo8lS1+Azz2dgphxrKhKFJhf
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ACilZqsn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=enhHE79E;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ACilZqsn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=enhHE79E;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFo/LHdAgh/g6yl74OS23VWiyZOi+wyShYodnbT7BbYImHwd0rE+afgKW9DceFa4/XMkJ39lB+8qEktBxsOIpPs4NY+sYX+J/cG6jmBCLN4a2aAjtnXN
    h5475WVZXAoo1gCLkgnLL93adQJNWfHJW6a1eJTau1xJgxqISaYCOCNuDbmbWd9NFT58ITp3NSix7IMDcXjKvtn+Fuy78tFhEfwUq3BRj5ufWUI36MSn92tT
    vVpAaMRzAuh0S/qZyIRFNA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=UWLGKgljVrAA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=w9j5uuQj-3BbXOR1XwgA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx49KYlBNRERgCMq1eUlRPrJtrKqRYyVZ6wnAEK22NCHvm7Z92PjvkLJE7YYjLnYTO5Twr6kP1A==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gdm724x: fix gdm_lte_tx()'s return type
Date: Tue, 24 Apr 2018 15:18:17 +0200
Message-Id: <20180424131819.5113-1-luc.vanoostenryck@gmail.com>
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
Cc: devel@driverdev.osuosl.org, Johannes Berg <johannes.berg@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 drivers/staging/gdm724x/gdm_lte.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gdm724x/gdm_lte.c b/drivers/staging/gdm724x/gdm_lte.c
index 4f3c51830..1f8a33f04 100644
--- a/drivers/staging/gdm724x/gdm_lte.c
+++ b/drivers/staging/gdm724x/gdm_lte.c
@@ -408,7 +408,7 @@ static s32 gdm_lte_tx_nic_type(struct net_device *dev, struct sk_buff *skb)
 	return nic_type;
 }
 
-static int gdm_lte_tx(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t gdm_lte_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct nic *nic = netdev_priv(dev);
 	u32 nic_type;
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
