Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1111812-1522476694-2-666470510095568162
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522476693; b=CO5fh0e1cGvsmkqQz1a/4XNvidmz2tjYMDDzFB5Xg8PIm+SRGP
    8JzGMEqYqf4b3wsLEcNuA6M3RfWHtfgjoydDkn2+pamYuCAygWmlkMBV+2m93qYF
    eFEjNO45wqv55GO4fALUIpHDl2+y3dJY6BwZOR+OXx5dLE+iU73XlWZh43gqa7wM
    5LwyaX9qVjZENvoahIPtSH9PWY9PwFU1RkO4hW9E4XydX950W8iLKWqNKH0HeFkV
    IroSocs9Qjn6CXBkADKI6FBjbpMgbDeCN8DNUuspMwHKk7DQb1BhV4Cg2KFYhSjV
    Ksobs7YeS5xzwyZx494quCs8xld1ia1vjmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476693; bh=ANoH4
    rDJ1NQ5Gx0y1oJEcr8rreken3MyCnQLbKGdaTQ=; b=EZjJlRuWvR9mHVJ5hD36m
    SC3duSIy7+q+mXyORdkU4Cq1ie/MwBzXffIramkDRu0pjgHVUg74Sxe2oBD5yH6g
    VqssAAudtJ+ZnEBZ9XeIlb9VCLHrYhPe6hA0VJzO7FsZkjdH5N8X2Wj4HXn/Vt8a
    OSu42XvuOIjvcTdRo9I+Zy3fnYKqNJsCirkEEqxvSvIFC2jWTg1rCK/d81l5RNAO
    r9ufbRCkhLMjO9DNS9jKzjlg0KBFumIIoxD9I4tlWFYi701q7tY779ZNvl0vQeN5
    fgVDNSa8v2V8ZT+svUA/Ty6EHAcKI61hQjLMTwQFClqIq4PAtZVbDxxMnomQ8Yl7
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGHuo+FlQuNYpZvF00CRZ5rm3pvqsXKf/zY4MFmyz70xGLXzoj1I7Qv059dCtD+QUyunIMb9NGwKxeF99l+g9ejZPwExhxA6J/vNz1fism9Nv21ZClc+
    V8JbPJMod+ajt1084ici4I7kafCUNslU+uVXybaLws8Do5esdFiq523i7h9ExRl6BW+20KU+C1qw/d+5kf0696Nw3JuSfmP4aYTtJHqm8pDhwI4UPi9cjKaJ
    Yf74Vgi6k+Ko5tKWbEpYYg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=MBXM6yTHWV4dAfAIpPMA:9 a=sKaoHJRpcJLRr88H:21 a=5UC9HWKxfHXp4bMj:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 51/75] staging: ks7010: Remove trailing _t from 'struct
 hostt_t'.
Date: Fri, 30 Mar 2018 23:08:31 -0700
Message-Id: <20180331060855.9452-51-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:lSt+fYqpeEfVsijGYyIgl8BRzA51WaXz4dZ/R2t5OfXM7AOTKOq
 6RCxp71i73MbM7NH0kAmhsYYSVi4vzw9QlEFYve9N0Jb42COGlyGBoRl8GeoXZxXRKae6UK
 9qPejJKHeUuL5ILk3SbnRlwP8IVKUafZcKx04YAOmOFFa//KrWtZY9nI8/oE7mv2qZ9yVbg
 USozDjaFUJrWCJ0qANHNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wWmrbcATX1w=:mj4XZOuEtqqt65XShi2vE7
 XCZJr+EMGzGLk/bmUvJ2+lN0iqN7xsPPCOkchrlwwz1LESjDR4Abp+N7gcy0y87ukFCyUqg/M
 SsGEcZhdDDJ+el1EHR+bDh1h4QamBKDiFNTZQHF+tlbM25HWAQjLEymWO2ocBLWGK6yR82mmz
 4Em2B5q2tEG2Q0YlD3wRLRb6DrBQvZg/r6WEOAi1led0/ns0wvTGjweHJpRZFw4ympCfuC+gs
 M6jUUD5+dbWDwvak81a90DLX+S1FidqL5RzzSXzbIh1nebwlH2mAEJ5Uu9JZMJk8MRgAQ3VLu
 dMNSUB+JrvtwqUJmF1IwzclX2GFmGZr8QEiA9D8PTzsjp6D46viwIoUATMJDMK8yZASy/2MH8
 UKFrwDOuX5piCGibCEvDiIbLfkD/Iq7RVvnCqqRkPJvIppuxL1gO1Hr/cmCKWA6t6LysVfOKK
 jR/nXVW8/XV2ibxQa5HcQheZAzBGo60knP/4wyoehwncC/Og/HDXdxgajshaW70R9Tkc9XQA6
 OQX8W6S5fT/Wm+1QhL1ZJkjMKb8QgkThm0ZCRA0C+xUCI1nvzKftUXUJH40rY2CrBVAHiJJSC
 ix9Ik5zgo9unL5+OCmUAeZ8GgaMtYu1OEXCF1qvD20C4GaZClD5DhJw8Yxs6bmeiyHjPkCAu2
 XQuA941NeaPWF9lECw8hoiZrhghE88a+ydXgHggec/MLY2JDPitFjHjvZOXL121+jZ2qhCuy/
 nI2RJrCz/DkCaREXta4ttd5PTAuGwzSraLibTUgA2Gj+z9sKI5ZMx9ayVvA3W6b6Wj0x5qll3
 8TtVvFjzyT7jZPhOijbXk3M7tv6uEh+RXHUHvXm8KAwhgfECWlIoYzDOYAsuDeQ6XlbUgTP9I
 uBZs6b7FUYbDtlIzl7Ev4372U3BId5Y6cZeatDRW42DOMu8yvSxxUmCttJtvjj
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
all occurences of 'struct hostt_t' with 'struct hostt'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 1b7036c32d1c..3ea62b708b01 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -196,7 +196,7 @@ struct sme_info {
 	unsigned long sme_flag;
 };
 
-struct hostt_t {
+struct hostt {
 	int buff[SME_EVENT_BUFF_SIZE];
 	unsigned int qhead;
 	unsigned int qtail;
@@ -483,7 +483,7 @@ struct ks_wlan_private {
 	struct local_eeprom_sum_t eeprom_sum;
 	u8 eeprom_checksum;
 
-	struct hostt_t hostt;
+	struct hostt hostt;
 
 	unsigned long last_doze;
 	unsigned long last_wakeup;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
