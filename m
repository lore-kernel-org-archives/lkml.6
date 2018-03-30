Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2920516-1522393787-2-954497565588989688
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393786; b=nqcFJ1B8zVUQSWUEHG1Ruoz9hM0btyBAGjeY83s6GQx73evQTF
    ZbJZZzAKr0sjG8m4nq/qZxWIeIZZVaAcLaShg+LvihMQNISnosquZftmIkZUoll/
    yQMU74EN4NZfSAnYd4UsfePnWiwTDXKpu7JriGsJeD0metVzV6mAqqm5JkGW/mny
    kmqEulGYffHKAkLW295oZzlKIhp9BcQqBkX8I+qXB+LgwASqhI0BVYo6fwuY7/9Y
    RClfD6zDsBDKzb7RcKIfhHOkrngV4dZsJS2bdi1zVa8X6nQGDnim+kzJnwxgzNcN
    FYhXdlkBUObOi7XXFCh1gCq5ueUx4R5/55HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393786; bh=zlRp+
    VUEn+edC1G+2mpZuHYY9qz4WooCyS5JFZWZe/E=; b=g2SEULLrO9iH7gUzyJKKo
    4L72d4FPIhrB1LKdrhptq+3afbff0Q0KtXlfbOEjGrg61k4bquB4bhnG7Mg8Fpcf
    K7UzZNV9YbgWUuKooDMJM6U2ALFQE9qjAtIS5iKfL+pDW46UyQthU1tVB/wVsAAu
    iWQlRRPPKlboAYuTveAfCoV3931DgcnIwRknlRq6NAB0nWvhDp057ZWRSXOPWSu3
    ox2R11D0SPSPSK6CPFOrj9t8GjaXcnMUA+Zpri5Yy9hClsGdJieqUNTUqM12bh9S
    UzcQvlNW74u6ZZhZKMCSxSmTmYPiTwKm8jPqpezv6WoSBR7mpssyKVAnDnnquvcT
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDwb+2YkT32EP1qaiRe8NTGF3ufM8/tUi/uy65KPQa1/kyIiQ7c590B4/gBUxM+YdQqi6DcUklbv/Yl+1HvqW9VMqehVvwlAzzJsT8sqkXDmLQWTcg+0
    0BDqhXi4iY+R6wKWdsNVip6G+rk9Unt0QoUmCggeIU4pYi5eNkEUsLuSQsmL4DNCiTmOeM4us8ROkMjd5TIQazhrldl5Z0KpwzC5AySZsLDJfTZFpCmOzOVx
    uAI6h74nsYr/SbCoPFpmjw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=CbvExfHWhw3hTN1UFGMA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 07/76] staging: ks7010: Remove trailing _t from 'struct
 channel_list_t'.
Date: Fri, 30 Mar 2018 00:07:30 -0700
Message-Id: <20180330070842.25224-7-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:se2LFdYeoAVJPGUr3BLItOg65SECdUIuCjswcmaaKloHzQjmv+j
 MVQ2np/qP98aEsL6fwwzVoSAWStwgf4V1avSrh+mu+VASAvw4GgU1wmpH40jSmIqKZ2iGmL
 ldV043wv7v7KX1K4ZGlngwSB10maf4q3tsbCLGls1pV6klOFDGKawwIr+f4o+pJgMSoxpE7
 YXtc8jdEj0PlaeAaePw9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9jMgj/237oo=:MYShLqd969Stv2WxqVMgmI
 C8xqpAW2Iu0IV6YR61eRH/XDbJOLOiUadX4gpQAQEsx7hlyo+3mpzKE4t2oUNmhi1ceOEigJQ
 6no7CdmTTDR4rqS07G2wuBictOsB8CkeypPjstFvSJi+7J+pCOjSNEAYJTv1Dqh3h33xq6Nn0
 Umvy6U5OurfMXu9CKWDJHVki6jaDLUNpkxOl0bBhA6OCPf+asJRJ085O5qStZvbfU02r7hoRr
 SzrJ3oU6W9FGXH/Hi7WBs6LMADpJ5whmh3Tj8Ej2DrnFIjGcy6rC6mWB/MxSecULfDMjVF0gr
 3bFjkg9Fcb52+QIK9gllCc1RTC2aLPRiahErQLJdF97FOeVkiMoTXGgbtrGo3eUj0QqvVnuj8
 9zAA2vArQBtvwFQHdvwEum+mp1mO4KtNiHWIW9E2JcjFMy3YfRjgzVwiLg4ccpI2VvWNdLdZF
 4r+X2zrDLmGZa9d7Z5m8AOHz5m5M5Zl4+BTPbuIkvA5KkIyI8mhMkoIvhhCASo9SswfubXVTk
 34pTCADHw/3wJOi7hxpm3lZ2wRO0zk41U4wpZ5Tbtk1rFA9Nyxr1ItG/N2rFAqTu0Dg+oUNke
 E03K8ZN4AtA72E+Uwfv28FoEypqnVA8FcINMp7HS85q2wMyYhJHZdOnccPOJRHxVPqpRcojbn
 WnK+7B2LJRt9hf94wYhBn4Ypjjizq6pLXodD3GrtA0haQEHkLbNmgx5g9EDckc/t75Z4IQrbM
 wo2iJUBsTvIIw2ZezZvLGSfH4LEsU3tHN4vEDQ==
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

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct channel_list_t' with 'struct channel_list'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 75c630e1f339..7869c80572bf 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -88,7 +88,7 @@ struct hostif_data_indication {
 } __packed;
 
 #define CHANNEL_LIST_MAX_SIZE 14
-struct channel_list_t {
+struct channel_list {
 	u8 size;
 	u8 body[CHANNEL_LIST_MAX_SIZE];
 	u8 pad;
@@ -385,7 +385,7 @@ struct hostif_infrastructure_set_request_t {
 	struct ssid_t ssid;
 	__le16 beacon_lost_count;
 	__le16 auth_type;
-	struct channel_list_t channel_list;
+	struct channel_list channel_list;
 	u8 bssid[ETH_ALEN];
 } __packed;
 
@@ -420,7 +420,7 @@ struct hostif_adhoc_set2_request_t {
 	struct hostif_request_t request;
 	__le16 reserved;
 	struct ssid_t ssid;
-	struct channel_list_t channel_list;
+	struct channel_list channel_list;
 	u8 bssid[ETH_ALEN];
 } __packed;
 
@@ -468,7 +468,7 @@ struct hostif_bss_scan_request_t {
 	u8 pad[3];
 	__le32 ch_time_min;
 	__le32 ch_time_max;
-	struct channel_list_t channel_list;
+	struct channel_list channel_list;
 	struct ssid_t ssid;
 } __packed;
 
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
