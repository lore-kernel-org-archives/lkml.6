Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D48C4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD6321BF3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD6321BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbeHIDcc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 23:32:32 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:60168 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731063AbeHIDcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 23:32:32 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w791AJXI026580
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 21:10:19 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w791AE2S001966
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 21:10:19 -0400
Received: by mail-pg1-f199.google.com with SMTP id m25-v6so1823629pgv.22
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 18:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=R5H1Fx3OoclB21wkN7PlwQ3/4Bcu29B6sqrY7mPcU+A=;
        b=ZXOTr9IhLu5XvBUJUkyvKvxkX5NQY7eZrwEDqQ/UutOYOVzwRY/p5/+99Bqvbk/m8w
         kvpOvYrQGZDMTkkLijgaumDWYfp9l5SEJ46bEJysA2OVd5S2Yy5NXaOUCK5isixj9Ifm
         tSeS36RmwJT5+6m8Gwysc/608LrKBN4oNDRjdmaQXMJx2pPNtstvcj/GGmL0ai8wMpvO
         3SeNisNtn3WJZJrjWx0tislHCoR8SfpV1IUyxvOBt1psSXcxEjPmbJWFI35YH+2TqxxO
         LdIn7UIHS4beEOxW7LerkSelmq6AcR2bQ215Z/NpTO588yxJ6DSBrLu7qZlqzdv7Ev3H
         O+Xw==
X-Gm-Message-State: AOUpUlGtHibIfAipjMhUQM+tRk75CvT2XjwGDr3nz4tfGgAMqH5GhD0m
        ji40YRKstPvya7k9aLYu48TxYnHOdiyzUufBN1HEx7D4FQex01jARANHVydvANOSHBLz1xfKUSQ
        owCha1KIzC0S/WVk86cl52/ekbHD6VnZ8830=
X-Received: by 2002:a65:4c87:: with SMTP id m7-v6mr57645pgt.98.1533777014556;
        Wed, 08 Aug 2018 18:10:14 -0700 (PDT)
X-Google-Smtp-Source: AA+uWPymgWB07ZSW0mDXb2r0wbtvdduZr96WStYX/agH2gqjXDIovWwK0f/ZZf7PXqdK/KFfz6YI6A==
X-Received: by 2002:a65:4c87:: with SMTP id m7-v6mr57628pgt.98.1533777014399;
        Wed, 08 Aug 2018 18:10:14 -0700 (PDT)
Received: from ?IPv6:2607:2c00:4000:2:385f:4702:864e:3179? ([2607:2c00:4000:2:385f:4702:864e:3179])
        by smtp.gmail.com with ESMTPSA id j5-v6sm6444980pff.139.2018.08.08.18.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 18:10:13 -0700 (PDT)
From:   TongZhang <ztong@vt.edu>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Question about inode_permission() check in unix_find_other()
Message-Id: <91367B74-6AC5-4E14-AE13-30FF6A7A6592@vt.edu>
Date:   Wed, 8 Aug 2018 18:09:57 -0700
Cc:     wenbo.s@samsung.com, ahmedmoneeb@gmail.com
To:     davem@davemloft.net, garsilva@embeddedor.com,
        matthew@mjdsystems.ca, willemb@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Networking Subsystem Maintainers,

I have a quick question about inode_permission() check in unix_find_other(),

I was doing a code review on net/unix/af_unix.c and found out that the inode_permission() check is confusing here.

Since the unix socket is presented as a file, and will be permission checked by VFS when user open it,
why do we still need the inode_permission() check in unix_find_other() anyway?

Thank you,
- Tong

