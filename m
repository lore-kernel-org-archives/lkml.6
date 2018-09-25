Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2AAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBE320867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LnsAHSR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBE320867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbeIYSUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:20:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44364 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeIYSUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:20:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id t11-v6so3532203edq.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 05:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+SJi6jIZW2lJ/yIWSh0Ju2vjFQAAgCzYNpIhE6KpBnQ=;
        b=LnsAHSR3C6ZyAJLXza0WAL+6HNSWaAOceZ9NyQEKAgfdIM0OzO9aCwRWQ2CRCJ8uzG
         3ZJ6vrgpzXVu+zGd2Ahz7hRNs7IaGbOQG2JTojIEOJMJpHNa72Y/S6xh2/PlLokeSWYv
         pXtJq0YsadHofmdgQr7s7RlhxlOpFnNoYa7I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+SJi6jIZW2lJ/yIWSh0Ju2vjFQAAgCzYNpIhE6KpBnQ=;
        b=akSlxgEUz8MrzAzkfBIUrDaRo4EPbGXXKsolXDGZRNkIF696hbOVN6sY/XNv4uY7uf
         WDZtgQB2J3A1Xa9rz53Xp+lus4wxYU3A7N4pPpzbe3DdTyaeHUbvR8/6+/VcwC4h8TgZ
         7qiJwihh4/AGczVNi0dzpeRVINQ1UNf2Fwhzj8kNm5gtIznnBBB+Jm6Hg8loHeHBlfjA
         jfrJHuPvzkLY7Y0MEWXcJjFUbLpNGETPn+2G2w5xClqKBlm7I4Pd1gqBjWnXKyNnUqA6
         4yQtPmO1TPSbae0GXBXlbZPeJyptomLD4+htBcesla5HUPwAMdNR/84l8GDyYBE57zIK
         f3Ug==
X-Gm-Message-State: ABuFfoinDnTAS+D4BJBNKhGXHEMPIveVH/mrXiZ4qPdrT5OsD9nLxEzU
        xeCxnHBb5zEZioxi+ZLktYWqexBD0PCRxA==
X-Google-Smtp-Source: ACcGV63+Zz5KG2Cw2C895r7B+/t+c4tRfhG3jWEHl6J+CkdOkqK6liZ9gEb3H//K6tXUPs9LsmjHdA==
X-Received: by 2002:a50:a0c5:: with SMTP id 63-v6mr627854edo.47.1537877569627;
        Tue, 25 Sep 2018 05:12:49 -0700 (PDT)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id a11-v6sm6739522edn.95.2018.09.25.05.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 05:12:48 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH trivial 0/2] h8300, riscv: Remove smp_mb__{before,after}_clear_bit()
Date:   Tue, 25 Sep 2018 14:12:23 +0200
Message-Id: <20180925121225.9917-1-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial clean-up, removing the (now obsolete) definitions of the two
barriers. (smp_mb__{before,after}_atomic() can serve similar purposes.)

  Andrea

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: <uclinux-h8-devel@lists.sourceforge.jp>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: <linux-riscv@lists.infradead.org>

Andrea Parri (2):
  riscv/bitops: Remove smp_mb__{before,after}_clear_bit()
  h8300/bitops: Remove smp_mb__{before,after}_clear_bit()

 arch/h8300/include/asm/bitops.h | 6 ------
 arch/riscv/include/asm/bitops.h | 5 -----
 2 files changed, 11 deletions(-)

-- 
2.17.1

