Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B8CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7362088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="HofaL2m+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MA8mJIvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7362088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbeGZGSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:18:18 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49293 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbeGZGSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:18:17 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 557C921F82;
        Thu, 26 Jul 2018 01:03:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 26 Jul 2018 01:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hx5LVx43cu3rH1wpW
        JfoBlYKGv6RjwuiyUBX/RSa0rE=; b=HofaL2m+12q7FYj5pBft8856HRLHkO3as
        UBkN5ICv8VKTIePUa0FaLTrOTf9nN2Oii92S9N3t3Em/fbd1RWMaSasn5g5znWAl
        hwsk+ECsi5G5L/Tak+ZGldqPH0F1PGGDXsRqkpkcjOPAEE5QGuaaBHWfzl7I29vs
        aoZuEp2mgPvOsfOWmU6etDXI8ctK8JBYs9wEsqME02XwDeN42Cv6zDhdUnwZ8EM8
        BLKY3QM4+JyTZjjwIR/R5Sz4/vv4yvQ+Oof1o8inO1jmV/gJVL9UhU2DM7+uU+bj
        gfFivULmhF3SSCj8qG/jdqvTS/7cdE7tH2mTPJZCeD2pGFBWmXaww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=hx5LVx43cu3rH1wpWJfoBlYKGv6RjwuiyUBX/RSa0rE=; b=MA8mJIvv
        97FDfBasB2G0PPsJKKlOj+p6OBVbJ3VdE8zMuUSa2w7V51bHq/KkmF/HvnNRw6tu
        eYlHvc2aKO3R5n4WhUfO0n/GYbkxmnXsvQs9ctnqQyeQ0tE2LR0YA/GzLO2/AK6+
        gvZST5Cy2AvACCsQMBNPrnk0NJ9UVHRbGDCTpwwxBJ6FPp2c7Co+F+D1xB4WOVNd
        PCj7MgVMP6GSdAUTZec1iMjDHKR+r8S620ywzZn/BuCulRoNWMw39XZA701B9gen
        Y+NluGTABSU1U/hJT7/YEC+V6+Pd+jNYnv25Lg+T0yKVnRCPugpIWw7qVl2b29ub
        94s3RN/hMA4E3Q==
X-ME-Proxy: <xmx:FVZZWz6vtQQofNQKqLXe-M9cJLfqA60A-mt2kyIsooGOhUZKJal44Q>
    <xmx:FVZZW-GYdb5y5fENIgXdnmFS0km3Kx9L9eKzQP1h_fh5260Pv7qPKw>
    <xmx:FVZZW93FQuzFPNIzNVl5_ho1r4Aaosq-pShcMm066fuF6pjAgXqdKg>
    <xmx:FVZZWzoMDUL_jQx7cVeeGQrNzTxvS6pQYpKR0FpyV4JGYarcXhsjWw>
    <xmx:FVZZWyPkfUzrlgUM2D2QY1RfhT-QTHBSqRhAuh5xEjLLsipSkWiaGg>
    <xmx:FVZZW2rwRVWcNNMhbLFLB0MHohHdi-Djmw_1gsrUcqBSFOP-PvuG9w>
X-ME-Sender: <xms:FVZZW-xBgK2KXdTCV03wqq5DMic54ET1BydckELJBYeZ8UErmgpf7g>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7FEFD1026C;
        Thu, 26 Jul 2018 01:03:16 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] docs: bpf: Rename README.rst to index.rst
Date:   Thu, 26 Jul 2018 15:03:02 +1000
Message-Id: <20180726050305.2147-2-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726050305.2147-1-me@tobin.cc>
References: <20180726050305.2147-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently bpf/ docs were converted to use RST format.  'README.rst' was
created but in order to fit in with the Sphinx build system this file
should be named 'index.rst'.  Rename file, fixes to integrate into
Sphinx build system in following patches.

docs: Rename Documentation/bpf/README.rst to Documentation/bpf/index.rst

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/bpf/{README.rst => index.rst} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/bpf/{README.rst => index.rst} (100%)

diff --git a/Documentation/bpf/README.rst b/Documentation/bpf/index.rst
similarity index 100%
rename from Documentation/bpf/README.rst
rename to Documentation/bpf/index.rst
-- 
2.17.1

