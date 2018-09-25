Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C1FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2682420833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOV90hfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2682420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeIZBcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:32:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46039 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeIZBcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:32:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id x16-v6so16440670ljd.12;
        Tue, 25 Sep 2018 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d/NOn73sulnzViPWgFPRhgBzoeN51MibPB5UyJoKcPY=;
        b=UOV90hfZLCFsTO3Up7K/UJOSyHotObGZMon2CPvbVVy52adQs+VxG/VbYjY3NDqWTo
         7tcK/Afp0isU/nFOdgwLl+J4nxejQA2T36DFpUW7Py/EJQEoaMASGvmYyjs45P5F1lwL
         ml+AUsFR1H7cAmEXfJesQkcA6u3cqAPDj+ys7+us6Q/Xl5JmNCGFsNaus89eqXuy+Tzn
         wq8G1y6iI4ONxXPjipvLMPQbWxF6yarBrqYeOa8tIZGGvwYUKFsVWaiHRQiPVVw5eQej
         NXAKcqJPWKeYQbuflLt/ERfdEABLv6PxzREFWV3Xia0Ey0OMytQMgvBrrS3hexspFFYX
         0wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d/NOn73sulnzViPWgFPRhgBzoeN51MibPB5UyJoKcPY=;
        b=jVHp+DxzTmetqvefDXj/hiuizkYAAtALsjkcUjhrBuNL2KGSxOnnnEmah4ynuEXZF1
         asd7AxC4o/ArcGxLERKXcd3/2n9Z77a41fwtwk1s5RGSgXMqGLnU/3xPoPtnA7a3Sy/T
         k/av8pUcOjkZiEUxn22ud+j0XITMvZA7at5uUSJZLRQrIGpObEO9F5hSyOgMHZBD0Iq1
         1onM11cfVUaga9Q+Vo49NXdVvw9ooUoQTbFd2GhgBRRnh+vTdvnfqVnBWqsHB1OqROAp
         S4IWaWWAbLdzrrOENsIIFhfRjaDiPUbmmf4uAkFvRHfGvayoY3v+w2OFNf0xBbTFX8//
         /sSQ==
X-Gm-Message-State: ABuFfog54WIlrQiKkmkJdhJHIGMBARy1yHo1FlZvP2SCNz/XuATZdF4G
        iopOjHSM6HiIqnkDLtebc7CajISJ6NE=
X-Google-Smtp-Source: ACcGV62yspT7xgZeOqLL6nDBJExDQ1gg6y4g/yTC1hNsgiYWAVRC256uyLQkZPEjCU7jDERwpoDyTg==
X-Received: by 2002:a2e:9694:: with SMTP id q20-v6mr2055898lji.35.1537903400434;
        Tue, 25 Sep 2018 12:23:20 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id n23-v6sm553160ljh.77.2018.09.25.12.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 12:23:19 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Subject: [PATCH] mmc: pwrseq_simple: Fix incorrect handling of GPIO bitmap
Date:   Tue, 25 Sep 2018 21:24:33 +0200
Message-Id: <20180925192433.1377-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <CAGfqbt4n4g_24kWGPhXojooiQQOmVeq-TfYucFERXJGMci87Xw@mail.gmail.com>
References: <CAGfqbt4n4g_24kWGPhXojooiQQOmVeq-TfYucFERXJGMci87Xw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b9762bebc633 ("gpiolib: Pass bitmaps, not integer arrays, to
get/set array") changed the way GPIO values are passed to
gpiod_get/set_array_value() and friends.  The updated code of
mmc_pwrseq_simple_set_gpios_value() incorrectly uses the 'value'
argument as a bitmap of GPIO values and assigns it directly to the
'values' bitmap variable passed to gpiod_set_array_value_cansleep()
instead of filling that bitmap with bits equal to the 'value' argument.
As a result, boot hanging caused by incorrectly handled MMC device
has been observed.

As a side effect of that incorrect interpreation of the 'value'
argument, wrong assumption is taken about the 'values' bitmap size 
never exceding the number of bits of the 'value' argument type.

Fix it.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Hi,

I hope I've finally identified the root cause of the boot hang reported
by Marek Szyprowski.  I've reviewed the code of other divers updated for
the modified GPIO API and found no more issues of that kind.

Marek, can you please test this fix on top of next-20180920 with the fix
"gpiolib: Fix missing updates of bitmap index" also applied?

I've assumed this fix, if tested successfully, will be merged via GPIO
tree, hence I've selected Linus as the main recipient of this message.

Thanks,
Janusz

 drivers/mmc/core/pwrseq_simple.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 7f882a2bb872..ece34c734693 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -40,13 +40,22 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 	struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
 
 	if (!IS_ERR(reset_gpios)) {
-		DECLARE_BITMAP(values, BITS_PER_TYPE(value));
+		unsigned long *values;
 		int nvalues = reset_gpios->ndescs;
 
-		values[0] = value;
+		values = bitmap_alloc(nvalues, GFP_KERNEL);
+		if (!values)
+			return;
+
+		if (value)
+			bitmap_fill(values, nvalues);
+		else
+			bitmap_zero(values, nvalues);
 
 		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
 					       reset_gpios->info, values);
+
+		kfree(values);
 	}
 }
 
-- 
2.16.4

