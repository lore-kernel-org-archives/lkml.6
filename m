Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523481689-2-8836012764414570806
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481689; b=Mf2IWJGEwhn/wFUCSSj4zGbyvasALWXAXVBHxlY10qPSOrpN9n
    5eCryxS1G6D+Oe67uEKP1mBmkeOQ2Y7jF0W7pms/OiQ1ZoaoqtEv2R2wTeMyszS3
    OQlV7lwZnKV1CvTy961X7tbF1tv7iMQwXk0OQsyrRc+CkpuB/ng2QzrxInnffn2g
    TC5flOXxFZ3udTc0zYfeuQkh069jUtIL3ZZCGHO0y7TF9DkJdTESGoxskXXTMi07
    mtTMoGS9lBiooJWzH7M8xzuVmn5hKIzT3g21dk7+FqNpann0aioVIa2UknYGoa5H
    jz1NYRxHZsY9K6T4vPJWvVEcX24dzZz4a3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481689; bh=dHGe6V+ZGFWTu/z/1n0EUhbneuaxGU
    8oCMBNcL7YWKQ=; b=LO2QlsupoE39dap/Qe2TAKRaXp2198mnpcwkyowGe2Ra2S
    toeNz165opkC5/t1/5vFQ6FuuQRlPI2+7nO5xNOslxbujM17b0c/RRDNOfjYWZJ9
    KURx68nZFDGncV5mG9P1fiurkgSdjOKARD3OgXqUp9Z1z0SnwZwNd9uyXCyKDBsl
    EKriqB3AJjqdizuJLoO3gFqkCm2LAAkizwFIvn+Tglz3PPMXrva9uO+QMORHM29G
    UsO1OwBPYUDwl6TvgHQycvWbT0wWNsF8fQiv0DkggExuWDo9YTw55p1b7GbWKpgx
    w43sp5eqjDTdXCQtwXWmwS9Oa7cPR2GgSe5MHelA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNPaiaRLwvcf2IoGgMHAfEYg9e3O92BgYJ2T1sGUp/PWqxV9LHL4SiRNxNkJZel2JOa9Kxr63O6hiNMVPKsc3d159sn/3+KuK7zqRVy4y8qVtX2hF3bp
    MlfZe3rDMo7/qVhA7FqFg3nMGW9v2f1h/iCHL8RH6+exBzGrtIvKP6Mnp5Rl1RaLo7+Ll7bLbE7c68E+n7wAbFEAFzduMhMLqYahtABXBqm+ZAdrraaylSlY
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=pGLkceISAAAA:8 a=LpQP-O61AAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=mszs2ZNTGQiz2OjqG5AA:9 a=4UkKTrb-bdLhrJ1O:21
    a=BFySnzN-hxhcZp44:21 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22
    a=pioyyrs4ZptJ924tMmac:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755195AbeDKVVK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:21:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55986 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754344AbeDKSjR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:39:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 037/121] ray_cs: Avoid reading past end of buffer
Date: Wed, 11 Apr 2018 20:35:40 +0200
Message-Id: <20180411183458.465703375@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>


[ Upstream commit e48d661eb13f2f83861428f001c567fdb3f317e8 ]

Using memcpy() from a buffer that is shorter than the length copied means
the destination buffer is being filled with arbitrary data from the kernel
rodata segment. In this case, the source was made longer, since it did not
match the destination structure size. Additionally removes a needless cast.

This was found with the future CONFIG_FORTIFY_SOURCE feature.

Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ray_cs.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -247,7 +247,10 @@ static const UCHAR b4_default_startup_pa
 	0x04, 0x08,		/* Noise gain, limit offset */
 	0x28, 0x28,		/* det rssi, med busy offsets */
 	7,			/* det sync thresh */
-	0, 2, 2			/* test mode, min, max */
+	0, 2, 2,		/* test mode, min, max */
+	0,			/* rx/tx delay */
+	0, 0, 0, 0, 0, 0,	/* current BSS id */
+	0			/* hop set */
 };
 
 /*===========================================================================*/
@@ -598,7 +601,7 @@ static void init_startup_params(ray_dev_
 	 *    a_beacon_period = hops    a_beacon_period = KuS
 	 *//* 64ms = 010000 */
 	if (local->fw_ver == 0x55) {
-		memcpy((UCHAR *) &local->sparm.b4, b4_default_startup_parms,
+		memcpy(&local->sparm.b4, b4_default_startup_parms,
 		       sizeof(struct b4_startup_params));
 		/* Translate sane kus input values to old build 4/5 format */
 		/* i = hop time in uS truncated to 3 bytes */
