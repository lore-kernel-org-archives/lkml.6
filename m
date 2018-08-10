Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D72C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C69D223E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oF/L5RyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C69D223E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeHJFtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:49:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34642 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725725AbeHJFtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:49:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so3719751pgv.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NqDD+BiHQCzvSNv3Gmercl57aKZ/TjO+E5fAfGbt/Jw=;
        b=oF/L5RyYw3378h13WVYLf7q6voh+9V28hHXKaj+jTudrPg9cbWcjXA6uimzRSyh1bQ
         jeN3sERrjtk+o43y9n4LVO4NoqDzVXIvZ5wx7x+NW4BpLmRANoFbTvIdNY8x/KOfpzR1
         j4jqIg4owR+oZ/u3SR7fMjIxYx2IkojSISb1z/UkwUEt47j5e4Yfkn8qD+B3SdKq2kNj
         FHEP54S4+TTYwlXV/TOdJ09nCvLUS5++CPNMDvOQMatEiQnkRwkOuxe8t3Wy8RNT8RZE
         SDqSrpfc96hU2z+gQW6gg3JvrqhFHlc8MpMaI8KM8XDkGpzThYUwGcgbgrsbaSn02jUW
         EIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqDD+BiHQCzvSNv3Gmercl57aKZ/TjO+E5fAfGbt/Jw=;
        b=QuCTm28er1m256fy5aLOjB3oKAvqp01vPhWWigRUsFSmSnSwLztaY9/ISTmbPQh/+w
         M1CvvhEFlXq8kP3fwByIm9i//hdSqcG1Jdf0wjmNBZB0x3d74VKsQctxc5r0wl12j/cK
         ivKmR6snOt0gudbvFkP9KKQ/jlONe3PqU4zmKQELWxuz9Q+nc8x7K79lFUYsoOKMJd81
         nn6GhrnF8pc+CrLKq2wma+e947i8onMMjcc4qo7IO5hXKgThMIVQSa/vZxEypHKPaT/a
         I21NtYJNJrl+NHK38Pk4LX9C9qui6774SBNRMRCiv+aA+m7A0LTo5kO6g5SED/TT9xIt
         xx+g==
X-Gm-Message-State: AOUpUlEfI5w1c4z9E4XhJuNb1N9CitDja5tFrEsv0xwIqCu/i4LzkMoi
        +iOPaaVo1e0bEF/A7BCEYHA=
X-Google-Smtp-Source: AA+uWPy6Quq293Ort5jJ90RmxmJknZKHUyep4PGbVBy/klext8BxkqsnFjYcgTP64edUffhPpi4chQ==
X-Received: by 2002:a62:20d8:: with SMTP id m85-v6mr5148295pfj.74.1533871288845;
        Thu, 09 Aug 2018 20:21:28 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p73-v6sm16130871pfk.186.2018.08.09.20.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:21:28 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 06/16] staging: gasket: remove gasket_exit()
Date:   Thu,  9 Aug 2018 20:21:01 -0700
Message-Id: <20180810032111.197743-7-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180810032111.197743-1-toddpoynor@gmail.com>
References: <20180810032111.197743-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove now-empty gasket_exit() function.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 0fe5b86b294c8..aee819f379e9a 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1801,12 +1801,8 @@ static int __init gasket_init(void)
 	return 0;
 }
 
-static void __exit gasket_exit(void)
-{
-}
 MODULE_DESCRIPTION("Google Gasket driver framework");
 MODULE_VERSION(GASKET_FRAMEWORK_VERSION);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Rob Springer <rspringer@google.com>");
 module_init(gasket_init);
-module_exit(gasket_exit);
-- 
2.18.0.597.ga71716f1ad-goog

