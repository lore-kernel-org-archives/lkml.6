Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479692-2-15990320309405692815
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
    1523479691; b=qSZIqMtktsZUTLQLOmGQsuwDYM4ItqzFzFJbxburLED/GrlAIn
    WtVLRW4eUeNFoSTUgUHcxH0FbRwdSdYHLhwQ6Lm2EUAMCYn/cLCEcedO2RHoAQoy
    I2HuNPF9ddYZ7bZilPVAlFv6cogyGH3/xop0nCbQ29GppPO3Jg4pfDli1I0a/Qfj
    X4jFm9FZsCziDM/QhbVR9cayi88CZZiC9s+foA+9oFfrt9ORemvf7Q3yy13nyKVZ
    N0a6WhdmD/x0tHD6d9jjLtbWY7ulI80IJGV3K7WW5xODRVlyYhvVXm5Y1+W7B+74
    HVqZR9SW6JnFVCyvu7YGU9b+3sceOT68AGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479691; bh=R+H8zHH8mNDX/GGJy+Qu4vYIp4nk1f
    2Smp1kw5soHwQ=; b=tJ3YYmUYBtHLpJZ/Qi6V/q9qDPYDmE7SuMLn1/Q4yT+rvZ
    u3slosZ4zSU1XF1NkhOaQl37vmRJWzLOB2Kr2ePjXT6JUX4aDm1xZ0Bvy1Zzhx4x
    5rWCh17pweyKgDHzPuAmiPUXbHT7BMrwcYFkP/H+E65qEv5LSZqtB9H1qknA+boB
    WcSrjrAMIFrU1FR/AmhQuK780mfWgBJJW6asR3/Q7fb4yZJNUIy5YtNi5+jrc97K
    LZLA1FgBNbsBFSGRNGFfhRwkUxJuDVcEvH4/EXVipnUSZXBq70usH/A1fa4++JhQ
    GsVf7PR/1dwRj1Bt0LV0OQxEzcDtliqlLThid/5Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfKHrvSvv8ydFViTZyBGFFcWdM0habau0+8czJHAOYri3Rnc384PCQoUShHSQArmQazQOTm6zyjnu2ulln0/yLaYkptvrRg+pXirF2lpOPJ+Hhtd4eSVC
    S5SaCKX9Ztx/DJQ83Pnn5cGizUlNJ5CeW/4EDrFGTFkeCxW7bFg+UGNpDIhmqIoGEc7H5BjHz/lRgSbsA1Gja5LbTtr3HcQBJeZp1OoiyDXfdgtx8MbmrUIo
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=pGLkceISAAAA:8 a=LpQP-O61AAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=mszs2ZNTGQiz2OjqG5AA:9 a=IMEryRM2TtodLh39:21
    a=BFySnzN-hxhcZp44:21 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22
    a=pioyyrs4ZptJ924tMmac:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755725AbeDKSqZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:46:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58896 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754987AbeDKSqX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:46:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 060/190] ray_cs: Avoid reading past end of buffer
Date: Wed, 11 Apr 2018 20:35:06 +0200
Message-Id: <20180411183553.829823073@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
