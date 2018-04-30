Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525117055-2-15643074332282985093
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
    1525117055; b=hdhiU6r+EiUURDcG7CHLeYWrqEdqKw+HbeT+2Hk+OrCaQJwSau
    ZjICmhdeK5BRyUWPQc0Ti4ob9rPtZ4AyaAalMglaPHBhT0bwBhG5BZn9EpcR8VZ9
    UA/yx0Z2o6dle1dq1tvrZZjOJD5EUhoGhK3XjyDNihgozNu2uYGaOnW3xUaykp8f
    p1F0+KBCrlFHiP29XyHeAxO+ogJCdyzFwL6cQe6O5JMAl8JKML3VE+8MMwjhdJJO
    AgneJbB5omup4JCxFkBC5yPk+2V2wx5/r0LeCch55/rZyfpa9bw4GQFlWHTvQkb9
    KwMhYpoCeeKMxNYzyb6gedlnY8ZXbqk3t3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525117055; bh=ceYz1JbNhL6lM7xNcjqZIY/lmu4tL+
    ZxGCudMZDTAPw=; b=XT3tItpTagspIODjv4Fa9nGbB5DIol7gwx2KwZvpbItRxq
    T0XxQFd3im6olTEqQf3EkrEWUMJq0qOfAotsbyQX9Wo6IRuJsCFzpBbQKAMTD9S7
    zR8i5cQE/b9tUZ34N4YJ2jmSrop2DCOp/rS7+1d8dByOh5JTn483z5pd6DQG6VS0
    VO/SxgiTlbuDXCw9Bjs7JCseWSYF5yG4UM0l8uf64uD/oOAtmns0qu5Mq4TfFW+T
    yF3idoQzKufM6XjwhPEfcr0dPptgID26xTPtQP+LCQfJDkP9SjPOyPOZa+wymgaX
    Q22/vRg1VN8Jib3ss7DnZJBZ5aPQS3eM38UD2HMQ==
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
X-CM-Envelope: MS4wfOXoLasmdilmOe6smfpGzlv49vrQc0QzykyAwX2rn2GTUUQTmjEgtI/XwbtbyJFkWtjNuCsETYutVfveAsuDaKedtSdq5uyZ18MeFUoG2YFAGplt2d9U
    PiBJmXNIeBOBtiC4H0x6kXKbNpiLihLYB5tySiWMJof5AimcymrP2xtlcu/2AP+bcr9VkEwQq5cLNE3ng9NaashovOKtJLfceeJNtMUUaiF4j9Di+UfQEkg6
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=SN8IJsBbIC5xGUleRXAA:9 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756396AbeD3T2n (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:28:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755343AbeD3T2j (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:28:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F2722E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.16 085/113] ASoC: fsl_esai: Fix divisor calculation failure at lower ratio
Date: Mon, 30 Apr 2018 12:24:56 -0700
Message-Id: <20180430184018.786859422@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolin Chen <nicoleotsuka@gmail.com>

commit c656941df9bc80f7ec65b92ca73c42f8b0b62628 upstream.

When the desired ratio is less than 256, the savesub (tolerance)
in the calculation would become 0. This will then fail the loop-
search immediately without reporting any errors.

But if the ratio is smaller enough, there is no need to calculate
the tolerance because PM divisor alone is enough to get the ratio.

So a simple fix could be just to set PM directly instead of going
into the loop-search.

Reported-by: Marek Vasut <marex@denx.de>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Marek Vasut <marex@denx.de>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/fsl/fsl_esai.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -144,6 +144,13 @@ static int fsl_esai_divisor_cal(struct s
 
 	psr = ratio <= 256 * maxfp ? ESAI_xCCR_xPSR_BYPASS : ESAI_xCCR_xPSR_DIV8;
 
+	/* Do not loop-search if PM (1 ~ 256) alone can serve the ratio */
+	if (ratio <= 256) {
+		pm = ratio;
+		fp = 1;
+		goto out;
+	}
+
 	/* Set the max fluctuation -- 0.1% of the max devisor */
 	savesub = (psr ? 1 : 8)  * 256 * maxfp / 1000;
 
