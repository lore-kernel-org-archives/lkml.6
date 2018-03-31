Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1160787-1522476718-2-4376634590268059074
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
    1522476718; b=NWTuXu0SQTZ5c6yCdaoC1YnXtBqoeNzJZUIS17C+m8Tyyj/hST
    7aCjXy2+tXj2z95TzqfXlYasDMpCtdevmaut7V9O/aRQcBVcuh2WFk/vAFj2fS/M
    bO61wf9qmNd2U6a7irDR5c96O3x2uPUHzqjl13EYyLn+ncW/onane9N3BS4qeBSg
    +KQNAu3GA7UqaYyzpPA0Pf1uIxvTKMme+EtVwYK0KFwBaT+/vEV05Y8wNfvy+pAT
    iC0mbmFqs3BlpjLPReu9qXa0Kok3j16Js7d6qMnvpaMkOg7z2MqYYYsR6STHTQD4
    6x4CcPjti12elB449ptBfrqiqQksxsMRPr3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476718; bh=IrQg9
    QSvgETWvMsa6jdi+UqMfBiGD+nn4/Tk1DrAQrk=; b=K8j17o0Ij+DMDQWDUaKHq
    eVzNJc7jh2dMX9A5mXqNlLiVfT9GBpQx6aHTtIJ6WYUHtStprKS4yv2njP1QBye1
    3eO8BRaJcsFY1bK3CZn9HbD8pvQjOZ1PnqBFoPKV7rHQ/MtAJsjqj3Af1Mh4OLqd
    13jPP0w43Qz7MGJucIXU+V2lZi5b/i8W3BIgJZHj6NnVwbPUW1/S4/9cqObH5h7S
    XjTE0pY38lxu7p28lGe7/QlvWoAqvoUebp9D5q6Kf2pOWj5V99wXkZZuZbZ6SUiL
    l/SU3zIzvFmgEY9Nlcrs2A8FWXIjWKOjEKd+6rAHB/kagD9Jk4bm6Q5WUs/B3UTs
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfORBWv+EVMJj8gRR/c1qIRl4RzK3Xzj9//H/AHNskD+y+5++IvUkM+mnpsyl6ywGGf4BG514cTwhA+STydGTqa7MQMNPsJYUC4nbeI1glRzWzTlMeXU9
    9vxpdAC1gZ7lzS+sGPAfwq7eu+Ymx1Veg34iTPGsjiX4tTkF49sY07ylHDFwxBg6HThP9OSPkjRl51t1jXvR8PeMasjKPVAHx7fO3xaJrzAiSMFnFfGi367u
    gewi3QiNT3nip5U7tXSASQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=MBXM6yTHWV4dAfAIpPMA:9 a=rU0Rcz606i24Et33:21 a=Y3eOlSroz8qpGpXd:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 57/75] staging: ks7010: Remove trailing _t from 'struct
 local_eeprom_sum_t'.
Date: Fri, 30 Mar 2018 23:08:37 -0700
Message-Id: <20180331060855.9452-57-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:ujehENTLNRmjiy+hcvXzF08Yk0Y8m6nwbTP1/7L/dnFfNpjeJ4j
 XUUrVmUL3bzRt3JSXZaMb/E/UEjmj8UdGWfl6RUv70IWfv/yzJA0opc9D+AkOYDPRxv3z5Z
 ArKq1M1+q/frwqFewm9bcL0cwU2b7o353DL+Jgyq5uapvNq8cTCp/gg4MUvi0M2875WouEM
 7D0Sw0JJEMU3wXb6QW5qQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b4RyxJQnLOs=:jn+mz34dSBlu5sae/Cus3d
 Wda7b4spEa6EJeJCu+0/jYa7pMzhdjMVU7DTNdfaAUwQjFiwq1jkwWiR0OWQirUm/qZk02BPt
 9kHovS88QDhuMEIsby8cPXahId0XjftDxm7WoA6cOTMp7HgIaHqpjJoFoRm2ZVeq5hWJ5AOdo
 op1Cmgw0SxGtmixGlkRw2d5RhZTatXxYNLCwcm3Sa38ubEvLY76P1+P92Snv/FzFjQStR0suR
 59dQDcl833xfu/d3rasFk/NIntnh8yiDKjqnj0/LBCmKeJL7BnIs6no/nXJJTLFX+PiEkHJsJ
 e/35afobiZd5kgxICXSKs5zjJ9s1Y5eqpCgAYIzdt2DSOWBhn8J56re5/m439INlrLzwZIdM0
 3rYniiNJcbl+U+sjt1/rTRX0VV0GVnNNXrTCGn2TwIZqBBg0xKeiFw07ujhH/jMs5zW6gAyNO
 UV2p9EBZbktxM9597Ake5feWczj6K5d7Lmoij3s+MP7jese0YiRuQYzHih46csdwHKVvKtkOc
 4nrUTKXXl4mgexKbZTqbU1QgrFEDd8xroGKRWd8/N0z22wfSRmRDFIBSCEvRyeRxEl1LOCRMg
 0nb3a4EyTsrKuf7x9RHpS5OxrY6dW3ii/VB/2AHKRsi/Ol8gffhJUHWdTv3wBqEzDC4KzPHoF
 c9sU5zR5SS/1PSXVKUYINDavNfxGht0zzQw2IExbmzRWULJILN1CAUGFnEkhdqhPk90TgvBRE
 lhCOQjeod6PoKJRzcox+h8D8OUEcatHEoG3d9Zbs5GxNW6WiZtd9tBjOztGSCEsB0k5TY5ow7
 T42/lFKpGDl7YSKxory6rN2Hg5ziGQXzs4uHwIRUpRgRd1S8YCrZCB2qKQbPruumjKBo00QFp
 Kn8Sb7jAy/mlt3cuQpr5af5zYoLM2kaL04xEDdp8yA4r5TvaZ67RdP3C23DueE
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
all occurences of 'struct local_eeprom_sum_t' with 'struct
local_eeprom_sum'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index e6c4a0fece54..f99b00344d39 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -256,7 +256,7 @@ struct local_gain {
 	u8 rx_gain;
 };
 
-struct local_eeprom_sum_t {
+struct local_eeprom_sum {
 	u8 type;
 	u8 result;
 };
@@ -480,7 +480,7 @@ struct ks_wlan_private {
 	u8 sleep_mode;
 
 	u8 region;
-	struct local_eeprom_sum_t eeprom_sum;
+	struct local_eeprom_sum eeprom_sum;
 	u8 eeprom_checksum;
 
 	struct hostt hostt;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
