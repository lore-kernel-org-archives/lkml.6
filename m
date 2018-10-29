Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640F3C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7CA20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="egboowhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7CA20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeJ3EQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:16:56 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:46834 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeJ3EQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:16:56 -0400
Received: by mail-pf1-f177.google.com with SMTP id r64-v6so4511504pfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 12:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:cc:from:to;
        bh=pTB2FPEP/cbXv24IRgwE++5m4C8hjjPVi3Qm7qpYKCI=;
        b=egboowhQL4MN7q+NC5Rlcw+vul2juzm+EU8mNW82/PGTGhfoYaP8Fiaq+7i7Yy/8SK
         mZkK5eqetZJAZR6vQFjIV5paVFqD5TKMA30ELQb3P0Y/TKW6XCRB4Dx0UR3vGr5OfXVo
         Nabf0dkBL9BUk+FCQlSWyPKXE+ACaMtdrtrgHMZlG43lwcNLLheWmQrF+JwJgaxQaxBH
         zy6gSkQ56nz3fCeiDuI3zDUUW8kytYZcKJiUUOoKq6mn0acrLvmQN1ViD0gyZnjifCI0
         DTRBd/AuxLqDveTmgG/Wx1zZQk+urkgEXORI39XOfFV52gy+9WSvtrt/KfKcLGnIbLeU
         v7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:cc:from:to;
        bh=pTB2FPEP/cbXv24IRgwE++5m4C8hjjPVi3Qm7qpYKCI=;
        b=OKfSD01YmNQl5NwCJROi2S2QBPROR/HZYJ3Y7W39ltSB8Cg8uUl4iySsB4mwJa1Vh+
         hAsx88nJhFlPsec4vnMtGWbVPrEnkNEiovg5SjndAlWMEqhWFamD2EW7yzac+JvTvs5/
         aFfe5nRiSXsCDdN9ppLre8Tmb0nsqpZfqF4m60OSooTN3BU8INlcQrSbEbU3wsbIqvQw
         p+lEpc2hkLPeFh05LrKxYC30uGQiNAiY2QYMhXSwd9UQxOp5+qnVPaYY0Ov+NYlHbvOr
         XDfHrTHT4Y4hR7dGHf5s1dAvJNbamdItnGqlQhWE9gKmqjdb8w32qAlmJxWEBQymX/0r
         rQaw==
X-Gm-Message-State: AGRZ1gJvQvpcHQbLHhqz7G/eJAxL37kUoh7P1DqOtOct2lNtyhxKw72G
        NRfnjFVBHPVOG/g0ik2TtSHEwY+g/ys=
X-Google-Smtp-Source: AJdET5dIQlolQFOmcfU1Q23HJy6EYUF7A2eThgS5t5oiv0bv9MzKQo4JmsoyKAlxmmptD6Vw5pKrzw==
X-Received: by 2002:a62:8f:: with SMTP id 137-v6mr16287743pfa.24.1540841213019;
        Mon, 29 Oct 2018 12:26:53 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id i189-v6sm4472808pfg.156.2018.10.29.12.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 12:26:51 -0700 (PDT)
Subject: [PATCH 0/2] Remove umoddi3 and udivmoddi4
Date:   Mon, 29 Oct 2018 12:26:32 -0700
Message-Id: <20181029192634.30078-1-palmer@sifive.com>
X-Mailer: git-send-email 2.18.1
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        khandual@linux.vnet.ibm.com, colyli@suse.de,
        andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org,
        willy@infradead.org, yuanzhichang@hisilicon.com,
        matt.redfearn@mips.com, robh@kernel.org,
        boris.brezillon@bootlin.com, Greg KH <gregkh@linuxfoundation.org>,
        alexander.shishkin@linux.intel.com, ynorov@caviumnetworks.com,
        keescook@chromium.org, bigeasy@linutronix.de,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org, zongbox@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These were only necessary for an out-of-tree driver that has since been
fixed to use the proper divide routines.


