Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041E4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDD820824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2YAF+JF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDD820824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440739AbeKXDwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:52:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35114 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436778AbeKXDwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:52:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so12571810wmh.0;
        Fri, 23 Nov 2018 09:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NBz21hdg4V/fAvkUex8BTAOFxqwTAUFc3IikGu4aJg0=;
        b=t2YAF+JFiOBGbHY00ASkBFuYGou9yEQXVoGu53l4FSZXqNzQIMG8ErA5wcSvCtMH+v
         fVh9o5vXItVKuTUgAyhBW727txsVaDv5kSj5kWxiMDqze44a6EnztNbWPCdsONb+sxsO
         O8JrFSIoPn7Hu715wVwLKxgL26H4l0DIYTz4frrkfUdPnAu8b7CJcV2H3d6Ckunh0K9N
         0gPudYnzizSIVo5hF4jTGRTn9Nqv+87MTLT8Orlz5v+SbauJSo5NwvSBYOcmd/pXomaC
         jrrvQo+Pw5z+FQGdWNLxlUBGozcymaHYOea6ZEThDZkLl1PWiVdM/PYk5nY7E6n2SwVx
         fPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NBz21hdg4V/fAvkUex8BTAOFxqwTAUFc3IikGu4aJg0=;
        b=eiEb2PdHpyRnhMadAaxkzIqtLRxqDNpPChBSHtmEOk4t849nGKUFUch5z8epU8XcDN
         GzNcQQS7USqwd+6WRs9WNVaUCVs5p/RfgfSyVA5FAl2Pb1We113PAdDlqLwQMBKd+ze3
         piaNjQ4ogxk8FD5W/t59KeWDbBM9cPqmmZdWw1mXKS/cz2wbz+F2/YcykLyWiWJonrgu
         QwlpHVVyGXOD7q0SyUjRcIBZIEAPIaQ2UAeo8pdusw1n7TYXDuaxpFbx2j14WTuvfNtr
         1yktoOpd2AakConwIbvZYsdo6M0VtW+8KJRqXY0IO/9kDqWcHcYPQflmZKvL4d0U25a2
         EyBg==
X-Gm-Message-State: AGRZ1gJuW8rBLH+EjijkvR6vS/nzmQT9w3wBHCw39EEJaCop3SE95Chx
        bv8M/F50zSJVGJ7vcEPlj+cTeGF5
X-Google-Smtp-Source: AJdET5cadiHQ2M96AoXz74Y0ujod1+Pau4yAjR4j9VM4Hfp+rva2wqNO7rc8mtJecST91FrN2CSdkw==
X-Received: by 2002:a1c:3e84:: with SMTP id l126-v6mr13892539wma.91.1542992827186;
        Fri, 23 Nov 2018 09:07:07 -0800 (PST)
Received: from ziggy.stardust (226.red-83-50-18.dynamicip.rima-tde.net. [83.50.18.226])
        by smtp.gmail.com with ESMTPSA id f15sm8990181wrt.10.2018.11.23.09.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 09:07:06 -0800 (PST)
Subject: Re: [PATCH v1 3/3] arm64: dts: mt7622: Drop the general purpose timer
 node
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Weijie Gao <weijie.gao@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stable@vger.kernel.org
References: <30f4a4110190a175307ac4dfebc98ffe96c44b90.1541643419.git.ryder.lee@mediatek.com>
 <17fde639c7d37f9cfabab230379913e652cf869a.1541643419.git.ryder.lee@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <be2b45e1-f639-e14c-1c40-9cd94b006309@gmail.com>
Date:   Fri, 23 Nov 2018 18:07:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <17fde639c7d37f9cfabab230379913e652cf869a.1541643419.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2018 02:28, Ryder Lee wrote:
> The crash http://termbin.com/zitb is caused by the timer register
> into system in early pahse during kernel boot, but the clock
> sources didn't get ready at that time.
> 
> A better way is to switch to use CLK_OF_DECLARE() in driver for things
> that need them early, but this node is actually useless in MT7622.
> So we drop it.

I suppose the root cause is, that the driver doesn't check the error
timer_of_init returned.

