Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560AAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9512086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC++vBNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfAaTHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:07:21 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43508 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfAaTHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:07:20 -0500
Received: by mail-qt1-f196.google.com with SMTP id i7so4672819qtj.10;
        Thu, 31 Jan 2019 11:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nRTkLSE7eY5XXFnTzAGig+Jd+mIj+eAMonYFMHXoeJk=;
        b=WC++vBNCfO8uv2RBIp3KlpbWttUbWFGGL/1WtpjKpDkwx4ujvN68SW40v58xNFH2gD
         GZiHvdVWTcl8y4zIuAIrm70enj/twikJ28+H2pnHNMDrgVF/y2SxNQyEhxsrDJRctct1
         rpEmU0dBaGl65n8qF6JXvkXEV0f5OfXc15cxyCTqubyQPG9ze0ezcd1dMeNajijeYFjo
         kwOnUxV+xH4rpY06CPIvDXVtiaCeX91jYDGZ5/A/uiB8iMcWujhSSJ/I6xqY3Y4UjM2M
         9Cu38L39nBDxWiuWkh29rmUmq001q79PekcIDwOP3eodXsNjeL+iB5GWR71H1n06Vn9d
         QfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nRTkLSE7eY5XXFnTzAGig+Jd+mIj+eAMonYFMHXoeJk=;
        b=SKETkCR5OaB9JTGsX+qjij1KXoZT5wvj4mEwClyNtIvbevO+x/rk2r/JWYcRE/iA7m
         yg2Ui/F9OVCurAfwKfEYm6qpP7vV67AaY3POkGF1mksJYMKIhFfV01DzLoWwUQuzsSX5
         W2VNiwCmLkjXw8lmMJO4PmkcP9LvMC+Gr5NtIAaRJ+jbyr2PEmkAhpwn1BsbW16xFBri
         aQXo9Zn617idDopTzuLkUDuozGM8IgY7eM90ZXmwDOkoJjoiiuivPDdylGb/16J1F2s7
         HLqpxeE+h3qw8GkcDBPTsY8Gfc+7+f+6PgL3474n3dk6jYcK0/2Tbes61T/UwC/uCr4/
         H4yA==
X-Gm-Message-State: AJcUukeL9bDaMrHMZMM7jGeedwX5fbj8SRIOMbHMnAtnBy97jjtbe3Az
        /9cLc0e5U3oHVLZE2uL3J/Q=
X-Google-Smtp-Source: ALg8bN7WYGhgxvjCmilvlDbf1agu22Xt6cw5pH64JXqwCQkJeOofH0Miz/ztT+L2sbexJxLwjGTlwQ==
X-Received: by 2002:aed:2946:: with SMTP id s64mr35204710qtd.383.1548961639132;
        Thu, 31 Jan 2019 11:07:19 -0800 (PST)
Received: from luciana-K46CA.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id u67sm6561643qki.22.2019.01.31.11.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:07:17 -0800 (PST)
From:   Luciana da Costa Marques <lucianadacostamarques@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        luciana <lucianadacostamarques@gmail.com>
Subject: [PATCH] iio:accel:adxl345: Change alignment to match paranthesis
Date:   Thu, 31 Jan 2019 17:07:01 -0200
Message-Id: <20190131190701.9637-1-lucianadacostamarques@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luciana <lucianadacostamarques@gmail.com>

Align broken line to match upper line parenthesis. Solves the
checkpatch.pl's message:

CHECK: Alignment should match open parenthesis

Signed-off-by: luciana <lucianadacostamarques@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 780f87f72338..f03ed00685ea 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -150,8 +150,8 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 }
 
 static int adxl345_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val, int val2, long mask)
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
 {
 	struct adxl345_data *data = iio_priv(indio_dev);
 	s64 n;
-- 
2.17.1

