Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeBVANC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 19:13:02 -0500
Received: from www62.your-server.de ([213.133.104.62]:52329 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbeBVANA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 19:13:00 -0500
Subject: Re: [PATCH] bpf: clean up unused-variable warning
To: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180220220744.305712-1-arnd@arndb.de>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ff1ed591-ae28-3d31-1004-5649f04f4d58@iogearbox.net>
Date: Thu, 22 Feb 2018 01:12:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180220220744.305712-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/2018 11:07 PM, Arnd Bergmann wrote:
> The only user of this variable is inside of an #ifdef, causing
> a warning without CONFIG_INET:
> 
> net/core/filter.c: In function '____bpf_sock_ops_cb_flags_set':
> net/core/filter.c:3382:6: error: unused variable 'val' [-Werror=unused-variable]
>   int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> 
> This replaces the #ifdef with a nicer IS_ENABLED() check that
> makes the code more readable and avoids the warning.
> 
> Fixes: b13d88072172 ("bpf: Adds field bpf_sock_ops_cb_flags to tcp_sock")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Now applied to bpf, thanks Arnd!
