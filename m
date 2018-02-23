Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeBWRo6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:44:58 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:35530 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeBWRo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:44:56 -0500
Date: Fri, 23 Feb 2018 12:44:55 -0500 (EST)
Message-Id: <20180223.124455.1183789000029287041.davem@davemloft.net>
To: laoar.shao@gmail.com
Cc: dsa@cumulusnetworks.com, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: NULL pointer check is not needed in
 BPF_CGROUP_RUN_PROG_INET_SOCK
From: David Miller <davem@davemloft.net>
In-Reply-To: <1519369121-22269-1-git-send-email-laoar.shao@gmail.com>
References: <1519369121-22269-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 23 Feb 2018 14:58:41 +0800

> sk is already allocated in inet_create/inet6_create, hence when
> BPF_CGROUP_RUN_PROG_INET_SOCK is executed sk will never be NULL.
> 
> The logic is as bellow,
> 	sk = sk_alloc();
> 	if (!sk)
> 		goto out;
> 	BPF_CGROUP_RUN_PROG_INET_SOCK(sk);
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
