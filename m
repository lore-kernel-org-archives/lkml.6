Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCBAC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 05:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD2B20865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 05:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB0Wfw5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD2B20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeIIK1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 06:27:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33598 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeIIK1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 06:27:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so8893029pfn.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 22:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vYEqOFn5R0amTaBE1RExEK3d6KlvYS2EmaOK7vztr18=;
        b=PB0Wfw5kQY/ittHpIzJtbVPfRpGFxreL6ZTxu1dZzfmRQpj7rIkfRN+WC3If/zFD1M
         b1uLNjuhWMEdBe8Hdsu5ZzhiMNs3ywW9juNPjU/NgfQN/ot8srzit3cy2B2MaAF4WhJy
         yarKKBuAUhRsira/DnddSyaE8cVcCZL5tPlugbbTPIRJof2g7gc7KLF/YYC7q23wBVfY
         qTiIOnqbuMDJ7lsWvTpJaTdGhLMuiDv3BOdcg2GWN+rw7q6xdhIAQdyFrVCNZTC8/MjT
         cx617QZd9mKp5kwP2kpKdwSUM2E8HGcsIbNns5jtvvHY0MGTphiomg0c+oFSkPTezQlL
         PMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vYEqOFn5R0amTaBE1RExEK3d6KlvYS2EmaOK7vztr18=;
        b=IvMYi4W1WAVLLK8avcThjUmO424AjRNQ2wanULs4r/MoHAo1Z6Mc0DDkCnsFDVkfP4
         i79pFbgKFrubAJEaZaiUOp6idgBaWajGXZlhmAaSuDHZvxRlrhUwSqSmwjTtzg30Fe0g
         Zoa1uMvUojOQKW8ucw41RZqOimK7V9LmqTcB6H9LQr3KkKyPlcAWTvX60pioweqrUCBx
         ywhhrCcSW6ickNDy4TkisGjmpbM40wxCYHFgae9lF72t6JWP2/ZUnnqQYKDStjkFIija
         YrUvbjUdQqD403Aa7G9Qpmv8ucaDy/x2ulmmqf9bnAqBdoLjeaxCgP4PdJKtffZtoJq+
         SveQ==
X-Gm-Message-State: APzg51CDo7t2ROJcIrnlmEvH0Bwr3FXvRDzW6IS5az6f9y5tbISlmwz3
        1NGYAVBHPQI1UxkL/lZfOds=
X-Google-Smtp-Source: ANB0VdaxAcWpFsxw+ywNrKLXrXM8K/QwLfcKiMPHUNf0mmdnQHCgwUsGlQFhUaMTiwMITPHRk/AcKw==
X-Received: by 2002:a63:ec14:: with SMTP id j20-v6mr16246808pgh.28.1536471566858;
        Sat, 08 Sep 2018 22:39:26 -0700 (PDT)
Received: from roar.au.ibm.com (115-64-249-220.tpgi.com.au. [115.64.249.220])
        by smtp.gmail.com with ESMTPSA id 186-v6sm6491034pgg.56.2018.09.08.22.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 22:39:25 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Matteo Croce <mcroce@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org (op)
Subject: [PATCH v2 0/3] tty: hvc: latency break regression fixes
Date:   Sun,  9 Sep 2018 15:39:13 +1000
Message-Id: <20180909053916.14139-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-sending this one with the used-uinitialized warning in patch
3 fixed.

Greg these patches are needed to fix regressions in this merge
window, please consider them for your tty tree.

Thanks,
Nick

Nicholas Piggin (3):
  tty: hvc: hvc_poll() fix read loop hang
  tty: hvc: hvc_poll() fix read loop batching
  tty: hvc: hvc_write() fix break condition

 drivers/tty/hvc/hvc_console.c | 38 ++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

-- 
2.18.0

