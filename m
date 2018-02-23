Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbeBWPan (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:30:43 -0500
Received: from www62.your-server.de ([213.133.104.62]:43005 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBWPam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:30:42 -0500
Subject: Re: [PATCH bpf-next] bpf: NULL pointer check is not needed in
 BPF_CGROUP_RUN_PROG_INET_SOCK
To: Yafang Shao <laoar.shao@gmail.com>, dsa@cumulusnetworks.com,
        ast@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1519369121-22269-1-git-send-email-laoar.shao@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5ccc063c-6b71-0093-5312-c6d1e96fabd3@iogearbox.net>
Date: Fri, 23 Feb 2018 16:30:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1519369121-22269-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 07:58 AM, Yafang Shao wrote:
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

Agree, applied to bpf-next, thanks Yafang!
