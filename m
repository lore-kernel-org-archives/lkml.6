Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvuKRZg3KkdqqrPO/fDt2+o5xRry1jn4cl8zikzuOZ/bYmTZzghKRpmATRhLUd4HgY4MKK8
ARC-Seal: i=1; a=rsa-sha256; t=1522117773; cv=none;
        d=google.com; s=arc-20160816;
        b=nnGKcLDEGPkD/mVn8TgKoYvAhUPcoUqDOJefmOvXqniUsMZtQXZn+Swh+lbXqG9vvJ
         gxeQjlVBj5A2fFLpB3whHur4dkjdv9fHOCmTyN9wtpmQUX1NIPbKwxaJyxfEppl5HFtI
         eCyXm317jN3ORyqqj04Nn7llGLKGZDZh+GAghTytMShPULLeMspMpgFYvqLp+tDAhzMV
         Ogl0oRjGAN+zkcAIUSyw2rLWB8Nj88NsxyyuiDCSGSKHnjeEnYnBlBY+tvvcMDb2pbjL
         41aYohILSc6ceh9RDeVdhSzO5FaD9ULff7nKK+TMjKgksZUU42RbarsVi9GeJp1QjLwx
         jtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=gDhp18WEmPkaj1pNC8sYK6S5BRGVbEVb+ZPVGjpgOSk=;
        b=DYdnM9l+YAbiwyvdzt7cD3GyHBm3PIzipENPp4wl88tw6WoFPRHAN8rWDuEXO52Kr2
         atsdn/lhVqWXa66QhRWZVcoaF4Ug8r0PwcYhY9oJGgw0AlgFTkEdjB3cUezZ3C4kOtNs
         qvst5pjj7CPfzedCdiUD/jBKUCeda30Re+lewigQmvocX4jNxoyiFXhAPx5sNUwLz14J
         nMotmsjG9ak26ll/rpT3g9q8G/WyeXdx6v0UjRmDwDi26kD+H1jRhfsRDnTC9Y/RyR/T
         dNgUQz34Er14YFw+ZvLeNvSi2SOoVoGQxDSER0cdk9rVHzluSPE4byGBBfVQ2a0Qazp3
         c5Uw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeC0C3c (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Mar 2018 22:29:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:54413 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752213AbeC0C3b (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Mar 2018 22:29:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,366,1517904000";
   d="scan'208";a="41492450"
Date: Tue, 27 Mar 2018 10:20:10 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: changbin.du@intel.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests/bpf: fix compiling errors
Message-ID: <20180327022010.57u6rn73inbkrycn@intel.com>
References: <1522056208-4004-1-git-send-email-changbin.du@intel.com>
 <1522056208-4004-5-git-send-email-changbin.du@intel.com>
 <20180326145511.lzoi6wja6iht5lvq@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326145511.lzoi6wja6iht5lvq@ast-mbp.dhcp.thefacebook.com>
User-Agent: NeoMutt/20171027-42-ad8712
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595992264368569998?=
X-GMAIL-MSGID: =?utf-8?q?1596056165803066336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 07:55:13AM -0700, Alexei Starovoitov wrote:
> On Mon, Mar 26, 2018 at 05:23:28PM +0800, changbin.du@intel.com wrote:
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > ---
> >  tools/testing/selftests/bpf/Makefile | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 5c43c18..dc0fdc8 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -10,7 +10,8 @@ ifneq ($(wildcard $(GENHDR)),)
> >    GENFLAGS := -DHAVE_GENHDR
> >  endif
> >  
> > -CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(GENDIR) $(GENFLAGS) -I../../../include
> > +CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(GENDIR) $(GENFLAGS) \
> > +	  -I../../../include -I../../../../usr/include
> >  LDLIBS += -lcap -lelf -lrt -lpthread
> >  
> >  # Order correspond to 'make run_tests' order
> > @@ -62,7 +63,7 @@ else
> >    CPU ?= generic
> >  endif
> >  
> > -CLANG_FLAGS = -I. -I./include/uapi -I../../../include/uapi \
> > +CLANG_FLAGS = -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include \
> >  	      -Wno-compare-distinct-pointer-types
> 
> Nack.
> I suspect that will break the build for everyone else who's doing it in the directory
> itself instead of the outer one.
>

This one? But I didn't see any problem.

changbin@gvt-dell-host:~/work/linux/tools/testing/selftests/bpf$ make
make -C ../../../lib/bpf OUTPUT=/home/changbin/work/linux/tools/testing/selftests/bpf/
make[1]: Entering directory '/home/changbin/work/linux/tools/lib/bpf'
  HOSTCC   /home/changbin/work/linux/tools/testing/selftests/bpf/fixdep.o
  HOSTLD   /home/changbin/work/linux/tools/testing/selftests/bpf/fixdep-in.o
  LINK     /home/changbin/work/linux/tools/testing/selftests/bpf/fixdep
  CC       /home/changbin/work/linux/tools/testing/selftests/bpf/libbpf.o
  CC       /home/changbin/work/linux/tools/testing/selftests/bpf/bpf.o
  CC       /home/changbin/work/linux/tools/testing/selftests/bpf/nlattr.o
  LD       /home/changbin/work/linux/tools/testing/selftests/bpf/libbpf-in.o
  LINK     /home/changbin/work/linux/tools/testing/selftests/bpf/libbpf.a
  LINK     /home/changbin/work/linux/tools/testing/selftests/bpf/libbpf.so
make[1]: Leaving directory '/home/changbin/work/linux/tools/lib/bpf'
make -C ../../../lib/bpf OUTPUT=/home/changbin/work/linux/tools/testing/selftests/bpf/
make[1]: Entering directory '/home/changbin/work/linux/tools/lib/bpf'
make[1]: Leaving directory '/home/changbin/work/linux/tools/lib/bpf'
gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../../include/generated -DHAVE_GENHDR -I../../../include -I../../../../usr/include    test_verifier.c /home/changbin/work/linux/tools/testing/selftests/bpf/libbpf.a cgroup_helpers.c -lcap -lelf -lrt -lpthread -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_verifier
gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../../include/generated -DHAVE_GENHDR -I../../../include -I../../../../usr/include    test_tag.c /home/changbin/work/linux/tools/testing/selftests/bpf/libbpf.a cgroup_helpers.c -lcap -lelf -lrt -lpthread -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_tag
gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../../include/generated -DHAVE_GENHDR -I../../../include -I../../../../usr/include    test_maps.c /home/changbin/work/linux/tools/testing/selftests/bpf/libbpf.a cgroup_helpers.c -lcap -lelf -lrt -lpthread -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_maps
gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../../include/generated -DHAVE_GENHDR -I../../../include -I../../../../usr/include    test_lru_map.c /home/changbin/work/linux/tools/testing/selftests/bpf/libbpf.a cgroup_helpers.c -lcap -lelf -lrt -lpthread -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_lru_map
gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../../include/generated -DHAVE_GENHDR -I../../../include -I../../../../usr/include    test_lpm_map.c /home/changbin/work/linux/tools/testing/selftests/bpf/libbpf.a cgroup_helpers.c -lcap -lelf -lrt -lpthread -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_lpm_map
gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../../include/generated -DHAVE_GENHDR -I../../../include -I../../../../usr/include    test_progs.c /home/changbin/work/linux/tools/testing/selftests/bpf/libbpf.a cgroup_helpers.c -lcap -lelf -lrt -lpthread -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_progs
gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../../include/generated -DHAVE_GENHDR -I../../../include -I../../../../usr/include    test_align.c /home/changbin/work/linux/tools/testing/selftests/bpf/libbpf.a cgroup_helpers.c -lcap -lelf -lrt -lpthread -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_align
gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../../include/generated -DHAVE_GENHDR -I../../../include -I../../../../usr/include    test_verifier_log.c /home/changbin/work/linux/tools/testing/selftests/bpf/libbpf.a cgroup_helpers.c -lcap -lelf -lrt -lpthread -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_verifier_log
gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../../include/generated -DHAVE_GENHDR -I../../../include -I../../../../usr/include    test_dev_cgroup.c /home/changbin/work/linux/tools/testing/selftests/bpf/libbpf.a cgroup_helpers.c -lcap -lelf -lrt -lpthread -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_dev_cgroup
gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../../include/generated -DHAVE_GENHDR -I../../../include -I../../../../usr/include    test_tcpbpf_user.c /home/changbin/work/linux/tools/testing/selftests/bpf/libbpf.a cgroup_helpers.c -lcap -lelf -lrt -lpthread -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_tcpbpf_user
gcc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../../include/generated -DHAVE_GENHDR -I../../../include -I../../../../usr/include    test_libbpf_open.c /home/changbin/work/linux/tools/testing/selftests/bpf/libbpf.a -lcap -lelf -lrt -lpthread -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_libbpf_open
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c test_pkt_access.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_pkt_access.o
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c test_xdp.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_xdp.o
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c test_l4lb.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_l4lb.o
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c test_tcp_estats.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_tcp_estats.o
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c test_obj_id.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_obj_id.o
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c test_pkt_md_access.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_pkt_md_access.o
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c test_xdp_redirect.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_xdp_redirect.o
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c test_xdp_meta.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_xdp_meta.o
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c sockmap_parse_prog.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/sockmap_parse_prog.o
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c sockmap_verdict_prog.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/sockmap_verdict_prog.o
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c dev_cgroup.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/dev_cgroup.o
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c sample_ret0.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/sample_ret0.o
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c test_tracepoint.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_tracepoint.o
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types -fno-inline \
         -O2 -target bpf -emit-llvm -c test_l4lb_noinline.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_l4lb_noinline.o
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types -fno-inline \
         -O2 -target bpf -emit-llvm -c test_xdp_noinline.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_xdp_noinline.o
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c test_stacktrace_map.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_stacktrace_map.o
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c sample_map_ret0.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/sample_map_ret0.o
clang -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c test_tcpbpf_kern.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_tcpbpf_kern.o
changbin@gvt-dell-host:~/work/linux/tools/testing/selftests/bpf$ 

-- 
Thanks,
Changbin Du
