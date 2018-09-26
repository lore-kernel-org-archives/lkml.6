Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11CCC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA1720684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA1720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbeIZTUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:20:54 -0400
Received: from uphb19pa13.eemsg.mail.mil ([214.24.26.87]:47011 "EHLO
        usfb19pa16.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727265AbeIZTUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:20:54 -0400
X-EEMSG-check-008: 130479696|USFB19PA16_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa16.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Sep 2018 13:07:57 +0000
X-IronPort-AV: E=Sophos;i="5.54,306,1534809600"; 
   d="scan'208";a="18683516"
IronPort-PHdr: =?us-ascii?q?9a23=3AdPgUCRGee6jmgHd0DxGOaJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76o8SzbnLW6fgltlLVR4KTs6sC17KJ9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa/bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Sc8kaRW?=
 =?us-ascii?q?5cVchPUSJPDJ63Y48WA+YcIepUqo/wrEYMoxSjHwmhHP7hxCFGhnH23qM03e?=
 =?us-ascii?q?ouHg7E0wM8ENwDq2jUodbvOasOTey4wqvFwDPeZP1Wwzf9743Ifwg8r/GQQ7?=
 =?us-ascii?q?1wacrRxlcpFwjYk1uQrJbqPzeR1usTs2mQ8u1tVfmyhG48sAxxvjiuydssio?=
 =?us-ascii?q?nOnI4VzEvE+j9jzIY6It24Vld2bNi5G5VesCGaMpF5QsIkQ2xwoyk6zboGuY?=
 =?us-ascii?q?K/fCgLzpQr3QLQa/uCc4WO/xntV/6RLC9liH9qd7+znRa//VW6xuHiWcS4zk?=
 =?us-ascii?q?xGojdDn9LRrH4CzQbT5dKCSvZl+0eh3iuA2B7L5+FfJEA0ibLbK5k8wr4sjp?=
 =?us-ascii?q?YTsVrMHivxmEjukK+ZbF8k+um16+T8eLnmup+dOJN0igH5KKgunNCwAf8kPQ?=
 =?us-ascii?q?QUWmib+OC82KXi/U3/XrpKkuU7nrTWvZ3VP8gWprO1DxVL3oss9RqzFSqq3M?=
 =?us-ascii?q?wdnXYdLVJFfByHj5LuO1HLOP34Fuqwg0+3nTd3x/HJIr3hApLXInjFi7fuZ6?=
 =?us-ascii?q?xx60FbyAot1dxf/Y5bCqkdIPLvXU/8rN3ZDgM+MwyyzObqE8t91p8EVW2RH6?=
 =?us-ascii?q?CZLbvYsUWU6eI3P+mMeIgVtS7+K/c7+fHulmM2mVgafamqxpYYdHC4Hu5hI0?=
 =?us-ascii?q?WcYHrsn9IBHX0NvgokQ+zgkEeCXiJLZ3auQ6I84Sk2B5+8AofdWI+thaeM0z?=
 =?us-ascii?q?qhEZ1IeG9GD1SMEXDmd4WYQfsMbjydItN5mDweSbehU5Mh1Q2ptALi1rVnMO?=
 =?us-ascii?q?7U9TcDtZ390th15PbelQss+jNpD8SSyX2NQ3tokWMPQj88xLp/rlBlylefza?=
 =?us-ascii?q?h4hORVGsBP6PxTTwc6MZDcz+1kBN3pQALOYMqGSFa8TdW6Gz0+UtUxw9oWaU?=
 =?us-ascii?q?ZnB9qilgzD3zatA7INi7yEGp008q3Y33frIcZy1m3L1LM/gFY7QstAL3Gmir?=
 =?us-ascii?q?Rj+AjUAo7Di1+ZmLqydaQAwC7N83+OzW6PvEFeTQ5xXrzJXXMBaUvMq9T2+E?=
 =?us-ascii?q?fCQqSwCbQoLARB09SOKqhUZd3zi1VJWvPjNM7ZY2KrlGe6HQyIya+UbIr2Z2?=
 =?us-ascii?q?Ud2z3QCE8YnAAd5naKKxEyCTq/rGLAEjNuEUniY0T38ellsn+7SVU0wBuWYE?=
 =?us-ascii?q?1lybW54AIahfuZS/kLxLILpD8hqyloHFa6x9/ZF96Apxd6fKVAf9w9+k5L2n?=
 =?us-ascii?q?/HuAxjIJOgK7tvhkQAfAtqv0PhzQl3Bp9cnsgtqXMg1BByJr6A0FNdazOY2o?=
 =?us-ascii?q?j9OrnWKmn04RCuZLfa2krA39mK56cP8vU4q0njvQ2wE0oi9Gho08RR03SC/Z?=
 =?us-ascii?q?jKEgUSXozrUkot9Bh1uavaYi8j6IPQz3FsNrO0sjDa0dIzGOQl0gqgf8tYMK?=
 =?us-ascii?q?6cDw/yE9MVB86gKeM0nVimdRUEPPtX9K41O8OpaeCL2KGuPOl6nTKmiX5L75?=
 =?us-ascii?q?x60kKJ7yB8UPLH344Zw/GE2QuKTy/8g028ssDzgo1EfSsdHne7yST9AY5RYa?=
 =?us-ascii?q?pyfZwVBmu0P8K3wdB+1NbRXCtk81isNVMP3sDhLQiOaFry9RNMk0kbvCr0tz?=
 =?us-ascii?q?G/ymlPjzwxrqeZlBfLyuDmeQtPbnVHX0F+nFzsJs6ylNlcU0+2OVt63CC57F?=
 =?us-ascii?q?r3kvAI7J90KHPeFAIRJnD7?=
X-IPAS-Result: =?us-ascii?q?A2AiAADcg6tb/wHyM5BaDgwBAQEBAQIBAQEBBwIBAQEBg?=
 =?us-ascii?q?VSBYSplfyiDdJRGUAEBBoEILYhpj2AwBgGEQAKDfSE3FQEDAQEBAQEBAgFsH?=
 =?us-ascii?q?AyCNSQBgl8BBSMPAQVBEAsYAgImAgJXBg0GAgEBgl4/AYF0DQ+jA4EuhHeFH?=
 =?us-ascii?q?QWBC4lwF3mBB4E5gj0ugxsEhGCCVwKdBwmGQ4lkBhePNIt7im4igVUrCAIYC?=
 =?us-ascii?q?CEPgyeGAooYViMwAQEBeAEBjEYBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 26 Sep 2018 13:07:56 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8QD7uq2028291;
        Wed, 26 Sep 2018 09:07:56 -0400
Subject: Re: Leaking path or inconsistency LSM checking observed in fs/net
To:     TongZhang <ztong@vt.edu>
Cc:     keescook@chromium.org, davem@davemloft.net, dvlasenk@redhat.com,
        ccaulfie@redhat.com, teigland@redhat.com,
        LKML <linux-kernel@vger.kernel.org>, ocfs2-devel@oss.oracle.com,
        cluster-devel@redhat.com, linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>,
        Paul Moore <paul@paul-moore.com>
References: <8004D467-2F24-4E9F-A429-AA4EE5D2E366@vt.edu>
 <e6ef53a8-187e-d030-9246-3de2a9a79265@tycho.nsa.gov>
 <14C343F1-CCB8-4B2D-AB68-653300E64CB0@vt.edu>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a05758ac-7a8b-d199-717c-5e43c32830a2@tycho.nsa.gov>
Date:   Wed, 26 Sep 2018 09:09:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <14C343F1-CCB8-4B2D-AB68-653300E64CB0@vt.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/2018 07:36 PM, TongZhang wrote:
> ocfs2 is using sock_create instead of sock_create_kern in kernel v4.18.5.
> 
> fs/ocfs2/cluster/tcp.c: 1636
> https://elixir.bootlin.com/linux/v4.18.5/source/fs/ocfs2/cluster/tcp.c#L1636
>> ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
> 
> fs/ocfs2/cluster/tcp.c: 2035
> https://elixir.bootlin.com/linux/v4.18.5/source/fs/ocfs2/cluster/tcp.c#L2035
>> ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);

