Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1200C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5E621480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeNSh7cw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5E621480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeIZCqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:46:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39537 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIZCqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:46:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85-v6so9330706pge.6;
        Tue, 25 Sep 2018 13:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4qe908RaJ/ph6+BBynCieTVKzv1hDPEvIA5ezYzjQ6I=;
        b=KeNSh7cwEqb6+fFx5st60R3Wt6+cbEad1n4tFIt0VFjeERMMMjCmSVaNw32FyTCCY/
         tZvKOullrHjLN/Q9FCAaraQKmXdcFJg7ha9k4MtRM3E/IeFz4gIUFHOeLLq3k43RRtOP
         Cet9k6fyuAX0fQfdwOnl1X6+n6VGkBA4596R8EgkAazt4vmT6I6GpEjkU+8ukZsz6Gq2
         MDuArF6nS/FYDR+btqz53CDFDCmTt3uAWcamWcZ2XGkuNQZgLsSnmeQhNyLNAlfSLOvk
         CFUYN6P6TjRFND0RQR73jurOKM7gaNpQh16i9O0ajr0HIyVay8wIHgcNhR2xlWOuimKA
         jPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4qe908RaJ/ph6+BBynCieTVKzv1hDPEvIA5ezYzjQ6I=;
        b=de5vIS84X5xH54qvWnOTONkIHLK6tul/aHVYZDn3i6/ORy6gCUKcVRdeg9xMiR/C+v
         Vya2vRyWiXN/GlWjCOjBXLQgEME3yS/rJVLTkkFj23WLJQtIpjatLdid9JzlJ9xAYp8H
         YR8nYmwU2aztQOml53NDtKfKYJehQ9h7ydiY3ZsITwFNCST/tB0g3SxRIZg+pV7PjcmT
         5+QzqMlPCGyVnHHJjSBi95lBxaQUnttsVWkDVc8kJGeTFwmJBPiz1ceyHYuJo4QgIF7M
         ksLnqUo1+WgEs0SC1HAcw0erxZembOLkJv0VzMTcRACOXAKBHK6bx54VkJcsPLGHM/OX
         Mw9A==
X-Gm-Message-State: ABuFfojJZPnrju93FzgFRM2zz4IVT8CpZFxYpF84O8Qa8ubeVz8HQ/Bx
        4mpTKYHcJZ/KBXWZ6YnkeLQ=
X-Google-Smtp-Source: ACcGV629n0ATILzl281EAwaEARyAVEMMAKwWwWX8UyQzx+2n35NLlxcC7yTFHxjOjur3NXXLKw0VOg==
X-Received: by 2002:a62:c186:: with SMTP id i128-v6mr2297376pfg.248.1537907851458;
        Tue, 25 Sep 2018 13:37:31 -0700 (PDT)
Received: from hieu-Inspiron-7577.net.fpt ([1.54.224.16])
        by smtp.gmail.com with ESMTPSA id g3-v6sm4042129pfi.9.2018.09.25.13.37.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 13:37:30 -0700 (PDT)
From:   Hieu Tran Dang <dangtranhieu2012@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gao Pan <pandy.gao@nxp.com>
Cc:     Hieu Tran Dang <dangtranhieu2012@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] spi: fsl-lpspi: Option to prevent FIFO under/overrun
Date:   Wed, 26 Sep 2018 03:36:59 +0700
Message-Id: <20180925203701.13605-1-dangtranhieu2012@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain devices don't work well when a transmit FIFO underrun or
receive FIFO overrun occurs. Example is the SAF400x radio chip when
running at high speed which leads to garbage being sent to/received from
the chip. In which case, it should stall waiting for further data to be
available before proceeding. This patch add option to configure the SPI
controller to allow stalling (unset NOSTALL bit in CFGR1).

Hieu Tran Dang (2):
  dt-bindings: spi: fsl-lpspi: Option to allow stalling
  spi: fsl-lpspi: Option to prevent FIFO under/overrun

 .../devicetree/bindings/spi/spi-fsl-lpspi.txt          |  2 ++
 drivers/spi/spi-fsl-lpspi.c                            | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.17.1

