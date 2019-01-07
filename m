Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B749C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C0C20665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sil57EZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfAGMJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:09:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44701 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfAGMJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:09:36 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so51979pfh.11;
        Mon, 07 Jan 2019 04:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CbPTZzcOA1DV1YhnY5u3loilJcAzxvy0+gpnuwEu9WE=;
        b=Sil57EZLzMoFwtJiCFynL1HqRsKwrzDvlzJRE+2OHmPnP4CKSaAaSeyd0qJCq4Byu1
         aveOBvisUD8c36bcVXHmSmLw8AJahdxBTlQaGZ1PGZ3pm5TFOXiWVrFweH2r4M4r97Be
         BKbxNtzBzM5Y/wRBoux7FuWp17vm+Tn2SejzWStUYqTxWWzcAXiSmg/byYzEdwimK8Jc
         B9HFGlhguKPwkCRIohMLx7f/yrRMLpn9boPu7j5XIfk2fLK1cbTBsgAi8jab/4boc1q9
         kZoY6JiEaOKn3VVNCmp6Mwc8vPZW6YswssgVO0OF/1B8DfWb2osd7UAgT1L+EjKH/NQf
         zoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CbPTZzcOA1DV1YhnY5u3loilJcAzxvy0+gpnuwEu9WE=;
        b=rrqj1GtTFhtY8dk65sS340ojPoArDVmSLk2WhvJ/MZzrtg5gmbLkGpz/5nEMObdJdu
         fqAUhZa7HHrBQn1laFUGLnmRGsG//nR9Qs1llN3ZJTAv/B4tmQjGLhI4AQmtdCURaHlO
         8uhBr+fe+xtJ76r8gz5EX/vMheH37hL4Dotn6+Xr/CTALUgzjIickT9L8Ch8gUf9f/oA
         TEMDZrWUWGEV5KIRmMaHw9Sjfpwzv/44ydvpTbqzgwHetQ9nYsaMVPJBwfj6vYU+aaJZ
         toJ/7Is4omWhbtjAIstOPNxnH7Ubvg8jR+ZFR6N/dlksG2toXWRxS4aqkuFQYkOgGhjh
         NeWw==
X-Gm-Message-State: AJcUukfvYa74+oRXWxo1TK4OCYPCaAjy6d8Rjy8Nkutt09x8p0U24ugA
        jfsFun3+CeEvQ8IWr3ZCmMo=
X-Google-Smtp-Source: ALg8bN4ay9zGV/zE8rqfZRq21Yw2EZHN7UTAXf4fCcqS41fSIJ/Wdaa/QOuJZzQjwUZbLyvR81XWeQ==
X-Received: by 2002:a63:cf48:: with SMTP id b8mr10902264pgj.17.1546862975391;
        Mon, 07 Jan 2019 04:09:35 -0800 (PST)
Received: from ap-To-be-filled-by-O-E-M.8.8.8.8 ([14.33.120.60])
        by smtp.gmail.com with ESMTPSA id w128sm95451783pfw.79.2019.01.07.04.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 04:09:34 -0800 (PST)
From:   Taehee Yoo <ap420073@gmail.com>
To:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
        mcgrof@kernel.org
Cc:     ap420073@gmail.com
Subject: [PATCH net v3 0/4] net: bpfilter: fix two bugs in bpfilter
Date:   Mon,  7 Jan 2019 21:09:27 +0900
Message-Id: <20190107120927.13238-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches fix two bugs in the bpfilter_umh which are related in
iptables command.

The first patch adds an exit code for UMH process.
This provides an opportunity to cleanup members of the umh_info
to modules which use the UMH.
In order to identify UMH processes, a new flag PF_UMH is added.

The second patch makes the bpfilter_umh use UMH cleanup callback.

The third patch adds re-start routine for the bpfilter_umh.
The bpfilter_umh does not re-start after error occurred.
because there is no re-start routine in the module.

The fourth patch ensures that the bpfilter.ko module will not removed while
it's being used.
The bpfilter.ko is not protected by locks or module reference counter.
Therefore that can be removed while module is being used.
In order to protect that, mutex is used.

The first and second patch are preparation patches for the third and
fourth patch.

TEST #1
   while :
   do
	modprobe bpfilter
	kill -9 <pid of the bpfilter_umh>
	iptables -vnL
   done

TEST #2
   while :
   do
	iptables -I FORWARD -m string --string ap --algo kmp &
	iptables -F &
	modprobe -rv bpfilter &
   done

The TEST1 makes a failure of iptables command.
This is fixed by the third patch.

The TEST2 makes a panic because of a race condition in the bpfilter_umh
module.
This is fixed by the fourth patch.

v3 :
 - Avoid unnecessary list lookup for non-UMH processes
 - Add a new PF_UMH flag
v2 : add the first and second patch
v1 : Initial patch

Taehee Yoo (4):
  umh: add exit routine for UMH process
  net: bpfilter: use cleanup callback to release umh_info
  net: bpfilter: restart bpfilter_umh when error occurred
  net: bpfilter: disallow to remove bpfilter module while being used

 include/linux/bpfilter.h         | 15 +++++--
 include/linux/sched.h            |  1 +
 include/linux/umh.h              |  4 ++
 kernel/exit.c                    |  1 +
 kernel/umh.c                     | 36 +++++++++++++++-
 net/bpfilter/bpfilter_kern.c     | 72 +++++++++++++++++---------------
 net/bpfilter/bpfilter_umh_blob.S |  2 +-
 net/ipv4/bpfilter/sockopt.c      | 59 +++++++++++++++++++++-----
 8 files changed, 140 insertions(+), 50 deletions(-)

-- 
2.17.1