Yes, I think that's the real bug here.  Unless the socket is in fact 
exposed for direct use by userspace, it ought to be using 
sock_create_kern() or similar.  I would suggest that you verify that the 
socket is never returned to userspace, and then submit a patch switching 
the code to using sock_create_kern().

> 
> 
>> On Sep 25, 2018, at 2:44 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 09/25/2018 01:27 PM, Tong Zhang wrote:
>>> Kernel Version: 4.18.5
>>> Problem Description:
>>> We found several leaking path or inconsistency LSM design issue in fs/net.
>>> Currently we can only observe sock creation from kernel and all bind/listen/connect are not sent to LSM.
>>> So, we think that those net/socket related stuff should all go through LSM check and being audited
>>> even it is not a user thread or process.
>>> Here’s an example where we have a check:
>>> in fs/ocfs2/cluster/tcp.c:2035 o2net_open_listening_sock() a sock is created using sock_create(),
>>> where a LSM check security_socket_create is called(net/socket.c:1242)
>>> And where we don’t have a check
>>> fs/ocfs2/cluster/tcp.c:2052 bind
>>> fs/ocfs2/cluster/tcp.c:2059 listen
>>> fs/dlm/lowcomms.c:1264 bind
>>> fs/dlm/lowcomms.c:1278 listen
>>> fs/dlm/lowcomms.c:1354 listen
>>> several places that use kernel_bind/kernel_listen/kernel_connect
>>> net/socket.c:3231 kernel_bind
>>> net/socket.c:3237 kernel_listen
>>> net/socket.c:3286 kernel_connect
>>
>> That's intentional.  LSM isn't trying to mediate kernel-internal operations, and we do not want to apply permission checks against the credentials of the current userspace process for such operations.  ocfs2 should likely be using sock_create_kern.
>>
> 

