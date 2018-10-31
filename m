Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A1CECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16B620657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="iOe5IfPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16B620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbeJaPoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 11:44:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42436 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeJaPoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 11:44:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so7123496pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 23:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=W1Z7T7kYjlBi8jnbvZhMFNfbvlYHmnf00Bddaj4EEcg=;
        b=iOe5IfPzrF5E0yjIQCcA5XCwUsRiMCfTNQC4xk6eGS6Opf1Jn8PgGFE9OEPk06SowF
         zCU9di3r7Ti45Ge115ru4+bplzx6EahmtXpDOPC7oCZpSRkYRADZuB1cs+wCAwRKUG0p
         6D5fYGrwVFYjMpmTxUCDhhAxWe+pcakjwuBbXYkLKlQOkYebPEaa120UPjvMYwP/9O0g
         DC6D4HvZmE50iLa5UfT+rHb+bSkD5ERmw9B7X+i0IB99VcBNtC0s9MCxhbk2zzQ5VIWr
         8zsiSaQlfJv7WRuq07NHwMWxm7yelaEOEAcVKi3T/NYkwsdaUwDVFTcyMHmpPyzEnyMI
         yAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W1Z7T7kYjlBi8jnbvZhMFNfbvlYHmnf00Bddaj4EEcg=;
        b=EafLC7Ne9KjeywCUWDrkUsNYcedTt+AUxTPnNGT1DLKaXhOUAmLXUSYEoLrQw+YRnS
         1mFqcn41o2oZyRBZaeuF6W1KnI6FR38gobAsG6tfvQPoqu9IdOKo7KXPkfx7w6VD8qNz
         xU6k3DZCbUknJrvV6HPO93O5EExHgwjUjTTf95zzsDprC5Ikm3O/HUXLSmt4MOgc6hxS
         /mDZSxZpVs91T6HuC4CARGMm8LuNVq3eTvfmT0kqr8lxY8XYEXq6TyQZlPAKaSEBhkKr
         4L+GXJfSMipmIYv1xBhw8Gp2E1a7pNonKClEnBQb+dZcO6GmJtYQupvdp0lh5W/jqHrx
         tAyA==
X-Gm-Message-State: AGRZ1gLJlPa6P0yr/yVU5Sy2hOmwQALueu4xfaUf26dGD7ljxclZJ1lh
        AyMbR93wJdQmychJAlCGnJ4Egw==
X-Google-Smtp-Source: AJdET5dilzfkWheBCWXHjkkoozVlDTr3ymkKUud+nAw6m33ypd3Xfs9LEF4YFLd/MVq33d48Jm1bKg==
X-Received: by 2002:a63:5357:: with SMTP id t23-v6mr1995605pgl.40.1540968439226;
        Tue, 30 Oct 2018 23:47:19 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id z7-v6sm12127306pgi.42.2018.10.30.23.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 23:47:17 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Zong Li <zongbox@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] RISC-V: A few build/warning fixes and cleanup
Date:   Tue, 30 Oct 2018 23:47:06 -0700
Message-Id: <20181031064709.30981-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of fixes for build breakage or warnings, and a small whitespace/asm
cleanup. The non-cleanups would be good to see in 4.20 to keep builds green.


Thanks!

-Olof

