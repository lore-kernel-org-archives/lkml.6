Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7341EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE172082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE172082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbeLJUyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:54:09 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:59053 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbeLJUyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:54:08 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M3UhO-1gVuKd2gpG-000dPp; Mon, 10 Dec 2018 21:53:57 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ajay Gupta <ajayg@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: nvidia-gpu: mark resume function as __maybe_unused
Date:   Mon, 10 Dec 2018 21:53:45 +0100
Message-Id: <20181210205356.2846843-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CW+VANAtXIQWNcjOIY2sMeZksNODDoahiQkGAfk66JxUMkQimGA
 kIfAvvUthrNtlOyOrtdDG9aVQu4UH+QJJVA46A+nyN8MJpFgzWiTkUl6Pt6qfsQzbKTHd/F
 g0MtgtdjF7Xyi6vGs7LTH7ihBQk0Ro1vrLfEGCkROCYP+Sx/mKanYx0BRSQCbiFsClGROyF
 UjaKr/zkKamJN/+ecAxuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XNgpvOIInRw=:qNWIII9vjbt321CDM8kL49
 5qS/ajGqVA1mBDIEl6UAPvZUB0DrcBHw546djLqQnGSjFbBPeOsJsTrjqMFAl1OpKZlLWFN21
 jG0ZWDssc8WbDFWhuDRrKDctsGSYiLD8RtP4p5nqmXh103T2LPazxDnEx33AlKYsnDPVaFe3y
 uS/XBfgh+6/RanRvhmpvDD1RLfmfxPzYRu4aCbcHO6gJu0wdedGA0citB04DlKRgQN+wzcGk+
 7T3uR1EH5c4zOkIcynWSt1kT6de9BwbwsNXHhFXil/nHTNry8lWrIIhcc61w/LxWa3EiKGU/r
 b7q/4I03vyxhFgV3IAu4MBvFbKFwiP8SkU/nELlmJbedC5/TF9lusI88oQR11YAan1QjyPfwh
 MGdPl64WZAGaqwT6Q9YykdTTU0MAcVWVbTi9lnjsxGTgR4ZU2b7TyAc7malp1Za82S6YCPgZh
 98PBf/Xyizep9naiguEiNuB4MzJAPZbU4nkETN+7sPcvXFBTDQjhLMp1VyHISzV0zx84o3iJ5
 9doB33bwkV2cFIywxJKwontLM4UuxJ+RAWCDi7kCt72WWcZVQICazYiomY4snkjWGJn7cLhOQ
 GFc2vm4B2TGNZtixmNp9N/B17PG2NQSIo8mAYVTSg7NAngduxk8n0YvxnOBj5F61qEBCeEH4l
 d5HMNJOBcaVRW3I6pt+XszRXRFoyH0i916Jfa5ZKPGARQnIXgctY7VFlBBvb5Cqp3SipAtDPf
 mbmqTP7h7CuslLjQWpnXqtuS57IYENOEOj6pKg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PM is disabled, this is needed to avoid a harmless
unused-function warning:

drivers/i2c/busses/i2c-nvidia-gpu.c:345:12: error: 'gpu_i2c_resume' defined but not used [-Werror=unused-function]

Fixes: c71bcdcb42a7 ("i2c: add i2c bus driver for NVIDIA GPU")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/i2c/busses/i2c-nvidia-gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nvidia-gpu.c b/drivers/i2c/busses/i2c-nvidia-gpu.c
index e99c3bb58351..4e67d5ed480e 100644
--- a/drivers/i2c/busses/i2c-nvidia-gpu.c
+++ b/drivers/i2c/busses/i2c-nvidia-gpu.c
@@ -342,7 +342,7 @@ static void gpu_i2c_remove(struct pci_dev *pdev)
 	pci_free_irq_vectors(pdev);
 }
 
-static int gpu_i2c_resume(struct device *dev)
+static __maybe_unused int gpu_i2c_resume(struct device *dev)
 {
 	struct gpu_i2c_dev *i2cd = dev_get_drvdata(dev);
 
-- 
2.20.0

