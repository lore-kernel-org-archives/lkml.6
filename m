Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0A7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E57020842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E57020842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeIYXfd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:35:33 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:57328 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726456AbeIYXfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:35:33 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w8PHR3xV000365
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:27:03 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w8PHQwUm027069
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:27:03 -0400
Received: by mail-qk1-f198.google.com with SMTP id c22-v6so26577072qkb.18
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=LRB843S1LvxU5qosP+tHZkjP1pe/ZSA7R3LuVe7lm8c=;
        b=HfPziLXwYJqVBzHVPG5kZmb/cZyy0TtX87EEQ3Y8ZJGeVpTao8tg3ahF8Vj9F/DCse
         RODx9ODx/bY9XtywOjYAzZcQZ9VLRv000pCDM8/XLATbYy2TF5MhfTWgbVxXfj4aHC9n
         Rm/9UU4QkAkgs4LS8d3r1Q6N2NDT4P0BqOuVY3JO9QwKD319SkvdY7dKUiMOklnmnoZ+
         Rhc1bJiuHNG+nBQbjBWvIYKNSxvYiVDMyG7uNt3AX6RCCXrYlAfkA55An45NY084pb2D
         TdIJDMI5RaA2YSubRh9OxUmSrNXDd5zkAkWwfPOx5X8/IfWkO/t+AqwL2hU468KR9BtS
         EA4g==
X-Gm-Message-State: ABuFfojkmy1uacFlb7Mv/jzCl9aZd+vHuSQ9aZ9CaDtZL/9ZA+C1zNBl
        FYkWBrOF018TpszxTRmyc9JHB9rfR8Ug1fH5sWNYGD8g3Xnet3/4DzWGLxZyluB2r4BDsmOONLk
        HiPlM2fBgPJVLqIas+G50u+cPv/iu3A6fwh8=
X-Received: by 2002:aed:3b32:: with SMTP id p47-v6mr1613304qte.13.1537896418006;
        Tue, 25 Sep 2018 10:26:58 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61Ry7Kdwn7tslwL4QjmQ0eQHZG8SYefWaarC6mO94sZlqCRE3k6fFTkpQGh4Sqa4+WWcYSQqw==
X-Received: by 2002:aed:3b32:: with SMTP id p47-v6mr1613283qte.13.1537896417806;
        Tue, 25 Sep 2018 10:26:57 -0700 (PDT)
Received: from [192.168.15.200] (linker.cs.vt.edu. [128.173.236.60])
        by smtp.gmail.com with ESMTPSA id k71-v6sm2140801qkh.30.2018.09.25.10.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 10:26:56 -0700 (PDT)
From:   Tong Zhang <ztong@vt.edu>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: different capability from different namespace required for
 prctl_set_mm_exe_file
Message-Id: <990D0DB4-35C7-4B7B-A938-2B984CD97E78@vt.edu>
Date:   Tue, 25 Sep 2018 13:26:55 -0400
Cc:     linux-kernel@vger.kernel.org, wenbo.s@samsung.com
To:     tglx@linutronix.de, akpm@linux-foundation.org,
        linux@dominikbrodowski.net, gorcunov@openvz.org,
        ebiederm@xmission.com, gregkh@linuxfoundation.org,
        keescook@chromium.org, Dave.Martin@arm.com,
        wolffhardt.schwabe@fau.de, yang.shi@linux.alibaba.com
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Version: 4.18.5

Problem Description:

We discovered inconsistent check when using prctl_set_mm_exe_file(), which is used to setup exe file link.

It is required to have capable(CAP_SYS_RESOURCE) in prctl_set_mm().
while ns_capable(CAP_SYS_ADMIN) in prctl_set_mm_map().

There are two differences:
1)requiring capability from: user namespace, init namespace.
2)capability bit required is different


- Tong


