Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeDDJPc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:15:32 -0400
Received: from www62.your-server.de ([213.133.104.62]:42046 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbeDDJPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:15:31 -0400
Subject: Re: [PATCH] kernel/bpf/syscall: fix warning defined but not used
To: Anders Roxell <anders.roxell@linaro.org>, ast@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180403120947.9321-1-anders.roxell@linaro.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <327e3c1f-860b-e2b4-7475-34a409c62fae@iogearbox.net>
Date: Wed, 4 Apr 2018 11:15:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180403120947.9321-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 02:09 PM, Anders Roxell wrote:
> There will be a build warning -Wunused-function if CONFIG_CGROUP_BPF
> isn't defined, since the only user is inside #ifdef CONFIG_CGROUP_BPF:
> kernel/bpf/syscall.c:1229:12: warning: ‘bpf_prog_attach_check_attach_type’
>     defined but not used [-Wunused-function]
>  static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Current code moves function bpf_prog_attach_check_attach_type inside
> ifdef CONFIG_CGROUP_BPF.
> 
> Fixes: 5e43f899b03a ("bpf: Check attach type at prog load time")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied to bpf tree, thanks Anders!
