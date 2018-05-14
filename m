Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1429261-1526333157-2-9603804168794300783
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
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
    1526333156; b=STY9Ap4Mlk/WCUweJpCHNgY5jj1n3EJg/+WQ0TqoQ9ostZh73d
    Nd1n8fW/foSunrjhXobk3q0S5GIx5TAoDCnWGuDBqxJADtVbm/wwJ3lk04jcZhQZ
    4VGAzP8LXQJn9nVHvNSmJ0wsJPdyYJekJ2829bWukbSqmvoGv+ohyc3ZmMPpPfcX
    gbwZTnio7SrbUtKc3Ue4hO4jp6t8wLimh7ABxrJA9yvvzcVnt7g1dR+PHeUUxTKW
    7SB5yQkycleHNPvOnFnCriQtz883FrP3j2lrvUPIAevma9i2wu14WP6b4lYokBAD
    lbkMd6aS7dfcWdL/GPNpVMgvLDTiNk1PPglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333156; bh=f+wsP
    ZyWSgtLmmXv5poe0WJyAjEfQ8/1NvfYq+r8l0c=; b=TL61viOuRRUnQ2hKufDfC
    Z//f+jXzwTkkEjyF3pV76GrIEJjZqMoNBhi2JIMHbWlR/bCMralDq/MrHfV/V8Ii
    WIYOcRatK+kRFJDV5GQJekr7P7kVktUovokl91l8KAgfw+AqGw6WVb+rFVuo6Z2/
    4nmMMmH/9p+2zuT09hOlUNp9FGbubljnY6H7EL/NPsKsPqBNsPcs1viFfG+XzAuR
    UaWfuKnSDIbxPdpVGp3Nrwux6iyjazdUXDpni3cLcz+WTVVKUHB3N+SZ+tWNB+Yi
    Cvl12SNUCpov6Y6Qul1lbQnnurtTCTXY9Zl2hR3f6m8zOCaCuhNX7bl+vj2iOrUi
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=jt3M7spI x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=QAB0EkI0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=jt3M7spI x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=QAB0EkI0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF4pAHYuHC6Ht0jU70C1WLIO8Ql0IEzQJzREYvLCyv6gJ+qbD1lW8LjHPl2hXDm80G/qTdYYKZU3tcu9KRfBEcD6FOWXvMjrz6QTNVeKcLri3hbF8r0W
    5Jzr+TgwVBOTayLDXr8RisDYshxHFpCUfBthCAi8VEFpccizJTU5CcsO0TPR8MZ5Qx0AoraOhgS+jzR5XfH0JH1h6lrNeLYfDUgXndYXIca4AANNUoeA3/U+
    bcFoESpehyrwNH17U0aEFw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=ndpnUl0PqxmXaaDuWOgA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqCDA+LSUX9JPhZKNhmN1hReyiw52RNoSTL7D+x8baF/O0lYh2CScXfJ5VXA2bHhmq7xlOQNg==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 14/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 corrected block comment style
Date: Mon, 14 May 2018 22:24:21 +0100
Message-Id: <20180514212434.17514-15-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180514212434.17514-1-johnfwhitmore@gmail.com>
References: <20180514212434.17514-1-johnfwhitmore@gmail.com>
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
Cc: kstewart@linuxfoundation.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, John Whitmore <johnfwhitmore@gmail.com>,
 colin.king@canonical.com, tglx@linutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Coding style edit to clear the checkpatch.pl warning:
WARNING: Block comments use * on subsequent lines

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 34d319ed5cc5..3a636807226e 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -721,7 +721,7 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 	*posRT2RTAgg++ = 0x4c;
 	*posRT2RTAgg++ = 0x02;
 	*posRT2RTAgg++ = 0x01;
-	*posRT2RTAgg = 0x10;//*posRT2RTAgg = 0x02;
+	*posRT2RTAgg = 0x10;    // *posRT2RTAgg = 0x02;
 
 	if (ieee->bSupportRemoteWakeUp)
 		*posRT2RTAgg |= 0x08;//RT_HT_CAP_USE_WOW;
@@ -731,16 +731,14 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 #ifdef TODO
 #if (HAL_CODE_BASE == RTL8192 && DEV_BUS_TYPE == USB_INTERFACE)
 	/*
-	//Emily. If it is required to Ask Realtek AP to send AMPDU during AES mode, enable this
-	   section of code.
-	if(IS_UNDER_11N_AES_MODE(Adapter))
-	{
-		posRT2RTAgg->Octet[5] |=RT_HT_CAP_USE_AMPDU;
-	}else
-	{
-		posRT2RTAgg->Octet[5] &= 0xfb;
-	}
-	*/
+	 * Emily. If it is required to Ask Realtek AP to send AMPDU during AES
+	 * mode, enable this section of code.
+	 *    if(IS_UNDER_11N_AES_MODE(Adapter)) {
+	 *            posRT2RTAgg->Octet[5] |=RT_HT_CAP_USE_AMPDU;
+	 *    } else {
+	 *            posRT2RTAgg->Octet[5] &= 0xfb;
+	 *    }
+	 */
 
 #else
 	// Do Nothing
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
