Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE05C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719BE20863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFdyIt7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719BE20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933213AbeGIPEc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:04:32 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43149 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932903AbeGIPEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:04:30 -0400
Received: by mail-pf0-f194.google.com with SMTP id y8-v6so13869098pfm.10;
        Mon, 09 Jul 2018 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8mHfuzQGaYi4cIeLtZSdvHsBy2cPhO4tqohsRr93AtI=;
        b=jFdyIt7osEt59TddYkA85UE5/+9GjpWD+FEmt92qLAFucQy5oa7l1WrlZ9LZGOtwzE
         poFS7vegAELJtV1/oH5Mbh2x9NzzyyD/ZXOpTKpPCeeRFvgd9xaxuELJR+flULuInPlp
         WncCg5kqkT1/LNKmROXTrVhXjUxiq1odN69/xHPzhQWByBN9A3kwZ7unF9Z6jJvUezju
         l8egZo9NEzN+jMZzeWFHBTPCcDOccJj1mm6/zmwyY4DTSMIcaT5RrXX8b1zv0XEf0kjl
         OltDZ3+04paGYC/dGRLM5bqssXEzcR0UW3e1+lIdTemTrvJPZzY1anXTuTgowS1fuH5O
         Oqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8mHfuzQGaYi4cIeLtZSdvHsBy2cPhO4tqohsRr93AtI=;
        b=af2LZnZP86owHrKpcrMA2wad8LbSfOZJqL6k4oJ40zHPaqANE/6/hw60bBXinhJ6iv
         OepeUzquOTOErXToXV9Puz6/Ag8T4V063SdmFTCZO0dEE9F8q3PL+721YoV3lGs/XogL
         9/qiQaczTOXznRp9CxM6aILjeFk8FS3Vc9+InvatKQUJMIdQCTSsoJO4rtdaAR0Z/0vV
         91UhNathfolOXxuK8fQEhbz37yNibAfVXcbNAwKd5pKX7Dq6mx1KD+YtKscLPTravJRu
         yj14FBtVAY24UnQsqfiTSU5ar5hSeHvuY1PUHkW5WM114tSVgfKoPvigHCx9NJ9BUOLM
         DZ/w==
X-Gm-Message-State: APt69E1XHXfVWNSsaZGn+dWTaja9syp1WNHRSEpySgaJY/J3H6uhj3di
        HNoW/9nGIjAbHjx64NqTDSTXGA==
X-Google-Smtp-Source: AAOMgpenP2ekrLFBEZ86K+FlZ/QrILUdwKJMfH9JrkAbl3gVSvnzZeTFEznA4/aQRfR6OYJhCMQJWQ==
X-Received: by 2002:a62:fb05:: with SMTP id x5-v6mr21841282pfm.210.1531148669598;
        Mon, 09 Jul 2018 08:04:29 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id f2-v6sm12692555pge.39.2018.07.09.08.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 08:04:28 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH] samples/bpf: Fix tc and ip path in xdp2skb_meta.sh
Date:   Tue, 10 Jul 2018 00:04:18 +0900
Message-Id: <20180709150418.32034-1-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below path error can occur:

  # ./xdp2skb_meta.sh --dev eth0 --list
  ./xdp2skb_meta.sh: line 61: /usr/sbin/tc: No such file or directory

  # which tc
  /sbin/tc

So use 'which' command instead of absolute path of tc and ip

Fixes: 36e04a2d78d9 ("samples/bpf: xdp2skb_meta shows transferring info from XDP to SKB")
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 samples/bpf/xdp2skb_meta.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/xdp2skb_meta.sh b/samples/bpf/xdp2skb_meta.sh
index b9c9549c4c27..67cf7b5f336d 100755
--- a/samples/bpf/xdp2skb_meta.sh
+++ b/samples/bpf/xdp2skb_meta.sh
@@ -16,8 +16,8 @@
 BPF_FILE=xdp2skb_meta_kern.o
 DIR=$(dirname $0)
 
-export TC=/usr/sbin/tc
-export IP=/usr/sbin/ip
+export TC=`which tc`
+export IP=`which ip`
 
 function usage() {
     echo ""
-- 
2.17.1

