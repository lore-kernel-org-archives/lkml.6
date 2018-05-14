Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1405515-1526333127-2-4578735233561405930
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333127; b=mhSesaCSt3LhRPLfGLq6UAbOgBFDV5vMBznXE0P8KPn3PUhiAh
    F2QOQNZxyi6wVmjBudRP2Z0b54YDGccGoZM85/uRhIw9hyUHYQdlHNmJLwLS5QhX
    XoitxguBgjsXT0bjnjEzuf6zKDeQoOuwp7BkICw7Z48l7tI1tDAmnbcsqCNu/aTi
    xZDz0RDKN20yk+f/whxtBbdH7gYhwR/u/gDJpNROe70YWCBa1EM2KHby/SSdAMEu
    6qQbJ3NxQGuVQyLjazkz4BPYAZiePDK2KZ/ai+jZXpyPQfijXXaeqKniB10cuY3P
    UpV4E7p9VZhelIAYincb56Bo51CwsVEQe/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333127; bh=JXZy4
    IoddsMwUZy9W4v4h7K1HVOzCBNTqpQRwYIwHHo=; b=EsQSykqSsTBhh6rdjAksX
    qSQmO69QY+9Exluok6UodqKAaxSVOISrariqyICZuU6yRvu9ytW+eLHvVvL8jh+p
    cWg6MYCGcEW37fEhHoeMQn8Pn2XYu4hJdKnc3GECMO4Dny3uDaK0GiaJSDPzS9d8
    1OdGnZ7Z1s+JXseUx8G7XNCyoRQJqY4r2oqSMTrE2qpMxPZaOa3Qm66QP33f+DqW
    W8fxFMuoXaFCjVEgt57ZqE+iIPlpcVH7o468vmN6Ta3c84nWawFO+gQg3DdGz29A
    og6aB1pw14Zy3JGx/W0h6vm4H4n0anqH1i+kTfjCHaunZC/xw7Rxgz5n3eP5cKyP
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=DoUUZqE4 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=psFwrP4p;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=DoUUZqE4 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=psFwrP4p;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA3aIp6gfXfKetCbHMzvf8H8I2vi5W6zd7gfruabbHCx9bl2qGYWUweeAFJSLwGy4R6+gJdfAF17ZWQSs2AErQ9GeVadpM653C4NZgVJgQfDSfQ+p+Bi
    aDmY+Ffqx1mxeSFUQnFJO8T6fxoVvMOSj+CKWIfWQR349GbWijKY136ibN91EmxGCQy5c4YudkchhAjkPSApCdzTrhOH24P3dauU8Njy4UpZUnce00zTNRkr
    e5k0FurS8TbJOed3MSgbAw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=EVzJR7y25Zz95493HCgA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqEf4VjOHKImDCpnVrRb7g+DoEIPanARdlPl3HEBBN1jU+cVffxy2lV4i9RMfOWncrphrDdFw==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 08/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 correct whitespace style errors
Date: Mon, 14 May 2018 22:24:15 +0100
Message-Id: <20180514212434.17514-9-johnfwhitmore@gmail.com>
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

Coding style edit to clear the remaining checkpatch.pl errors:
ERROR: trailing whitespace
ERROR: space prohibited after that open parenthesis '('
ERROR: space required before the open brace '{'

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 5591cde8a5a0..74385b5d2e41 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -301,7 +301,7 @@ u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 	if (nDataRate < 12) {
 		return CCKOFDMRate[nDataRate];
 	} else {
-		if (nDataRate >= 0x10 && nDataRate <= 0x1f) {  //if(nDataRate > 11 && nDataRate < 28 ) 
+		if (nDataRate >= 0x10 && nDataRate <= 0x1f) {  //if(nDataRate > 11 && nDataRate < 28 )
 			is40MHz = 0;
 			isShortGI = 0;
 
@@ -641,7 +641,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 	}
 
 	memset(posHTInfo, 0, *len);
-	if ( (ieee->iw_mode == IW_MODE_ADHOC) || (ieee->iw_mode == IW_MODE_MASTER)) { //ap mode is not currently supported
+	if ((ieee->iw_mode == IW_MODE_ADHOC) || (ieee->iw_mode == IW_MODE_MASTER)) { //ap mode is not currently supported
 		pHTInfoEle->ControlChl			= ieee->current_network.channel;
 		pHTInfoEle->ExtChlOffset			= ((!pHT->bRegBW40MHz) ? HT_EXTCHNL_OFFSET_NO_EXT :
 											(ieee->current_network.channel <= 6) ?
@@ -867,7 +867,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	u8 i = 0;
 
 	// filter out operational rate set not supported by AP, the length of it is 16
-	for (i = 0; i <= 15; i++){
+	for (i = 0; i <= 15; i++) {
 		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i]&pSupportMCS[i];
 	}
 
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
