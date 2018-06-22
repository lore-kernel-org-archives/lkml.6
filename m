Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8008C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0E0245C1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mna60d3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0E0245C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934369AbeFVQ0B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:26:01 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33194 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934062AbeFVQZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:25:59 -0400
Received: by mail-qt0-f194.google.com with SMTP id l10-v6so6426981qtj.0;
        Fri, 22 Jun 2018 09:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4ry5i/t+vR1U8hwk0eEgnMo6/kvdXWyzFtn5ixrKPb0=;
        b=mna60d3wTqmdA06HTtjN1baBX6nBEmLOz5frZbTpMqDa+pBmo0PMkxKEwmPA1LLqa9
         RFamTpRPyT2d6UX5zFCdrl0vsX2oyr91RNvCxlVvHVMOx+NNHLJK8PwQC+9uyJu5Eo0n
         6SVOAwPJlpWbITNaDnCaZEu5PK2QbBC7zwHsaDRDMsimPP8yvp6CHTsb5WWLqroWcKP9
         e6y1h8IG6Skog7Uniqm6UreeerDStCd3GO7c28Mtg559RsH3o0fUi9DOSYXuCXb0V92v
         FzaMf6WIcP9Cf2/a5GXNiBMzYzHimadGxHR+5yJyS3MMb9YKB34J4KODqV+sF6xkgRaT
         vwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4ry5i/t+vR1U8hwk0eEgnMo6/kvdXWyzFtn5ixrKPb0=;
        b=WQOhIKv1WJDkqzXsxvGGGUdbZEZY+o43klOXsXAsRYAlD7FCMTJ2DxuPCdTSUowv/Y
         JI9k5vKZAh6D33U0z1vkQXlLqp0I0yxxM3Jrmf4ZzJMBEnIRkT5B7pvMa89U4S0p1UWK
         vHFNeAf2xnRT0S9TE5MwnJa/usaayvcKG6mcST0mCo7GC7dGPcSk1+ykqlWjKtxLgCsY
         YtFa7uqsvYaIh4cSLzFXlZBLd66tRJPKU+CAwinpolWH9ChI4jrHuMsWh9P1BsGXkoVy
         yOqTWAfr7xJ4yUD//uFAieWHTyj0Ke7M4cwNDt0VXVpgieFKYdAam0lwG1EGdARqNDGD
         YFBA==
X-Gm-Message-State: APt69E0aCIYCa5Ftr6EJnqKIaYTxCbqkMZ/c2Ol3MzFYDmB/TC+kEr9q
        aXm26lOyshDtoKs26Zked6/HSuSb
X-Google-Smtp-Source: AAOMgpe64NbtSOmGis4XjBr+7HqE9odqjEligBrFupoHD9q4S1Zoa4ggTUYVeTukUUCvzAjZLOYE6Q==
X-Received: by 2002:ac8:3426:: with SMTP id u35-v6mr2031876qtb.288.1529684758378;
        Fri, 22 Jun 2018 09:25:58 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:ba27:ebff:fee8:ce27])
        by smtp.gmail.com with ESMTPSA id g57-v6sm6072873qte.52.2018.06.22.09.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 09:25:57 -0700 (PDT)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     john-s-84@gmx.net, Jason Andryuk <jandryuk@gmail.com>,
        stable@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] i2c-hid: Fix "incomplete report" noise
Date:   Fri, 22 Jun 2018 12:25:49 -0400
Message-Id: <20180622162549.9563-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ac75a041048b ("HID: i2c-hid: fix size check and type usage")
started writing messages when the ret_size is <= 2 from i2c_master_recv.
However, my device i2c-DLL07D1 returns 2 for a short period of time
(~0.5s) after I stop moving the pointing stick or touchpad.  It varies,
but you get ~50 messages each time which spams the log hard.
[  95.925055] i2c_hid i2c-DLL07D1:01: i2c_hid_get_input: incomplete report (83/2)

This has also been observed with a i2c-ALP0017.
[ 1781.266353] i2c_hid i2c-ALP0017:00: i2c_hid_get_input: incomplete report (30/2)

Only print the message when ret_size is totally invalid and less than 2
to cut down on the log spam.

Reported-by: John Smith <john-s-84@gmx.net>
Cc: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
John Smith originally reported this, but his post did not include a git
formatted patch nor a Signed-off-by.
https://www.spinics.net/lists/linux-input/msg56171.html
https://patchwork.kernel.org/patch/10374383/

When ret_size is 2, hid_input_report is passed 0 and returns early.  ret_size
== 2 seems to be a header size saying there is no content.  Should
i2c_hid_get_input just return early in that case?

Also, should this condition be noted to stop an interrupt from firing to
avoid the ~50 bogus messages?

 drivers/hid/i2c-hid/i2c-hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index c1652bb7bd15..eae0cb3ddec6 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -484,7 +484,7 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 		return;
 	}
 
-	if ((ret_size > size) || (ret_size <= 2)) {
+	if ((ret_size > size) || (ret_size < 2)) {
 		dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
 			__func__, size, ret_size);
 		return;
-- 
2.17.1

