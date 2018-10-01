Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B01AC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217172146D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llT1skT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217172146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbeJAWAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:00:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40162 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbeJAWAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:00:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id o2-v6so9175345wmh.5;
        Mon, 01 Oct 2018 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KKQpgpwNy86ffd2TDO9cjPUzRysi42bWS9548gaSokI=;
        b=llT1skT+rkiL0LrXKjFJFQ2eNAL9VV9o6MHtxeu/9Rv42R3icy7gA/Roekdn06to3C
         H9U+/EWJZycHYodkJTAVVgj8zkbrhmmjXj9tIb/L7xXWg6c5ociWt6dkXS1Hi39UxkA0
         Ve6boniS01KFUrZkkfLTRRDwQqky0G+JoP3UsIQBX5/UXEyJ1IsveWMuzX0dcW+JJK6I
         BPv9zMpCoKlD39HQiAMS6GNfu9qdG0+p2mLnQIdwk9jiq280MLGFuFhy1kcpfAdFaXlS
         sh/SzOzsxUSGzh15Xfv4oq7Oh/Bv8SR5IUIvIByEaPjY8LlmnYnfXD4m611tAQdxXcHV
         WF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KKQpgpwNy86ffd2TDO9cjPUzRysi42bWS9548gaSokI=;
        b=LDS4Bp5UzD5XUoBT1L+LcCRTZI+MrSe0sW+iGX/ItY/sjxdk6EJEBP9+MkFsXVveej
         kaZlloNwakbJlhNFs2ufZn85fPaWj8z9hBuSfzf158yVN08w2j4vmhBL9UyPBcK6aXfp
         8xWebOHSw0RtHDtDMsmJYaN3wSC1yiPsdhPz8VeqquBojvPrxt1RRKvDRq0Pw76V58e8
         ovC0axlNMmNnbKIe+XDp5KTcGF0NP+rlpFk1T1NN0FKgX+vhOjDiY7iUMvDuDzgJZ1QU
         XTTGacYa7i/k9KPLjo7Bsb4j29gsPGYzW1LpqrDOs0rX09lUqXHJgRj1LIN5d6DDSw17
         Yc7w==
X-Gm-Message-State: ABuFfoheWkEUGTcwm1M2wXOf4Ai22qURbM/M1RPNNWRgkQ2qq34UWjAq
        9m8byXe8rFZRKLevJHUjyQA=
X-Google-Smtp-Source: ACcGV61a4yUoytTclp62NY5LTG6ka0WXovFGHpE1ClaCNQ7d3oLLOgNwugV8zQdFMtC8PRWcl0l9Tw==
X-Received: by 2002:a1c:9ca:: with SMTP id 193-v6mr4131067wmj.86.1538407332101;
        Mon, 01 Oct 2018 08:22:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z13sm12539293wrw.19.2018.10.01.08.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 08:22:11 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andy Walls <awalls@md.metrocast.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] media: cx18: Don't check for address of video_dev
Date:   Mon,  1 Oct 2018 08:21:11 -0700
Message-Id: <20181001152110.20780-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180921195736.7977-1-natechancellor@gmail.com>
References: <20180921195736.7977-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns that the address of a pointer will always evaluated as true
in a boolean context.

drivers/media/pci/cx18/cx18-driver.c:1255:23: warning: address of
'cx->streams[i].video_dev' will always evaluate to 'true'
[-Wpointer-bool-conversion]
                if (&cx->streams[i].video_dev)
                ~~   ~~~~~~~~~~~~~~~^~~~~~~~~
1 warning generated.

Check whether v4l2_dev is null, not the address, so that the statement
doesn't fire all the time. This check has been present since 2009,
introduced by commit 21a278b85d3c ("V4L/DVB (11619): cx18: Simplify the
work handler for outgoing mailbox commands")

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Fix build error and logic per review from Hans

 drivers/media/pci/cx18/cx18-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
index 56763c4ea1a7..a6ba4ca5aa91 100644
--- a/drivers/media/pci/cx18/cx18-driver.c
+++ b/drivers/media/pci/cx18/cx18-driver.c
@@ -1252,7 +1252,7 @@ static void cx18_cancel_out_work_orders(struct cx18 *cx)
 {
 	int i;
 	for (i = 0; i < CX18_MAX_STREAMS; i++)
-		if (&cx->streams[i].video_dev)
+		if (cx->streams[i].video_dev.v4l2_dev)
 			cancel_work_sync(&cx->streams[i].out_work_order);
 }
 
-- 
2.19.0

