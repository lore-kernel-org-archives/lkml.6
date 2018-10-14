Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DD5C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E23020652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckLgtAMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E23020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeJNR6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 13:58:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33956 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeJNR6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 13:58:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id w19-v6so15174100eds.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 03:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fEzcotzchAWc4ELNc1djL8gtzTcjkoyKeNUaucEVOw4=;
        b=ckLgtAMwElUULTwboJAGkYaEG0XImuEh71rh0DyHQNkiAxSJCfhOlNJvRZQ+TpchCx
         suTMjXviI+WTIM16w7RQjUSACLQDc4SpzZeHvkb8eyQCpFVAGN/kZUsPniigO0HL+As1
         qCjVwUlnqR5IcmlEhPLMS7I6yN/g/Z24nVc6I0SxN3k9Ze8Np+AunDiWMlyvu1EGHXTJ
         NzAD/0Ph0dXHPoiBTWr1wC0T75psdvAWuxgc0QOb18ul1hN1l3zL8T/KbMS1FDTwp9BK
         7u2s40vJSsL6CScsHYcegZJo66GhVIkRBLG2+t9vwtD54KAXFn2rjUoUTnRjuKb3QW9J
         6YtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fEzcotzchAWc4ELNc1djL8gtzTcjkoyKeNUaucEVOw4=;
        b=I+EhYQneVLQB7FYfCcliR/X4Z1ExLDEH+Jr7F5EE7JupGNqFzT3IeCZB+kjVF0jMsr
         rtsI/CBeXWmFAoGoJFEJnKnzq2X1Lv0R6dgEU246KyW6+Hw7VsFE7WoO4zpJjrkrfANN
         RFyIai5ux3nFftu167oKioEDkebCHr4nR6NCn8q3u+D9LxtVBGzQGV8/c+4cc5sagBjk
         QbSa+kD0VVOEQ6H7jorUilGnRKnM3Zpngsgdw0h5svXqtgGxLfWf+PWBwX8nT9Mcdym3
         sjXQ9a6fh+b1lxr2aL1Ef0+7vxhL3+nCMQNuM8i/5vNPwncvhuaskA9l7uu5+9f3TOYW
         m+NQ==
X-Gm-Message-State: ABuFfohnbFko2zhyd4Cys4EC+67AOaTuFW3KeVURQw8A3F49sRlSudPt
        f+Xyhdc3e4ecpCG5WxP+JqJxFqhc
X-Google-Smtp-Source: ACcGV60hfb8tx+mH6YfHiMidW2hplMf1lwLQIo0R91/lYjW80/C3CMwn8elGJmAeI/6rLz0sHdQdpQ==
X-Received: by 2002:aa7:c5c5:: with SMTP id h5-v6mr18156133eds.27.1539512286337;
        Sun, 14 Oct 2018 03:18:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id o13-v6sm1475630ejb.34.2018.10.14.03.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 03:18:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 8/8] staging: rtl8188eu: remove whitespace - style
Date:   Sun, 14 Oct 2018 12:17:42 +0200
Message-Id: <20181014101742.10952-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181014101742.10952-1-straube.linux@gmail.com>
References: <20181014101742.10952-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra space in variable declaration.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal_com.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_com.c b/drivers/staging/rtl8188eu/hal/hal_com.c
index 6db5c34ed02e..ff481fbd074c 100644
--- a/drivers/staging/rtl8188eu/hal/hal_com.c
+++ b/drivers/staging/rtl8188eu/hal/hal_com.c
@@ -265,7 +265,7 @@ static void three_out_pipe(struct adapter *adapter, bool wifi_cfg)
 bool hal_mapping_out_pipe(struct adapter *adapter, u8 numoutpipe)
 {
 	struct registry_priv *pregistrypriv = &adapter->registrypriv;
-	bool  wifi_cfg = (pregistrypriv->wifi_spec) ? true : false;
+	bool wifi_cfg = (pregistrypriv->wifi_spec) ? true : false;
 	bool result = true;
 
 	switch (numoutpipe) {
-- 
2.19.1

