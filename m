Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeE0Wg4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 18:36:56 -0400
Received: from www62.your-server.de ([213.133.104.62]:49177 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeE0Wgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 18:36:53 -0400
Subject: Re: [PATCH, net-next 1/2] bpf: btf: avoid -Wreturn-type warning
To: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180525213331.2115471-1-arnd@arndb.de>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b070795a-c529-0149-cdf3-b0d9dd9a09ff@iogearbox.net>
Date: Mon, 28 May 2018 00:36:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180525213331.2115471-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/25/2018 11:33 PM, Arnd Bergmann wrote:
> gcc warns about a noreturn function possibly returning in
> some configurations:
> 
> kernel/bpf/btf.c: In function 'env_type_is_resolve_sink':
> kernel/bpf/btf.c:729:1: error: control reaches end of non-void function [-Werror=return-type]
> 
> Using BUG() instead of BUG_ON() avoids that warning and otherwise
> does the exact same thing.
> 
> Fixes: eb3f595dab40 ("bpf: btf: Validate type reference")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to bpf-next, thanks Arnd!
