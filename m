Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165B4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B159020833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B159020833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeIZAxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:53:20 -0400
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:3437 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbeIZAxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:53:20 -0400
X-EEMSG-check-008: 594079957|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,303,1534809600"; 
   d="scan'208";a="594079957"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Sep 2018 18:44:26 +0000
X-IronPort-AV: E=Sophos;i="5.54,303,1534809600"; 
   d="scan'208";a="16210626"
IronPort-PHdr: =?us-ascii?q?9a23=3Am0GJlx3n4aU48Yv5smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesRK/vxwZ3uMQTl6Ol3ixeRBMOHs60C07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwdFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5UTA+YEO+tTsovzqEYUrRamBQeiGf3hyjFLiHH406I13O?=
 =?us-ascii?q?YuHh3J0gE7A9IDs27ZoMnpOKocU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXb?=
 =?us-ascii?q?J/b8zRwlQyGQPAlFqQrYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2ho?=
 =?us-ascii?q?nPnYIa0ErI9Sp+wIYrPNC1TlNwb928EJZIqi2XOIR7TtkiTm11oio21LILtY?=
 =?us-ascii?q?ChcCQXzpks2gTRZOadc4eS5xLuTOORITBli317YL+/nBOy8VS4yu37S8m0zE?=
 =?us-ascii?q?5GripbndnIsXAAzwDT5dKdSvt840ehwiyD1xzT6+5YIUA0krDXK5g9zb4rip?=
 =?us-ascii?q?Ufq0HDHi7ymEnuja+WcFsr+vSw5uj6bbjrqYWQOo9phg3kLKgjldKzDf4lPg?=
 =?us-ascii?q?QWWmiU4+W81Lnt/U3jR7VKi+U7krLEv5DBPskbuq64DBNV0oYk8Rq/CSym38?=
 =?us-ascii?q?4CkXkIK1JFZgqLj5L1NFHWPPD4EfC/jkytkTd3wPDGOLLhD47TLnjfirvuY6?=
 =?us-ascii?q?ty61NEwgop0d9f/45UCq0GIP/rX0/+rsbYDhwiPgy62ennE9V92Z0eWW6VHq?=
 =?us-ascii?q?CZN6bSu0eS5u0zO+mMeJMVuDHlJvgn4/7hlmE2lkMGcKa3w5sXaXS4HuxiI0?=
 =?us-ascii?q?qDZ3rgmNABEX0FvgAmVuzllEWCUSJPZ3a1R6885S80B5y9DYjfQYCth7+B0T?=
 =?us-ascii?q?ynEZ1WfGBGDVWMEXb1d4WBQfsMbziSIsB5mDweSbehU5Mh1Q2ptALi1rVoNP?=
 =?us-ascii?q?TU9TMdtZ/4ydd6/fPTmg839TxwCMSd3X2NQ3tynmwWWz88xLp/rlBlylefza?=
 =?us-ascii?q?h4hORVGsFN5/NNSAg6LoDTz+p5C93pQALOYMqGSFa8TdW6Gz0+UtUxw9oWaU?=
 =?us-ascii?q?ZnB9qilgzD3zatA7INi7OEGIY78r/Y33j/JsZy1W3L1LM/gFY7QstAL3Gmir?=
 =?us-ascii?q?Rj+AjUAo7Di1+ZmLqydaQAwC7N83+OzXaQs0FZXw5wVb/KXXYCaUbNt9T2+F?=
 =?us-ascii?q?7NT7+0BrQ7KAdO1cmCKq5SYN3zkVpGXOvjOMjZY2+pn2ewBBCIxq6DbYbzeG?=
 =?us-ascii?q?USwj/dCE4anAAX5nuGKwc+CTm7o27EDzxhC0jvY0Xy/ul6sn+7SVU0zw6SZU?=
 =?us-ascii?q?17y7W14gIVheCbS/4L2bILpCkhqy5qEFqkwt3ZFcSAqBRlfKhHZtM9+0xH2X?=
 =?us-ascii?q?jetwxnJJOvM6RiiUAEfwtruEPu0g19Cp9cnsgysHMq0A1yJLqE31NFajOYxo?=
 =?us-ascii?q?zwNaPNKmXr4R+gdbDW1U/a0NuN4KcA9uk3q1X5swG1DEYt73Jn09xN2XuG+p?=
 =?us-ascii?q?rKFBYSUY72Uksv8xh6prfaYjQy5o/Nzn1jL7W7siLY29IoGOskyg+sf9JYMK?=
 =?us-ascii?q?yZCQ/yF9MVCtOwKOwlhVepdAgIPONM+64uOcOpaf+G1LSsPOZ6kzKslX5H75?=
 =?us-ascii?q?xl0kKQ6yp8TfbF340Fw/6G2AuGWSnzjFG6vcDwgoBEYDASHm6hxiX/C45RY7?=
 =?us-ascii?q?d9fYcPCWu0P8K3wdB+jYb3W3FE7F6jG08G2MixdBqKdVP9wAlQ2F8PoXO9hC?=
 =?us-ascii?q?u4yyV4kzQurqqYxizB3f7uewYAOm5OFyFeigLQJo67x+IaVU6nJ1w7iByj6m?=
 =?us-ascii?q?7k2+5WqLkpayHWSF1LVyb/NGFvUu27sb/GK8xL4p4jmShJUeCkZVmcDLnnrF?=
 =?us-ascii?q?9S0C7uBGBZwzMTfDGwvZD4ghk8j3iSaD5/pWTUfOl8zAnS4djbS+IX2DcaAG?=
 =?us-ascii?q?FmiCPQLkqxOdi3u9GVkYrT9OekWCS8VdkbfTfvxJiNsiiT/2BmARSj2fu0n5?=
 =?us-ascii?q?mvGgMzzCv11tRCTyjErB/gJILs0uDyLe9mcU1hAlPU8cd2Gohi1IA3gcI+w3?=
 =?us-ascii?q?8f066J8GIHnGG7CtBS3abzfTJZXjIQ68LE6wjinkt4JzSGwJyvBSbV+ddoe9?=
 =?us-ascii?q?TvOjBe4Sk69c0fTf7OtLE=3D?=
