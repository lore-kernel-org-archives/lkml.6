Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbeE0WhN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 18:37:13 -0400
Received: from www62.your-server.de ([213.133.104.62]:49201 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeE0WhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 18:37:10 -0400
Subject: Re: [PATCH, net-next 2/2] bpf: avoid -Wmaybe-uninitialized warning
To: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>
Cc: Yonghong Song <yhs@fb.com>, "David S. Miller" <davem@davemloft.net>,
        Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Chenbo Feng <fengc@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180525213331.2115471-1-arnd@arndb.de>
 <20180525213331.2115471-2-arnd@arndb.de>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <61a96e95-a256-ef40-c25d-e7dbf4c51b02@iogearbox.net>
Date: Mon, 28 May 2018 00:37:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180525213331.2115471-2-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/25/2018 11:33 PM, Arnd Bergmann wrote:
> The stack_map_get_build_id_offset() function is too long for gcc to track
> whether 'work' may or may not be initialized at the end of it, leading
> to a false-positive warning:
> 
> kernel/bpf/stackmap.c: In function 'stack_map_get_build_id_offset':
> kernel/bpf/stackmap.c:334:13: error: 'work' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This removes the 'in_nmi_ctx' flag and uses the state of that variable
> itself to see if it got initialized.
> 
> Fixes: bae77c5eb5b2 ("bpf: enable stackmap with build_id in nmi context")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to bpf-next, thanks Arnd!
