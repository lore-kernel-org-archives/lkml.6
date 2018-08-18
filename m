Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9524C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEB421746
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0Lzc09l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEB421746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbeHRVce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 17:32:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34733 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeHRVcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 17:32:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id l2-v6so3859929wme.1;
        Sat, 18 Aug 2018 11:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aJipq5ucdV615GL9AIp4tVWQTE5lfc3zjDxNQT/U12M=;
        b=P0Lzc09lYknqf5xK7b2aqMZ7W+VEDR51nthl9HSCB9Lp1gfGNL8s0KGZJmlzRDXX4V
         USW4tKb+XCEJd+hf/eD/qcbySjLZWnZV63cfC/zKRgSY6ZOo4mpGlhAZ/UCTm9HE+u5e
         h7+FNApZvVciTSiYiPGBp+J1z/AwdRd3WOe4ZxgOWfIE89HKD5L6CDwUe9cO59wQECJX
         D3lmEPEHv0IT6CJxkZiCV04VcslwJoQxwMkoGPpDP9BYI6xxNlMlfGno45k0cO3dXm7u
         zLXoI6V0NPw3TCfT7c7znR0V11vWtR0w9Q0L466VkJLz4+48a/lXey9hZbYbh2AG6Vse
         oj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aJipq5ucdV615GL9AIp4tVWQTE5lfc3zjDxNQT/U12M=;
        b=T9ylA+O8ZTzy/MNbmxZUR3Y5tPH8dWQdyqorwCxcnST4p0BeYSeGk5HiZj5vzWkENp
         YPKLXP4eMOK0TuWAW6vIhesQ4RWel+khFQQmyGkV8JIpKwLGGoEPR3jopSB6KUpKMdkI
         XkoNopPZcgSiSFV/qZq4sdtmNXQYAKskPYtke96Wb3grdKtozHQKcFCp4onNwnc5WTOy
         rqFVIctfINXZHj4Q+REHqEl85uPDjtPUjTXPSG15kG3XI7U6vYwpXr7joR35GWRyu07z
         YKQHFjoV+5xMSnwjkpUf0kkE/wtssYiU7FwSsFTdQa5jAUgT32yPo043yL/6iNmb7zuH
         mfeQ==
X-Gm-Message-State: AOUpUlFQx3kibqjskj8nTHgI5/JgnYvCBOvyHu5IpvMI7pm80H1arZKO
        2ZP6ZM6zEgaGaoXMOF/MFEIT6wL61gY=
X-Google-Smtp-Source: AA+uWPybA7l2h2H2QJDCJLBspo5yAprSfMPVv+h+N4cFnZ0EQSoBW24xCNBIiWQ6HemREWVhXVhoMg==
X-Received: by 2002:a1c:b756:: with SMTP id h83-v6mr13910402wmf.8.1534616637571;
        Sat, 18 Aug 2018 11:23:57 -0700 (PDT)
Received: from Fulcrum ([39.40.115.2])
        by smtp.gmail.com with ESMTPSA id r13-v6sm5241027wmf.34.2018.08.18.11.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 11:23:57 -0700 (PDT)
Date:   Sat, 18 Aug 2018 23:21:59 +0500
From:   Faisal Mehmood <f.m3hm00d@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hid: hid-logitech-hidpp: Fix spelling of 'length'
Message-ID: <20180818182159.GA10389@Fulcrum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'length' was misspelled as 'lenth'. Fixed it. It is a coding style
change which should have no impact on runtime execution of code.

Signed-off-by: Faisal Mehmood <f.m3hm00d@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 19cc980eebce..b89c0f5b8895 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -81,7 +81,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
  * where as most newer devices use the FAP protocol. Both protocols are
  * compatible with the underlying transport, which could be usb, Unifiying, or
  * bluetooth. The message lengths are defined by the hid vendor specific report
- * descriptor for the HIDPP_SHORT report type (total message lenth 7 bytes) and
+ * descriptor for the HIDPP_SHORT report type (total message length 7 bytes) and
  * the HIDPP_LONG report type (total message length 20 bytes)
  *
  * The RAP protocol uses both report types, whereas the FAP only uses HIDPP_LONG
-- 
2.18.0

