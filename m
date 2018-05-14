Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1429261-1526333172-2-18148375077199477844
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
    1526333171; b=Lo4eBJG2LrXfxIHTAIu0HOdtaJew+Tz3Gv4eaklmolVU4HSCFl
    e4YIEfkxvFC+qjwmNsQdqtV1fuSOUqr+NPlUAOChtdjWp02n5sEoeoXA7wZC6CQI
    zmd/cDvw7mNN8kOwDkXY1DxzVQga0/kaIhk91y40viHS22dlR1uRDN3HytEsZWzz
    M3BccFmgD/WUlD8XFXw0fKh8f3snmglRzprzrs8waGAwpwM9CDr1InvM1DJrjSbp
    Ul+fs7wD3rRq2dRrE2zMTEFIo28UjFUMrrZCm+AV8HMBazXB289vcvGzversTQW1
    YgivlkCye+BSyshxLgdiJJJK7PqF7iQS2Xvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333171; bh=1+38r
    NdZ+k3AjVe1/G4nmm0N1i0aKi8u8OW03wBnZFE=; b=Na95BMdWNPG5eYQo7143e
    wKH9Pmdhpb5x8Lr+rrVuUCRgDcB73xeKm8AbKOh06gtnn2HzqH3lPfBQcLNy9BHw
    BOCouC0L4PlF3VDsKuyCXXJB38hUEqZI7p7Fz7g9MW6/VQ0KxyOGTySLjAJ25zUk
    UFJ+mUTIm61DQS6eO9hH9ScWyP7rwsYARcEX+CGiUIJxgNcBTYvjDQWmtXnnD5wN
    +Hn7DoE8hQM8xKco1HwQuVTSWlSJvcZ25d5qKcpmP5T+RDEYp5pdsQ+2vvCzcdn3
    5oRaMxJfDto9F4LPvATbRgsGc7PMVIYD+25BTqcdX7cq0z1fNHOorczX6DfSaTVV
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=pRitFsoc x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=ayTyrdAk;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=pRitFsoc x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=ayTyrdAk;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGaR+c4G764jfDe+ozIwQP8ogrtXqZ0L8/8qCddmezUvoS/hcAgWon0+NukQtHc0sCpJji7dk+UaIYIwPsBaw9wtHw0lGHMSoAP1O/bp7nbO5NGD1q2j
    TfbLSl1j1AkfWoOXXDnC5Q6i9O4/mgLe9vsBpHUbalKDWePyj8vMY7Ij61F7usYqQxTckBlzcN3bbWW5wU3mP0CTakHJMiOCCuYH1Rg4H/FOFPU81wV390Rb
    4U2ZoxyyZnhKSzjdJrAnaQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=PR4BiYExFYcBjYYXJgUA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpUiJUUvyqL39LbEgm00ABdGUp3oFk6Xp+mFvwP9adbSpw2WyuSDkIG1FWelLOOq/7oMREaNg==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 27/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 removed redundant return statement
Date: Mon, 14 May 2018 22:24:34 +0100
Message-Id: <20180514212434.17514-28-johnfwhitmore@gmail.com>
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

Coding style edit to clear the checkpatch.pl warnings:
WARNING: void function return statements are not generally useful

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 833b3574d155..519601f5bfee 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -145,7 +145,6 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMPDU Density = %d\n", pCapELE->MPDUDensity);
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMCS Rate Set = [%x][%x][%x][%x][%x]\n", pCapELE->MCS[0],\
 				pCapELE->MCS[1], pCapELE->MCS[2], pCapELE->MCS[3], pCapELE->MCS[4]);
-	return;
 }
 
 /********************************************************************************************************************
@@ -611,7 +610,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 	//Print each field in detail. Driver should not print out this message by default
 //	HTDebugHTCapability(posHTCap, (u8*)"HTConstructCapability()");
-	return;
 }
 
 /*******************************************************************************
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
