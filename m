Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tmyfOtghHluyWgAAmS7hNA
	; Mon, 11 Jun 2018 07:19:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3C20B607A4; Mon, 11 Jun 2018 07:19:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="CNNDlFi/"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A7B7160792;
	Mon, 11 Jun 2018 07:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A7B7160792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754117AbeFKHS7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:18:59 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34108 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754100AbeFKHSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:18:54 -0400
Received: by mail-pl0-f65.google.com with SMTP id g20-v6so11806056plq.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 00:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ot9BLptEI709nbh4VxHxjhKyV8A4dexww6fbzmu4S4M=;
        b=CNNDlFi/PAyowYTZtDjVGchXFSgauaczFxqs+54qiKrv3gf2tLbu3MfUg4FuEsWei+
         1Z3YHuoe3NeEkQVMzo2/0ZTVlhAenm4Fx0yMGKESixcJUMAWAKj7ZfqJqApN+tLBOy7p
         cJ7fQhXbUKPl5X9lUP3b0+yqoPgay7VyamOaa8eg1zZWPS5pdiezDHcLoe6nm+7fXpdv
         5e4Bw6L5C2PB+rzGxY9oO807jU12lTrCe7ffFBeB5+QSn+vTDnB/zAYA+NB6mlLn7MP+
         VHMtlHYyeH4CdFZlvNf1guaRp88lP5SmeCcpps8IwvLLhOWX3mDDoI2Qbb4JZQkITZwl
         NWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ot9BLptEI709nbh4VxHxjhKyV8A4dexww6fbzmu4S4M=;
        b=Dc0Zh4ceLedynV5TYOQC4+839SO/RFwYYP3rFI1j/zVbzKVf3K9R5LSLv3VZwRY1ew
         fC4ZATz3UKGThCjFMN0l1NcD94SC5TQbJUqJCNIKCLk/31FKYPavtzYN89fOmkWNhRI9
         zCq/N2uZH+oxQquBFvR0a9HFMLZV58RaToKAKhtCWVDNlwzZdAEc4rshda23pOaeW/86
         RzIF0qqYY49YqHbBYsXdu61wsLWC7kUz0XxVlHxHvhqItdvjew2gNudrZGwclx/Wcaza
         igRzopZGU6PGK5x/rYdjbFiStTjtI09OTJjh3gR+Ho19C4V1xxAHOGFctVn3/BMV+7GI
         YPRQ==
X-Gm-Message-State: APt69E2tAkYoRHd0GiBFV/ApmY7wf0LYaqvYyQRRZ+lfmpedW3jbCaBz
        qlruWZHIl5TlkUsFaPPEHt1+gw==
X-Google-Smtp-Source: ADUXVKKYaFmlUWQw6QI8OwZ9TmgMZQ9iAVDhx3jKH1zGw5dYchA2FywE4/t+FrwuuixWRzv9Zp97BQ==
X-Received: by 2002:a17:902:925:: with SMTP id 34-v6mr9147388plm.218.1528701534199;
        Mon, 11 Jun 2018 00:18:54 -0700 (PDT)
Received: from localhost.localdomain (114-26-212-90.dynamic-ip.hinet.net. [114.26.212.90])
        by smtp.gmail.com with ESMTPSA id t13-v6sm30349692pgv.43.2018.06.11.00.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jun 2018 00:18:53 -0700 (PDT)
From: Chris Chiu <chiu@endlessm.com>
To: corentin.chary@gmail.com, dvhart@infradead.org,
        andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, hdegoede@redhat.com,
        linux@endlessm.com, Chris Chiu <chiu@endlessm.com>
Subject: [PATCH v2 2/2] platform/x86: asus-wmi: Add keyboard backlight toggle support
Date: Mon, 11 Jun 2018 15:18:38 +0800
Message-Id: <20180611071838.47945-2-chiu@endlessm.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180611071838.47945-1-chiu@endlessm.com>
References: <20180611071838.47945-1-chiu@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ASUS laptops like UX550GE has hotkey (Fn+F7) for keyboard
backlight toggle which would emit the scan code 0xc7 each keypress.
On the UX550GE, the max keyboard brightness level is 3 so the
toggle would not be simply on/off the led but need to be cyclic.
Per ASUS spec, it should increment the brightness for each keypress,
then toggle(off) the LED when it already reached the max level.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 drivers/platform/x86/asus-wmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index a18484f4bae3..bfcafca54a7a 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -67,6 +67,7 @@ MODULE_LICENSE("GPL");
 #define NOTIFY_BRNDOWN_MAX		0x2e
 #define NOTIFY_KBD_BRTUP		0xc4
 #define NOTIFY_KBD_BRTDWN		0xc5
+#define NOTIFY_KBD_BRTTOGGLE		0xc7
 
 /* WMI Methods */
 #define ASUS_WMI_METHODID_SPEC	        0x43455053 /* BIOS SPECification */
@@ -1755,6 +1756,13 @@ static void asus_wmi_notify(u32 value, void *context)
 		kbd_led_set(&asus->kbd_led, asus->kbd_led_wk - 1);
 		goto exit;
 	}
+	if (code == NOTIFY_KBD_BRTTOGGLE) {
+		if (asus->kbd_led_wk == asus->kbd_led.max_brightness)
+			kbd_led_set(&asus->kbd_led, 0);
+		else
+			kbd_led_set(&asus->kbd_led, asus->kbd_led_wk + 1);
+		goto exit;
+	}
 
 	if (is_display_toggle(code) &&
 	    asus->driver->quirks->no_display_toggle)
-- 
2.11.0
