Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E014C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060EE249C1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WMsVwJQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060EE249C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934005AbeFVXVQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 19:21:16 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39578 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933931AbeFVXVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 19:21:14 -0400
Received: by mail-pf0-f195.google.com with SMTP id r11-v6so3862900pfl.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 16:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:cc:from:to;
        bh=sqC8pE5iajhtogWJlfHen5WxYD8aVk/phL1mUlPtmu0=;
        b=WMsVwJQZ3LGG60DxIGHfGtO74kEARZ1Z4c9rh9WXGQxRsC2tgz70SVhub7T+tVGXL/
         5011FFxWiBEBwvvlOTLQO6zqK13t0apVQv4kM1FnxdlIgYKdUCWBEM2wNHOKZ2McyaDp
         XhozU7rc6hCyVqPrAQBeTXbpD2yfDtMWLJm2EM4rqcQIKxc83A9Ygbs3Lr4CMDYyNXhh
         o7FK3HRIIINcZM3ZSsyTztJFHa4ItwTRmfbVfoM22aLd2cVeEfKPxWry7MxGU95sI+EA
         4mHTSWX0K3UvIeS/WfcifmGbacCxlQd4FlpJY2Y7/QJVqkMt257XRBu1/JGA5CbLH5tA
         zMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:cc:from:to;
        bh=sqC8pE5iajhtogWJlfHen5WxYD8aVk/phL1mUlPtmu0=;
        b=FE+qqE2MoQkzq0/XRu/12ivU8hOwwI0TFaybVimru+DSDxWc2CvvpNpTZZK0OWuKZq
         iEGMVldOZBTsJ/kiNEpjwWmcE4M9hnrDH0WcDMXzHEbDbqa5glT1AbbLQ8xMC/Qttjv7
         LpOFBWxVSeBS9NoT6YIXeoOyy04EdGY8YE+yRvXStd7oiUgZfxx6Zla5x6Q+q9s5I7/m
         zUZ56jovpswO1CRs2/hYNWhfPjRPQWyuthyNbSZmwyXE8Ku6T9rDStPR5ttzKMwStW/c
         ZqcuNK4OQYssdkt50P+kxmtDSEqqiBfrKP6BeBCkhtHjc3vZEWd7iyEKyYe9tgV9OBiL
         P1hg==
X-Gm-Message-State: APt69E0sMqSZhsBrF9FfUB8DMRJKDdReDAm61x3IG+De1IUG0VuIcD+Q
        GMwGC7J67PWKV1ugQgtEY0bSWA==
X-Google-Smtp-Source: ADUXVKJ7q+Z1KJHk+A2vvpf2yKqWTtUl0uEnAMXCq1gKG7w7nlTA/n3G8oslBrc+fwMComc0abyFLg==
X-Received: by 2002:a65:6148:: with SMTP id o8-v6mr2982991pgv.93.1529709673601;
        Fri, 22 Jun 2018 16:21:13 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m11-v6sm4096904pgt.46.2018.06.22.16.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 16:21:12 -0700 (PDT)
Subject: Driver for the RISC-V Interrupt Controller
Date:   Fri, 22 Jun 2018 16:20:03 -0700
Message-Id: <20180622232006.12158-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        shorne@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V ISA mandantes the presence of a simple, per-hart (hardware
thread) interrupt controller availiable to supervisor mode.  This patch
set adds a driver for this interrupt controller.

The patch set itself has been around in various flavors for a while, but
as far as I remember it's never been properly cleaned up and submitted
before.  As it currently stands it's essentially three seperate patches,
but as they're all intertwined I'm keeping them together.  Sorry if
that's the wrong thing to do.

The patches are:

* A cleanup to arch/riscv to remove a bit of the old initialization
  mechanism that snuck in to our arch port.  This patch is trivial, so
  unless there's any feedback on it specificly I'll include it in my
  next pull request.
* The addition of device tree bindings to describe "riscv,cpu-intc".
* The actual irqchip driver.  If this gets merged before the arch/riscv
  patch then it'll cause our build to fail, but I'm assuming this will
  be targeted at the next merge window so we should be safe.