Would you mind to test the following patch to see if this fixes the problem?

--->8
From be91e56ed527261137335af340845eb3dd3dd33a Mon Sep 17 00:00:00 2001
From: Matthias Brugger <matthias.bgg@gmail.com>
Date: Fri, 23 Nov 2018 17:04:08 +0100
Subject: [PATCH] clocksource/drivers/timer-mediatek: error out on probe defer

If the clocks are not yet present, because they are loaded after
the timer is initialized, we are unable to boot.
Check if the return value of timer_of_init and return on EPROBE_DEFER.

Error seen is:
[    0.008337] Failed to get clock for /timer@10004000
[    0.013435] WARNING: CPU: 0 PID: 0 at ../drivers/clk/clk.c:3615
__clk_put+0xf0/0x120
[    0.021453] Modules linked in:
[    0.024614] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
4.20.0-rc1-00063-g2859d9abd7e8 #2
[    0.032902] Hardware name: MediaTek MT7622 RFB1 board (DT)
[    0.038580] pstate: 20000085 (nzCv daIf -PAN -UAO)
[    0.043538] pc : __clk_put+0xf0/0x120
[    0.047328] lr : clk_put+0xc/0x18
[    0.050753] sp : ffff000009163ed0
[    0.054178] x29: ffff000009163ed0 x28: 0000000041010018
[    0.059676] x27: 0000000000000000 x26: 0000000000000000
[    0.065174] x25: ffff0000090cb008 x24: ffff80001dfd7800
[    0.070672] x23: ffff000008f934b8 x22: ffff80001dfdeae0
[    0.076169] x21: ffff80001dfdeae0 x20: fffffffffffffdfb
[    0.081668] x19: ffff00000929ac40 x18: ffffffffffffffff
[    0.087166] x17: 0000000000000000 x16: 0000000000000000
[    0.092664] x15: ffff0000091696c8 x14: ffff0000892cd70f
[    0.098162] x13: ffff0000092cd71d x12: ffff000009181348
[    0.103661] x11: ffff000009181000 x10: 0000000005f5e0ff
[    0.109159] x9 : 0000000000000040 x8 : ffff000009181400
[    0.114657] x7 : ffff80001c800270 x6 : 0000000000000000
[    0.120155] x5 : ffff80001c800248 x4 : 0000000000000000
[    0.125653] x3 : 0000000000000000 x2 : 0000000000000000
[    0.131151] x1 : 0000000000000000 x0 : fffffffffffffdfb
[    0.136649] Call trace:
[    0.139175]  __clk_put+0xf0/0x120
[    0.142605]  timer_of_cleanup+0x60/0x7c
[    0.146572]  mtk_gpt_init+0x18c/0x1a0
[    0.150359]  timer_probe+0x74/0x10c
[    0.153969]  time_init+0x14/0x44
[    0.157307]  start_kernel+0x29c/0x414
[    0.161098] ---[ end trace c3137b005300b618 ]---

Fixes: a0858f937960 ("clocksource/drivers/timer-mediatek: Convert the driver to
timer-of")
Fixes: e3af677607d9 ("clocksource/drivers/timer-mediatek: Add support for system
timer")
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/clocksource/timer-mediatek.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-mediatek.c
b/drivers/clocksource/timer-mediatek.c
index eb10321f8517..d40c77a65b08 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -276,8 +276,12 @@ static int __init mtk_syst_init(struct device_node *node)
 	to.of_irq.handler = mtk_syst_handler;

 	ret = timer_of_init(node, &to);
-	if (ret)
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
 		goto err;
+	}

 	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
 					TIMER_SYNC_TICKS, 0xffffffff);
@@ -301,8 +305,12 @@ static int __init mtk_gpt_init(struct device_node *node)
 	to.of_irq.handler = mtk_gpt_interrupt;

 	ret = timer_of_init(node, &to);
-	if (ret)
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
 		goto err;
+	}

 	/* Configure clock source */
 	mtk_gpt_setup(&to, TIMER_CLK_SRC, GPT_CTRL_OP_FREERUN);
-- 
2.19.1
