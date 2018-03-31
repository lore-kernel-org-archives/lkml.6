Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1111812-1522476672-2-10856581448285943208
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522476672; b=t5BxccNO5DI+148/Ohz0YjdlydXpAaeH6+0HRvd5xlrpplpeiR
    luaPh6cpVuGKvmeOqYNqUY7B1Zryuy8PKr6Y3QfZn+5hWKHhvQVvEexGKUc20//Z
    t0AOlr2xgUD9xMdPjL6SAyid1rDtHPeEGmo/Z11tA0k2RyBQ6LIBpN2z72yaQrUK
    nos2+IS+M9SHk9m9DmmaUeWVO71/gFQ7vg1YVM9Wxrd7RTJgkZ5x94mY+LTA4l7L
    VidGJ8nqjnMNngJmGsA8xEO53Ot48AXS91LXG7cQIoYCC5FWMZtWdVXfrK3B02Sp
    81gc4yia8md87gWZKPwmDKwE7AwK7PHinkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476672; bh=vOYdd
    KN1vv8M8ymr+9YWAmONV4D1ACo6fDNyuHGRdeI=; b=gG2fdGo6VuWZ3P0YzQmqv
    DKNxX5N8BU3aPyTCNTAQQBs1kM4XXSO5wQ6BAEEQbOuSuGK7lp52Sygz1wXnDGv+
    BhSEzQAcicXxD/hxTaCp7/OshI5yHh+/ZI29xW8ZprUz1Ba7Cya1yKCmD5ASYZ84
    lP6q3A26MtFV+YMIR1DYjCt8r8DPPEzvkWaNAp75F0w+Ug9W9GLj8gXO6pUCURqZ
    OJD9lweU1zt+2EYVZR6UUXbLqQLWLTRDZxwQ8UK+jVnw9EuGid6D1ZZqn73m24Id
    lu7DSXyRosajl47eoK5NotLU9HfoMuedXYAf90yxNKbGQUf5EpQyY+59nhxfGWdb
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKRrHqTvnBw3ppyvE5Y9YgUWhamUPl8+wbJTDlrAwAURmPOHIh3V2pwNJVfxx5dhRiEDJ34ix9bjINT7JU5y5Mxm9z4Yi2Ft1bRFqilQ8GTRYrtMpgvc
    LK2bYG8XaFIcRcR8JMXDDvSNrkncVyIREo+m2obQ3XYOqBm7d25qXxToAFxPu5kFuoGILYMn79vZ2CF/rt5LDeeFks0AaKLBmVGX4nTfcCqIZqoYHCKPhofo
    A9eIopuSahp86BfYE/le4Q==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=V_zipIKupC2UuXeJSREA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 43/75] staging: ks7010: Remove trailing _t from 'struct
 hostif_bss_scan_request_t'.
Date: Fri, 30 Mar 2018 23:08:23 -0700
Message-Id: <20180331060855.9452-43-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:JzQfE2y4N6gJ6PTyEFdIPZMkZ61sGpM/t41hofUaIXdAnje96Vk
 ZbRLqqnQ/WliQu5zbtl4NDEYbyUp15o7icI7pvfqehwCodMZ7RHKZZFgrAyFRiqp1k4Pu0Z
 QdkWzFADeXgGjAy69ERqkKH63/kiZK9K1dat/QP+xCykSlEI8o2JNTnGTC9QVlQSwXDpfSF
 iiyuJ0HgWjK0Gyy++cM8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hrEHZRnNRS0=:VO0oQSjOksvH8bm1PoJ9Ns
 HBf70JEUPcYuaTPUZizRSaCe/wn1zgB7+dkhCNG1daXKbfPTkbeogprYkuNV7Vyc02EOz7dPO
 b9ouc1M8iV0YT3SdfKf5teG8hKIK3nNgfP9vG/3TNGYOR+ogbsZg41KKnHeOrWElQquMdp+m/
 aZ45FufOupC4Q3efDH+mckzTRDMDZNVxEU67wIybOV7tluM6cYnsVwsv/40U9b9hXuIyK+/1g
 Ps93Ruta5EBkyqKykTezU2Bx9mbFwfgkASWd9fkEcV8BV8vmiG5T9isz5r/hsT9yLJmcNVG9V
 /psIjlWKn2DpFOZuy6v5toyAx+lHVZyg+VggWPuLLrOGYJhiYcv8lrfYgaqTPhQm3iSS0HmgQ
 fZkWuIkJjsHGrT/d4fwPC6OoVIsXZa3aaqV/Q9E8Rb7r4+FKgiOr42A7H9sHCcW9xBYpR/H4L
 FHBTEz/7/y7IzMB94xS1yBBk17TLGATKNiIFk/Yl+af1p5ZTKjZkeS4uK1lqraRrqcKvQ2bf+
 TaLklNbEbCcthFu3Aai5byZdv0ykn30B5jrCWbVwIyb4IVVrjuf2y2VplxQm+3iPyYYNJVWUW
 XGEaZK4l8berGKjGAnt1ibKvY1/pB1xy8K/gET7QI8nwNXmzfUhRALJDEfNU5NyfYGGqObXQD
 eHMBHKfQ6d98TthGl2iORYVq1a/nmSARGcTaGThRWb4yQPTdDcDF00S1eMN/ZjdVy9Zja9WLU
 jiuv51JeKSMvDwyVyVg3W4bCgqZlJPfHw/c+sg==
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
all occurences of 'struct hostif_bss_scan_request_t' with 'struct
hostif_bss_scan_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index e733a77269df..aa827949db7e 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1508,7 +1508,7 @@ void hostif_bss_scan_request(struct ks_wlan_private *priv,
 			     unsigned long scan_type, uint8_t *scan_ssid,
 			     uint8_t scan_ssid_len)
 {
-	struct hostif_bss_scan_request_t *pp;
+	struct hostif_bss_scan_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_SCAN_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 9c8b0a93f7cf..7785e620e03c 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -389,7 +389,7 @@ struct association_response {
 	__le16 resp_ies_size;
 } __packed;
 
-struct hostif_bss_scan_request_t {
+struct hostif_bss_scan_request {
 	struct hostif_hdr header;
 	u8 scan_type;
 #define ACTIVE_SCAN  0
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
