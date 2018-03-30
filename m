Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2927865-1522393774-3-1045481258302954019
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
    1522393773; b=eCqKzL/tmOVTW0iYsOSce6JrgGbre/+vDKUGTiP7ZnlxLvW2ha
    MA+TrHiWRqFMeLeO7bINJT3mpUIuU+ag3lSuVnRmGesyDaaMsUehgGgrpCCyRVQU
    o7rF//W9uAnZRPZzWxZQpS04GDoIr80rpTeWTpJYyFJ+Qs9NjkpIJYPSrlK/kyWy
    YfKhid96vt6RIanWHO68k6//2nHrm3OmTNaRP95IucofuuULOAS2Udatv8RZx0S0
    YesPqaLun1jjz/MRPMWlu6IiOky0Zzcu38yA6jMtxvuRu3kVtlHmZwGNc0mPRYVH
    EeuQ8+KaP9PsL7dHbx/Ru1aKo242i2KqPMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393773; bh=oruVa
    RB5r7aSRtjTcBzZr+JUFeI7Ljt9BTYKx4q2T+4=; b=GE6xDh5oaT7TZGD2GtL6n
    ChQZIa0T2VNbuRB4Np1aA8GZr5BS+pTKI/UrcYnFLEYyOnagxmedJRq5UhlVjXxi
    0o53PVuwEs11nJhWfZqARJoGraZWb6oI2fcEZN/ulG3THpmGTW7saPXRvbMAq9jt
    beCrDei3nP50IlEq/lXnUoFL/Bljkl+hnpsys2JxxK7CSKLGHQLiNRF4pFifU7Os
    KUgRkDVukiOWuvnlHpzteRRN70kzfAFnPxKmPcz5yf5AgSIV+wCLMnGjQwSxzrnj
    z8jJWz49zaVS1cEVyzd1qNkSeBGUJDj9bN3Ved29sbsu8nPyX205m1QdY+37KWwM
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfJRUItyYBfFBqd1egHltpaC9jMunJrTj7I6Cq6Uhh43DFhir/elD9URV2ppXmgAVVfEAFq2JZlRPz6+ihF784GtYkcgqSlOrnbx00ODwpwQ3CI1Sa89b
    lSEIbe6kAOP890IrkNxKJDzvpcDw5H+DJKlKTvmV/ICs7qLrj36uZHyBTS4CiseFWcvWE3sFetbR2gKlQSkiydTxFgVAVbpAKIGd6WyspjVIBJ9LnhgIXmzS
    nzYnUwg5VTKRj8efzHrutg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=7pVo4ew1gVD5Bra2lq0A:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 04/76] staging: ks7010: Remove trailing _t from 'struct
 pmk_cache_t'.
Date: Fri, 30 Mar 2018 00:07:27 -0700
Message-Id: <20180330070842.25224-4-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:TIvgQTGpWxnonzL48ChoExHSd7MV1V8YW2yFeG+TpHvjPZPG2jC
 gsx5Eo86FG0FJAeJFGkjZIIBYro0ethpdTGwid3uAdekTVbsK+Z+leVELf7VjZIDHKLBiUy
 yUxcuSSqBDvYaKMTHx19sfr8V1gTIMaJhhLfSRz6h3W1hybUJH9jSXCLNPBtM6cNk1y2frg
 h6enbsQQyYvJ7VFayIL0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kTH9Qw7aMVw=:K6TDn0NBZ3vuK02Slo+Zy5
 2UtheXvvZLcNODLUyoPLo2/Jn3rFC6iJW0GqjqtqsB0KNY3V+ty6auWh2daCMcdYlXorz4Fqc
 aM9pvDBBoCU0caxWK+wQNKM0tBy5alDSCLWawhaKEpEgAmqQA8I4LztsQ18M2nqyiz0m+vWfL
 ffEktnWquRDiCplDmF7IhP/eIkGPrUAuaJFgHjbyIdr6dGjNGSdVMDL+VzbdOTeOOswLvCErO
 lG0I8A0ZAzEcCfKGgf9VX6+zemBr7RxcUHY2Zz69D/auAzvq4ZwcTIDHlG5vp4cwm9pTui+Sj
 BsD9pTdYaVrgBS3AIG5etAldVs/lRygoNGQCgMWUT8lxcrdjxYeL1dR+S9Lv9qEs/z5LDvlvu
 QoFVVFNrhhLR6dW0tvLgWPLKaTi4rFLVt5ZqBWgyyuxnYp98YDzXigYOuR/NFcu3QPjUw9vOK
 rQbDYSX4HYfo2IEzRDEhY3mLDT9IJXjzQ3Mm34W7qC+iZtMytJWvo7dLK/ypvH4xWJSc+R5eZ
 crABDTeEzMoOy3osbnS9QR3sIzjK0uTINm7xi2JHX9GKOEcjU0xleST2iuCa/hkJbP5QypILd
 n2IfYcdzlFSbvwCyt1npTSG2xvIm8/ItUxA1hVZFxyH7OaohVTCvRBYubfvktP1RhqCUpx4I5
 QVhnnGufw4YgBZOZV2J4Cwakh+4Ff0GhGPZ3t9/o7Uts62oEJ1Enk3rbsZHCEFHz8oDyP8Mvi
 kEc3SbZNUsqMY8OoinkwkpLOpPmuledSip6OSg==
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
all occurences of 'struct pmk_cache_t' with 'struct pmk_cache'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 8c269624401b..b8a9d242e95b 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -2123,7 +2123,7 @@ void hostif_sme_set_key(struct ks_wlan_private *priv, int type)
 static
 void hostif_sme_set_pmksa(struct ks_wlan_private *priv)
 {
-	struct pmk_cache_t {
+	struct pmk_cache {
 		__le16 size;
 		struct {
 			u8 bssid[ETH_ALEN];
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