X-IPAS-Result: =?us-ascii?q?A2ALAADRgKpb/wHyM5BbDgsBAQEBAQEBAQEBAQEHAQEBA?=
 =?us-ascii?q?QEBgVKBYyqBZIQclENQAQEGgQgIJYhojWaBejYBhEACg2YhNRcBAwEBAQEBA?=
 =?us-ascii?q?QIBbCiCNSQBgl8BBSMPAQVBEBkKAgImAgJXBgEMCAEBgl4/gXUNpEKBLooXg?=
 =?us-ascii?q?QuJbxd5gQeBOQyCMYgtglcCnH8JgVWOTgYXjyyWTQE1gVUrCAIYCCEPgyiQG?=
 =?us-ascii?q?VYjgSsBAY0WAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 25 Sep 2018 18:44:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8PIgI4I001409;
        Tue, 25 Sep 2018 14:42:20 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Leaking path or inconsistency LSM checking observed in fs/net
To:     Tong Zhang <ztong@vt.edu>, mark@fasheh.com, jlbec@evilplan.org,
        keescook@chromium.org, davem@davemloft.net,
        viro@zeniv.linux.org.uk, dvlasenk@redhat.com, ccaulfie@redhat.com,
        teigland@redhat.com
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        cluster-devel@redhat.com, linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>,
        Paul Moore <paul@paul-moore.com>
References: <8004D467-2F24-4E9F-A429-AA4EE5D2E366@vt.edu>
Message-ID: <e6ef53a8-187e-d030-9246-3de2a9a79265@tycho.nsa.gov>
Date:   Tue, 25 Sep 2018 14:44:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8004D467-2F24-4E9F-A429-AA4EE5D2E366@vt.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/2018 01:27 PM, Tong Zhang wrote:
> Kernel Version: 4.18.5
> 
> Problem Description:
> 
> We found several leaking path or inconsistency LSM design issue in fs/net.
> 
> Currently we can only observe sock creation from kernel and all bind/listen/connect are not sent to LSM.
> So, we think that those net/socket related stuff should all go through LSM check and being audited
> even it is not a user thread or process.
> 
> 
> Here’s an example where we have a check:
> in fs/ocfs2/cluster/tcp.c:2035 o2net_open_listening_sock() a sock is created using sock_create(),
> where a LSM check security_socket_create is called(net/socket.c:1242)
> 
> 
> And where we don’t have a check
> 
> fs/ocfs2/cluster/tcp.c:2052 bind
> fs/ocfs2/cluster/tcp.c:2059 listen
> 
> fs/dlm/lowcomms.c:1264 bind
> fs/dlm/lowcomms.c:1278 listen
> fs/dlm/lowcomms.c:1354 listen
> 
> several places that use kernel_bind/kernel_listen/kernel_connect
> 
> net/socket.c:3231 kernel_bind
> net/socket.c:3237 kernel_listen
> net/socket.c:3286 kernel_connect

That's intentional.  LSM isn't trying to mediate kernel-internal 
operations, and we do not want to apply permission checks against the 
credentials of the current userspace process for such operations.  ocfs2 
should likely be using sock_create_kern.

