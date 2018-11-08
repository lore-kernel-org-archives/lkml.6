Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD516C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9539720825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXfmAqxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9539720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeKJIUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:20:49 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42033 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeKJIUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:20:49 -0500
Received: by mail-qk1-f195.google.com with SMTP id m5so4489253qka.9;
        Fri, 09 Nov 2018 14:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=FseLGOVXhXaszuhNkjLaxiQrhtI1YKOtn1mv2FWXrLs=;
        b=vXfmAqxKfieusvNNQ8pNbbTZ/etKL3WwMAWU+V7ruW5c+BALzpGaW7JxRWjkqedSb1
         qs/pjYbArnXeyAGuupFA95gkdZi/buNHE9JjJvMr8INRKav2r2RcrGyLtQXNwxShRLZ+
         JHtGwQx4H6D3w+WRxZLPQ3egDJvaZ1IzRDJfC89wnEBUwwIZNTWwd83WozTzr6Bx17xl
         r/2NesTGjLjXp0ele6buwEb55Z+sEOp0C4S1SuTZ8hqEGw8iBlKN+BmEpKTUpIjMKZA0
         OQp3LK1wu9SRD5YdK54P5/l4xCIION7Ki1CpPzEXkqJ8SNRYfvrtQ2lvha2QmMpZ2kNr
         Mt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=FseLGOVXhXaszuhNkjLaxiQrhtI1YKOtn1mv2FWXrLs=;
        b=lGzmUf3O6yIS9hmIoq2CyBL9LMeKMKrv+N1bxJYBWkvk2piry9nCh4cPsJSddS7O+a
         BAs6sY5o3Y2liMwbWkzpheOtAhsvkM9YIE+lT5nTudMBctoQq/sh9HK9qvG8a1H6lLqe
         /TOZhPY9hQSN5ZHXVWWhoqAIlIgzyIlWIS9lqwIzPnUwrwqTny4iZjid9bCPkrSug1/5
         QaIUtXdem1YbD/k9N4FEhgweNZfABAy8WzVPpPLATi27axuDvNN3tqYVaUEyjMGSqdVh
         SBJgP4dJbjUMT1d1UOrIR/kyWTdK9FuYpTklW96XAtOPgMoQV/u2cZWlzvWzR9QI3+QP
         XXBw==
X-Gm-Message-State: AGRZ1gKWhJJcwWi68/O4gFpSdk2VmLSBEKcxUiiz+rXJTUYy1xsKRfui
        pmWqA12bAcGhfJ51Or9m8xBNtKnvrOw=
X-Google-Smtp-Source: AJdET5cKSTsReavjuP1ZhTzWnVb4ieZgQ1BWVVS9gvXw9vaJcVi71qKcaxmUryUCjcdFia6oaI8CDg==
X-Received: by 2002:ac8:75cc:: with SMTP id z12mr10271238qtq.249.1541803090638;
        Fri, 09 Nov 2018 14:38:10 -0800 (PST)
Received: from ubuntu.localdomain ([177.194.48.25])
        by smtp.gmail.com with ESMTPSA id b8sm6065968qka.79.2018.11.09.14.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:38:09 -0800 (PST)
From:   capetry.dev@gmail.com
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fpga: altera-cvp: clean checkpatch faults
Date:   Wed,  7 Nov 2018 23:13:10 -0200
Message-Id: <20181108011312.29587-1-capetry.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlos A Petry <capetry.dev@gmail.com>

Insert missing or malformed SPDX-License-Identifier tag
    WARNING: Missing or malformed SPDX-License-Identifier tag
Fix function definition argument 'struct altera_cvp_conf *'
    WARNING: function definition argument 'struct altera_cvp_conf *'

Run checkpatch and all problem was fixed in the file.
This is my first contribution to the Kernel Project, 
please let me know if something is wrong, thanks.

Carlos A Petry (2):
  fpga: altera-cvp: Insert SPDX-License-Identifier
  fpga: altera-cvp: Fix function definition argument

 drivers/fpga/altera-cvp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.17.1

