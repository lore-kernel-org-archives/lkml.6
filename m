Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933303AbeB1Q6E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:58:04 -0500
Received: from www62.your-server.de ([213.133.104.62]:47264 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932117AbeB1Q6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:58:02 -0500
Subject: Re: [PATCH] selftests/bpf: Add bpf_probe_read_str to bpf_helpers.h
To: Tushar Dave <tushar.n.dave@oracle.com>, ast@kernel.org,
        shuah@kernel.org, netdev@vger.kernel.org,
        linux-selftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1519778024-3113-1-git-send-email-tushar.n.dave@oracle.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1d72361e-e8a7-38e0-16db-ade3f658ce92@iogearbox.net>
Date: Wed, 28 Feb 2018 17:57:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1519778024-3113-1-git-send-email-tushar.n.dave@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tushar,

On 02/28/2018 01:33 AM, Tushar Dave wrote:
> Using bpf_probe_read_str() from samples/bpf causes compiler warning.
> e.g.
> warning: implicit declaration of function 'bpf_probe_read_str' is invalid in C99
>       [-Wimplicit-function-declaration]
>         num = bpf_probe_read_str(buf, sizeof(buf), ctx->di);
>               ^
> 1 warning generated.
> 
> Add bpf_probe_read_str() to bpf_helpers.h so it can be used by
> samples/bpf programs.
> 
> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>

In general no objections to it, but it would need an in-tree
user first:

$ git grep -n bpf_probe_read_str tools/
tools/include/uapi/linux/bpf.h:596: * int bpf_probe_read_str(void *dst, int size, const void *unsafe_ptr)
$

Why not adding this along with a sample?

Thanks,
Daniel
