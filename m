Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751621AbeEDAQj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 20:16:39 -0400
Received: from www62.your-server.de ([213.133.104.62]:58247 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbeEDAQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 20:16:34 -0400
Subject: Re: [PATCH] bpf: fix possible spectre-v1 in find_and_alloc_map()
To: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org
References: <20180503160459.4111-1-mark.rutland@arm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <28363c0d-0b78-681c-d9ea-908671b0067e@iogearbox.net>
Date: Fri, 4 May 2018 02:16:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180503160459.4111-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2018 06:04 PM, Mark Rutland wrote:
> It's possible for userspace to control attr->map_type. Sanitize it when
> using it as an array index to prevent an out-of-bounds value being used
> under speculation.
> 
> Found by smatch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: netdev@vger.kernel.org

Applied to bpf tree, thanks Mark! I've also just submitted one for
BPF progs (http://patchwork.ozlabs.org/patch/908385/) which is same
situation.
