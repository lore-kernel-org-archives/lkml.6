Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1429261-1526333152-5-11912262771359664369
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333151; b=Qz8lBuNUKY6BUKkhCup9ujqHRXPU7z4JNJLSZ8YpJUdNJpZuLD
    az4HzO90rPJRVa49Lk0TY9+tNBEvSTb/k5kjWMC4unJp+4frqbueYrgptTxUW1pD
    7etGCvhXf4YD8fCT2mY5A1avEspKYAZ7pUGUtPEWkCRlxA5/xEbupJ9lzqLbUCrO
    9GmQlRB1IwFamvv2fUO2WqGN80AXF61nXt8J8CghMxDoYEs+lhh2XXeBjkimd8yg
    H5f8z4iK+b/LqRvFHHOVsBI3vXkUVgGrUOrkicC8t8Kymrqk+emazYrEC18Psyxw
    eOmg6H+yySMYEs4UaBDbzmmz+N/31RK7INHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333151; bh=OXk0X
    qVjgfwbnkDZrbjEKBuytNf8pA0K1ITo5mr/bVg=; b=VZY7Lk0YPSsWWjw7Tl2NW
    yJLdMhMWd5zx/yspP+lcourlj1POJejtO1Grn75wnKfr2lPpDImklhQkKUnvQeNX
    VYNKQdMe0PBq/jlQi6eD6eKz6q/z1qdEJ9tfrquAVlW/6ag9f/LuhD6LA5DQ7try
    KkjtGawS1moE7qmex7NhlCgYtssnLpVN8d0vx9LCxPclwg9w8A8aolHeZiLlRi4J
    V8Rw8+SqyWTIejal5/pwloI9x0Sx+A3ybtRT6025CBaaSpPP8RpsiHsrK8H2HBEz
    Vi259H3O6uovwv57w5k62Wa1uHVnE3/VTF1eRlVsxVuyKysIRwiahCCQ6X78l/sc
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=m9bmYdPQ x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=iB+red6E;
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
      header.d=gmail.com header.i=@gmail.com header.b=m9bmYdPQ x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=iB+red6E;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGPELnbGnwV6tuUljFB0++pk3CBUs/eqLwXJorFrpFEPnrO+idxrH21DH+eblt1u76iHHJR6gmhNUYOqfINWWLT4hFQTywGvkn5iGYx3eKy5wtCZ27RG
    BREh7ZCtaUiZngouONEl3xVHZgr2iL2uBlpIaBYciazmK1fL1HlQF0NXIXHcruBBRKiDIPHQ+XWTwdjCVXkQxFy3xWpqxJqVcKl4aHDBiBnSUCQ64WY+7I4v
    SITYhbxErC5b4qdF/lWzxg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=fMn4QhR0HnYZ1lrhpqsA:9
    a=pYT6Gv-gwzbn2ZoB:21 a=qhxAj8EA2QioTKPq:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpYRROOEf/t7mHme0DQL2ZKsZBErQv/pgMRdD0jKfVTomAJ5Q/wIgcshQ5NEx35SrAZd0ebVQ==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 13/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 removed redundant braces
Date: Mon, 14 May 2018 22:24:20 +0100
Message-Id: <20180514212434.17514-14-johnfwhitmore@gmail.com>
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
WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 0cc3e7f18c53..34d319ed5cc5 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -723,9 +723,8 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 	*posRT2RTAgg++ = 0x01;
 	*posRT2RTAgg = 0x10;//*posRT2RTAgg = 0x02;
 
-	if (ieee->bSupportRemoteWakeUp) {
+	if (ieee->bSupportRemoteWakeUp)
 		*posRT2RTAgg |= 0x08;//RT_HT_CAP_USE_WOW;
-	}
 
 	*len = 6 + 2;
 	return;
@@ -780,9 +779,8 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 			//legacy rate routine handled at selectedrate
 
 			//no MCS rate
-			for (i = 0; i <= 15; i++) {
+			for (i = 0; i <= 15; i++)
 				pOperateMCS[i] = 0;
-			}
 			break;
 
 	case IEEE_N_24G:	//assume CCK rate ok
@@ -881,10 +879,8 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	u8 i = 0;
 
 	// filter out operational rate set not supported by AP, the length of it is 16
-	for (i = 0; i <= 15; i++) {
+	for (i = 0; i <= 15; i++)
 		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i]&pSupportMCS[i];
-	}
-
 
 	// TODO: adjust our operational rate set  according to our channel bandwidth, STBC and Antenna number
 
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
