Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2915802-1522393786-2-13637109547882559663
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393785; b=rkL7dFg4yL5X/hQVTA8fW531xWtvCACMIziok3c0TYtIMWC8Bk
    boXjIRKRTE/3yqFQ4sC8BCvCX5hQzv/EXD+ANq8ieWUVQSipPYCPDuOwF2BnOB/C
    jpSpEjdIIvdV+A2u07tp/tcmojE6z4G8SlBvoEr/dNXpTE8TfojR89yKggjDB49N
    0/vk2xdtzvynoUOwX201s72cY8QIqNcs/NgWLjlqGJYDjGZcrgBufzbK2f8SlCYO
    +FhOcSmzyT19m2mnbJGEe7ZwLe4tU3RIZjhUDn0p6EzcSn9jMDORUkIa56JqSN/y
    QuZdRuimtF6QXEIt+6UzCgunO8F1SE6GS0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393785; bh=LheCr
    uJomjl6TJJzY2q9RBhljo3DL7pfE4cdEgsJCoA=; b=ekKZOaN8S54ymNsTM2bbW
    qOEOHuOXuVENp8fVXvOl1/UVtiMXWNvqpADp+lKuJQEL7FPAGpXNW9ReIR+VD415
    262oedw4AU45R55ppNyYlWu4gjXddvZrqgneVylfA2DDD6qpEf4xvOaePNsu3wql
    35txcsH3V0YrPJQPmUaz5RnmbiuZ1LVgLI900+igSMCpgPmd9hH31nH7IMocld+j
    4Mmd+kfzNh51B9nBBCTIZ0ovGf9h7wx7+UesHdamkjN9huuGBJZPVegICZW8bpq0
    uteD8IMw0KjKZnUx9E1G2c+b6Q8YsKF4hHUW1u68QZCzi8YQO6I1BQzLYIX6zQou
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
X-CM-Envelope: MS4wfBLAp8e5Hwjbqv3+e1KxEz6ffaGoir4WJkcHK0Hcr/RqHA++/SSmJhTzJj38JWkidqIC2ls20skMzbhk4osILCMZJ5LZ6JID5rDy3lMra2YLo4wm9FBD
    eAk+s7e9AvumnAz1Q17utJ//+4WK+SArw0tWfBvdZd1aiytSvCfBT4FCBp3Z8qxELVnvrEDBvJL6tNUvIH5tKIMotIDUjwLbl6pHp/NrOzxM974vE848bhm+
    MjCagPI63sJFKwm35f191g==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=KjG7R9OqOhbJiQy3oYAA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 10/76] staging: ks7010: Remove trailing _t from 'struct
 hostif_mib_get_confirm_t'.
Date: Fri, 30 Mar 2018 00:07:33 -0700
Message-Id: <20180330070842.25224-10-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:aniwTUcY9fWZYv1g6yK3VUub6fio+mVpYqI47WsYMfGI4aNdSOo
 5S/o21TqE8JTHxMJcwSIMtv2xCT8DupyVJ5TEmzgsT/M7b3MW0F0g2IUM2wR+ZtcUK2pvAJ
 Bqi9ZLQgjXwVwyD2pe/ovl16lVNG8xaQWER2FfCry9x6Ls4z8T7zClp1h4q1Y5qkL+71l1k
 zcNVUuPlv8Nt9kRZGba4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J2dQ0OhevU0=:rkgJa/MOaObcPB2nc35iw0
 6/b8KVl7wBhzbUYX82JI/wqiK4+MN0RLYTmc2httzXCdCngoawFgbipMAXvhJ4CCwQQ3RqpRi
 LrdyKW75QE5FwWnIQ3jIV8/NEfu5v1xZfkv7AuxctJ8nGYv//z/a6N3HVcwkXf4Xs3rGF8gUa
 9rlPoZ5JbmJ8e0OVpfswlF95a61m0rs5n7+n8kvPzinMx24E8ySo2GS5zc1QkoS1fp039DWFr
 enNHAs/yEfq/PByMHqCosNQHkEXKshgicJrAcDxOMRFN+pJKGBa0iYLAlH6SKG6hqYB4k0A2I
 XdWr/sGClX9LsWyKJD3Dsk70/URI1CHvb1sYI1IibI6XCw3dwxF0eh+hq9C0CPP9A2QWEldvt
 /iy+32N26qePOif8m6STQYZbRGiNKwb9zOXrxNCFlclLjlFb34IaTFE9uwCJb0rijIPIkgXsz
 VwfmwKhDiJNcZWDRKcHZVF1cWugMbiglXHPdOaWtFllq0NwNlYMfKWxeSUOGifRbR6N8ptmt2
 KggGDYoluXiTgk0+RBjR2OkeQvP4L9ZTFGBSVND8ZqKCoJHay9iNvsuimxLQEUcgJ05AnDkCO
 zngZu8gxy59sEJPlRV9PhTvJn43YGvytQp8Xr8FiMFr0jHvjomS5d33ahFbbVlS/hj0qo1Acm
 N5DdURjHSMHsdSYWCEQcq02huvbxA8LMMLa3tzhn4N56sK2sYZu2rwzaVWAmLL+Gu5GZAdsgr
 0EmQWL6om1IYoaA2oUgSYs/O854dXElCpeEiIQ==
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
all occurences of 'struct hostif_mib_get_confirm_t' with 'struct
hostif_mib_get_confirm'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index bc6ed9d767a2..de4e0ed6c576 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -158,7 +158,7 @@ struct hostif_mib_value {
 	u8 body[0];
 } __packed;
 
-struct hostif_mib_get_confirm_t {
+struct hostif_mib_get_confirm {
 	struct hostif_hdr header;
 	__le32 mib_status;
 #define MIB_SUCCESS    0
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
