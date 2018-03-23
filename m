Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1821531-1521826580-2-17505316804674644974
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521826580; b=MWW4/mGZOzCDmJ3Tvq+FY/Lx4wKHQb7/1FtaBnDf8or2CnU
    0C/ABxdxxKEQXZA+Tcb95c9oMCEFcizUAu7BabrKj0fG4KCykJc1PqePaZ3czThz
    UDyPcVdO68r3NedunqM3qjAgxq4yWfeD1GvygNqCfUImnCOGj5ENb62cdd1S9R/8
    BUr3rUSjl05tGguOcxAe+6Qr8lviVgMcvnOpIySNEbFvEx6YJj5wU5GZU+Nfah/G
    q+Agtfd6kEC2s/NCkPa5R4sD8H5uUw5zqrFgK0Ldn1SyCTjGkZwNQF3nx3Fq3EDA
    yMDK58WhzzYGtvLVJ2b4cnCnuO+y8F3jHduX2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521826580; bh=I
    702iTT7m55DVWEhajGNLDNs/3MG10+sJhxe3rfeMxY=; b=eMIt3OBKsl8DG5+fc
    c0doEf6FuVrcwu5iEqU8h6i4OZzJ9qw5zo/0s9nwLOWoazlfUUMWszQonrxT3lQE
    qnW/fviQZe4NS18awLCoaAF/ad4my8s17ChBD8A4aeu54jXAzIuBzFgBPsS+tMVZ
    WsHkMS1NgA/9/0KprYT1sfEvg0emt9botERNMyJuJGV36D5DGrvwdnTJmeYb4Ezv
    rUtN1W3zLu9kEHQBJ6iu97GiJGU/xXacrqvAeMoBrZbNv9BpeOXHop2Vl3DKrLIb
    5JfpsmGqQlZwl1GGo6BTxXczaiYgFP5QEuWlmpZJB/ZGQArnFoZw8olH6vV8X6rL
    FRC2g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Colin King <colin.king@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Ping-Ke Shih <pkshih@realtek.com>, devel@driverdev.osuosl.org
Subject: [PATCH][next] staging: r8822be: fix type in guard macro
 __PHYDMKFREE_H__
Date: Fri, 23 Mar 2018 17:36:06 +0000
Message-Id: <20180323173606.21119-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The #define for __PHYDMKFREE_H__ is missing a character and is not
the same as the guard check.  Defined this correctly.

Cleans up clang warning:
warning: '__PHYDMKFREE_H__' is used as a header guard here, followed
by #define of a different macro [-Wheader-guard]

Fixes: 9ce99b04b5b8 ("staging: r8822be: Add phydm mini driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtlwifi/phydm/phydm_kfree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/phydm/phydm_kfree.h b/drivers/staging/rtlwifi/phydm/phydm_kfree.h
index 1ee60059afc1..2c6b0a48e76e 100644
--- a/drivers/staging/rtlwifi/phydm/phydm_kfree.h
+++ b/drivers/staging/rtlwifi/phydm/phydm_kfree.h
@@ -24,7 +24,7 @@
  *****************************************************************************/
 
 #ifndef __PHYDMKFREE_H__
-#define __PHYDKFREE_H__
+#define __PHYDKKFREE_H__
 
 #define KFREE_VERSION "1.0"
 
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
