Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3765319-1523363078-2-15373492466126266532
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
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
    1523363078; b=BTtaLspiZNRCnNhOjlZbYgqPFt/clhV6kgdiB54GD4bjf6HNmA
    yfHicHt22hGauMoBg9+NxFzKrojVl9yOcuPDQIeLz6tm2F3wbY8s84Rax8YdPnXL
    keeNk6F/DKt7bEwO94tH7jRKvaQ0c3F1jyQcK6RlppmLugEJfGO/RsU0aouLpsJR
    hVssNml8XEWIl2SU1kyX4attxggISBAM9KrwNqH+RYzkoM+Qr7OEuVVhQCpYhsM4
    eUhyXAlFesdf92IgjRHEBbxyERTFxFVVLrj4MNnXrJ6gX72Tc2Vd0LtEEyJZRkzl
    p2LUDKwSf+P5N3i1rDD7X3xWL3xbj/Vd7WQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523363078; bh=02w6F
    oPZiN0btNO4AvZ26a0K9uZxmOP1R2hqp5fCnzY=; b=vKlofuJtVrbMkKO4TnmVz
    Xd3Xim42lrK8wEEoI8+TFW8r6oHM0xc/FkfXpCefy6xVONF9o3cd7VCRkXE1QeBn
    cZGthu5VjFkniFmEYX3p6NbU5T4xlusYZCgMxEIQaVNtR8QDIA3Z0m7zz+5gfoRx
    SetfNAl74pmCFiJf6M3BIkfIWLp5rc4Hjoqy40Q6XdiPgtjQsdVVFd7d1av2dtBb
    BOStZ71jrDoDnryR31TcUNvnnyn6x6jWXxtiY6fZt/wZetrFHb/c/lcFq0WkoH7j
    83ZmM7vMn43jVQ4K8LU2Zv7n9aL+8l+kz7dJb4TyQGfO/ApLIXgtWzVIxgt7TnrS
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IXyMjKsD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=B9cZ0wU6;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IXyMjKsD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=B9cZ0wU6;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI1E0iqnndc0FSy5NixFYF1rkXSdpjX3YWUn8WAsYSCOq6bMGcsAhv+JoKwoA4AsVgzHCc0hgOeMkSBirncQh42e+cUHDkc/iSiUDRlAo3KcSN8LIxWd
    es3klgVJAUChzRzpLkekKPKjL6RVgM71rjKAFXl5VXeRUKI+CbvorJfgLJ/x08Fp3VcsH2dAUSpveIOvEy4uFk21xhfpkZmhMLNTqchyojVref7CQdOMTgtJ
    ggZQp5hBOvmVeMR3HBycSA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=tmjX-nCzVX8A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=v1HGfOFxJQX3CYJzu1EA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx491HKnomffWS3JxA/dQwiTwoAwcRq7EDKmyEdYoBccaQY+bON8V9zGNhEarwJiwLFJg+0T0ew==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: gregkh@linuxfoundation.org, davem@davemloft.net, johannes.berg@intel.com,
 Linyu.Yuan@alcatel-sbell.com.cn, stephen@networkplumber.org
Subject: [PATCH 4/6] staging: rtl8192u: Replace GFP_ATOMIC with GFP_KERNEL in
 ieee80211_softmac_init
Date: Tue, 10 Apr 2018 20:24:23 +0800
Message-Id: <1523363063-30950-1-git-send-email-baijiaju1990@gmail.com>
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
Cc: devel@driverdev.osuosl.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ieee80211_softmac_init() is never called in atomic context.

The call chains ending up at ieee80211_softmac_init() is:
[1] ieee80211_softmac_init() <- alloc_ieee80211_rsl() <-
    rtl8192_usb_probe()

rtl8192_usb_probe() is set as ".probe" in struct usb_driver.

Despite never getting called from atomic context,
ieee80211_softmac_init() calls kzalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index fe6f38b..cb4a2ad 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -2682,7 +2682,7 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
 	for(i = 0; i < 5; i++) {
 	  ieee->seq_ctrl[i] = 0;
 	}
-	ieee->pDot11dInfo = kzalloc(sizeof(RT_DOT11D_INFO), GFP_ATOMIC);
+	ieee->pDot11dInfo = kzalloc(sizeof(RT_DOT11D_INFO), GFP_KERNEL);
 	if (!ieee->pDot11dInfo)
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "can't alloc memory for DOT11D\n");
 	//added for  AP roaming
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
