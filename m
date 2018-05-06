Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2920666-1525592026-5-6556361351685397569
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525592026; b=NoBGoAboFu07PbBQ2WmIRBfeNU6kYPNDsl6AwhIDtEeEDf6ZOZ
    TmL/6zXXTgfCiQdxoiyeomRB6EyPupZRKoaVwHL7TpwoNXEMykCqXime4ndfm0C8
    rS/NRGhJCJgKZkYxetxO1H4lELGk+m5YpaTRazF+2yKAdevOJFzMCuUNLIIIIiWK
    acRGBL9YEGNa9zlTz8TJ2cYTG/s3EjEbH0rn/auv/eFvD4SbwZZcZs+PO5o+Zmlm
    msHFO/NA87xweiv3Bg+ASoZSEivY5ulldFlnhRfkirmPy6bOBM2tEu5EfhD1lAgr
    xS113iMHYS50D01dZpyzRXnY/m/pnU8BQjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525592026; bh=ifLxG
    cvRloSj/GXLpdgDFCizAf3ZxLmH2xZHUMBrozY=; b=To/tmLb0cazIXY8Aspx15
    xYiGhLBBfumAogP+A8cDxz1nH1yInF4qYrkQ7Rl7v3XdubmgERW/yZEcWPdxIiIM
    swd8ndX+QtwPzh95WpIzHS7/UFF6A+KttraznAiPxo+Rzlg7mdwLZunhwxLo6MY+
    ewUSPUCzrsrbeM2/zFB+6zbxu29WBkeqAOTq95tBkN7zxQ1NBu2h4940rSJI07t8
    pXk+SdHdh59aGAs+Y/UYH+ngRvqJlm+jb9ZBR/4cfiOWbqCBx4F6fRWQY8CgoiEZ
    uQ76++GhMAYXjPSyrmcS47PTKGGBBY3S2bIFBfaIaK0kULsqg4OiDcDvvJDPqDOv
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=NsWGfB8C x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=AJvft7hl;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=NsWGfB8C x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=AJvft7hl;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGclrjJlaPP07mDmeNdVhzEpQMAULAGrcfRvgo1aetLA88Q4FijrYCPscD/yP+Yt8/Rsvb2Vcc9NITrff/guKJPu6kOG2GvjiEhfuS/Xqbew4slgpILE
    kK8pDsZ84wDFmmE/oYpOVz2vM8U0oc2h+OQZlTiejPf+/+NhRDwPlz1GNs+YcH4dM32LBeInSVa2br123bkhIgMAKZCTHqO2RxXG8iGipkgiqLHEFXtuFqAm
    ORLvnE3cBVa7yMkywYTGpQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=et6RZJVh8K29cVVBWrIA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZos5+uMnKxwzZT8kgdg+GcTnKvuciwOXXUxOktB4Iir8Q64cqthVijVH8F4bJ3uVdlL0VAGJw==
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org
Subject: [PATCH 3/3] staging: wilc1000: Remove unnecessary array index check
Date: Sun,  6 May 2018 00:33:33 -0700
Message-Id: <20180506073333.3770-3-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180506073333.3770-1-natechancellor@gmail.com>
References: <20180506073333.3770-1-natechancellor@gmail.com>
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
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ganesh Krishna <ganesh.krishna@microchip.com>,
 Aditya Shankar <aditya.shankar@microchip.com>,
 Nathan Chancellor <natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This statment triggers GCC's -Wtype-limit since key_index is an
unsigned integer so it cannot be less than zero.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
index b499fb987395..e0015ca6c21a 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -1054,7 +1054,7 @@ static int del_key(struct wiphy *wiphy, struct net_device *netdev,
 		}
 	}
 
-	if (key_index >= 0 && key_index <= 3 && priv->wep_key_len[key_index]) {
+	if (key_index <= 3 && priv->wep_key_len[key_index]) {
 		memset(priv->wep_key[key_index], 0,
 		       priv->wep_key_len[key_index]);
 		priv->wep_key_len[key_index] = 0;
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
