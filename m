Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE77C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2062820647
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLg2/TPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2062820647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeGYIfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:35:30 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41082 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbeGYIfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:35:30 -0400
Received: by mail-yb0-f193.google.com with SMTP id s8-v6so2627787ybe.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 00:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hS0VAEdQ6pPLPCS2anL1wq6RP0BqkAGLLSlh84lqMiM=;
        b=nLg2/TPx6fVcm9QLhUIV8sy1npMg1Zr+v+b6IajycREMK0+kjW6UZFhFN3XKX7gWAW
         RbSt+6oEIB4Ialb7+2JLuCZ0SUcTeNu+3mK9XS7di2KzIlVDjrpGZLO1MeIyugA8O1jl
         WAU+kSfQ6Cq3eUrpJGNoqU+2a9oklfN/qFDzxRtmdjeWRm2HmDyZjOzLkkY1XLVkiytF
         Nc8Jcsju5qFp/+OJlmNDDtCZveoe+DrxZ69OvMkMe1OZWXQSBnPH6OrRnkdOPgBuy1B+
         iXw0fVRXjAwrS3hEoV2PsT6WjVWMk1/IIJM8DCBoeBFryzWtDjoEt8gVi7Mo1msbCXOt
         XixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hS0VAEdQ6pPLPCS2anL1wq6RP0BqkAGLLSlh84lqMiM=;
        b=TgS9rj3T35jao7HGq6UBMLHEZE4V1u1Po4hxF/U8QkLRQsHICEuiiLE7pW+yH1vKhH
         WwA7hexljn3KAaq0BvJ13q0iF0zowsm6XI4JMP3KB1lbNZrDUqZD1tXpN5tk/CP4pyq9
         uHSURJk+nvAKdU4outtTNDb517+57pN5cpTBipfzGugcU3VmgAhngoxrzz72hsFHEMRG
         4QmdG++fCw4fq3lVXtw4MezMKYIE418Y82MnIHFAE/GNH+IsvCD2N5cMpE6X4Y5+ec6A
         q2w+KKYSXVpOtF7OsCWILsWd+jl0ChmqK76GobHFZr2ai+eTSSiqkSwKgPI0YULCx5p9
         sjoQ==
X-Gm-Message-State: AOUpUlHxkarRlTV+6r/QMvOjAXg00l+BqtKFdnYShf6M+SkHdZWL+kkc
        bLvkGeoj5cRBsw0PVhaalCG5xRf5bg5vJYXeUHpThA==
X-Google-Smtp-Source: AAOMgpd3RIonW2/u9xFc1pJYZXLw6dKCGmqhl9ctBaLitM8ppYN9iQCbZBQevy9Lh6xXLsv6MIzzwjSUVN8rN/13hAk=
X-Received: by 2002:a25:b28c:: with SMTP id k12-v6mr10791060ybj.161.1532503507490;
 Wed, 25 Jul 2018 00:25:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:b88:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 00:25:07 -0700 (PDT)
From:   =?UTF-8?B?5byg5a6B?= <zhangn1985@gmail.com>
Date:   Wed, 25 Jul 2018 15:25:07 +0800
Message-ID: <CAC2xsYKxv_4-n19LwuoR=RJL_yP+zSqn6+HFpQyVtrsqmyv7OA@mail.gmail.com>
Subject: no public email address excluding Gmail
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone

I notice each developer in this email list has a company email address
or Gmail, or maybe selfhosted email.

last night I have tried my outlook.com, yahoo.com, QQ.com email, all
of them are rejected by mechine.

I'm new to this community, don't know the history, could someone spend
some time to explain to me?

I can't access Gmail at home, and I don't want to use my company email
for my personal fun. which email provider in China I can use to jion
this community.

Thanks.
Ning.
