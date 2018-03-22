Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1321235-1521684278-2-16561911086686270154
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endasv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521684278; b=rnjMcGNsl9y0PXgB1NnHznFV9ukjz8zHLHaHRfLS6mufZL0
    HyCLo/KWfF+3TF7WFMlqcaRqPrBK/6l03XX+QmR3Jt1rGeXjZprDH+N8ikf5gRdR
    y41Bmiek6ZQx+Qp+Cd88WF2zrEMFRyjBuU28E/g0hh3tMrOKB+DUnTeGYU4tOeKQ
    VEiZQWTg9HJfAhDAym1uNPNbUGN65suGmT495NHwo/Z15cwa/ylsuYA74dA8PWph
    z5Q2yH6kTjkhATmB8VM3VfHmdP46mxwQPNUyQ620CfkucGKIip2K9MWdA7m2rW3L
    FOds9Z6ILYqpSbSMDdX6i1cDs1ygGefEJMjVWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521684278; bh=Z
    p88rNLVAHU+wZZhGtSONcNG3Psu/9FH0YmW866EFy0=; b=o3dq25kQRzGznfSZf
    u9oPnuI62LRQkZJX2bpGsdZHU5Ev7sUK2Xl/cOeuYpttyAtuNczCnE3LDT65rCoc
    VqFH3Ge1vRJghGm127vGVsdDKdbLbghQnN4ijKgiWz4mMqA5qB+5UZ4KXEEir+lW
    tKsVmrVEwvqYpvR4IhwWc+KqqxZjGS+IFzr52kbwpNCdvcZX3bLlTiniVrrVtR3m
    YCyrLn4d8sGzDNlCfRMK66eTarKOgBRzARYTUPPJhVXMH8mRZMKfqMmHPNhe04aV
    lAbmiDsT7ClqrKo+zuWr3oMwWeKaBUdd5W2gN/bD6Dc/NiaGccAbFF8Avli9GNna
    0BtQw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, John Crispin <blogic@openwrt.org>, NeilBrown
 <neil@brown.name>
Subject: [PATCH -next] staging: mt7621-eth: fix return value check in
 mt7621_gsw_probe()
Date: Thu, 22 Mar 2018 02:10:07 +0000
Message-ID: <1521684607-77277-1-git-send-email-weiyongjun1@huawei.com>
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

Fixes: f079b6406348 ("staging: mt7621-eth: add gigabit switch driver (GSW)")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/staging/mt7621-eth/gsw_mt7621.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-eth/gsw_mt7621.c b/drivers/staging/mt7621-eth/gsw_mt7621.c
index b49ee94..ce8d7d7 100644
--- a/drivers/staging/mt7621-eth/gsw_mt7621.c
+++ b/drivers/staging/mt7621-eth/gsw_mt7621.c
@@ -263,8 +263,8 @@ static int mt7621_gsw_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	gsw->base = devm_ioremap_resource(&pdev->dev, res);
-	if (!gsw->base)
-		return -EADDRNOTAVAIL;
+	if (IS_ERR(gsw->base))
+		return PTR_ERR(gsw->base);
 
 	gsw->dev = &pdev->dev;
 	gsw->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
