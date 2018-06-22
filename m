Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E5FC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0992466B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbmVOrna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0992466B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933499AbeFVRGq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:06:46 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38138 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933095AbeFVRGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:06:43 -0400
Received: by mail-lf0-f66.google.com with SMTP id i83-v6so9588334lfh.5;
        Fri, 22 Jun 2018 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GbPfr6gtlVSKjjBfkvP9xH0kdNCvFfz3lz/YlzLyrmI=;
        b=hbmVOrnaLz0/sThLywjqOsaSGc8/yt7GyrXtcjh8UTFgYacOY3wbRJGDuXkRuCEaf3
         OMJALMrfACEcXun2/r3qQbbQG19l5zLFhwoWkfvx6/Ml80UYl7+ydktITcc28Eu+PNcs
         N5BYsuuML61WJX2q5nIE+e9SwIckTf9l0ylF2wx2sxMFpRFJeTM6J0SFSDnBW2Mow8Sv
         ctcZuS9eObTt08VZDwxYc+Dk5hezftMYjPCiT6mm7V0SrDjM1A1wX3ENMco8RmMgONa5
         XSPwNKkbIVe/YH7n+nYfOL9xTFWrXvDcfpbo3qF2UXfmAzEa68tN7p5Pnp2Si97k8mMB
         BjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GbPfr6gtlVSKjjBfkvP9xH0kdNCvFfz3lz/YlzLyrmI=;
        b=TLEyxtuu8dVaietgBK2+XLeTu5ifmFR56qxBDBG3u3hu8M80PedIrNypLTCNxZMGkJ
         dj/ouPgJHwUr5ysc0v+FWirepF8AWfya641eTlhozXV0/m0S2T6cixL5vB+llxwWX5ws
         OL2Tx4lKfph7hI0dbKQcVUIPHpvYW9HFgQKfXELTpmSySi0i5DEQaaseXIjQeHVIG39U
         NBOBPT59mIfjzQi2gVLivxgr4ou8lpRCPDK6mkMp9j6FyrrFMvN1iOZqL3ztj0Amiccv
         CEHLNclvQ3MGVqL9zCeDJuM0EXhPNfEoyg8VCbTrNNXcP1Ch5udEtn5VCDSpKNqTjZbG
         9SZw==
X-Gm-Message-State: APt69E26o1tyTzH0YBdR8KhKyJLmU6n1XypAjucMOyTKStdLUTF0ZAKQ
        TpvWiFEV1FkW7efrlAEHvGQ=
X-Google-Smtp-Source: ADUXVKKttddAdaz2O2sO6BFe4MMwkhTQ6dCjLqjp0nJPsCtoRYQQi7aaMBJDHgWNt4E3eBuoCZdawA==
X-Received: by 2002:a19:1b11:: with SMTP id b17-v6mr1573071lfb.50.1529687201458;
        Fri, 22 Jun 2018 10:06:41 -0700 (PDT)
Received: from localhost.localdomain (213-238-244-10.customers.ownit.se. [213.238.244.10])
        by smtp.gmail.com with ESMTPSA id b65-v6sm1661175lfe.80.2018.06.22.10.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 10:06:40 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [RESEND PATCH v2] MAINTAINERS: add PhoenixRC Flight Controller Adapter
Date:   Fri, 22 Jun 2018 19:06:05 +0200
Message-Id: <20180622170605.8411-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for PhoenixRC Flight Controller Adapter

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
    	Add proper mailing list

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ce5062dc028..d8b5d9f810e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11103,6 +11103,13 @@ S:	Maintained
 F:	include/linux/personality.h
 F:	include/uapi/linux/personality.h
 
+PHOENIX RC FLIGHT CONTROLLER ADAPTER
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/input/devices/pxrc.rst
+F:	drivers/input/joystick/pxrc.c
+
 PHONET PROTOCOL
 M:	Remi Denis-Courmont <courmisch@gmail.com>
 S:	Supported
-- 
2.16.2

