Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4565BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CA920874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pb0gkkxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CA920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967022AbeFSQlW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:41:22 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35101 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967009AbeFSQlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:41:18 -0400
Received: by mail-lf0-f66.google.com with SMTP id i15-v6so507836lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tCfkDSKKHTOrFOxeEZdd68xBhnHV+cYMbg6JkAlxrPg=;
        b=Pb0gkkxHU97JnciR5Wu+PEDIvnbj8dFgJsHoLmb6ER6rVh9vfo6wVdydPQTrEllfd+
         2299E+GeAura7zVvlQgcb6Lx5j7/H855z6QRt0Ewed6215WsVYZxpSh8p5XlbVg2ta+A
         tncmRyCfc8SPUee/+VjCBGE1weGNSo1dCJm3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tCfkDSKKHTOrFOxeEZdd68xBhnHV+cYMbg6JkAlxrPg=;
        b=hgqGyyvT2y/rhRGHPEHmO7a1BSO0RJ7h7MXlG82/s3XzFupLrmY5bvbiYtZzRTnmdp
         HYZ+1TuLvsrb3qqBvP3qgT8BMS7SiZWkAdObI/jozJuyhLBfXToSmrYbZDwInGtXZgv9
         Dnhyfr0WdFDYC51DWGsl4wRAWRtKcYgabR8pcElp5O24kLm7S3svf+dfnFPA7abafmbh
         BK10+5SyTWFeo8YKuaqjrUOyOQTJqW9jzJYJ4GPmp2P2FPdMPo2WYk8f9b1YE2V1Cc4J
         s2r6EmiTn6LICSNa1MB02WG/DQrHFS9uiLuhdEu1OhYNREHMrI41uXCUJ9FFmDmOhj3t
         ALXA==
X-Gm-Message-State: APt69E3OQcS5EpUT2a9/WplN0P5oLp+UYlwVOEhVPGiN3ymx2OkKM56L
        q9iVTejXS6C5VvlSmr4l1RWNJw==
X-Google-Smtp-Source: ADUXVKK+EOyWBQUcW+FI59pEAiNHQP6lDAJ8zjvSdQyhTS+sBHwv6ezft/IK/TMCGaRWAlwZncbX4A==
X-Received: by 2002:a19:7:: with SMTP id 7-v6mr11276601lfa.62.1529426476981;
        Tue, 19 Jun 2018 09:41:16 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id q5-v6sm17255ljj.68.2018.06.19.09.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 09:41:16 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     davem@davemloft.net, shuah@kernel.org, fw@strlen.de,
        shannon.nelson@oracle.com
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: net: add config fragments
Date:   Tue, 19 Jun 2018 18:41:11 +0200
Message-Id: <20180619164111.30785-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fragments to pass bridge and vlan tests.

Fixes: 33b01b7b4f19 ("selftests: add rtnetlink test script")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---

Hi,

net/rtnetlink.sh still fails on tc hbt hierarchy, addrlabel and ipsec:
Error: Specified qdisc not found.
RTNETLINK answers: No such file or directory
Error: Parent Qdisc doesn't exists.
We have an error talking to the kernel, -1
Error: Parent Qdisc doesn't exists.
We have an error talking to the kernel, -1
Error: Parent Qdisc doesn't exists.
We have an error talking to the kernel, -1
Error: Parent Qdisc doesn't exists.
We have an error talking to the kernel, -1
Error: Parent Qdisc doesn't exists.
We have an error talking to the kernel, -1
Error: Parent Qdisc doesn't exists.
We have an error talking to the kernel, -1
Error: Invalid handle.
FAIL: tc htb hierarchy

FAIL: ipv6 addrlabel

FAIL: can't add fou port 7777, skipping test
RTNETLINK answers: Operation not supported
FAIL: can't add macsec interface, skipping test
RTNETLINK answers: Protocol not supported
RTNETLINK answers: No such process
RTNETLINK answers: No such process
./rtnetlink.sh: line 527:  5356 Terminated              ip x m >
$tmpfile
FAIL: ipsec


I'm using iproute2 tag: 4.17 and tried the qdisc command from the
function kci_test_tc in net/rtnetlink.sh:
$ tc qdisc add dev lo root handle 1: htb
Error: Specified qdisc not found.

For kci_test_addrlabel it fails on this row:
ip addrlabel list |grep -q "prefix dead::/64 dev lo label 1"

Any idea why these three fails?

Cheers,
Anders

 tools/testing/selftests/net/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 7ba089b33e8b..cd3a2f1545b5 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -12,3 +12,5 @@ CONFIG_NET_IPVTI=y
 CONFIG_INET6_XFRM_MODE_TUNNEL=y
 CONFIG_IPV6_VTI=y
 CONFIG_DUMMY=y
+CONFIG_BRIDGE=y
+CONFIG_VLAN_8021Q=y
-- 
2.17.1

