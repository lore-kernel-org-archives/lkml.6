Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1429261-1526333179-2-15972318336596403007
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333178; b=arnEtgzYgCy5g6ZqaT9XePRq21lwZBTZKpC6NNgIfXBtctqrX5
    Xkx0tgohP1prCC+jv+ZqptNzB1zd2tjNbVCk+7wb5ptlSSnIb2RTFEZARF8gzfxG
    RTR1jxOeqL91bks+w8/M0QObzfsAJCFHfcRz49xKd/8bVk7tB6PesMWpo0hWTPbU
    a6uYl+Bpn+EN2AeiEath/RYIOymjBY4HktHUyvfRWHPd8DNmzCao3xo9DVduivkV
    LCeW9kwyVKlvfxJ+DfYYX73TPwyDVO5E0Ck+827e0Cvlj5DLLpHDUbvmATYzIHz4
    KGFWCptr/yI7ssuC6+ble/ZvHb8SBeeTpHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333178; bh=Q+JQK
    XyGzcS9snAs/xR/092emMJH0YpzmCnztXvQ+xw=; b=dJ3+13mGjoD4UNz44V/tQ
    CTNlv+9fNpTPpwXQM9o8MeJ+34IzTloqFAka03FE/JNTY+1ZqQsxDRwZ8ari6n2U
    HPKVN2/HKvCBfbZRyKmGbOIonxC0onvzv2SXJcIwZd6oX37+wagzT0Z66NLPhoX4
    jGYjKp2H4Ghko5zjWsT/bYu5JjuYj0QjC1lBCkUoUBZZlWp5zm1d6ByKhAulnyYi
    HwbB8iLOjYlxanqggUlzLdaqprM1DwQf7K2qjXTFTV/tveqYOxp3HyCSxJTOX4dd
    70x6fpMfu9cU6js4S+fVWcvND8WNalguVuAE6NnNkWY3D3jUQjfzbKm6oDgCQIg7
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=jeM1easA x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=glENjNxa;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=jeM1easA x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=glENjNxa;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBuZX26PdePKnqjZEEImc8ZyHivbrTf4uWMN1f+baURShVumwgWi5GVwIL+MfEJzWAeuGuv7OqVS58HM0DB01QaM15bvniJCVNwXUTZ/xp9ccdoW9K2m
    9syDc1CrzrmmeSarJTdANzPcNlOwcMbQLATj/t1zHhtTmRzSNRGUAR3QocOTDne8Ad8ynhMkq4uUH1J+p7DUgcqdlAHHzS67QkU1RajeUkqd/oxi1ybz0lvT
    WuxtbZxea/77hs8xHlbXow==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=IqqUQSfqgCbYgtyRKFwA:9
    a=ZsneWQNFUYYMe5iU:21 a=2WcPmmP7XXWsAsLM:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZoyhPnyG95nxOhD/VfyGktwwg2GvJDqqGedZc+bCI7E79ufl6Lf8CrXtI0FrpSGovNPu6q8sQ==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 20/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 added spaces around '&'
Date: Mon, 14 May 2018 22:24:27 +0100
Message-Id: <20180514212434.17514-21-johnfwhitmore@gmail.com>
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

Coding style edit to clear the checkpatch.pl check:
CHECK: spaces preferred around that '&'

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index b076ff66bc8f..0eea1ec1b25f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -263,7 +263,7 @@ u16 HTHalfMcsToDataRate(struct ieee80211_device *ieee,	u8	nMcsRate)
 	is40MHz  =  (IsHTHalfNmode40Bandwidth(ieee)) ? 1 : 0;
 	isShortGI = (IsHTHalfNmodeSGI(ieee, is40MHz)) ? 1 : 0;
 
-	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate&0x7f)];
+	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
 }
 
 u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate)
@@ -274,7 +274,7 @@ u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate)
 	u8	isShortGI = (pHTInfo->bCurBW40MHz) ?
 						((pHTInfo->bCurShortGI40MHz) ? 1 : 0) :
 						((pHTInfo->bCurShortGI20MHz) ? 1 : 0);
-	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate&0x7f)];
+	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
 }
 
 /********************************************************************************************************************
@@ -316,7 +316,7 @@ u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 
 			//nDataRate = nDataRate - 60;
 		}
-		return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate&0xf];
+		return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate & 0xf];
 	}
 }
 
@@ -855,7 +855,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 
 	// filter out operational rate set not supported by AP, the length of it is 16
 	for (i = 0; i <= 15; i++)
-		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i]&pSupportMCS[i];
+		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i] & pSupportMCS[i];
 
 	// TODO: adjust our operational rate set  according to our channel bandwidth, STBC and Antenna number
 
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
