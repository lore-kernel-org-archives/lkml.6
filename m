Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D365CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B0B217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550547624;
	bh=l1g4TzNMDPVPnAzL1kqDObVlI8dMDQ7tO4dKoGLZuGw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Zqb9yDJG52MeUP7Im1DI8lnWh0txREUUa1Y5gAzMdzn+zfyGJM3DQRQp3yJg3/K1E
	 NIK7yGjxXX3FgGMoC/XL47z6S8HyC/6K+WGWBQZGhA8klBS+0OfGBzyG9onhh1IXxE
	 TCL0eWNYO12lrPUN9Puc0ueEjmPBflHno5exqjA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfBSDkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:40:22 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36715 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfBSDkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:40:22 -0500
Received: by mail-qt1-f193.google.com with SMTP id p25so21373400qtb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 19:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=EM+bwIatlVJyJ7ZZcy1LNMJoJp1bSjYRN5FGaaOtuFk=;
        b=rzvZF8bs4HSld9KM1D2QBZ633kV6XJy9WYpR0TyksauPj3ugQQzGT1y6buq2YEHknC
         SyMoEGXezcJl+53mL9tZdU36gs7N2TPC60L7fZUzZfNuHD/KRpM4YFkXWavs5t/iQL6K
         6cxySXvXJnL0k8eoU7QAuGWlOXraPGtFLAeW+URNfx8rtFNcKVHUn11I8sVLm8vncguv
         HRHESI8hHoT1mIKAir+cepTgC7geLYkSEFIhZ40MEHfmYrOJ0K15SZIyg4gepVUixWER
         qvk4hF8DblRsK0DwQEV3NM6k+rqS0ISraacDzZQbyqSeQJEpEUs0Hpny1o1terUjyOEi
         I2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=EM+bwIatlVJyJ7ZZcy1LNMJoJp1bSjYRN5FGaaOtuFk=;
        b=p/KOb/xPKtC/8KFexXyNV80ycEUJUJAXFf4iP9tQxGY/pPUO28E9dgdyuyXNnRdURX
         ztaVmT9veCeerUt//giuqxS/c6iTv43UoW4jXIfgwdVU0fKgMiqkSUriTtxpRR2iHFT7
         2SbIVL4P16ZqTnTQLOpWcVdk/f9CQ7CXu1C9bj6jK06XG6I2CbuPBYoEr1wRxV4S72XG
         Ogb+wOwXG+3Q8a/ih0pGZ0pQYgtGcC15rX2/2ZjmRhpXeUUbF+2q1c2eO2iD2hiTjfZj
         0N2JRSQe7scMYeIIEuF9Pk1VMaUp8BvjNUfLFjLQy2+JdkYKF7pvc6Had52i2fIVXioy
         ZC4g==
X-Gm-Message-State: AHQUAubda5TOXIB0l6E96L2JgoCSKVpBDIUF5FZb4bmcJXkyG+hr/vWl
        IR0jC9ss7keZfLOD4WEDAZM3zt/I
X-Google-Smtp-Source: AHgI3IY0QFsbz9oKHqqGYEt3HLdRSSlfYGxg/jCbW03/yaqIi0ucrgvlgDGgQHjujyOZsyX6fTXk6A==
X-Received: by 2002:a0c:c584:: with SMTP id a4mr19592201qvj.227.1550547621541;
        Mon, 18 Feb 2019 19:40:21 -0800 (PST)
Received: from kbl.fios-router.home (pool-96-233-42-17.bstnma.fios.verizon.net. [96.233.42.17])
        by smtp.gmail.com with ESMTPSA id u5sm7327680qtg.37.2019.02.18.19.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 19:40:20 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/11] multi-die/package support
Date:   Mon, 18 Feb 2019 22:40:02 -0500
Message-Id: <20190219034013.4147-1-lenb@kernel.org>
X-Mailer: git-send-email 2.18.0-rc0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does 3 things.

1. Parses the new CPUID.1F leaf to discover multi-die/package topology

2. Exports knowledge of multi-die topology inside the kernel,
   and also to user space via the topology sysfs.

3. Updates parts of the kernel that need to know the difference between
   a die-scope MSR and a package_scope MSR.

To follow, Kan will send some additional perf-uncore patches for #3.

Also not include here are some updates to user-space utilities,
cpuid, lscpu, turbostat, x86_energy_perf_policy.

Rafael suggests that the most practical way to handle this series
is via the x86 tree.

Thanks,
-Len


