Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1006072-1526313272-5-5240333165846054432
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526313272; b=lvzEikc4AnyhkqaAvzeTJDCpC/q23CX3CtZheASDmDngzN7CrB
    FM9eo4QqadzApMFlARTzTX3FJtDgPyfyurCiTfPc2+RBuh8KAF+kzg7qWbE/7G6t
    QAikTrrSDFQxdhf/nzr2ae0RBg2GcsQnTpW4wnFaPkb8UNX7ZQNi7k5ar1ghJpwq
    9VYLejNamZM7jaZYoFq3/DmOl5aK/zYWSzvTS0Nh+F5JfiAROr1ITKqTwoXTRqqc
    eoXNvuaSX//3AXBHmKl3am0F7Q8pPRqq9GNnCsYQlfBfHGTcesJ0MxUk7hUfNJvm
    T1zCof1wenYrorAZqm2k6fcjZ9W/0agv42Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526313272; bh=KIOCn
    FR3aY7VgdwuMBMFuKKinYL8FDbdMiz7bHjlSw8=; b=eabeBvkx7huUXEo8Pkyyl
    IXc2ipcI8eaqJqKPvr4Gy8psdPeqEI3iKFLu7a5tMB2c4z/Iv+emCFH+0R42+RfD
    Y23Pl+bSDzqdKQZ0+vEonp4od45ImDYrKbJxA3asOtS+qTQyzJTERH+gQS1/JuWc
    3/roLLzH1QhkgQwyaLvKkM+HRdyjmsHiVPrA6FFv80MLq7OUrZIkFSs7NtWQVRkV
    GtVIYs3jR+wDk0BB1Jrp2hy8wcwFur5Q+wK8+HgMWAEnTqdvNyxFsqdq4eLJxxCO
    l8+Bdc5uV6Hk7HZDrwez45hfKy+v8Ow016rVv16k2znwPwC5wUMeFCi/a+8ue+Kz
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=oqj749gO x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=S6XyOt48;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=oqj749gO x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=S6XyOt48;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLK/2nWBqd7DeiDKV8c27/EDLLiL7Xp9SulnuixK/Salb7pC3FciQ0Zjp/cqFR33rFM/kOkBLsUA2XBiZ/xWLilmY9LVSVPDs/NIpucoAWAVgK7RDlbO
    P5QR/tD+AEjGengSvHPl7cLA4KLRLiAAbNRWZLZgPdoJxwD0T0lZM5O6+P75iv0fth1iCyM0xu15Ymns+WYNx9fK2IFMF1iCKdEnR0XPp9X8tyqM4nIntcUx
    QzzHWM6c5iBZfCdFAG/2vQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=26EkWuy_hZEYXS-WM60A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZrGN33pd492k9WSTfUelifZugny10fXD46ig2RtG5aanaFDZna1vpelz4kXbySH+5qmP5CUwg==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 10/13] Coding style: Removal of prohibited spaces.
Date: Mon, 14 May 2018 16:53:15 +0100
Message-Id: <20180514155318.32195-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180514155318.32195-1-johnfwhitmore@gmail.com>
References: <20180514155318.32195-1-johnfwhitmore@gmail.com>
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
 linux-kernel@vger.kernel.org, johnfwhitmore@gmail.com,
 colin.king@canonical.com, tglx@linutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index f26b01c56d66..25db009e0a37 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -482,7 +482,7 @@ static u8 HTIOTActIsDisableEDCATurbo(struct ieee80211_device *ieee,
 }
 
 /*******************************************************************************
- *function:  Check whether we need to use OFDM to sned MGNT frame for 
+ *function:  Check whether we need to use OFDM to sned MGNT frame for
  *           broadcom AP
  *   input:  struct ieee80211_network *network   //current network we live
  *  output:  none
@@ -547,7 +547,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
-		pCapELE = (PHT_CAPABILITY_ELE) & posHTCap[4];
+		pCapELE = (PHT_CAPABILITY_ELE) &posHTCap[4];
 	} else {
 		pCapELE = (PHT_CAPABILITY_ELE)posHTCap;
 	}
@@ -650,7 +650,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 	}
 
 	memset(posHTInfo, 0, *len);
-	if ( (ieee->iw_mode == IW_MODE_ADHOC) || (ieee->iw_mode == IW_MODE_MASTER)) { //ap mode is not currently supported
+	if ((ieee->iw_mode == IW_MODE_ADHOC) || (ieee->iw_mode == IW_MODE_MASTER)) { //ap mode is not currently supported
 		pHTInfoEle->ControlChl			= ieee->current_network.channel;
 		pHTInfoEle->ExtChlOffset		= ((!pHT->bRegBW40MHz) ? HT_EXTCHNL_OFFSET_NO_EXT :
 											(ieee->current_network.channel <= 6) ?
@@ -968,7 +968,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 
 	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize == 0) ? 3839 : 7935;
 
-	if (pHTInfo->nAMSDU_MaxSize > nMaxAMSDUSize )
+	if (pHTInfo->nAMSDU_MaxSize > nMaxAMSDUSize)
 		pHTInfo->nCurrent_AMSDU_MaxSize = nMaxAMSDUSize;
 	else
 		pHTInfo->nCurrent_AMSDU_MaxSize = pHTInfo->nAMSDU_MaxSize;
@@ -1010,7 +1010,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 		pHTInfo->CurrentMPDUDensity = pHTInfo->MPDU_Density;
 	else
 		pHTInfo->CurrentMPDUDensity = pPeerHTCap->MPDUDensity;
-	if (ieee->pairwise_key_type != KEY_TYPE_NA )
+	if (ieee->pairwise_key_type != KEY_TYPE_NA)
 		pHTInfo->CurrentMPDUDensity	= 7; // 8us
 	// Force TX AMSDU
 
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
