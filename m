Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94727C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D5D20824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D5D20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbeKXFTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:19:31 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:60610 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeKXFTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:19:30 -0500
Received: from cpc118554-reig6-2-0-cust775.6-3.cable.virginm.net ([86.18.95.8] helo=xylophone.i.decadent.org.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gQGHB-0001FX-Ky; Fri, 23 Nov 2018 18:34:01 +0000
Date:   Fri, 23 Nov 2018 18:33:56 +0000
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] bpf: Test defence against SSB exploitation
Message-ID: <20181123183356.5q4bu47zpj5wdufb@xylophone.i.decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds log messages for all patching done by the verifier,
and a test case to verify that the patch to defend against SSB
exploitation is applied where needed.

Ben.

Ben Hutchings (3):
  bpf/verifier: Log instruction patching when verbose logging is enabled
  selftests/bpf: Add the ability to test for a log message on success
  selftests/bpf: Add test case for defence against SSB exploitation

 kernel/bpf/verifier.c                       | 13 +++++++++++++
 tools/testing/selftests/bpf/test_verifier.c | 26 +++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

