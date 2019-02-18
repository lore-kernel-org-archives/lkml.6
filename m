Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9E9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5512147A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVrXsGeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbfBRNev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:34:51 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:35594 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbfBRNev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:34:51 -0500
Received: by mail-qt1-f175.google.com with SMTP id p48so19149073qtk.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 05:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hyi/5Em/QJP+a119xdeuFosVC5/h4J5zbETTYJU5q08=;
        b=AVrXsGeh2iBvJMK3BXpKIsQ9a6D8ni2DN6143syJK4fcdzRC8o2D2xvgXHqrt0SsxI
         EU6JZVP6FQCnGSyqpWEMOYTa7+CvMxea/TAAWgCQAeTO9uLPuyRrq92CPuoPDYmo0FDN
         VDCIHG8Bd1unyZxlDvE961sSeE8QK9PoQrmDbzqD6EYoqueubG7+qxWLBxDBnmUEnUQ1
         7GZG22zmceas8+oSq0gr/NlG6Td1bUnnlo80LNgo9I70iuGa0wTgFGHb32khAbsx1m7k
         YXzh+IAgk6iPFYtGHP81vZlYHMw8TzGBOq3ogSWSwHa2XvdBPLPjG7fzHtCrE7jXAat5
         rdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hyi/5Em/QJP+a119xdeuFosVC5/h4J5zbETTYJU5q08=;
        b=K1tg/SHmmGXjWwmdCpQZhBJnsA6oLvVXU+xYOYzV32sENP6IOTEitSSGYlburqA+9H
         Lst9y7vWOnxYRdZF9tzicn5yQ0i7W6rQG+VdSbIYK0703FI/08jYajyh+mmin3rB5XsA
         ecsXi0rWZsmXpPsqNiWr1btVCiDfSb78Y/6iXBzYG9+r032PVjlp7erUMGEWPJK61icB
         kaBcXsbTtoIS2A8DLhg5Jlet7F0kaIGzk9EZtPEQpsunqFlODSmBx40rZSRQJkXH7rmW
         HYiV+9XXEPmlNfDed1SR5dBFYqL2SbBMxLwcMmXvvqb+Ew53tU9BBvLmFax0AjzA2a0A
         N/Jg==
X-Gm-Message-State: AHQUAua7dz42/HXDgmAP0tgQon3DcOuUWJLg1ll/xbLxZjVkDj+c63sO
        wPTWp+sS1w+1Jzf0crM6oKY=
X-Google-Smtp-Source: AHgI3IbBlktnJx06H36IzQgn3GcbV5h9JqArANpWtMr2FmBF9hUuXk0cxM9IdO4G3hWn8mSwVWky4g==
X-Received: by 2002:a0c:c687:: with SMTP id d7mr17528284qvj.86.1550496890246;
        Mon, 18 Feb 2019 05:34:50 -0800 (PST)
Received: from nessie.verizon.net (pool-100-15-144-194.washdc.fios.verizon.net. [100.15.144.194])
        by smtp.gmail.com with ESMTPSA id k62sm7212821qte.86.2019.02.18.05.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 05:34:49 -0800 (PST)
From:   Dan Robertson <danlrobertson89@gmail.com>
X-Google-Original-From: Dan Robertson <dan@dlrobertson.com>
To:     kieran.bingham@ideasonboard.com, jan.kiszka@siemens.com,
        linux-kernel@vger.kernel.org
Cc:     Dan Robertson <dan@dlrobertson.com>
Subject: [PATCH 0/1] scripts/gdb: fix linux constants
Date:   Mon, 18 Feb 2019 13:25:11 +0000
Message-Id: <20190218132512.19988-1-dan@dlrobertson.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <07923abd-117d-2a33-2700-7db0840eacad@ideasonboard.com>
References: <07923abd-117d-2a33-2700-7db0840eacad@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Fixes tag to commit

Dan Robertson (1):
  scripts/gdb: fix linux constants

 scripts/gdb/linux/constants.py.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.20.1

