Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E8FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569B32087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwtqOy9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569B32087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeIYC5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:57:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51299 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeIYC5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:57:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id y25-v6so3698646wmi.1;
        Mon, 24 Sep 2018 13:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=odoAFg3mCbMEEQncGHczaktcQLg5ndQMmrNPL+ny1wg=;
        b=iwtqOy9/q7unIqsbh2REL+ZZ810ZdZw8fpKjeLcb726DbxH6cZgZbWfrs/n39vup55
         NbmLcqyQYAWpqu7Ltf8G40YSeoWKGiGUEw+spQg83Z9FLE9pkWCP+CAVU3vy+18kwgpt
         UNiND3XBWuGXjkB6RtCx/fMt4vmL3Ju5bTc0EN+IIJVAhq56SEE762uQavJRVIBGw7H2
         C0xiobA0f4s+ZW2XBxsP5vJOVt4vSTlqBnqW4D/bTI3UcUS9/DpBAua9eJMjZH0vhQdx
         rxXHYRCc9Fhrfhs2/A2hCpdWK1NHGNpMNQK7dr78SP5dLqbwWG7o8WiaFZwfQB5t7i0X
         EgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=odoAFg3mCbMEEQncGHczaktcQLg5ndQMmrNPL+ny1wg=;
        b=GaC+KF+uJ1KtEiirycOSyS9sU5GcJ4WiI1DQ1ko9zn2mZsn/qB47LNysBer8PwIJU/
         5/uu0b3nQNJMyb+Kqlv62iP3uefJygwBkN84OGF40roq+HkItsw0P2j21MGNFi5qXFE0
         8vK4TFqVHYM5C4USWH9GFQiH5AlXEQQTc19EJOTtX0ljyCIF71VYGh5HeRVNCedA73z7
         EEIDhkJ+TsbL4qBxJh0OUzQhn9hWjwbThcnxaaPoStzkEdFPxPZZMdqbGOgwLKPnWxT0
         sDZ51QKaQYJkru/q4TNIaHvxWpHef+W9FYlZaiDBGdX3dgV91zDhj1eEuqsMcRNT7GLz
         CdFA==
X-Gm-Message-State: ABuFfohgsdx5cTy0CUM6L9lwr2vojxqfVfLFijA7lBjHeHsp8vwLeZZD
        zqjprbJIsswbx3jiJQ/+Pow=
X-Google-Smtp-Source: ACcGV638uIKZnnnU4On6y6XLccZW2Qg3Gh9WsZHAA0qELLPcRTHrVIMz66tvlrrANsIC+mxBTS8CQA==
X-Received: by 2002:a1c:3dd5:: with SMTP id k204-v6mr89182wma.53.1537822424463;
        Mon, 24 Sep 2018 13:53:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id q5-v6sm126068wmd.29.2018.09.24.13.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 13:53:43 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] qed: Avoid implicit enum conversion in qed_set_tunn_cls_info
Date:   Mon, 24 Sep 2018 13:53:34 -0700
Message-Id: <20180924205334.7337-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/net/ethernet/qlogic/qed/qed_sp_commands.c:163:25: warning:
implicit conversion from enumeration type 'enum tunnel_clss' to
different enumeration type 'enum qed_tunn_clss' [-Wenum-conversion]
        p_tun->vxlan.tun_cls = type;
                             ~ ^~~~
drivers/net/ethernet/qlogic/qed/qed_sp_commands.c:165:26: warning:
implicit conversion from enumeration type 'enum tunnel_clss' to
different enumeration type 'enum qed_tunn_clss' [-Wenum-conversion]
        p_tun->l2_gre.tun_cls = type;
                              ~ ^~~~
drivers/net/ethernet/qlogic/qed/qed_sp_commands.c:167:26: warning:
implicit conversion from enumeration type 'enum tunnel_clss' to
different enumeration type 'enum qed_tunn_clss' [-Wenum-conversion]
        p_tun->ip_gre.tun_cls = type;
                              ~ ^~~~
drivers/net/ethernet/qlogic/qed/qed_sp_commands.c:169:29: warning:
implicit conversion from enumeration type 'enum tunnel_clss' to
different enumeration type 'enum qed_tunn_clss' [-Wenum-conversion]
        p_tun->l2_geneve.tun_cls = type;
                                 ~ ^~~~
drivers/net/ethernet/qlogic/qed/qed_sp_commands.c:171:29: warning:
implicit conversion from enumeration type 'enum tunnel_clss' to
different enumeration type 'enum qed_tunn_clss' [-Wenum-conversion]
        p_tun->ip_geneve.tun_cls = type;
                                 ~ ^~~~
5 warnings generated.

Avoid this by changing type to an int.

Link: https://github.com/ClangBuiltLinux/linux/issues/125
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/qlogic/qed/qed_sp_commands.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c b/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
index 8de644b4721e..77b6248ad3b9 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
@@ -154,7 +154,7 @@ qed_set_pf_update_tunn_mode(struct qed_tunnel_info *p_tun,
 static void qed_set_tunn_cls_info(struct qed_tunnel_info *p_tun,
 				  struct qed_tunnel_info *p_src)
 {
-	enum tunnel_clss type;
+	int type;
 
 	p_tun->b_update_rx_cls = p_src->b_update_rx_cls;
 	p_tun->b_update_tx_cls = p_src->b_update_tx_cls;
-- 
2.19.0

