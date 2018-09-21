Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A404C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3DE2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOuOlsvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3DE2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391388AbeIVByJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:54:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44896 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391089AbeIVByI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:54:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so13941033wro.11;
        Fri, 21 Sep 2018 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3YW34xB6QhhNdcA+S9Z/6kjLx1NyQmg3AOL8sBhSXm4=;
        b=cOuOlsvmtSB5jpywS1e7AjPXTNNXsloNPexvABETr1D5LbznjIq5e4G+2PvmmJcMCU
         x0Nb4iVhB9t20nuFWaHzhJ+hdSBIunivxXV4YTSw2Z+u7zUmEtt0jJV6lMLKXzq3EaL7
         5XDhKoyFTXOUaKEYWqcGgCdVhSEV/zWRFxvt6XoayiNND0DNG7+ofM7tNDsX3mUUGqEu
         YngSD95Dg/9wstmI3+Lqh5fAmqYDZ9ErJYz3oFYeCEssNzODJLE0HVIlhsQXMiEpDDOo
         /pyLgwI8AvqVpvJfutLmN/1npbdRjhyIz0IWCrPVOh5pfcGrFad9Un3fJu1RpDio/4cu
         SpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3YW34xB6QhhNdcA+S9Z/6kjLx1NyQmg3AOL8sBhSXm4=;
        b=nuWcbpRgk7hbOcI4as32sLE6w2JwVlGpuEV+vOAHD/+AFPb75TuIkda31AIPx8wv8d
         hXE9YNSTxAFkHtT+msgJcW4cjaOuxVRFa7NWJBmlFqOhoNmH/UbdNTm5H7vCFx9Vr29J
         BHysKbwJhmuW8XXAf+jHcMTb8Fp8nG54RDTuyPyRxhkaw+VqSTgI8jSD5P10y46pDJGz
         aCI903HooIcRfCRzvkg2gQljEW97+2klneoVqku1/B2StTER1bxkQIjtS6cN0WXwK/3g
         U0w89psgmneR+NU9y3LLXUq0HEQ7KAL0gDmz3lbiSvRalKmtdB2bVrdf/EIhW2Gu33jv
         JNPA==
X-Gm-Message-State: APzg51A59K/gmyttHUbndRRNO3CfmQ++sZE9kr62MCapbxS2zMYJieJQ
        l08QLzRJ0k7hxER1rlB4D0lzc39d0C5cxw==
X-Google-Smtp-Source: ANB0Vdb1wkdQsqH0esNz6rcr6+HwXCtX1J0atIvoJaDcb0WA++0e9/FBLtq52iZzUYd7sjKV2Q8/rQ==
X-Received: by 2002:a5d:4849:: with SMTP id n9-v6mr20203053wrs.234.1537560221793;
        Fri, 21 Sep 2018 13:03:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id s2-v6sm33425817wrn.83.2018.09.21.13.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 13:03:41 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andy Walls <awalls@md.metrocast.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] media: cx18: Don't check for address of video_dev
Date:   Fri, 21 Sep 2018 12:57:37 -0700
Message-Id: <20180921195736.7977-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
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

Presumably, the contents of video_dev should have been checked, not the
address. This check has been present since 2009, introduced by commit
21a278b85d3c ("V4L/DVB (11619): cx18: Simplify the work handler for
outgoing mailbox commands")

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Alternatively, this if statement could just be removed since it has
evaluated to true since 2009 and I assume some issue with this would
have been discovered by now.

 drivers/media/pci/cx18/cx18-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
index 56763c4ea1a7..753a37c7100a 100644
--- a/drivers/media/pci/cx18/cx18-driver.c
+++ b/drivers/media/pci/cx18/cx18-driver.c
@@ -1252,7 +1252,7 @@ static void cx18_cancel_out_work_orders(struct cx18 *cx)
 {
 	int i;
 	for (i = 0; i < CX18_MAX_STREAMS; i++)
-		if (&cx->streams[i].video_dev)
+		if (cx->streams[i].video_dev)
 			cancel_work_sync(&cx->streams[i].out_work_order);
 }
 
-- 
2.19.0

