Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B7BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E132089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRYoBN5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfAHJXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:23:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36797 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbfAHJXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:23:31 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so2792038ljk.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=os9UMXiP5DOCaFU3g8mBC0SoBCxdTiZaR7qK5UdhrQo=;
        b=dRYoBN5cjlEQhV7LUtP+VY/ZWQUv1fxkRSX3zvjMPxDiQiBnKmyKmbj3uzeFF95gbq
         jMom4vnT9u8NFxE5onf/pe/vI9GmZJVPHyUpXNgHRorKOsjl2BeIEEXCLUBrolzr7oHg
         8Yc06Ssn1F9PAVmDXWr3kFz5/yIz5wI8VvbwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=os9UMXiP5DOCaFU3g8mBC0SoBCxdTiZaR7qK5UdhrQo=;
        b=tCUcUhx+5o7zQmiD7IMYOke+uY1Ur+HfdtlCgDQ3dkkpaxgHeZRuuLbqZUMOezZ6+R
         uoOm0peq0YaL1ymup+ZJWzAPpTCRuEADniBseQwkf7zIlvlGs4cd0naW/a5TiKpBzCuq
         NDuyQEUquXIt+wdwoN77lypy99Dxo6yPOW4f+NyvZYn+O/u38qYRENNXSjHRn36j3ewb
         QFROpNSEwoGiI7v9c8JYopyu0oqOrxkT6Ur9RInpJeF9kgVeryD9RpANKMfiadt5Chrm
         vBpMklCgln7CbY9yL7mzE05LeacHoPJQznO4LpdVm7AzpB7P/bZXAuFA2y/iEAYWeR4e
         PKVw==
X-Gm-Message-State: AJcUukelZUiaV3SFGmO9AIPBOVIZJN3j6UbTd16Lrcaierq/ByAYxoLk
        KuzzMa4ZO3tDDmyfHSpg8eKn2w==
X-Google-Smtp-Source: ALg8bN7Q+GvrRgQxmu4Q79YdlefvRBYpDGGnlrgwrz+LvOLkt9tp+kV0Fvg7qyV28DgqSsoZuAH6ww==
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr640573lji.133.1546939409355;
        Tue, 08 Jan 2019 01:23:29 -0800 (PST)
Received: from localhost (c-4f66025c-74736162.cust.telenor.se. [79.102.2.92])
        by smtp.gmail.com with ESMTPSA id p19-v6sm14348111ljb.47.2019.01.08.01.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 01:23:28 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: bpf: install files tcp_(server|client)*.py
Date:   Tue,  8 Jan 2019 10:23:03 +0100
Message-Id: <20190108092303.12597-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When test_tcpbpf_user runs it complains that it can't find files
tcp_server.py and tcp_client.py.

Rework so that tcp_server.py and tcp_client.py gets installed, added them
to the variable TEST_PROGS_EXTENDED.

Fixes: d6d4f60c3a09 ("bpf: add selftest for tcpbpf")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 73aa6d8f4a2f..70229de510f5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -55,7 +55,9 @@ TEST_PROGS := test_kmod.sh \
 	test_flow_dissector.sh \
 	test_xdp_vlan.sh
 
-TEST_PROGS_EXTENDED := with_addr.sh
+TEST_PROGS_EXTENDED := with_addr.sh \
+	tcp_client.py \
+	tcp_server.py
 
 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = test_libbpf_open test_sock_addr test_skb_cgroup_id_user \
-- 
2.20.1

