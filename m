Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46142ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089E421480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089E421480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeIZHCI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 03:02:08 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37082 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726269AbeIZHCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 03:02:08 -0400
Received: from mr2.cc.vt.edu (mr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w8Q0pvPb009793
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:51:57 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w8Q0pp4U020718
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:51:57 -0400
Received: by mail-qk1-f197.google.com with SMTP id g26-v6so22439155qkm.20
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 17:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=0T7+7vQ5CP4OHDhtetl14pPjwXeE4C2Nsa5lSYjM4d0=;
        b=NDf5D0r9a0Utnimmsl/ixbycMinwC9mua/y1asCsUVfpMQrD1CYS/2hqaizG32QV/S
         NvG9+qn6MtE+32QGG4iOKLomf4g5iMW21+XOx/KYdWt2TrMeOOqAEPlAvdd+bQ1pofuc
         QZ5h12l7e4bHc13EHv7D4Ju1th4jp/+JLmXQt3sm7jRTWtMfKvHPEbbmiHfyCeBI/Slh
         V4O9hS9pyeaNINZ13jSpI4iAA4FqR/6i2iOjyk3D70dkraCyMGSWfdawfkGe9eOpe4+m
         HCgTTR9/SZW7XO3uV8nItDkBRHCrpz61gGyEdVxQMbBC7SA0sFa6Fs4QezZpnDaZ8xmc
         +T7g==
X-Gm-Message-State: ABuFfoicUGoruGLZwV39mckoAuFAWmaIMrVQZOuYkFB37qmIFaL2rmH1
        TJ3TSEMyK3ueHU4oMGQ4DX057L6Bu6qGAShw9sle8h3w+8ly/FCFcQ6RAiHvElQqcdQLDigRL13
        5g/djObNUyETqkTvTiE+T1hj6H7D8iHWFKWA=
X-Received: by 2002:a37:83c6:: with SMTP id f189-v6mr2646560qkd.47.1537923111844;
        Tue, 25 Sep 2018 17:51:51 -0700 (PDT)
X-Google-Smtp-Source: ACcGV63ndqlop8F7it4g3CIB77VWJ+mkWZEwqPDbvmhqPyAzNgg4Lq6D6ML2d13Tk8E8WvVRnNSIAw==
X-Received: by 2002:a37:83c6:: with SMTP id f189-v6mr2646553qkd.47.1537923111689;
        Tue, 25 Sep 2018 17:51:51 -0700 (PDT)
Received: from ?IPv6:2601:5c0:c100:49da:1857:54ff:f889:7a68? ([2601:5c0:c100:49da:1857:54ff:f889:7a68])
        by smtp.gmail.com with ESMTPSA id l2-v6sm1921211qtp.41.2018.09.25.17.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 17:51:50 -0700 (PDT)
From:   TongZhang <ztong@vt.edu>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Leaking Path in XFS's ioctl interface(missing LSM check)
Message-Id: <5EF0D46A-C098-4B51-AD13-225FFCA35D4C@vt.edu>
Date:   Tue, 25 Sep 2018 20:51:50 -0400
Cc:     linux-xfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
To:     darrick.wong@oracle.com
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm bringing up this issue again to let of LSM developers know the situation, and would like to know your thoughts.
Several weeks ago I sent an email to the security list to discuss the issue where
XFS's ioctl interface can do things like vfs_readlink without asking LSM's
permission, which we think is kind of weird and this kind of operation should be
audited by LSM.

see the original post below:

>We noticed a use of vfs_readlink() in xfs_file_ioctl(), which should have been checked by 
>security_inode_readlink().
>The callgraph is:
>	xfs_file_ioctl()->xfs_readlink_by_handle()->vfs_readlink()
>
>This path allows user to do things similar to SyS_readlinkat(), and the parameters
>are user controllable.

security_inode_readlink() is not used inside vfs_readlink()

- Tong

