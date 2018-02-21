Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224xMRJP9fozUW4SJPog4rMvNg7lItTDJ+wVoVe7lIKr50Rt8P2sNlVQgAHYy60lbE0ByOx0
ARC-Seal: i=1; a=rsa-sha256; t=1519249146; cv=none;
        d=google.com; s=arc-20160816;
        b=VxsXP5Skh+JwyAURHGB2VhTkrOWCp9xXGO43ed8myTumOK+Ae89Nfuviyq8IruevvO
         fMbOm3x6q87kbRQ6EtLX6NO8i+h70uZzihMZSxuqM96h+yQQOBPulvzxd1WrDIHSbTmd
         8HBViAWwa+E5T6aF/xfUkMhe4hVPnSt8E1XnbQ6D7VnFklrMD91+rIaQQYgmMcyULENO
         1RRYez7GW8NcDQ92eg+7WgQCojCZ9LUcqk2OmmFSyNfVY5lMrSaF0NzP5W8TmtlqvmER
         tH2HP4dV61tgmYL12+5KeAvMdH5L3CMdhdDGtgxM5PA2NCi8a2qtofu7xnj5bY3Eosbk
         ekZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=ub0Nodf9W/KRgMWxe4opba1rtr2W+HWw06Att6GWvys=;
        b=nG3oLa+zMgg/Afe/nm5FCrMM+9jqpBVoeyGsjkx6FrmWALHCyaSiwJrWpFhdC+2U0S
         IInJLF7KMdzEPnvzDeR4GzdXqhuwenNI/s1LkGl5OZAJHSBH6XYXOuH5nvAaQQvgxnFo
         d6MzKXwIGGg/o20HI74QWgnOvKQl++OGaNUq5UXGP5L0mLGAXefJAAwJ/VjyMOYGhO2c
         PP+rE9IkpscRJfyDwxo9+vazKAIfIIXk9oK8nlbbVh2JT1oB9T+ASGwlndXQ19HgOti5
         3/x6e+YZEu0xbwcOH01u2wd+X29+tjFn+OVqgjNLEeUJBPZ6rR0wuWNNe7GXrBL+Qap3
         J/UQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=Oq1MZZM6;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=Oq1MZZM6;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbeBUVit (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 16:38:49 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43742 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeBUVis (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 16:38:48 -0500
Subject: Re: [PATCH] selftests/bpf: tcpbpf_kern: use in6_* macros from glibc
To: Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org
Cc: daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20180221165116.9754-1-anders.roxell@linaro.org>
From: =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <02cb5e7d-5119-8501-01b7-9ea0f4b95450@linaro.org>
Date: Wed, 21 Feb 2018 15:38:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221165116.9754-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593030175575827124?=
X-GMAIL-MSGID: =?utf-8?q?1593048192965630153?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 10:51 AM, Anders Roxell wrote:
> Both glibc and the kernel have in6_* macros definitions. Build fails
> because it picks up wrong in6_* macro from the kernel header and not the
> header from glibc.
> 
> Fixes build error below:
> clang -I. -I./include/uapi -I../../../include/uapi
>      -Wno-compare-distinct-pointer-types \
>          -O2 -target bpf -emit-llvm -c test_tcpbpf_kern.c -o - |      \
> llc -march=bpf -mcpu=generic -filetype=obj
>      -o .../tools/testing/selftests/bpf/test_tcpbpf_kern.o
> In file included from test_tcpbpf_kern.c:12:
> .../netinet/in.h:101:5: error: expected identifier
>     IPPROTO_HOPOPTS = 0,   /* IPv6 Hop-by-Hop options.  */
>     ^
> .../linux/in6.h:131:26: note: expanded from macro 'IPPROTO_HOPOPTS'
>                                 ^
> In file included from test_tcpbpf_kern.c:12:
> /usr/include/netinet/in.h:103:5: error: expected identifier
>     IPPROTO_ROUTING = 43,  /* IPv6 routing header.  */
>     ^
> .../linux/in6.h:132:26: note: expanded from macro 'IPPROTO_ROUTING'
>                                 ^
> In file included from test_tcpbpf_kern.c:12:
> .../netinet/in.h:105:5: error: expected identifier
>     IPPROTO_FRAGMENT = 44, /* IPv6 fragmentation header.  */
>     ^
> 
> Since both glibc and the kernel have in6_* macros definitions, use the
> one from glibc.  Kernel headers will check for previous libc definitions
> by including include/linux/libc-compat.h.
> 
> Reported-by: Daniel Díaz <daniel.diaz@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

FWIW, this was
Tested-by: Daniel Díaz <daniel.diaz@linaro.org>

> ---
>  tools/testing/selftests/bpf/test_tcpbpf_kern.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_tcpbpf_kern.c b/tools/testing/selftests/bpf/test_tcpbpf_kern.c
> index 57119ad57a3f..3e645ee41ed5 100644
> --- a/tools/testing/selftests/bpf/test_tcpbpf_kern.c
> +++ b/tools/testing/selftests/bpf/test_tcpbpf_kern.c
> @@ -5,7 +5,6 @@
>  #include <linux/if_ether.h>
>  #include <linux/if_packet.h>
>  #include <linux/ip.h>
> -#include <linux/in6.h>
>  #include <linux/types.h>
>  #include <linux/socket.h>
>  #include <linux/tcp.h>
