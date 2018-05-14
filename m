Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1405515-1526333126-2-15127162804894425200
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333125; b=g5B85fu8jWMH/ZuIXnTqvoG12fl6wXc4NxcJpFijiuz4oVDj5B
    N902tE8a6I29YKLdjEtdNrr4pNXTjkJgzGTlWiIjxJmQO/q+36cfIoHzlSVogXHY
    WPmu7qfa1KvuOXAhpisy2yEA3heK35kgTXfi+2Xu8V4HW2UVZWMZp0M0Xkm0+edm
    pGznCdqMPY+tX2iT8G7w0+qr7L5W81n1LVbvXSav8m6pb7vABtv6nGzg2SjPhxOD
    FQ/Hz0jS5ZkOn09Wm6AD6qaqV94iMrfDN2Xt8NP5EtsnTknU6023KxSUA5dnRIgr
    BUw9yOPekqv8MeGcTBdcG81lW/xX+D1CrMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333125; bh=52pUv
    xx4N5R60WaNhfN67kPHjB5uIgH43Q9oUuBn1GI=; b=Ax9xkyDQW0UfrmXpZRvtj
    3DV3pQro26/UVkjgzajgRFHzuHMbJpyqzpM3advr1o0ezDaNY5LcQGpO0/GxaEBL
    eehudpFPgpHNANdU25TNyTguglH/6gKpvEEN7DDKjyp2hm83DeXFZAoFVyVhARg5
    h16rUKFUotYw8HcwQ0Ok6CJ/0NMsyQzBdBcid9MrwEsfdJ7SMm8rY3FaId4RzO7U
    8dPdE2t9WfX4EC2wVAM8Op9Tdgz+9gsP43N13j35cSMF3N7Q9fqSOckIT6A4MZ8N
    PgFliYSmL/D0Edp9cJFjFA9fxLOp7ptirFy/ohrvLdPqHm/4r8HtCpY10GTkC1IZ
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=Y8exUxAg x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=BjyR52sc;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=Y8exUxAg x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=BjyR52sc;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGuVFwDzs2eJlTaQ4EjfVPICBMw7jvhvcIBMpd/trN5UOx6UiwT38PfA8SN61VhjOzhSdm11czSEgCMnN2QYfhk/RiHYmOjHEWJGihqVYDidat56Xk74
    scaIFKroJBw4y07YeS+dipAynbpseLgebhkQD9G3iW3J9bs9/r5owTYCO4v2sv7hsBjK5wo3DBZjs94fyH09/CLFle6rCAfsocILjtnbXW+FTglfoS+dw5UV
    fpAswh8rSyIHBT4LCyod+Q==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=-5xeK5i3hiI24sgovPEA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZrETf5KFB9LIZ7Y+T04csFXLMvm6S/dQJfYjUKSOnGZSXNKVJrRKPXBK5vr6MudgGKO4zAVdg==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 07/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 correct indentation of switch statements
Date: Mon, 14 May 2018 22:24:14 +0100
Message-Id: <20180514212434.17514-8-johnfwhitmore@gmail.com>
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

Coding style edit to clear the checkpatch.pl error:
ERROR: switch and case should be at the same indent

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    | 48 +++++++++++-----------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index beecdbfe401b..5591cde8a5a0 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -177,35 +177,35 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tPrimary channel = %d\n", pHTInfoEle->ControlChl);
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tSecondary channel =");
 	switch (pHTInfoEle->ExtChlOffset) {
-		case 0:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "Not Present\n");
-			break;
-		case 1:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "Upper channel\n");
-			break;
-		case 2:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "Reserved. Eooro!!!\n");
-			break;
-		case 3:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "Lower Channel\n");
-			break;
+	case 0:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "Not Present\n");
+		break;
+	case 1:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "Upper channel\n");
+		break;
+	case 2:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "Reserved. Eooro!!!\n");
+		break;
+	case 3:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "Lower Channel\n");
+		break;
 	}
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tRecommended channel width = %s\n", (pHTInfoEle->RecommemdedTxWidth) ? "20Mhz" : "40Mhz");
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tOperation mode for protection = ");
 	switch (pHTInfoEle->OptMode) {
-		case 0:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "No Protection\n");
-			break;
-		case 1:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "HT non-member protection mode\n");
-			break;
-		case 2:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "Suggest to open protection\n");
-			break;
-		case 3:
-			IEEE80211_DEBUG(IEEE80211_DL_HT, "HT mixed mode\n");
-			break;
+	case 0:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "No Protection\n");
+		break;
+	case 1:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "HT non-member protection mode\n");
+		break;
+	case 2:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "Suggest to open protection\n");
+		break;
+	case 3:
+		IEEE80211_DEBUG(IEEE80211_DL_HT, "HT mixed mode\n");
+		break;
 	}
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tBasic MCS Rate Set = [%x][%x][%x][%x][%x]\n", pHTInfoEle->BasicMSC[0],\
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
