Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD15CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5B220A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5B220A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeHYClq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:41:46 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:37787 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbeHYCln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:41:43 -0400
Received: by mail-it0-f69.google.com with SMTP id e63-v6so2887064ite.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 16:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=v4vh5XvnR1DQsyIpm2k2jXJ7RpxmC6UnUsRDLJg78DU=;
        b=IiLLmGkaMQ67Hgcj7qr14nUdxW9DP2EHBCd/8EuUJSI1/W8ch1SHyevNopMfpL/0jI
         lnJUlZgPKwqO2pMiNr03CkrO/q2RZKiIZM9h7jlKCs7mxZK6NHQhNhq0Ijkfp58GSpK8
         dRLL1R9jrhqHRoajM9vp9OEiKWXTeEGMXXhd+rgIxhvWd6m3ppU7Q1PRk9r9ME7RuLIz
         i5ShcLme2FWthmWsYLgpUHibBfuvzqv9YH3SbAmbpKRPvgfSXC8ugq+F8sEFm5aw95fg
         mp7wEOnUsEoonVm7FLPC067bP/qJmh4AklKOUB1EaC55CoTTbxO8rqL1ptN8jbabkgPc
         bBww==
X-Gm-Message-State: APzg51Ar+cVps76AGQL6O/3HL7VK6CYvp32rJE+/Y6ixgQW+X7Va1Urz
        RmtRxyoUBVEafpiWk2AcRipl6NY60DhG2GYAwozWLdSuhg8T
X-Google-Smtp-Source: ANB0VdaoQSBQ3fICeEVcRnbrEy0CzWn8d/NGVY/H++W7y+S0iTMPqIUkf9HmzlVxHqIIUS32gWRZ1NcRurV2JCyrYi+3WVP28ExA
MIME-Version: 1.0
X-Received: by 2002:a24:b250:: with SMTP id h16-v6mr1844754iti.19.1535151902851;
 Fri, 24 Aug 2018 16:05:02 -0700 (PDT)
Date:   Fri, 24 Aug 2018 16:05:02 -0700
In-Reply-To: <20180824230446.GA16891@oracle.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8879a05743667a2@google.com>
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

> --
> You received this message because you are subscribed to the Google  
> Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an  
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit  
> https://groups.google.com/d/msgid/syzkaller-bugs/20180824230446.GA16891%40oracle.com.
> For more options, visit https://groups.google.com/d/optout.
