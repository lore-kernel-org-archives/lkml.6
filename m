Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E67C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CF420870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="axKNw1Pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CF420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbeKTIKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:10:23 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38865 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731082AbeKTIKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:10:23 -0500
Received: by mail-qk1-f194.google.com with SMTP id d19so51253501qkg.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 13:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0UloynJx4FD/pgAzOgUkwGUsAXEVRg/vVo9Gep3eslQ=;
        b=axKNw1Pk+n3TbtNQl91iKltb06dXmDlBM8GXD+DQwsuCSOl0JZze1Qa/AM+qxSnmSV
         0KgWmG/UoZA4SCl6CWcCQERX1SSM3cgBS+0QVUcTMFPm8XnfkMU3s55ZMq3y8BwGvb8h
         auPWs8Nao93vjtDAGK3BSISVpxxC9gPbTwnddrUq0kFWNDVNQYYyH7LebXtdx1iNJ2Jq
         XSULpw9i6SfCUAxiO+WMbIyUcAUygh297vYWrhDGp688oRz96AKkLDy6RWHm8LDaVeeC
         cr1e7BttdymrUl3U5GA/OSufPDnqltO93YJp76BIrPhNjW3LCRyNFB8GYKD5U053Tra8
         1QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0UloynJx4FD/pgAzOgUkwGUsAXEVRg/vVo9Gep3eslQ=;
        b=GaxltaBilPZ5PBrslcj8O5Y6ijvBlopPpxlqqi/Ltznth1x8ZnoTfad8NZZmxqLNJu
         s9PbHvo+LA+0lzT1dZTsfV65trkUwFAOn0DvstwveNaFH9IRSVJYy8s6j8O7aMus/xzh
         wRT4NkH8ksDIp8/wIQGc4Muoq7t8eZjm7gao6vXLqIOEHAqmO+wTtRo5F90UAHM1wOoZ
         ePgqpFBxFYQoYOeaRWFlekHr2vXL91mWUDP0UwTS3zJ/WE7OgKVGuPS5PMUvwzganahp
         ZJTeh1dvhtRsS5Oqe6qSqDclXmcwT9ajLvZB8PHKUPNLJko++QGOuPFzRis1HxaC5ja5
         xRyQ==
X-Gm-Message-State: AGRZ1gKzSi20mpeBVYzbqoDzDrHV/XHGG2Fnlb1u+pCkaci/KWTpfG6V
        iNRgQw5fe40zg0HhqjNN6dONyrsreSk=
X-Google-Smtp-Source: AJdET5fHGvFw2W1hFj5pm+GF7fa8pN7yNozvtQ0B8/O/nASArwr1DH1sX7cTtCxejQBCMK/3ntkfvg==
X-Received: by 2002:a37:9f87:: with SMTP id i129mr20883056qke.255.1542663885411;
        Mon, 19 Nov 2018 13:44:45 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x5sm27493714qtc.43.2018.11.19.13.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 13:44:44 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, ard.biesheuvel@linaro.org, andrew.murray@arm.com,
        james.morse@arm.com, marc.zyngier@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@soleen.com
Subject: [PATCH v1 0/1] Early boot time stamps for arm64
Date:   Mon, 19 Nov 2018 16:44:42 -0500
Message-Id: <20181119214443.25175-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I made early boot time stamps available for SPARC and X86.

x86:
https://lore.kernel.org/lkml/20180719205545.16512-1-pasha.tatashin@oracle.com

sparc:
https://www.spinics.net/lists/sparclinux/msg18063.html

As discussed at plumbers, I would like to add the same for arm64. The
implementation does not have to be perfect, and should work only when early
clock is easy to determine. arm64 defines a clock register, and thus makes
it easy, but on some platforms frequency register is broken, so if it is
not known, simply don't initialize clock early.

dmesg before:
https://paste.ubuntu.com/p/3pJ5kgJHyN

dmesg after:
https://paste.ubuntu.com/p/RHKGVd9nSM

As seen from the above with base smp_init is finished after 0.47s:
[    0.464585] SMP: Total of 8 processors activated.

But, in reality, 3.2s is missing which is a quiet long considering this is
only 60G domain.

Pavel Tatashin (1):
  arm64: early boot clock for aarch64

 arch/arm64/kernel/setup.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

-- 
2.19.1

