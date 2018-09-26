Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51282C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D482089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D482089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeIZG6M convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 02:58:12 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:36388 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726190AbeIZG6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 02:58:12 -0400
Received: from mr1.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w8Q0m1Oj008977
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:48:01 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w8Q0lu4d010913
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:48:01 -0400
Received: by mail-qt1-f198.google.com with SMTP id b12-v6so2168595qtp.16
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 17:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=x6H14tvZ4JVglBdFz5PN5+IqF/Nwn9Alwin/2d8VLaI=;
        b=h1FQiU2qcQi2HZGdHpuNQPENsV9WHM+qa1YKGjKBGxVxW1chIvjJLtn+Q0F3/8HZNU
         hcmSdEZr/A8uoo4/rpU8ITqFVAzsGuTWtB/HJPZENcUtvMcp3Q5Tycje/bXuzjhPECzf
         ZRElRmduslAF+ea6HVddqT3Dzoq92xGW/ILhv47ieiVVtPVr1DAufv8Hm9UrWXAVQD1f
         RJ/7zY1tEieq/o4XOETgg73pDtvCnVxdIfUlYsFuudb7IiofAyqrL9BWSBi/6qqKWqPQ
         J9J4lUw0EUqYbIacGyfIpOGWlnzbh/UzTbHUV+RTC4UyAwd9JMqTwgQwRM1ZqoyCNykg
         +tdA==
X-Gm-Message-State: ABuFfohgxqYmwXvaK8L7ASzMq0MbAENX8XD8xJPpnkSQ6oVSzO4LkKY1
        VeSxGlgtg5cgu1h7sajJL8kVgheIxBx6Gi2rD9r0bELiUzO1yOS/fy20VG9UNGI2+KMc1SIki33
        wfSY14ydF+PduciBYjQxKcdIdmXr2/AszRQo=
X-Received: by 2002:ac8:3236:: with SMTP id x51-v6mr2763392qta.275.1537922876488;
        Tue, 25 Sep 2018 17:47:56 -0700 (PDT)
X-Google-Smtp-Source: ACcGV63tRpRMsCH8ajI+MT6zJY6osFZB8DMx8NyPPKcrVs/WuAIJNvmKNreFjKBJpeXhbwP78zgGqg==
X-Received: by 2002:ac8:3236:: with SMTP id x51-v6mr2763376qta.275.1537922876317;
        Tue, 25 Sep 2018 17:47:56 -0700 (PDT)
Received: from ?IPv6:2601:5c0:c100:49da:1857:54ff:f889:7a68? ([2601:5c0:c100:49da:1857:54ff:f889:7a68])
        by smtp.gmail.com with ESMTPSA id e15-v6sm2033287qkm.34.2018.09.25.17.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 17:47:55 -0700 (PDT)
From:   TongZhang <ztong@vt.edu>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Naming confusion and code comments for
 security_kernel_(post_)read_file
Message-Id: <208C9D5E-E63B-4A89-BC91-E163CF52AD03@vt.edu>
Date:   Tue, 25 Sep 2018 20:47:54 -0400
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
To:     james.morris@microsoft.com, Paul Moore <paul@paul-moore.com>,
        ebiederm@xmission.com, casey@schaufler-ca.com, sargun@sargun.me,
        fengc@google.com, mjg59@google.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        richard_c_haines@btinternet.com
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we were doing code review, we found and feel that the current name and 
description of security_kernel_read_file and security_kernel_post_read_file, 
and corresponding document/code comment in include/linux/lsm_hooks.h is
confusing and kind of misleading as we discovered that security_kernel_(post_)read_file and kernel_read() do not always in appear in pair.

security_kerne(post_)read_file is only interested in checking firmware/kernel module/policy file etc, however, kernel_read() are used in other places in which the parameters are also specified by userspace. For example, kernel_read() is used in https://elixir.bootlin.com/linux/latest/source/arch/x86/ia32/ia32_aout.c#L413

We suggest that it might be better to fixing the code comment as well as 
the function naming and it may help clarify the purpose of this LSM hook function.

- Tong

