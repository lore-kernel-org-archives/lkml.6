Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EA2C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 00:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B1C25446
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 00:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyxSR1L1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B1C25446
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeGAAT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 20:19:59 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44975 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbeGAAT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 20:19:57 -0400
Received: by mail-pl0-f68.google.com with SMTP id m16-v6so6206065pls.11;
        Sat, 30 Jun 2018 17:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iVQtEs2wOysfYXXf5UJHXyB4xxh4KdBDZ61+WBU7RHE=;
        b=DyxSR1L1DxE42mbySpVpIWNJKlSlyllm7XxtMUiMjWNni4hjllnIkSKWt0m297xb6T
         N5yH3b7zI299cLcLBA/nFpuCvh1PQLzwqlcqELHH/slPzOtMuUZWJI1QjMeBrklvTYhi
         njSoDbGUT7nb6LgbmwACEAcJTQ3oDu3T90IvqwKUNjBruUSKBpN5bD4riyQ6HyeFaZQQ
         Svrw+tf6LZZeO6zQba7swL1SETN/vWQaZaM0ChGKLy3VW5QK+fVaM20AmbjUPWcdBpnP
         DsBKajF1dY+Gx8/twAJT/Zjv/TTdiQPlv7soZjGUZzHoKaYcBrIRbDDnOP+I+Li5nY0n
         fV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iVQtEs2wOysfYXXf5UJHXyB4xxh4KdBDZ61+WBU7RHE=;
        b=SFKr8vmx+KY/1ipD2RfVF3cX6X5TW0DiZ0Dg3EaWM70Jflt1943NMrRj+LNfZxtxSE
         sdIIVHUdmDiSVz3AlGxa7uhrYgnnaBh63bkic/IMdOKMJtpjuAubYY/dbv0CBgW8lK9r
         P54rd3Unr1BEwiRqjddLPgOB7NFhixAAs0PWMY9yvLMVtWpX48ehry8TCwXVvJzzBUZq
         7kWrUTEDe67HSo3OzCO07IR+wfl1qMkDwqmDhQ9oH5wdW6vz6ZQTWhDp/nXp27/9zPIk
         7lmIhYejCnBAkY+wGeDFGXnv9mmt4GJSk9s6gG6e+mZE5CxGS2li5p4EgiXOis6gyoD6
         El4A==
X-Gm-Message-State: APt69E3Q0uilgB1MpJR3JnItkv9g7hF+Zbqzv18EDaA2ChkzEZbUunRi
        h9cs4ysn52XacRvInm7x76izhA==
X-Google-Smtp-Source: ADUXVKKmIQn3MeGa9CgvRERUuNKN/HojOkXC6DjkkE/r6/GaWWL6aQ5shVgyEQio9TadWx+KhrfCNg==
X-Received: by 2002:a17:902:2884:: with SMTP id f4-v6mr20507310plb.204.1530404396861;
        Sat, 30 Jun 2018 17:19:56 -0700 (PDT)
Received: from hobbes.alyptik.lan ([2605:e000:1117:c002:2e0:1bff:fe70:ea])
        by smtp.gmail.com with ESMTPSA id b123-v6sm8424566pfb.156.2018.06.30.17.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 17:19:56 -0700 (PDT)
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Martin <consume.noise@gmail.com>
Subject: [PATCH 0/4] reduce Surface Pro 3 multitouch jitter
Date:   Sat, 30 Jun 2018 14:19:49 -1000
Message-Id: <cover.1530402641.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Surface Pro 3 firmware doesn't reliably send contact lift off
reports nor handle invalid report values gracefully.

To reduce touchscreen input jitter:
  - add MT_QUIRK_NOT_SEEN_MEANS_UP to the MT_CLS_WIN_8
  - drop invalid report values

Joey Pabalinas (4):
  HID: multitouch: add MT_QUIRK_NOT_SEEN_MEANS_UP to MT_CLS_WIN_8 quirks
  HID: multitouch: don't check HID_GROUP_MULTITOUCH_WIN_8 for serial protocol
  HID: multitouch: drop reports containing invalid values
  HID: multitouch: remove unneeded else conditional cases

 drivers/hid/hid-multitouch.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

-- 
2.18.0

