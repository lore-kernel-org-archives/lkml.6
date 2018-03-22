Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1361858-1521684249-2-8528456633545375511
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES ensvda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521684248; b=RHhYD1b/arH3aoa7Bn0qOMsRORxNfT6X/l9kaYM0+mgf2Ag
    9ggC65bj00cFg/1QSAeiasjh8bJgIZF89/32ds4W4Sa1lSvQmpAleJmf9CUh8PXj
    6NwjnUG8TtEXGBz6JivewepZJM75pGtMd+EgHpfE66Jo0utwuJR+RvX6O568tGhn
    f3hg9CQBcmi+jofU0Z6DuISX1mFQX43wsjJIy9Ty4L+eRxKt6xszL+lgBgRHPQXt
    H2ddpgwQP7pXUk5ploAghQeROB4k+dLHzHXr0EYac5Zr1Kfg6frV0Ion7SxiNEXL
    JvOaQlPNHprWHQ+T5mlEewgZC8V8K0CUaBr8eXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521684248; bh=K
    xkD9M8uO0E5L1KO2WjmnG56XfQxGi0Rj/Rrz5LOo4Y=; b=JuwqRfMC6PoDFYW33
    kU0n5q7p2D0RqoXhmMokZfgkNYCPXFJ4TVZj4WNOV5ecGTobyNSUFpTgbbKjEDSC
    V/Vn0qXOvch1z0P/Kvq82vqOxmPapML3rV0OggpWZUMWXjKYw9IQr4b5Z8wHt4O1
    FzMHVOmvgqJKoZkRyBcq1YfTRNrLGkBXkvwm7IORYb5LY7aKr8UkXVphNG6rzCsG
    q7ytiyM8R7dkypXHG5e9jUCUd6QmvGzefpROCxd/cZuNxh8JxRZljEdf6rg5qu3x
    CUQVt89Nuuuy1OldfIRp3xfumWYjWv3sexGjgmWZhrQpUX3T6nvFrffb3Ms5WaEZ
    5EWnQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, John Crispin <blogic@openwrt.org>, Michael Lee
 <igvtee@gmail.com>, NeilBrown <neil@brown.name>, Felix Fietkau
 <nbd@openwrt.org>
Subject: [PATCH -next] staging: mt7621-eth: fix return value check in
 mtk_probe()
Date: Thu, 22 Mar 2018 02:09:39 +0000
Message-ID: <1521684579-76660-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
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
Cc: devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Wei Yongjun <weiyongjun1@huawei.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In case of error, the function devm_ioremap_resource() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: e3cbf478f846 ("staging: mt7621-eth: add the drivers core files")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/staging/mt7621-eth/mtk_eth_soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-eth/mtk_eth_soc.c b/drivers/staging/mt7621-eth/mtk_eth_soc.c
index 98b4462..dea4270 100644
--- a/drivers/staging/mt7621-eth/mtk_eth_soc.c
+++ b/drivers/staging/mt7621-eth/mtk_eth_soc.c
@@ -2077,8 +2077,8 @@ static int mtk_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	eth->base = devm_ioremap_resource(&pdev->dev, res);
-	if (!eth->base)
-		return -EADDRNOTAVAIL;
+	if (IS_ERR(eth->base))
+		return PTR_ERR(eth->base);
 
 	spin_lock_init(&eth->page_lock);

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
