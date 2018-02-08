Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2982132-1518104570-2-16617920258136592793
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518104570; b=sH7HiNo41IT8Bx9KnQwd6RgAhHFS5plwWVsf/m81BqUQTY+
    dtFsp+lYJrKlWSSUXh2VdPQOGxTA93Gz43WkMyrSaWGLJyH1dpRZCux5xqUnM+1P
    0ojOb0L7E8WHYv7vCramp8MEesAjdMI25dPMmCZclRB1mN4zEnr7a6YtsM2JgAr4
    BglIBKXGQ/nD09sdklpHvBigVGUUfcQ5UdzH6UAgXkXS82+ugUUjUzW65kBiq3Km
    8sCLmVmW4oPF72DQZ2FiU7vmO+d9smhTO1X6J5qw6MXwsYw+OOv6FugsDLK6FjIU
    KHxdQJ4MAQDuVVwvTkBQCkKNbX+xgKm4fqwnlDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:message-id
    :date:sender:list-id; s=arctest; t=1518104570; bh=BOsVEKMcNS2QUb
    k3PwJtlK0ZRUB0pD7GncqukDWtGKs=; b=sgnigcArGPFaygUQJGqPQEYrSmXqIs
    ioCLU43zUlMEO5vbLaNFPyoD3h86jjS76qcaHyGAgI2aU90H/EuwxkdinrOblFHh
    KZQPFVE7fCAe8+lC+WoZeYwnRlGRT4ZkMiaTkaRL7xthHJYqU1NFGvgL77x26jb4
    SENIl4FXn6PjFHClIjM2dlrX+fYahTUW70j68FVgsWGmPriRPO2h2qnEXu9D3uOF
    zyca9rcJQfagh7NNazS8fKt7rQ8aLdbe6TWD2yOhEUTllaFflKmLj6Z0Fq4c0Eeo
    Z7FCzRtFnK9Cj14pD8fLvkKCWpKn7NfxLh8ziawzwwXTyImoGuIoeaDQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=Qlk9wntX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=Qlk9wntX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeBHPme (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 10:42:34 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35822 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbeBHPmF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Feb 2018 10:42:05 -0500
From: Mark Brown <broonie@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        broonie@kernel.org, lgirdwood@gmail.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: stm32-vrefbuf: fix check on ready flag" to the regulator tree
In-Reply-To: <1518097385-7449-1-git-send-email-fabrice.gasnier@st.com>
Message-Id: <E1ejoKj-00006C-SN@debutante>
Date: Thu, 08 Feb 2018 15:41:57 +0000
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   regulator: stm32-vrefbuf: fix check on ready flag

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f63248fac563125fd5a2f0bc780ce7a299872cab Mon Sep 17 00:00:00 2001
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Date: Thu, 8 Feb 2018 14:43:05 +0100
Subject: [PATCH] regulator: stm32-vrefbuf: fix check on ready flag

stm32_vrefbuf_enable() wrongly checks VRR bit: 0 stands for not ready,
1 for ready. It currently checks the opposite.
This makes enable routine to exit immediately without waiting for ready
flag.

Fixes: 0cdbf481e927 ("regulator: Add support for stm32-vrefbuf")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/regulator/stm32-vrefbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/stm32-vrefbuf.c b/drivers/regulator/stm32-vrefbuf.c
index 72c8b3e1022b..e0a9c445ed67 100644
--- a/drivers/regulator/stm32-vrefbuf.c
+++ b/drivers/regulator/stm32-vrefbuf.c
@@ -51,7 +51,7 @@ static int stm32_vrefbuf_enable(struct regulator_dev *rdev)
 	 * arbitrary timeout.
 	 */
 	ret = readl_poll_timeout(priv->base + STM32_VREFBUF_CSR, val,
-				 !(val & STM32_VRR), 650, 10000);
+				 val & STM32_VRR, 650, 10000);
 	if (ret) {
 		dev_err(&rdev->dev, "stm32 vrefbuf timed out!\n");
 		val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
-- 
2.15.1
