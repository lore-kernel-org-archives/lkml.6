Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9704DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4446D2098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4446D2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeHYClm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:41:42 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:46294 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeHYCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:41:41 -0400
Received: by mail-io0-f199.google.com with SMTP id f4-v6so8570430ioh.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 16:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=Z+lYWO33pFp12kPKqYKdss4rHaQQfYDNJVOA5TSbei8=;
        b=ngIn8RMPIl/boWzMQP6YwahIC+aieIN72VOcKkH8uVOamwPJH09SaKFuEInmZstFzV
         wDDczjtVVCfeStL+B/yTRFohhPs97kC9V7ATvINJ7ermhQ+gZE5+C6eKRkCJtud6NSUI
         3a6nynOZ5ga83u3NNnEz4j1LhwZs/3TETbJ4PItmtnUlUa6uATo1NJEKu9CVbRaqELsH
         2curSbU2bK3svUKb9vulWU4q0DxuojpetoyN/CZgE0u5LhLPxWHVk8cNln1CDsa0+tzN
         31UB36j/db5lGUes25qwK04rvSGEoFcvz7iiWM0kAtgt86MtbRcznrjaJuKDi6hzVVJy
         YGaA==
X-Gm-Message-State: APzg51Ce1qyzChq3dFCQTkkRZOK0AXC14PUHQ7klzD3DghBOMoCjSEuq
        e0XTS9eqe8073YaDv8DitajyWiOYs+coKAjhmg87i/rvjWfK
X-Google-Smtp-Source: ANB0VdbF2BclJ6nEV19risXOY0PurxxmeMjJWh5Pxz9AWhUlIV5PtnDK4s/jurvx97WzjbJrJsTkb/nxGnIw8EoXlgBnzVlEHy/j
MIME-Version: 1.0
X-Received: by 2002:a6b:e4d:: with SMTP id 74-v6mr1647709ioo.51.1535151901536;
 Fri, 24 Aug 2018 16:05:01 -0700 (PDT)
Date:   Fri, 24 Aug 2018 16:05:01 -0700
In-Reply-To: <20180824230446.GA16891@oracle.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c479900574366765@google.com>
Subject: Re: Re: KASAN: use-after-free Read in __rhashtable_lookup (2)
From:   syzbot <syzbot+8967084bcac563795dc6@syzkaller.appspotmail.com>
To:     Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, santosh.shilimkar@oracle.com,
        sowmini.varadhan@oracle.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> #syz dup KASAN: use-after-free Read in rds_find_bound

unknown command "dup"


> The problem is a missing synchronize_net() in rds_release.
> References:
>    https://www.spinics.net/lists/netdev/msg475074.html
>    https://www.spinics.net/lists/netdev/msg507908.html
