Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2915802-1522393793-2-4145830713193935895
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393793; b=dQ0kYk9hGNONRJj7ndMZrkm/h8zCcR4nd6OP08EOgSvAOYoDNy
    XKXycLlnFaj8+imNkoD8SQbg+Fz7ObAPGtditcmQuYHCc3A1O6G35Q3nuLrko4Rw
    SEyqHK8WHUSkWXvg44+2rDiUwpyjL4ZG75gNee9tWvMsL3iI2uruodUD4ZGV1Wbd
    CnKIxL+DWflZbVgIscxD29ZZfGGwC7erVn6DTQrr58RqCoB/ZzeVtBGwObpIieQl
    zYxCT+fBfvLiN2fg8LXxYAP+OULmBzN+rc8SS73i6pdr0Vx8VQWhoqQVbbknMsaV
    bfy/6FfmM0upGw2L+5qBF77KxrPVLXZ99RYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393793; bh=ldEiW
    srMvDu1PvnQiWNCEm7RCvAfuZ4MC2LRgunZfW0=; b=hzDw/pg1GOxSuAH81jb7+
    pj4+I/vns4UtC/uKVHWdlTlzxvBB4Gs0EJwRFmwpLg2yGeKzmCY378msl7R3sBCC
    2Xihd+GTJm0pWkF5le4lEL6kZKxhLgfZFZytQpGGvOJ4oPJLXl1vzdvKYSVMqnoM
    1t+UJ2EJ8KypRtDBy8UGvkDfcLDn/4h/8etNA9vmDC7hpdM8YLIP/nCZJPXRWHkT
    /g6AXjjnYxus7i0s4fNiIjzyeN+AbVICHG7xKqVSEkLZqq9MmpfhzxJYEqWbjQiV
    04LnoBHitWNV4Pu81x3CCddGmhycZ225M4blB1sJ+jecQK/53pJ7cqjMh7KOknFR
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHY+V6Js6hJe2yyb2OXpZD9Pq/41i93H0LXdzeuHz3GrMJI8sdFIs5ZJxysV4EFqX6hKvfum5YH8wM0AdFhEYLmf9eWvePviNKEZS0iB7izSp/pplD1A
    5BK3rOPeiXsCls/ysBcrJDPjQXEzmEKrs9PtdSfH22FceRKvtcZjjdOVWjuUKio/xzkA01T1Nq7g2mX8G2mUj8XFV/kG/BufS31c6UBZTmU/xGw5vcaTClxl
    vCrJiqKkvRKh5J789GrjRg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=V_zipIKupC2UuXeJSREA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 13/76] staging: ks7010: Remove trailing _t from 'struct
 hostif_power_mgmt_request_t'.
Date: Fri, 30 Mar 2018 00:07:36 -0700
Message-Id: <20180330070842.25224-13-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:K2oVArtPnbIzZ79D7lFRtaWqWyIFuId0vTZw/7OxCecUgdYPObU
 bgqMqJsvtNrPl3oZmu5XVvgZs1H8wpwPFE79wU50c3iFRhnlMMMKXHZct2Nuz3itqjDiY2f
 sT7MCUscopwrHaWFJ2hQq3ru9LDfrirR/qVx2daNKu+WXrWrBbhZabWpUJan0JPkNj3cdek
 6qHxxeGOCr6mcZz1XZNKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sN+1pgd95Po=:G/6jXKI7mPjzS/3rwmoXJ9
 sfLmrUzfI96VpceY1K7CnCPhifO2JnyyP45+yCsQJrWknwsyXm+nf6x5IZZSzba4gSPx4W5KI
 5ZhXVp+fPa1PIjzJGff4M9wqqU2z68dKJ3mKnthFZhJqwSazh6hH14M+slWmFzf9m2x0BgeK5
 17B1uSVuc2MrWy+aCdYiRrwmvTSDHsH1Iwflk4anI6URYCLxBFxVupLuNX7Hv/3uXc09o6r9U
 9nVj4SgMZpKVwJv4zpi7pQ5bYlvHukaG/4wmWqUrINgc/j3vY4v8VOVxxG/1fkIaESqOOWDay
 qKGXyyaGUVQofHVxPs/s5BB5vokCWOpauom6AhzmPksz/W3eWaFz9kAfMA5NHLEEiFq9+UXKV
 GBDLQzn06wPeS5AOemWm4gpDPT1VVzcGXyrV4Sz2AbuiiFeLzANz1Pc5iwcgR93ytNekcLLuG
 67Uied/l0HhkxyNst+GjkgNwR6eqKxw3mVnsDeeGMUpc8xS+kOiqQphfn1odUj6oK1mN/3y5/
 kXhZl4xvE1C/DMiHby+bH2RS1Y3N0Eozh6F0xNVKYjQbzoB76dVu4RJruIx7c5KtUSyX54nVn
 1Dmdg3ms5J2f5dSblxZGdxha3JFVaO9kURj86z+YohsainV9WUoVJvSP9kSsr0u6xyG8gyOBw
 ZB3K0oCKk0kFFeZZZibTJb9znJ56wZCXuv8HMjFNxyKDnOWyc16GpT0sRF1dhPX2111eoC/Hz
 H2E2AjB/8mkTd9m5DqiBvEALgr2smiqMVswLnA==
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
all occurences of 'struct hostif_power_mgmt_request_t' with 'struct
hostif_power_mgmt_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 6295e01d91da..848307241195 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1464,7 +1464,7 @@ void hostif_power_mgmt_request(struct ks_wlan_private *priv,
 			       unsigned long mode, unsigned long wake_up,
 			       unsigned long receive_dtims)
 {
-	struct hostif_power_mgmt_request_t *pp;
+	struct hostif_power_mgmt_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_POWER_MGMT_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 7a0e0c610c50..cd23ed67cd45 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -181,7 +181,7 @@ struct hostif_mib_set_confirm {
 	__le32 mib_attribute;
 } __packed;
 
-struct hostif_power_mgmt_request_t {
+struct hostif_power_mgmt_request {
 	struct hostif_hdr header;
 	__le32 mode;
 #define POWER_ACTIVE  1
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
