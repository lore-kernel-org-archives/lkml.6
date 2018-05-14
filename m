Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1429261-1526333151-2-12131500640081857652
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333150; b=OFuHmRhNo+/vuw8Qu6xOSrVKBTfb8wHbzmAV6F5wegTgo63uyu
    6gYsz4dzU85wUaGuLI2o8LSfyZ4tO5lnWUduT5060XQUYt/aAGUWO+HGnUQPq0Im
    QQSCo1QRWqgMO/GvulkDXhpwwpTlJuTCLNNBQKMZl7kxxAarF6mmhjoFOg0Lu67J
    u4tyOyII7unqhn3LxiLwTjaHzJq3OgP2HlWa0ChCaLFaWhSwW3vmpncLsVzS3TIV
    TAtdK0VvUi2H7maQjb7cSOqQxV3HeDY2XnKrO4UiRuNpZ644GdgYikS2s1TpAnmc
    FcjR7xL6ikcJ7GSTlg70CmllmUIWSAJDnv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333150; bh=l8MeV
    3lkj1pZD5SSlmg9Dlrb53hc+oHS5vvUUj7G9/s=; b=DD/EyWBQIrqIxdM3ZHyzK
    lfucXci5fM8LGumVS14gek8czStolmAMhoo33ttgUk6xA5MtrmK/1lofIiIfxMMq
    mU/8FgOoU0i/59e7q0ZwcylFeCPifP2R7Jf/Djrs4EjmaIeLiUfLeOTcxIH9Zj9B
    DuGsJNLsK8eDGgqYMda/w9qvfCLjwYq3/qJ9oX+BKF+ZmmoutWtfTcQM8ek8QSFX
    BruF7TOuApHDhrKeb9Ki5swkSbDDhCrd+aJBZzWeIUodr3ZkzcyOaZclBi8EF8kR
    MJ3O7m78HVZlVUlPKg/RM7tgAPqWH639fZ3SN9EhQf4mdHqndahxv3r5CiSkrGjN
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=M2PSiIRz x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=hlxOrENC;
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
      header.d=gmail.com header.i=@gmail.com header.b=M2PSiIRz x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=hlxOrENC;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBYfdUp01CzyRJ3pVrXzGoa3qtc3GOhgrYmLwLcH9zQz3UtltmD8RJTNPziWJqsVFOjsfkdmCYMtIOkbwErGA5DMg8SXfHxWFpJRnmMrhljTDzUxf901
    1EHyCrLbnxNblq1vf3cRVKPOpoy6/zfE8YQFICFE+h2ME8ZeTlutyCU7YQkCGYM9ZNRTJAqJHmE0r+vrl47MwxxEp6GpuBacifQpevoVrCh0r10A7wQtikYe
    uvOkdg9A2Xis8IAjIc9DdA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=FzJISoMkPqXz6p5uZU4A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZrl3vdGQCreOLVp2y97Amvieb6rFSnYUscoZjRtt2HNA0WnTw/vZdfZE64LWGwEb68UU19a6w==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 25/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 Added prefered spacing around operators
Date: Mon, 14 May 2018 22:24:32 +0100
Message-Id: <20180514212434.17514-26-johnfwhitmore@gmail.com>
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
CHECK: spaces preferred around that 'x'

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index d2a5ce5549d5..f9d664890622 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -826,15 +826,15 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 		if (availableMcsRate[i] != 0) {
 			bitMap = availableMcsRate[i];
 			for (j = 0; j < 8; j++) {
-				if ((bitMap%2) != 0) {
-					if (HTMcsToDataRate(ieee, (8*i+j)) > HTMcsToDataRate(ieee, mcsRate))
-						mcsRate = (8*i+j);
+				if ((bitMap % 2) != 0) {
+					if (HTMcsToDataRate(ieee, (8 * i + j)) > HTMcsToDataRate(ieee, mcsRate))
+						mcsRate = (8 * i + j);
 				}
 				bitMap >>= 1;
 			}
 		}
 	}
-	return (mcsRate|0x80);
+	return (mcsRate | 0x80);
 }
 
 /*
@@ -911,7 +911,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	////////////////////////////////////////////////////////
 	// Configurations:
 	////////////////////////////////////////////////////////
-	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_HT, pPeerHTCap, sizeof(HT_CAPABILITY_ELE));
+	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_HT, pPeerHTCap, sizeof(HT_CAPABILITY_ELE));
 //	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_HT, pPeerHTInfo, sizeof(HT_INFORMATION_ELE));
 	// Config Supported Channel Width setting
 	//
@@ -1045,7 +1045,7 @@ void HTSetConnectBwModeCallback(struct ieee80211_device *ieee);
  *   input:  struct ieee80211_device*	ieee
  *  output:  none
  *  return:  none
- *  notice: This function is called when *  (1) MPInitialization Phase 
+ *  notice: This function is called when *  (1) MPInitialization Phase
  *                                       *  (2) Receiving of Deauthentication from AP
  *******************************************************************************
  */
@@ -1312,9 +1312,9 @@ void HTSetConnectBwModeCallback(struct ieee80211_device *ieee)
 
 	if (pHTInfo->bCurBW40MHz) {
 		if (pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_UPPER)
-			ieee->set_chan(ieee->dev, ieee->current_network.channel+2);
+			ieee->set_chan(ieee->dev, ieee->current_network.channel + 2);
 		else if (pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_LOWER)
-			ieee->set_chan(ieee->dev, ieee->current_network.channel-2);
+			ieee->set_chan(ieee->dev, ieee->current_network.channel - 2);
 		else
 			ieee->set_chan(ieee->dev, ieee->current_network.channel);
 
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
