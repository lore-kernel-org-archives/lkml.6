Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/OUaeRvq0axScm8D7tWQzvThKCyp0FDMeNADSGL1KKhNkzXrr9LB9L+h4/fi9+c/k9OHIv
ARC-Seal: i=1; a=rsa-sha256; t=1522076143; cv=none;
        d=google.com; s=arc-20160816;
        b=Py+qSisgRixfK7sp+1hTdjAekldxsLjBf0xkfxgEzB9/MoTProsBPS3Z1cfceH6zoz
         o32lzURusD8NFGhAPxm0lSFWRbanhnqmOhwMJxoX7hFW62NhvjzYzpIEbxKePtjbCNhK
         Oa2r+9ZT0Jr5YV7H+V5rm9lGuky2uAm7+tbvd5iNtk0w/pOeKQzQxL61hXEvCHgw8IE0
         eLTTcwUq9s3AFuFRj6y9+SfDw1OnlaI6k34VTg2vn1rAksrA68Q7Gmp11RIIrIH4CBgT
         kfPVDzX13tVPCo0pE0O8KkeEXZ3omvaKCQmlvwi3U2V9/kYXMis4sHRWRPbDGUtxVVvM
         whTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=N5uGRtlsT+cIcPy0Wchl/HzQ5qhfa0WIr3DHwIyx4yg=;
        b=FNtrctOWzDYnWIQfQX3nCyexXTU43BfG6EeGvjmLHbR7FazWuG4dlZ8ZRxryen8EDH
         ldqd9/lVaqV0E20nqpOQobl0A3zL91sP7WHllI9D0vq5BAPcpAaidTD7TiL4uU1sa1Rb
         zhjzbGNZzYtalNObL3gPkMhI3hnxiz/VALLDl7jTMjnlD0Bb9bP3crVAyvQsY7g9pEuv
         Bkltbr2ieq/RDyboDOv5HtCe33lGczlZesO6xh4e/UXld+Bzi2j4v7VX0R4Zt6F/aYJ0
         qznaPkGeNJV0wTZ64R+1pK13pCwmtePZqDK8I1o8Bi5F6/LEN/kqDYLBpOGDpdkQIcxt
         sGEA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=Ei1YsAdP;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=Ei1YsAdP;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeCZOzW (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Mar 2018 10:55:22 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45599 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbeCZOzR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Mar 2018 10:55:17 -0400
Date: Mon, 26 Mar 2018 07:55:13 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: changbin.du@intel.com
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests/bpf: fix compiling errors
Message-ID: <20180326145511.lzoi6wja6iht5lvq@ast-mbp.dhcp.thefacebook.com>
References: <1522056208-4004-1-git-send-email-changbin.du@intel.com>
 <1522056208-4004-5-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522056208-4004-5-git-send-email-changbin.du@intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595992264368569998?=
X-GMAIL-MSGID: =?utf-8?q?1596012514803598731?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 05:23:28PM +0800, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> This patch fixed below errors of missing head files.
> 
> tools/testing/selftests$ make
> ...
> clang -I. -I./include/uapi -I../../../include/uapi -Wno-compare-distinct-pointer-types \
> 	 -O2 -target bpf -emit-llvm -c test_pkt_access.c -o - |      \
> llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf//test_pkt_access.o
> In file included from test_pkt_access.c:9:
> In file included from ../../../include/uapi/linux/bpf.h:11:
> In file included from ./include/uapi/linux/types.h:5:
> /usr/include/asm-generic/int-ll64.h:11:10: fatal error: 'asm/bitsperlong.h' file not found
>  #include <asm/bitsperlong.h>
>          ^
> 1 error generated.
> clang -I. -I./include/uapi -I../../../include/uapi -Wno-compare-distinct-pointer-types \
> 	 -O2 -target bpf -emit-llvm -c test_xdp.c -o - |      \
> llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf//test_xdp.o
> In file included from test_xdp.c:9:
> In file included from ../../../include/uapi/linux/bpf.h:11:
> In file included from ./include/uapi/linux/types.h:5:
> /usr/include/asm-generic/int-ll64.h:11:10: fatal error: 'asm/bitsperlong.h' file not found
>  #include <asm/bitsperlong.h>
>          ^
> 1 error generated.
> clang -I. -I./include/uapi -I../../../include/uapi -Wno-compare-distinct-pointer-types \
> 	 -O2 -target bpf -emit-llvm -c test_l4lb.c -o - |      \
> llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf//test_l4lb.o
> In file included from test_l4lb.c:10:
> In file included from /usr/include/linux/pkt_cls.h:4:
> In file included from ./include/uapi/linux/types.h:5:
> /usr/include/asm-generic/int-ll64.h:11:10: fatal error: 'asm/bitsperlong.h' file not found
>  #include <asm/bitsperlong.h>
>          ^
> 1 error generated.
> clang -I. -I./include/uapi -I../../../include/uapi -Wno-compare-distinct-pointer-types \
> 	 -O2 -target bpf -emit-llvm -c test_tcp_estats.c -o - |      \
> llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf//test_tcp_estats.o
> In file included from test_tcp_estats.c:35:
> In file included from ../../../include/uapi/linux/bpf.h:11:
> In file included from ./include/uapi/linux/types.h:5:
> /usr/include/asm-generic/int-ll64.h:11:10: fatal error: 'asm/bitsperlong.h' file not found
>  #include <asm/bitsperlong.h>
> ...
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 5c43c18..dc0fdc8 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -10,7 +10,8 @@ ifneq ($(wildcard $(GENHDR)),)
>    GENFLAGS := -DHAVE_GENHDR
>  endif
>  
> -CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(GENDIR) $(GENFLAGS) -I../../../include
> +CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(GENDIR) $(GENFLAGS) \
> +	  -I../../../include -I../../../../usr/include
>  LDLIBS += -lcap -lelf -lrt -lpthread
>  
>  # Order correspond to 'make run_tests' order
> @@ -62,7 +63,7 @@ else
>    CPU ?= generic
>  endif
>  
> -CLANG_FLAGS = -I. -I./include/uapi -I../../../include/uapi \
> +CLANG_FLAGS = -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include \
>  	      -Wno-compare-distinct-pointer-types

Nack.
I suspect that will break the build for everyone else who's doing it in the directory
itself instead of the outer one.

