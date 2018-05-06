Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3800236-1525644198-2-7570778680603019125
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525644198; b=crOrljHwKUitRpr+6nFZhH7qAsEZ23oMRgdFvDp5oc73lzvZyM
    tpcBEWGBV6iXddPH5PGxt1kDGnec1m62esCf2c2r8pfiDDv/MllNvOom1MWV9Svk
    BAqpi6i/GYNbWCPByahsIeix+E3nPlR/QdxledfzY2efdgPDLMfjjlowgFSO9t1h
    gYzz8mLpf/W+68MZZlr3G3Z2cCJr5Bj1CcMz1h699wxwO4YLoULgVezpfO6O2YLh
    7fQ5nKsJsSdnuZJemR9vqy9Me7kSDTjaznk1bezXHuXXUuxgiBZRZFDVK7p5uCM4
    K2thBSGUIKUypR8Bo//m4++JYlCVrxcmlrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525644198; bh=dKvUU
    MNpej5K1zzjqX0XQivN+KzPcvMOqEKxdYHwiIc=; b=NkNCrnLotcmM1ToBaCvE/
    cWEtHWb7aW3bRJLcgh3kmlZRE8bELskVTc6V/dcInxaClYFO+6NFiJBSPwCl/aP0
    dWZWw2GWvgKEI3IZ8RBTll3lQZRKehUqRGXRZXRad7yLT6XyHFWKvaQvXnfQBfph
    v5bJ9yrFMrL7SvLH+8f1Yh+XKOKX9xWiL7kqPA1y25GHJxhrTIwbqf7R7ZysnnV2
    wEFv4UGFFwoAO57uoB8nyuGx58Fe6bkm45XfIvA3wMOReY8x7okXal/JUS2Pamo1
    RZtNFu3u/sEdmPQQLI3/dQ5myTneix8Kng3XZY2Q0sdQSQT1mJmg58V6ZvIHSbsj
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=Jai1TQ6h x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=GGcUGbkg;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=Jai1TQ6h x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=GGcUGbkg;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP8OpXGAvfTADEbYHNlMbUNMMXGxkl1X2bEMO28QFjfjnks+LjHuU38m0aAYyGBQXd4SFEt5l/Jk781yYddU+DsGNDgofwzmxq+DtjFFzJs8YxxT1a7X
    AyituNN2b/I1R1qYt3ph9YaQsrFDK185VJ2tySSs3g6MyU5+EaE43M9JQe5dh5r8ARwHYtEzKCH5bJnakyeAvVkbpH03woMzw5P2GrowxUWI2ABnaESxE+wx
    mGd+OxH56LDMGZs24ZC4rQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=fv-7OBe3yHGqfDU1zT0A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpgF1WArHHgDHpsuQUB6udbfwBo3GAQw8Zw/UMmDxy23DlPB9J63AwCjwpT3i+B2kc59fh7Dw==
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org
Subject: [PATCH 6/7] staging: ks7010: Adjust alignment to open parenthesis
Date: Sun,  6 May 2018 15:03:03 -0700
Message-Id: <20180506220304.13040-6-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180506220304.13040-1-natechancellor@gmail.com>
References: <20180506220304.13040-1-natechancellor@gmail.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <natechancellor@gmail.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes a checkpatch.pl warning.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 094f8c11b4ab..628171091786 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -732,7 +732,7 @@ void hostif_scan_indication(struct ks_wlan_private *priv)
 	priv->scan_ind_count++;
 	if (priv->scan_ind_count < LOCAL_APLIST_MAX + 1) {
 		netdev_dbg(priv->net_dev, " scan_ind_count=%d :: aplist.size=%d\n",
-			priv->scan_ind_count, priv->aplist.size);
+			   priv->scan_ind_count, priv->aplist.size);
 		get_ap_information(priv, (struct ap_info *)(priv->rxp),
 				   &priv->aplist.ap[priv->scan_ind_count - 1]);
 		priv->aplist.size = priv->scan_ind_count;
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
