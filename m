Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510A5C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF53020881
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uaoHo7Mq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF53020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeILCwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:52:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34593 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbeILCwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:52:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id g33-v6so27608437wrd.1;
        Tue, 11 Sep 2018 14:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fM7u1RCgIOSvcsNvJzGe9WXQfYLKVMYBECHaFd+sfvA=;
        b=uaoHo7MqQabimwg/90xU+IZN8Cz+le8vrYuN42l8HaAluZdjp9synpULI3qGv8QNBK
         YSsGgY28zCr38k9HO36oYXNAfkX4IPhWPvz8XM7U/V7pLHrvsNgRGw1YHAdpdVOLE5Tp
         xZ2ZyBPcTVa5K5KhRcq5EKXM7jY3LzK2QRekbAJ/zWJbGgBq782m4xXVopteEURpoXS4
         1pzPs6H3ZclVR/QxhuEgFQAA96b8DWCX3ABpUeQYGmXvkMu92/plRwZ3tNlNOqSgZZNH
         +7DSiNcN5wwm0GfRwjRIkGeLcFurGPtxW6CL73745aWDYVHouh2bWxrCx+FcU7TRYVEo
         aQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fM7u1RCgIOSvcsNvJzGe9WXQfYLKVMYBECHaFd+sfvA=;
        b=Qtq9aNjxeXTRIyB/5JKPGYWEThZM/2BvMRlFcW95+72iC99uggxI9c+b+oKasIcRyi
         eXlsPk3OgGWcwuSxfHqUBrawiKn54SvcYMPzm8J1FwkCFIw1+hoqz6UTEkAhUimksjh7
         33gK7tPZKaYZh0b7UTtTe3pC42aL2Pl7BRUVlLy/FnBPw6bC24d3yLaJKriZEaspGaPx
         pEhLm9UtzdJRtVkVA+tbIhx5IFn1r6GekO23ZcR5JliDTsRQm5Z7CocWEQSOL/pg0TSF
         F24hKJHzq6s2lRszzYpdVYsXPsY6FdaPtvSK4QjTvU6RNOl5F9ylUtStf9ylykMaCu0O
         TRZw==
X-Gm-Message-State: APzg51BHEN1ytxBSuvZYBJStESiAJEvj6VT6gmfp8XPlIexSLmNNoTge
        McElQXfDsNDvMPduZDFHzM2ozUG4L04ugg==
X-Google-Smtp-Source: ANB0VdZF1MDeka7gvV23IgBOuiyMi0biKRDgQM47VbVn73VSSaYCbG9ip2Y+rOJUJeqfbJiwspelZQ==
X-Received: by 2002:a5d:5450:: with SMTP id w16-v6mr21466086wrv.4.1536702677854;
        Tue, 11 Sep 2018 14:51:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id h73-v6sm4362380wma.11.2018.09.11.14.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 14:51:16 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.vnet.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] rsxx: Remove unnecessary parentheses
Date:   Tue, 11 Sep 2018 14:50:40 -0700
Message-Id: <20180911215040.7906-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when more than one set of parentheses is used for a
single conditional statement:

drivers/block/rsxx/cregs.c:279:15: warning: equality comparison with
extraneous parentheses [-Wparentheses-equality]
        if ((cmd->op == CREG_OP_READ)) {
             ~~~~~~~~^~~~~~~~~~~~~~~
drivers/block/rsxx/cregs.c:279:15: note: remove extraneous parentheses
around the comparison to silence this warning
        if ((cmd->op == CREG_OP_READ)) {
            ~        ^              ~
drivers/block/rsxx/cregs.c:279:15: note: use '=' to turn this equality
comparison into an assignment
        if ((cmd->op == CREG_OP_READ)) {
                     ^~
                     =
1 warning generated.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/block/rsxx/cregs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rsxx/cregs.c b/drivers/block/rsxx/cregs.c
index c148e83e4ed7..d9a8758682c9 100644
--- a/drivers/block/rsxx/cregs.c
+++ b/drivers/block/rsxx/cregs.c
@@ -276,7 +276,7 @@ static void creg_cmd_done(struct work_struct *work)
 		st = -EIO;
 	}
 
-	if ((cmd->op == CREG_OP_READ)) {
+	if (cmd->op == CREG_OP_READ) {
 		unsigned int cnt8 = ioread32(card->regmap + CREG_CNT);
 
 		/* Paranoid Sanity Checks */
-- 
2.18.0

