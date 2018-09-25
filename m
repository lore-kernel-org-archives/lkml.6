Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CE3C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A810B20880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A810B20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbeIZFqb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:46:31 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37720 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726089AbeIZFqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:46:30 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w8PNaW0X028554
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:36:33 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w8PNaRdx025347
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 19:36:32 -0400
Received: by mail-qt1-f198.google.com with SMTP id f19-v6so8899553qtp.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 16:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sMpSBH2PbU+C3KJABjRF58jfEPY+sECSwnUW3dhLDQs=;
        b=QJkYQD3yd7G0Ju9kV6vnnXs8hN5Ht+yTkDoR92qagQamzxCATG+P4svIvvHeNoh9C1
         Gxizy9tVb4XdeR1Wb6gHjQ7XZM008RfDKRBuFZQ1TWT59n7C+E4tuEsxrdYpuUrT0/Yx
         O8sCsLErqEY57V3PPuLckgYV9NikYfvlKPOWXzl9sH7ox91dXehWF6gc3IfB9aCan/Ms
         J4P8UnNIJaYzFQgTy3hZiMHItf1qbTpTcwQKwO9KqnGc4xirgzN5eqX7HsXWDTIJz+mq
         MKR1QjArEA7ZZ0zWSoqzJiXGUiddT+W1azOoOeH4j9s+f75LjxMklP+4dccYimqWQ86H
         7Iug==
X-Gm-Message-State: ABuFfohPg6/FzAurWf5QJPPWH9KMgfhAahYEvaHJKhZpZadrk0oSiqX3
        pibGOP5wp26c1OtdqnEForNvMGzHd1VRlJ1n9UwwY9fTAnBzit4kJ6RVFZTI/1N5czbJ9AvTljB
        fGF8sqFVBdC62qLfgGFvFAhI5Iw6BlHDGvnI=
X-Received: by 2002:ac8:24e1:: with SMTP id t30-v6mr2673760qtt.208.1537918587284;
        Tue, 25 Sep 2018 16:36:27 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62jesCok7SHm88Q3Ff9wV/WD4tgNNjcvTJl0f7wXGtzJ0SDr9wRXaeXN/5Psv/EfP8ydJ+MCw==
X-Received: by 2002:ac8:24e1:: with SMTP id t30-v6mr2673749qtt.208.1537918587076;
        Tue, 25 Sep 2018 16:36:27 -0700 (PDT)
Received: from ?IPv6:2601:5c0:c100:49da:1857:54ff:f889:7a68? ([2601:5c0:c100:49da:1857:54ff:f889:7a68])
        by smtp.gmail.com with ESMTPSA id r20-v6sm1907806qtm.80.2018.09.25.16.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 16:36:26 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: Leaking path or inconsistency LSM checking observed in fs/net
From:   TongZhang <ztong@vt.edu>
In-Reply-To: <e6ef53a8-187e-d030-9246-3de2a9a79265@tycho.nsa.gov>
Date:   Tue, 25 Sep 2018 19:36:25 -0400
Cc:     mark@fasheh.com, jlbec@evilplan.org, keescook@chromium.org,
        davem@davemloft.net, viro@zeniv.linux.org.uk, dvlasenk@redhat.com,
        ccaulfie@redhat.com, teigland@redhat.com,
        LKML <linux-kernel@vger.kernel.org>, ocfs2-devel@oss.oracle.com,
        cluster-devel@redhat.com, linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <14C343F1-CCB8-4B2D-AB68-653300E64CB0@vt.edu>
References: <8004D467-2F24-4E9F-A429-AA4EE5D2E366@vt.edu>
 <e6ef53a8-187e-d030-9246-3de2a9a79265@tycho.nsa.gov>
To:     Stephen Smalley <sds@tycho.nsa.gov>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ocfs2 is using sock_create instead of sock_create_kern in kernel v4.18.5.

fs/ocfs2/cluster/tcp.c: 1636
https://elixir.bootlin.com/linux/v4.18.5/source/fs/ocfs2/cluster/tcp.c#L1636
>ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);

fs/ocfs2/cluster/tcp.c: 2035
https://elixir.bootlin.com/linux/v4.18.5/source/fs/ocfs2/cluster/tcp.c#L2035
>ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);


> On Sep 25, 2018, at 2:44 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> On 09/25/2018 01:27 PM, Tong Zhang wrote:
>> Kernel Version: 4.18.5
>> Problem Description:
>> We found several leaking path or inconsistency LSM design issue in fs/net.
>> Currently we can only observe sock creation from kernel and all bind/listen/connect are not sent to LSM.
>> So, we think that those net/socket related stuff should all go through LSM check and being audited
>> even it is not a user thread or process.
>> Here’s an example where we have a check:
>> in fs/ocfs2/cluster/tcp.c:2035 o2net_open_listening_sock() a sock is created using sock_create(),
>> where a LSM check security_socket_create is called(net/socket.c:1242)
>> And where we don’t have a check
>> fs/ocfs2/cluster/tcp.c:2052 bind
>> fs/ocfs2/cluster/tcp.c:2059 listen
>> fs/dlm/lowcomms.c:1264 bind
>> fs/dlm/lowcomms.c:1278 listen
>> fs/dlm/lowcomms.c:1354 listen
>> several places that use kernel_bind/kernel_listen/kernel_connect
>> net/socket.c:3231 kernel_bind
>> net/socket.c:3237 kernel_listen
>> net/socket.c:3286 kernel_connect
> 
> That's intentional.  LSM isn't trying to mediate kernel-internal operations, and we do not want to apply permission checks against the credentials of the current userspace process for such operations.  ocfs2 should likely be using sock_create_kern.
> 

