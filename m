Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1429261-1526333120-2-4584080080956195682
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roenca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333119; b=fe+AtPzg3F2qx+RllykX3Kn2xMd3EwVSZ8Wiizmy5vt/sJMHUH
    DGjloT0IVfnWncxgi/6zXvPud3y/ZwjHf4+fbnXm285ZWOY85QqirEhxF9Mzu0Ef
    XAcyKGAt/YPf+em6+M+j5LIffouVoRU6soKcZNlK2xd8vEiCmbBaabGAb2ZVBrV6
    VMI7WVclvIH9Myj5DVQd82d59fKEjnj4/k+pClkwM3U7oPUWqde1FGwKKkbrmrBG
    Hco8ypfQDE2G+avHDUI7mtId/htK9xP8xr7o1bZnZVwwwm4s8QJJaqJR8kOnIEuh
    /kZUjPHdi2zffHGi385dtOT7lUWdI9o7QG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333119; bh=Gu1o7
    zAwky+V+r1PNXps+dOIpMJ7RDcOQqZiKk4qyxk=; b=jmyrYmWRlTBnTt26cWGXy
    0txv7PodCnDWR9+yZ3hd2jhPZ+YGCNTetnvSKppnulaAFlHfYeP3wksM4lIX2yCT
    RexclM14/o6A6wkjYC6TTfGSzI4eJAxRwqljTAHH2r6iKw89v14KWxvzShGb4jTp
    5e3dZiC9tIaS4JifPEaR/JLizES3yig3opylLKaEyB6chOyJL4ndq0SsnmwD0NUl
    6GmoLvnq0PKumhKTiRf0bXcDEnH0nOBumYPiHwjwQ2f840oHnM/APKerNdqydtOt
    9jJoW7k/WmsIJ8/qNlOmoKT4CGpp2WzBBdA8wNdPnwVD1MZPGAseiCPogjEl8uF2
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=WYVzDrw6 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=I9K/rhvv;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=WYVzDrw6 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=I9K/rhvv;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGdarXNoQ8vI4Z0BoActp8bgT/Q1bAUEQB+KTJOHpnOqSIeLU/akfO3g0/EOlw28OQfvlAo9sHAQJKBdUZHi2qxl+MwlniIzgWLnFzfrM5tH9ZTEPuwj
    g+Pj+nqqjmQ/l3ZTHDnsb10UT5tCIpuGetyGr/GNJOwDkEEwbIsbW8pfldrhKZxqipmVO/x3rRgagoCU2TaAFpIXhbTvshpesz8fMg+YtjO9D668/e8bRobe
    Bnh5tF2Lhqm9805NF9mA1Q==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=1mx1RCpw9qlm-IAQv1AA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZrhus1nztGjE7+s5tiiKW6lJ1WJKJGXm5/3Op8nm9gw/B/iBu0CkaM8Q1gB8tw7Bm6CMx7A/Q==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 03/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 correct space before ')'
Date: Mon, 14 May 2018 22:24:10 +0100
Message-Id: <20180514212434.17514-4-johnfwhitmore@gmail.com>
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

Coding style edit to clear the checkpatch.pl errors of the type:
ERROR: space prohibited before that close parenthesis ')'

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 065ede61a3cb..d4ab8481ee30 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -122,7 +122,7 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
  *  return:  none
  *  notice:  Driver should not print out this message by default.
  * *****************************************************************************************************************/
-void HTDebugHTCapability(u8 *CapIE, u8 *TitleString )
+void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 {
 
 	static u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
@@ -135,7 +135,7 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString )
 	}else
 		pCapELE = (PHT_CAPABILITY_ELE)(&CapIE[0]);
 
-	IEEE80211_DEBUG(IEEE80211_DL_HT, "<Log HT Capability>. Called by %s\n", TitleString );
+	IEEE80211_DEBUG(IEEE80211_DL_HT, "<Log HT Capability>. Called by %s\n", TitleString);
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupported Channel Width = %s\n", (pCapELE->ChlWidth)?"20MHz": "20/40MHz");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 20M = %s\n", (pCapELE->ShortGI20Mhz)?"YES": "NO");
@@ -308,17 +308,17 @@ u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 			isShortGI = 0;
 
 		      // nDataRate = nDataRate - 12;
-		} else if(nDataRate >=0x20  && nDataRate <= 0x2f ) { //(27, 44)
+		} else if(nDataRate >=0x20  && nDataRate <= 0x2f) { //(27, 44)
 			is40MHz = 1;
 			isShortGI = 0;
 
 			//nDataRate = nDataRate - 28;
-		} else if(nDataRate >= 0x30  && nDataRate <= 0x3f ) { //(43, 60)
+		} else if(nDataRate >= 0x30  && nDataRate <= 0x3f) { //(43, 60)
 			is40MHz = 0;
 			isShortGI = 1;
 
 			//nDataRate = nDataRate - 44;
-		} else if(nDataRate >= 0x40  && nDataRate <= 0x4f ) { //(59, 76)
+		} else if(nDataRate >= 0x40  && nDataRate <= 0x4f) { //(59, 76)
 			is40MHz = 1;
 			isShortGI = 1;
 
@@ -373,7 +373,7 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 	else if((memcmp(net->bssid, UNKNOWN_BORADCOM, 3)==0) ||
 			(memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0)||
 			(memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3)==0)||
-			(memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3)==0) )
+			(memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3)==0))
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
 	else if((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3)==0) ||
 			(memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3)==0) ||
@@ -967,7 +967,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 
 	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize==0)?3839:7935;
 
-	if(pHTInfo->nAMSDU_MaxSize > nMaxAMSDUSize )
+	if(pHTInfo->nAMSDU_MaxSize > nMaxAMSDUSize)
 		pHTInfo->nCurrent_AMSDU_MaxSize = nMaxAMSDUSize;
 	else
 		pHTInfo->nCurrent_AMSDU_MaxSize = pHTInfo->nAMSDU_MaxSize;
@@ -1011,7 +1011,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 		pHTInfo->CurrentMPDUDensity = pHTInfo->MPDU_Density;
 	else
 		pHTInfo->CurrentMPDUDensity = pPeerHTCap->MPDUDensity;
-	if(ieee->pairwise_key_type != KEY_TYPE_NA )
+	if(ieee->pairwise_key_type != KEY_TYPE_NA)
 		pHTInfo->CurrentMPDUDensity	= 7; // 8us
 	// Force TX AMSDU
 
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
