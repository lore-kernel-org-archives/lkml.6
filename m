Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4191898-1519818834-2-17644923557867764838
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519818834; b=wzqHfCXAQlsvIEWiALK//t5AAMC2vC6zkSN6T/JfhIVCrjQ
    ofhTljhFbhfAOtFRtDUhBaUIUgDt9mUuCxxj0OwlGhzFwlvRv1pOO2PplLMLehIQ
    7sFCZvp6PtWMqVqe0/CKnJWoCDj38jnz0cvx/iFwOSSw5JT+za96HP4qEhTPe91y
    Ha2uRilgrAYNlvVe66JOQOjYQOJ0wtqT4sQ0xQj2fNMHu/LhVfEkrOwSvgO6AFqB
    6bNjdVgi5PFt1obWNeXtJDd9xPW1Xvj6YkhCqOmA+sjEczCU3AevN5j3beGhHbiN
    KUak1MgXdmXvOWF6DQwdP8qXpsldW2RVMIZky3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519818834; bh=+oTPYvEzjyqb2QN7yilnizNksC
    X7KBlgUqouFQ4uvww=; b=l7bX0ynyL1bV9sXiP1qgaagYw8AnIXhzX1Hg8KMnV3
    5pVYZfuFwJyvI5lKp0dDafT05nxjVIdGBpmfjz9E0cD5BJgInfSYE76ggqCuURJd
    V4kHp3WZSKCdPxPVFEYcPgJIF7DZbBeISe/WuiW2J/tPyb6gWv7066GqrHP1pAor
    4vO2uuII8ZiEcXpbyjhGpmHpGZ8ppGguR6uwF5VNETtS6gaPThmLbsg1C98HsrrC
    1LLH+1Ph4sWwtGeCH9PR93GZoxHFRWwAqI5EUA06NhlXV/1Olg085zJc3gcTyrHX
    86sXm04NVkreMHi6R534qNZFh2No6Ud5DOIbqczQ5CvA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752418AbeB1Lxl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 06:53:41 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:37562 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbeB1Lxf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 06:53:35 -0500
From: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
To: linux-mmc@vger.kernel.org
Cc: Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        stable@vger.kernel.org
Subject: [PATCH v4] mmc: dw_mmc: Fix the DTO/CTO timeout overflow calculation for 32-bit systems
Date: Wed, 28 Feb 2018 14:53:18 +0300
Message-Id: <20180228115318.20154-1-Evgeniy.Didin@synopsys.com>
X-Mailer: git-send-email 2.11.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In commit 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation") and
commit 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation") 
have been made changes which cause multiply overflow for 32-bit systems.
The broken timeout calculations leads to unexpected ETIMEDOUT errors and 
causes stacktrace splat (such as below) during normal data exchange 
with SD-card.

| Running :  4M-check-reassembly-tcp-cmykw2-rotatew2.out -v0 -w1
| -  Info: Finished target initialization.
| mmcblk0: error -110 transferring data, sector 320544, nr 2048, cmd response
|  0x900, card status 0x0

DIV_ROUND_UP_ULL helps to escape usage of __udivdi3() from libgcc and so
code gets compiled on all 32-bit platforms as opposed to usage
of DIV_ROUND_UP when we may only compile stuff on a very few arches.

Lets cast this multiply to u64 type which prevents overflow.

Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com> # ARC STAR 9001306872 HSDK, sdio: board crashes when copying big files
Fixes: 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation")
Fixes: 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")

Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>

CC: Alexey Brodkin <abrodkin@synopsys.com>
CC: Eugeniy Paltsev <paltsev@synopsys.com>
CC: Douglas Anderson <dianders@chromium.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
CC: Shawn Lin <shawn.lin@rock-chips.com>
CC: Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC: linux-kernel@vger.kernel.org
CC: linux-snps-arc@lists.infradead.org
Cc: <stable@vger.kernel.org> 
---
Changes since v3:
-Switch DIV_ROUND_UP macro to DIV_ROUND_UP_ULL
-Make one patch from two patches
-Modify commit message

Changes sinve v2:
-add fix for cto_ms

Changes since v1:
-uint64_t switched to u64

 drivers/mmc/host/dw_mmc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0aa39975f33b..cba534d4c81b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -409,7 +409,9 @@ static inline void dw_mci_set_cto(struct dw_mci *host)
 	cto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
 	if (cto_div == 0)
 		cto_div = 1;
-	cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
+
+	cto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * cto_clks * cto_div,
+				  host->bus_hz);
 
 	/* add a bit spare time */
 	cto_ms += 10;
@@ -1944,8 +1946,9 @@ static void dw_mci_set_drto(struct dw_mci *host)
 	drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
 	if (drto_div == 0)
 		drto_div = 1;
-	drto_ms = DIV_ROUND_UP(MSEC_PER_SEC * drto_clks * drto_div,
-			       host->bus_hz);
+
+	drto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * drto_clks * drto_div,
+				   host->bus_hz);
 
 	/* add a bit spare time */
 	drto_ms += 10;
-- 
2.11.0
