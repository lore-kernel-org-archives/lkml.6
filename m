Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeENUlr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:41:47 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:42328 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbeENUlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:41:45 -0400
X-Google-Smtp-Source: AB8JxZp2YyZ8+bGpMg/QP+AkTCIpR5EyTMCd46b8Ub/DQyx8dJDhs1aoqKGbz7ooZd2vJy1F5B2pgA==
Date: Mon, 14 May 2018 13:41:40 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <20180514134140.0c468174@cakuba>
In-Reply-To: <20180514115700.0faadd6f@canb.auug.org.au>
References: <20180514115700.0faadd6f@canb.auug.org.au>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2018 11:57:00 +1000, Stephen Rothwell wrote:
> diff --cc tools/lib/bpf/libbpf.c
> index 8da4eeb101a6,df54c4c9e48a..000000000000
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@@ -2163,9 -2193,12 +2193,12 @@@ int bpf_prog_load_xattr(const struct bp
>   
>   	if (!attr)
>   		return -EINVAL;
> + 	if (!attr->file)
> + 		return -EINVAL;
>   
> - 	obj = bpf_object__open(attr->file);
> + 	obj = __bpf_object__open(attr->file, NULL, 0,
> + 				 bpf_prog_type__needs_kver(attr->prog_type));
>  -	if (IS_ERR(obj))
>  +	if (IS_ERR_OR_NULL(obj))
>   		return -ENOENT;

This is okay, thanks.  The OR_NULL is unnecessary just using the
bpf-next code is a better merge IMO.
