Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1088159-1523410453-2-11434841866628852982
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523410453; b=IGw8roAJFkJaDanOzOD8Hc9zPh+2+w0o1EyA8Wi1O3hgHr2/cn
    /2vFUQqOqk55qWw5xsvY9hVepc8Q3dSbwRlVekLjiV1XnHS61ytCqtdwsMddYVHV
    Yqf+ozGMMtrFpVa2LLtBsvuofXHYe2mXNCM1H7wpC71cGMLiicB8kbRj/CHRnBly
    i7X+wIgJQ5Dfn/3NhAMhzIgIkJd58nxp1pPJkvitirLL4eOWcBKrylzNXWbnVsu2
    P3Mg+ypvDIJSPzhoaUYmD2cCkIhxyqk2NxCtbFrG6tO/D5zchVVaezmd/yQAbAQn
    ckylk4/MLseUXoosAH/QyVkUsnoZusultQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523410453; bh=sAg6c
    uvG1PX4ZpG0z/Di7pTEykp4l1poy6XXlARZRas=; b=iuxVVXRz5VSg4P49+uQh5
    6kl0eaJK2ML0nJRLEaLozfiW4g6VMs5lUQSKTzwTHVTIHzSdqsCYzmrVsNJUqxeK
    VLMh0BEI/gQF9UdEP+ton0IS5nZDiOQeVaeStPj/C/Sqjdix8rjoKM4U6/hzVSiw
    p7JItfv6BIs6YmzJtPZR+sZIMgxAhUVDqeIoeQg5cW8lCE8ou1mlm3mjDwAys32l
    x0QGMwL1saIsEEZKWuDUrH3Wm0RTrhgevaTH+onSyK5O7Q1D1Y2Irs4MmTBvKW5w
    fC1Q+8Dx/WfxMKQDeRnW9VNQdHzqstC7vfoLZl5gKiMn37gCJEUPNDaOG6yE5cQa
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kxIDnjGs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JIv1biAF;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kxIDnjGs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JIv1biAF;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEVoch8NIy/EUfKllK+I8MKDlrvCy/86EphbeWRJjxFa6tYa7ZhkwKnArmUM3iC2PUFe1DhAeb2A1qJZQi7ezm90DUEEY7l13AbAD4nCkjXoAmNA+RUC
    SVx1WueEfJdG9DZC6/86cTGFSBJj1foBhRZjCEZwWFNgIhQfK63wo0prlCPnGc2B9a4agl9us7z2s50AEyRAhriA0v3pkoXlzmR9p68gdn1me+YAZcO/S9Id
    7zBvvCwfUBRNXlJQeo4Xbw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=tmjX-nCzVX8A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=BaufZ62Zk1JhIVNeUt8A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/XlMUXd7+xNb86oWo+X3VZUdxRXb/xM3MnQwNfgeySgeeQ66HPXT9YUcCBgBl4TA/G2WU8Iw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: samuel@sortiz.org, gregkh@linuxfoundation.org, davem@davemloft.net,
 johan@kernel.org, arvind.yadav.cs@gmail.com
Subject: [PATCH 2/2] staging: irda: Replace mdelay with usleep_range in
 irda_usb_probe
Date: Wed, 11 Apr 2018 09:33:55 +0800
Message-Id: <1523410435-1693-1-git-send-email-baijiaju1990@gmail.com>
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

irda_usb_probe() is never called in atomic context.

irda_usb_probe() is only set as ".probe" in struct usb_driver.

Despite never getting called from atomic context, irda_usb_probe()
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
index 723e49b..6ff5b08 100644
--- a/drivers/staging/irda/drivers/irda-usb.c
+++ b/drivers/staging/irda/drivers/irda-usb.c
@@ -1710,7 +1710,7 @@ static int irda_usb_probe(struct usb_interface *intf,
 			pr_debug("usb_control_msg failed %d\n", ret);
 			goto err_out_3;
 		} else {
-			mdelay(10);
+			usleep_range(10000, 11000);
 		}
 	}
 
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
