Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4127268-1519815972-2-11452735609834395605
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519815971; b=IQ73v8DXyURQR5tkPUt8lsCLjhg/hTF6sOuj6Y4P0ieXPpW
    RW7J++kFLFK15CUmqV4YfbGXs+RVCzXUglY12YgPchBBnXPCFkUvRt6RPXgJZCDC
    YpB25y191qxA6q1fLa8CG25827ynUJJJ0d3dusW1Nw3uku+/rl6jcyz1FymWEJnK
    Y90ALLajrheVF89qfXnJrt2C4CwNh2HEr1qFWu1OGnfAGhFMcZ+mutxqIGQGkULy
    1mki9ginWPWqyWzhXWt0DrdzXdssLcSihr1Q/6dM7UIg2DvSZmzRXVcIii8HD6H9
    uwW3Zn/im3rKB/mofU/Nr+ZUtBVyBdjLhTVZ5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:message-id
    :date:sender:list-id; s=arctest; t=1519815971; bh=wGA/L0lCtBA4XH
    U20jaYZobus2Ono/V06qFfgdJEKJo=; b=aNcL1XekXzOsDQbcE0hqce7LQOkMAC
    phsa0b7basObKn921O67W/i2QOBnMDb8XlRX7gWRghkaQcuUvRBb/GwF16F5hsTz
    dBHNBHEzhsGrdOurH6iI/dttvGJPMzOOFQUkE8qQ+8vq5iG5eINklBHb7OSP6qkz
    3yhRoE+E+3mgu2cFUB4RbiQjQe9uYZyBFrbIXXglljGkxE1PidMq+Si5Ss38q1YT
    NXej3WHqeOUU4l/qdYexSW9JkwpUDv0/gm7K/FegJCvQU5ScXqO/cCciwkeOolIK
    UhGUg3nv6fQ1bSRk24ZHDMPlLfSjd7wpoHz/wjB9H26AGE6J3B5Q7Bbg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=S012++Zx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=S012++Zx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeB1LGJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 06:06:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38200 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752120AbeB1LGI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 06:06:08 -0500
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        broonie@kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: wm_adsp: For TLV controls only register TLV get/set" to the asoc tree
In-Reply-To: <20180228103110.2055-1-rf@opensource.cirrus.com>
Message-Id: <E1eqzYi-0005BJ-Eq@debutante>
Date: Wed, 28 Feb 2018 11:06:04 +0000
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: wm_adsp: For TLV controls only register TLV get/set

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From d7789f5bcdb298c4a302db471b1b20f74a20de95 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Date: Wed, 28 Feb 2018 10:31:10 +0000
Subject: [PATCH] ASoC: wm_adsp: For TLV controls only register TLV get/set

Normal 512-byte get/set of a TLV isn't supported but we were
registering the normal get/set anyway and relying on omitting
the SNDRV_CTL_ELEM_ACCESS_[READ|WRITE] flags to prevent them
being called.

Trouble is if this gets broken in the core ALSA code - as it has
been since at least 4.14 - the standard get/set can be called
unexpectedly and corrupt memory.

There's no point providing functions that won't be called and
it's a trivial change. The benefit is that if the ALSA core gets
broken again we get a big fat immediate NULL dereference instead
of a memory corruption timebomb.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/wm_adsp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 66e32f5d2917..989d093abda7 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1204,12 +1204,14 @@ static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
 		kcontrol->put = wm_coeff_put_acked;
 		break;
 	default:
-		kcontrol->get = wm_coeff_get;
-		kcontrol->put = wm_coeff_put;
-
-		ctl->bytes_ext.max = ctl->len;
-		ctl->bytes_ext.get = wm_coeff_tlv_get;
-		ctl->bytes_ext.put = wm_coeff_tlv_put;
+		if (kcontrol->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
+			ctl->bytes_ext.max = ctl->len;
+			ctl->bytes_ext.get = wm_coeff_tlv_get;
+			ctl->bytes_ext.put = wm_coeff_tlv_put;
+		} else {
+			kcontrol->get = wm_coeff_get;
+			kcontrol->put = wm_coeff_put;
+		}
 		break;
 	}
 
-- 
2.16.1
