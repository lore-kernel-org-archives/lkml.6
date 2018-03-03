Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-794649-1520104188-2-3025531751023431553
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520104187; b=kqiUF7INCELae/nJAJVUsRnFxccLMkDcflsUc0HC+5kPFGw
    CSJo0NdKL/D2xMAbyc1jQ+rGNNYgwiJ0cQMQ1WQUf5QQ1C2hEkq1ozujhrm8aze6
    8J0gVIjIML46lK6tClkm326LVayr8Dzfiaao++c3hnOuCocj7T5XTXokcFUt7q3v
    RmWAzh74/b11sw2mZHzQ/ySSO20v2yuNna5o9DMfBJyjCy4urR1Dltk0kk+qtW8w
    ZWK2G/ENgd2HkO61MJiwAGA0c6ZGqYmtEFRtknp9GqUbS3mPVGUpe1wTAZljhRFw
    v9jf0kiP1ccU6qCGg5MnIKpXRy0QurFazdzmx2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520104187; bh=/
    0Ko9A23F7b4lgQ84lYnxU/j1P2EMgGrqMHGCT0zKRk=; b=E0IdQLbEFBEWRJ9eB
    EYuP7thD/jva2uuBQvxlQ/+dAtVle3rwrXPALLsyXoN38xMA6kYAFD6BIu5DRWC6
    /oFvIiL9tb0110GxZqth5/mjBOH8l1XzJashPorwEvCpOp176jH91RjjvlTzztEj
    Q2931zEkezRBlhP4o/MdWODLKZOToIf9B/Gxj27vWVOjX6kEAdrzcKMaIV4bGWWq
    BSJsUWMADBFfQXNZrB0UCt12sSuAsnITSeeVqO/lnhznCf242NBdShipOxgWyWZj
    keQfdXi9wVkHFmlpFp2xwerzDWDoFQhhqxSsTqkVPae3o/PNi4Vmdtht91RZTIoC
    yefpg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=sdRqIPXF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=K6JkgYUb;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=sdRqIPXF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=K6JkgYUb;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtzc2wKn5ULrTe9DNngBjTz9FRg5iH2z0Pc0d0ZBBOsdsss2BZ52LvQPjk8V0t+ZnhMXKBbjA==
Date: Sun, 4 Mar 2018 00:39:13 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH] staging: rtlwifi: Remove nonessential semicolon
Message-ID: <20180303190913.GA4555@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove non-essential semicolon after 'else' and 'switch' statements. Issue
found using semicolon.cocci Coccinelle script.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 drivers/staging/rtlwifi/base.c               | 6 +++---
 drivers/staging/rtlwifi/phydm/phydm_rainfo.c | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtlwifi/base.c b/drivers/staging/rtlwifi/base.c
index c947def..eea0003 100644
--- a/drivers/staging/rtlwifi/base.c
+++ b/drivers/staging/rtlwifi/base.c
@@ -710,20 +710,20 @@ u8 rtl_mrate_idx_to_arfr_id(
 			ret = RATEID_IDX_BGN_40M_1SS;
 		else
 			ret = RATEID_IDX_BGN_40M_2SS;
-		; break;
+		break;
 	case RATR_INX_WIRELESS_N:
 	case RATR_INX_WIRELESS_NG:
 		if (rtlphy->rf_type == RF_1T1R)
 			ret = RATEID_IDX_GN_N1SS;
 		else
 			ret = RATEID_IDX_GN_N2SS;
-		; break;
+		break;
 	case RATR_INX_WIRELESS_NB:
 		if (rtlphy->rf_type == RF_1T1R)
 			ret = RATEID_IDX_BGN_20M_1SS_BN;
 		else
 			ret = RATEID_IDX_BGN_20M_2SS_BN;
-		; break;
+		break;
 	case RATR_INX_WIRELESS_GB:
 		ret = RATEID_IDX_BG;
 		break;
diff --git a/drivers/staging/rtlwifi/phydm/phydm_rainfo.c b/drivers/staging/rtlwifi/phydm/phydm_rainfo.c
index 8c08c76..e10a91a 100644
--- a/drivers/staging/rtlwifi/phydm/phydm_rainfo.c
+++ b/drivers/staging/rtlwifi/phydm/phydm_rainfo.c
@@ -142,7 +142,6 @@ void odm_c2h_ra_para_report_handler(void *dm_void, u8 *cmd_buf, u8 cmd_len)
 				     "SGI_support =", cmd_buf[7]);
 			ODM_RT_TRACE(dm, ODM_FW_DEBUG_TRACE, "%5s  %d\n",
 				     "Rate_ID =", cmd_buf[8]);
-			;
 		}
 		ODM_RT_TRACE(dm, ODM_FW_DEBUG_TRACE,
 			     "-------------------------------\n");
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
