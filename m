Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1006072-1526313270-2-3225995672418697233
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526313269; b=Ssp5R6cbL3WdV/W+eGYKLt6pmuiGJ1k5Kp6dQBsokABjKFfON6
    2jcOOcz4HtUHmQJxz3M2g0+KfqiGH0ZnipiTzL9SDWU0dH4H31JcUa3j75v27Ax3
    mzdjk9lbXgs6OzwanMg+w1sIICMGWeRrPFPjb37iU3j2pdGiPZCkoWCttbkxyEg/
    8AjwDU+Othxpc/JcDQ7vDMVOSpMDqa+dkrGZQT/1VhS9Is9Li7dlsgbOplbUCuGt
    ax6yCWvKIHfG8+fM80Lv2zSafjpUBnzxRG77QXhGWxrfmR6NZ9BLw206VEuw24+q
    /y/CUYnCIBdgobmi32r8dQwd/LaDEEOpchFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526313269; bh=wf9vW
    ryX6Cb3CDN4aob2emapocCRTrQnWGSmDpYSplw=; b=H1h0HDc3srYdcDnsvCtY8
    C+xNZoU23+H3GqvdwrNnHLKmMOE+g6BglXrp4cInJeC6FamHV+4B6/TMJnW7Iloj
    baPl4/bYpdit296kgRAoEeTrm3jfhDBgnDElV4aAkgdB4thvs60szCtP0wPNC5by
    SkaRHVSeX+rgbG/VsHzC/4Prb3qACNAfOCFmQepYiXn67Fp8Ko6gEP6I6ALGh659
    sp22NsqLoFHodxTgb+gDY6rUemNfOldQi5ojMNYtIDR6Xy9LExAqWed+MEGxip1g
    OI9zkJkK+arrqzZRkzkZiIQkjCBPCTrT6CVdVrkq0vLHBTO4oAZLIVORbKs3Rhpm
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=G/5/AUQD x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=eb/YvtgL;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=G/5/AUQD x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=eb/YvtgL;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFAYuy5+PnbesgBNGtYcMVcXP201/0I+mBAXuMxsmVLJksGXCdQ7TPbrUfyH8AXf0APq6BIgylwBzfYUgvo+KklvGPJQfrBOGnAYHClWb072QPyUHFyc
    ubgT91SghQf4zIL2f+gRiAdlEreb6fRvMsP2tAlTeZGJHJqvMQ4/AWq2FyoKrwrt37NLxgjNRBe+kEtuUj9D0WCqMJxynEy/5+koR+XG0Wz3YSpfH/okxprX
    hJi3B6Mu0tf1xLNr5u9exA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=PR4BiYExFYcBjYYXJgUA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqLYARMm3wW/aMg8PqRC0K/byBasf6mowVNnO0m/ufePCHCpi5kOqc/szG4QgIZr5sf6pdEuw==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 07/13] Coding style,
 removal of redundant returns from void functions.
Date: Mon, 14 May 2018 16:53:12 +0100
Message-Id: <20180514155318.32195-8-johnfwhitmore@gmail.com>
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
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 13f1eee7d8b1..56cc1192cf9f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -150,7 +150,6 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMPDU Density = %d\n", pCapELE->MPDUDensity);
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMCS Rate Set = [%x][%x][%x][%x][%x]\n", pCapELE->MCS[0],\
 				pCapELE->MCS[1], pCapELE->MCS[2], pCapELE->MCS[3], pCapELE->MCS[4]);
-	return;
 }
 
 /*******************************************************************************
@@ -214,7 +213,6 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tBasic MCS Rate Set = [%x][%x][%x][%x][%x]\n", pHTInfoEle->BasicMSC[0],\
 				pHTInfoEle->BasicMSC[1], pHTInfoEle->BasicMSC[2], pHTInfoEle->BasicMSC[3], pHTInfoEle->BasicMSC[4]);
-	return;
 }
 
 /*
@@ -620,7 +618,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 	//Print each field in detail. Driver should not print out this message by default
 //	HTDebugHTCapability(posHTCap, (u8*)"HTConstructCapability()");
-	return;
 }
 
 /*******************************************************************************
@@ -672,7 +669,6 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 	}
 	//IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_HT, posHTInfo, *len - 2);
 	//HTDebugHTInfo(posHTInfo, "HTConstructInforElement");
-	return;
 }
 
 /*
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
