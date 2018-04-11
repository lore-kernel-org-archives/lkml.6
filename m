Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1082032-1523410191-2-9303666933000473766
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523410190; b=BD26ReRupigymp4oWz6hljuF6nrU69EVrXyhwuhfl/dLRAz4VG
    mNZSlAPqG1YbMEKeMU8occ5xic3P990ShrucCT5gv2/hpyfQgrtzrkUax+ljMUjW
    v5FnRjZdviWpFMJD0+6IL7lveEzavD4lad0Z6ReGVVNd5WWxbLI3YJ4tAKHX/o5Q
    6STmZi6DJ+6LxLm3quCQ1cYew8yQWK9cLFNKrxxMsnzt0Kcgkksm0BlOe4ysvbIR
    TAVx6aa8yjvU5Yvp+IsUuvcfP7F7WErBaEEcgb79eXfk3o6kqTQ220/NFsfzRR8A
    vY4JNiPKwlTJy81ncve4Ic4WlDA3LXqmH0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523410190; bh=AWjQQ
    hzqdzG8RVVYdvfCXXalqgIigJm7SUDWdl5WziY=; b=tzkIUoP3tBHGNzFWKQ7fe
    mxFN8aer28Udaru3UdmhoI0yQenKRUqB1/41HXhaqSCtJnuUUXYco3rb3Y2z3mFy
    Mi8BQ7nJ7iuFSVPb2mMwPFQ011Niwwnx2Vonm/DngiSskS7so8cSFSiSb39uN8Ma
    ThG+2Qta0zzO5L/hNVDfZE37GCgr8DTMd2PiX9ObidfdFFcNl9HmlBut/PtLTzwq
    NKUPgCizLuWGsgmUvzSZmxV821HaYETZsAvmI6cvG75GCY76lwfculwDoxM9WAz5
    ASPoLoCGOBe4ebMtpmaDfg09UZftxT8lO4TE7WCOHtsE1zeMBXhTUMC65i88TbU1
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bQdYFr0v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sTat+gKH;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bQdYFr0v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sTat+gKH;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF6Ij79jt++B8utd+BGpEOg5xkDAf3yN7vzzMhcGuTZvG/FTk2q9SIsRko0QCezYLRHLd4MV5bV4VPZGWtbsEEzmE2x/qCUJ6SDBS2/yIM2aDZLthly0
    rsj8+lg9mMg1Oa0uEibUV24ozZG4RrlcHHZMBO0PZHOVeh011YCwwGE8Z57Ya7AM5JBIixi99ZTKgzzUiWSmeZY6wdVViy6Io+IuAcTpa3nLfr08VbymYyEI
    uANdCxpzfKVhzed9r12haA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=tmjX-nCzVX8A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=BaufZ62Zk1JhIVNeUt8A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx48DVyXCSFkikuxIW40UAzOuXpYvT+IATkEsq6LLNWSWBfgMlAHN1WyNwLH6ZgO9fw5gS5JGyw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: samuel@sortiz.org, gregkh@linuxfoundation.org, davem@davemloft.net,
 johan@kernel.org, arvind.yadav.cs@gmail.com
Subject: [PATCH 1/2] staging: irda: Replace mdelay with usleep_range in
 stir421x_fw_upload
Date: Wed, 11 Apr 2018 09:29:34 +0800
Message-Id: <1523410174-1553-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
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
Cc: devel@driverdev.osuosl.org, netdev@vger.kernel.org,
 Jia-Ju Bai <baijiaju1990@gmail.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stir421x_fw_upload() is never called in atomic context.

The call chain ending up at stir421x_fw_upload() is:
[1] stir421x_fw_upload() <- stir421x_patch_device() <- irda_usb_probe()

irda_usb_probe() is set as ".probe" in struct usb_driver.
This function is not called in atomic context.

Despite never getting called from atomic context, stir421x_fw_upload()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/staging/irda/drivers/irda-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/irda/drivers/irda-usb.c b/drivers/staging/irda/drivers/irda-usb.c
index 723e49b..c6c8c2c 100644
--- a/drivers/staging/irda/drivers/irda-usb.c
+++ b/drivers/staging/irda/drivers/irda-usb.c
@@ -1050,7 +1050,7 @@ static int stir421x_fw_upload(struct irda_usb_cb *self,
 		if (ret < 0)
 			break;
 
-		mdelay(10);
+		usleep_range(10000, 11000);
 	}
 
 	kfree(patch_block);
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
