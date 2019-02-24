Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3ABC00319
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F64220842
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJjXuucc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfBXO6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 09:58:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34693 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfBXO6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 09:58:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id o10so1158427wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 06:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=qr+eQh9svX29d7fanVXH9c3+0nPdrHqtDP/CyXhYxVg=;
        b=TJjXuuccMm6bwin5ZksE9WhBuaNTHz2S8FrW/00DPFJnDlYAvQQX+7FRtdp2lesM33
         77Vydfi2Oq/IgKV24+8jgU/5EPTjV4UCna8sTVZlUnN7M7AcjNEWCczzir9+ApQ9gaK6
         IvU6kEVcyJtG+3UdAX2Bv2Od6TomRPq2P227+vyR43m4Z37cV59wM6/pfe/qo33UIChX
         nrvZvRfMXt6WiBXDIEgUwpmVtLSLSjvNQxl02TWzm+s/woW7GC3ezuLgyayIDLhF9PIw
         3UNbLV00zJsiWKWty9pWfQkIxm+TlqM0nEQyz7anOlfkyIxEIb1SPEHhdCX95ohka7Y4
         T/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=qr+eQh9svX29d7fanVXH9c3+0nPdrHqtDP/CyXhYxVg=;
        b=UF6R6hW/HYLzS7HwF0jzLYHuYmx7wnGcjcM8XRQmXdXUeU7ORoBUfmMjPWo00LMXMU
         XCEixXOqu8tbpWFwrpmT5U7ix5flAWObDVNcK/++MNb6dMJyqKJVMO+yG8SypAOgsu4C
         PXOlsdsc9lP1GJ+FaupS2RxlzInV5/X2MU/iHq+/c797cwJfc8pZQnBkvurtdeJbxPFY
         KhIefPR+YoyNYICo5oE28tHmB5CsHLuTozorf1MdT6XB8InmGI76sOl/s2aKg4JlS/pG
         b4IzgtWCGVRn8lnEx0EAGqVMO5Ts1BJMUFPHidM1sLIWS2q7YScnWYeKOb2UFcD+pY2d
         rRnw==
X-Gm-Message-State: AHQUAubtEESvCvgNB5W9IgPblWZhtka6I+grTg2UIXuoVmDyF2iXc82J
        VWTCoOw+v9o5JXskSAksLLM=
X-Google-Smtp-Source: AHgI3IbPq3odUqFErUgZYJJNLwM4efrsXl6gJ1PvreqYIpIOAM404JDE9/Moxqo26iUX73ytsg2Qbw==
X-Received: by 2002:a1c:b38a:: with SMTP id c132mr4326901wmf.49.1551020323406;
        Sun, 24 Feb 2019 06:58:43 -0800 (PST)
Received: from [192.168.1.43] (host86-131-109-12.range86-131.btcentralplus.com. [86.131.109.12])
        by smtp.gmail.com with ESMTPSA id p1sm8808271wmi.9.2019.02.24.06.58.42
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 06:58:42 -0800 (PST)
From:   Ken Milmore <ken.milmore@gmail.com>
Subject: thinkpad_acpi: Battery quirk for Thinkpad 11e (4th gen)
To:     linux-kernel@vger.kernel.org,
        Jouke Witteveen <j.witteveen@gmail.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Message-ID: <333cc78c-7537-7898-d753-17352df893aa@gmail.com>
Date:   Sun, 24 Feb 2019 14:58:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently acquired a Thinkpad 11e 4th gen (Type 20HV, BIOS version
R0KET36W, EC program R0KHT18W). I've put Debian Buster on it, with the
4.19 kernel, which gives the following errors in dmesg:

  ACPI: \_SB_.PCI0.LPCB.EC__.HKEY: BCTG evaluated but flagged as error
  thinkpad_acpi: Error probing battery 2
  battery: error in extension, unloading: ThinkPad Battery Extension

I wanted to try using the battery charging thresholds, so I added an
entry to the battery quirk table in thinkpad_acpi.c (patch given below),
which allows the battery extension to load successfully.

Setting charge thresholds seems to basically work, but one thing worth
mentioning is that charge_start_threshold and charge_stop_threshold
appear to be tied together; AFAICT setting one also sets the other to
the same value. The battery does seem to start charging whenever it
falls below the common threshold, I have it set at 80% and it has kept
the battery floating around 79%.

Battery status is reported correctly when charging or discharging; when
charging has been suppressed because the battery level is above the
threshold, then the status is reported as "Unknown".

diff -uprN linux-source-4.19~/drivers/platform/x86/thinkpad_acpi.c linux-source-4.19/drivers/platform/x86/thinkpad_acpi.c
--- linux-source-4.19~/drivers/platform/x86/thinkpad_acpi.c	2019-02-24 13:27:29.341331227 +0000
+++ linux-source-4.19/drivers/platform/x86/thinkpad_acpi.c	2019-02-24 13:09:28.710982438 +0000
@@ -9619,6 +9619,7 @@ static const struct tpacpi_quirk battery
 	TPACPI_Q_LNV3('R', '0', 'B', true), /* Thinkpad 11e gen 3 */
 	TPACPI_Q_LNV3('R', '0', 'C', true), /* Thinkpad 13 */
 	TPACPI_Q_LNV3('R', '0', 'J', true), /* Thinkpad 13 gen 2 */
+	TPACPI_Q_LNV3('R', '0', 'K', true), /* Thinkpad 11e gen 4 */
 };
 
 static int __init tpacpi_battery_init(struct ibm_init_struct *ibm)
