Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-317056-1521781732-8-4321139702009839014
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521781731; b=bjxomhfj0I/2dpfVlGmg7E+E0rJZOK9agv9SZ0Idu2u23cl
    tagjyw2a6PD+jJhwDNqNTbyRPWpVoDMRDnYwr1Iug6hnc80kajGzb57eAWCXTK6h
    3ll7HlGLlEPqkF61K7pfoRXQ7OGpszN9CH1f8H4t3gNcDtktacRRnuUNOR/LXnGK
    RszzjtkrWr5xuAxtp+AMm7ZpdZlsOYjGQmnlPnQM2yT8hcAsiTXO7+q0wc4Wd9X6
    GBAHNIJL9xRuWN7jA0YWx71oYMPeyiXYqxl9AztAFUMqQEL2/YtTDfbmO30Sn4Pd
    rw5465NWR8fwSqkKRau3n60LQOQnE3LbMeoj3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521781731; bh=h
    Oq+a8Qmyyv+4eRdKZA+5IF2584wIAkorrPg12xEiRg=; b=un/H5MrwtlpkQxpkl
    kAg57VtF2Uanq8Z5Poe4mph/59YkddG9PeXvgdlAjEvh04ZrAsnrrhlVDk4uu/gt
    zHzRWBHO4n1R1fbnxjwmgafMMVfM5GvJNW1ksXbtpgsuoSx5MU1QF8je+szsFbFq
    9t/ukr/i1A2wGilmjL+erxOikWTToY9fXuIXD6Al9cjB2aNw6s+RheDHS3DLs1Wn
    7/yXfSaCRuAk4dHjHEK27Yc2phF95fmG8vzcBd/3nEP++C95agmgyj5g3T7thOIU
    ZqsCAZOjA+P0FuPGNGEqvC/qiUDQSU2dtZ9hgapH2vh4jTYDi0l72CqJ1H9M853c
    fFQuw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 4/7] staging: ks7010: Remove duplicate #define's
Date: Thu, 22 Mar 2018 22:07:42 -0700
Message-Id: <20180323050745.28903-4-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323050745.28903-1-quytelda@tamalin.org>
References: <20180322172014.GA6801@kroah.com>
 <20180323050745.28903-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:slTDNx+jBcO55rT6UhHr8BfVCZHmElnWSzPwyYWZubReWff51Tn
 xjVKCq/XsYShYr7/cIctiFfchh4OTWZEty3+I5IG3vIlUuhA3RTHVMhB0STr38PlgF4Stzb
 QRVZL+Ek5uOAiUd9dzf2LDR473TP+ao0kBtv5JJ2hzPQ1/go532lhvrZbILwERu1bOdjI2D
 UwKUKfSViDYMPCsyIH+nw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MBUZ5t4spzY=:ocz++j5PaFijYe5SAxT7PL
 MAydh5uoGdsmQ6X1o3xqYAEVER8Nx0zHc/HCNZlWbLI57lrtiRX/hQM86KSBAgvo5+1Yz2cpP
 zOixdp9eMSWD38tCdxE+wumP7rxTe+zExO2OK4HEOMhASzJ4/mhem48UNVg5zirnWuoTRe8cI
 0oj5TzfrjwGBvrBl3bD0h6Kz/m6B9sTTl2fffK1OQA+ko44Ac9v5ipBkBiFql0rNQcrY3z+60
 cO+e1w9aWWsPPYX4OtNczpDAkmJo1t6mmukRGxUNHYN3baizFjXQLLv4xujq2Lk9wReKJL7o3
 NTDwpz/dyeP7ZEI0aaScAR30A72cyUj/+BvShNHwZeuWoo83SwcrgRyPNChBgY5YUmPQbyslw
 Gpr2jmVvsc6hSaxW/+umIJj4Xg4JDd0ASdwVx+/cQFHC8M0WNp6kAa4hmcOupFRf6V1cLLhzR
 k6akkrDnHCWnefysSnJQmY5O6TeVP2fLMJqrYDySTSVlASMpfU3tkw+APFOWf/eAkUfi1zqsG
 JBn6gprRrR0zbacCjpylomGLFGkCGFhDQw9qzSrtQs7UzI01ZeRwT/oKkmh+PqbJyzwUm3sql
 RhMYa991lnVZFfyzCWkNRLWazEjgALaYmvnK1r8aATxK7peyQc4GRrnIUaUI7qltoY/SAfthQ
 TWGlrz1kuaXaQVabQuWGK1daF7EVFcxp1YX5qGHFtVXBLNBJjbva8Q2BIK3X3NkpoBHVxw2al
 2Bnu0SdQj8UCfFZ9qb9/RO5eQ2z3oPqSYWMD+Q==
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The AUTH_TYPE_OPEN_SYSTEM and AUTH_TYPE_SHARED_KEY #define lines
are duplicated in ks_hostif.h.  Replace them both with one set of

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 87686fe83c67..fde89bafd7fa 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -369,6 +369,9 @@ struct hostif_ps_adhoc_set_confirm_t {
 	__le16 result_code;
 } __packed;
 
+#define AUTH_TYPE_OPEN_SYSTEM 0
+#define AUTH_TYPE_SHARED_KEY  1
+
 /**
  * struct hostif_infrastructure_set_request_t
  * @capability: bit5  : preamble
@@ -382,8 +385,6 @@ struct hostif_infrastructure_set_request_t {
 	struct ssid_t ssid;
 	__le16 beacon_lost_count;
 	__le16 auth_type;
-#define AUTH_TYPE_OPEN_SYSTEM 0
-#define AUTH_TYPE_SHARED_KEY  1
 	struct channel_list_t channel_list;
 } __packed;
 
@@ -400,8 +401,6 @@ struct hostif_infrastructure_set2_request_t {
 	struct ssid_t ssid;
 	__le16 beacon_lost_count;
 	__le16 auth_type;
-#define AUTH_TYPE_OPEN_SYSTEM 0
-#define AUTH_TYPE_SHARED_KEY  1
 	struct channel_list_t channel_list;
 	u8 bssid[ETH_ALEN];
 } __packed;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
