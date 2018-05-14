Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1405515-1526333145-2-2333859614341865863
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333144; b=JoM52QjSg5EWd9vGDDNQthmYQ8bFEVvAKldu6X8C/1FbDY1md9
    Yylr4YfXdOv0f6xZGM4PBaHr4PTCJ5NGOJHgGUM1S2Ds1hlWqrkfzDk3zbXJ4Qru
    JNkQfq9rtUwUOPt1wbOedezKQUFh0Q60mU+8XAHwjYz6Xp3Hiv3TeEptNyLWJb/s
    NyQFwHGQgrzyuC8l8vw0pRGEzqdNZAC/3/v4ZIbdQt1TFsA0fE6CQag+QRtoE00p
    7ueVT3kYPpvbdro37c1yXQkasmOBmtkmPzyxr70dvCHOXyc91m7nzTRJo+JLxZaC
    TC3kbuwy7zNFz3PhDtWgjEx6Kv5Xt7pqGLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333144; bh=KHt9E
    N97ORWF8Pp74IFBNXTA4SRmfJW+UCHzh9rAuaw=; b=nkT2OrwAd9nWZ0IzSTtrU
    RzMZ5Eq8DQ2afhL3RVffxWAVOR1GMYyPWGdb/sAXFX9SQZq2A5AbIDJTR6eu2BAK
    uYzdKqOmFKQNq4Jn17J5p5OMLTuer9oaBPF9RsjdLpEQF5gM9T6vWrHySCDAXGbn
    lARWv9R97IoLFK+w44w80pm56ZG4kMhmfXd9yublXNiafQgbluWq9NI3AaZtn9gD
    aXTECCA8lRBAaNPY54XKS3qpsFtv+5osVAwOB8RQiamwjdEntte8pUPtPjDEPi3r
    KyhBNT5ITKZeOnpMJYU91a6DJHT0RXlk6fnz63DZLwAGw66LFKVStgnv68tGgbbe
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=ulI3vOfg x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=gp0vIvSG;
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
      header.d=gmail.com header.i=@gmail.com header.b=ulI3vOfg x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=gp0vIvSG;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA3s/GJE8WYM7vypX1C3iKvmstD3OoVU53L+2iyUp9h2Q8OGF5hbzGAo3uKb5zM1VZacaEXlvgMHeJYgdPPf6SiDAVGscEpMHQafPwl6C3t7XpbEJhGl
    2vY9+XtXx0MwxKGUywNhSRHGGJzzX9GH8JpL92AMPdQWEPNumFx+JJc+H6Jg2eTYOz+TyoBR/chq89g63JCFraCkBv+QH8xK+GI1fguFRyVa29GkyUz/MRCb
    GqeF+AvBnzKTVEhk2FlsQA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=MX8CqnXLN6n9lhic-PwA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZp4f4UTNsSHGaCVcHvsv5b9oUojSPcFaN6we74Drt2A4V0JPk8ch0VSTfcX7UDd+0ExyCqSBg==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 21/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 corrected indentation
Date: Mon, 14 May 2018 22:24:28 +0100
Message-Id: <20180514212434.17514-22-johnfwhitmore@gmail.com>
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
CHECK: Alignment should match open parenthesis

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 0eea1ec1b25f..e92600b26f66 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -363,16 +363,16 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 	else if (net->broadcom_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
 	else if ((memcmp(net->bssid, UNKNOWN_BORADCOM, 3) == 0) ||
-			(memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) == 0) ||
-			(memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0) ||
-			(memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3) == 0))
+		 (memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) == 0) ||
+		 (memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0) ||
+		 (memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3) == 0))
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
 	else if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
-			(memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
-			(memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
-			(memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
-			(memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
-			 net->ralink_cap_exist)
+		 (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
+		 (memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
+		 (memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
+		 (memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
+		 net->ralink_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_RALINK;
 	else if (net->atheros_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_ATHEROS;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
