Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 183C7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5822089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z12I0fDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5822089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934581AbeFLUkE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:40:04 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37490 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934270AbeFLUj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:39:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id y5-v6so140387pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=bY2StdiJXNDu+Svl5y67786DSzfxqI6OfonqZtmBPL4=;
        b=Z12I0fDJc2YrzbRcZOM3WjL6RunkhAZOTW1oGvk8rN9TC+AKNMMX9ooMWl470WDDlm
         5ODxjN7pt42VZjfjwlpRDYX1oH0C3khKCHq0LmV/bvFwMn5a77jZ6Gg8r+wVanUeuq+T
         /bAHob5XIf4KxlyDo6FlSpqoomxER3euQJXjAoGRA7v6jZSqBcUKtJND81BKeL58egsx
         /BbuEWrsdhsVd4MhPRcoJ3jIgauOu/zZg+I3/rfEjELl6AIgSF+o52QLgDgTcp4vP53w
         Bw+yancLjHz0HidITvAFE7cWHtZm2yfGZTUlKQFCgJtH3DZIm0jOncaihkNraM9GBNwe
         bhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=bY2StdiJXNDu+Svl5y67786DSzfxqI6OfonqZtmBPL4=;
        b=bkIgTMY5bqxbB537OzDEd6jGVdme92VCk2tf5vPUk8BZ2sLRWorUOXWgbRtAtrWYI0
         B/4Syh2MegMRZA27rRrnN7Ew6U6/Q0eITuu0c8CfPSdYjTr3H2PIq1TZM9KskvGNFuz2
         7RHsoVx3wQTQ3Cgp3EN51TyvvegaqcSPoblwBAw8BGt8+NIT77EJ/nw+VtXScb5wayaq
         Lz5ipMt4lIFTHK7Gml1ref3RDKmX2p0+oC7WCfXeaGDU7IG68fh69XtLYG/4BqP1azcf
         CyhFWeVfeLY2BisJO3mhGA1/oiYQxfd217JQiSC6SkzYVLEZwYKXGfOoZ63wtDk6GL8E
         rLmA==
X-Gm-Message-State: APt69E0hNU5ue+UdMvQ1uLSAQPUolYiv1JI7Wl1e68pwy4Y2PYhHLamG
        LLMkcjWp6M+2LkNHSoXVdQsfnQ==
X-Google-Smtp-Source: ADUXVKKAt2cXOPXruhZqGB39Bx8U8YBVS6gw7j4H7n22dkVic/kK5NtLKE6j+oKMf2LrGWTGedIZeA==
X-Received: by 2002:a62:1f45:: with SMTP id f66-v6mr1908496pff.253.1528835997736;
        Tue, 12 Jun 2018 13:39:57 -0700 (PDT)
Received: from jchowdhary0.mtv.corp.google.com ([2620:0:1000:1612:e11d:1467:a8a:6428])
        by smtp.gmail.com with ESMTPSA id n25-v6sm1179206pff.119.2018.06.12.13.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 13:39:56 -0700 (PDT)
Subject: Re: uapi headers userspace build results
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-team@android.com
References: <8b90457a-5b1d-818c-d2d6-ba3d16ad3eaf@infradead.org>
From:   Jayant Chowdhary <jchowdhary@google.com>
Message-ID: <1ef3a7b9-5172-9f7a-01fa-4866e765fbbe@google.com>
Date:   Tue, 12 Jun 2018 13:39:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8b90457a-5b1d-818c-d2d6-ba3d16ad3eaf@infradead.org>
Content-Type: multipart/mixed;
 boundary="------------855D4F0426F7198062015A98"
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------855D4F0426F7198062015A98
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Randy,

On 06/11/2018 10:49 PM, Randy Dunlap wrote:
> Hi,
> 
> Here is what I have so far.  It begins with a makefile and some
> template files that are added to.  There's a good bit of Perl also.
> 
> I put all of these files in tools/uapi/ and run them from there.
> 
> There is one .c file generated for each .h file in builddir/usr/include
> (O=builddir).
> 

Thanks for this! I wrote a small Makefile (uapi-compile.mk) which I'd put in
tools/build (I can change this to tools/uapi, if that is more apt).

uapi-compile.mk straight-away compiles the uapi headers, without pulling them
into any generated c source files. It may also be invoked with an environment
variable 'UAPI_DIR' specifying the directory, for which the user would like to
compile headers. This way we can test a directory at a time as well. In your
opinion, would this be simpler to have rather than having to auto-generate c
source files including each uapi header and also autog-enerating the make
targets? I feel like this approach would make maintaining these makefiles/
scripts easier as well.

> Out of 889 header files, I see 45 errors.  That is better than I expected.
> 
> The makefiles and scripts are attached (tar), as well as the output (I used
> 'make -ik' so that make would keep going after errors and attempt to build
> all target files).
> 
> have fun!
> 

I did a 'make ARCH=arm64 headers_install' from the kernel source's root, and
then a 'make -kf uapi-compile.mk all > build.log 2>&1' to compile all the
headers. Out of 864 headers, I see 20 compilation failures.

I'm attaching uapi-compile.mk and the build.log file along.

Thanks,
Jayant

--------------855D4F0426F7198062015A98
Content-Type: text/x-makefile;
 name="uapi-compile.mk"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="uapi-compile.mk"

# 1) run (from top of kernel tree): make ARCH=arch headers_check
# 2) cd tools/build; 'make -f uapi-compile.mk [UAPI_DIR=<dir>] BDIR=<build-dir>'
#    , where UAPI_DIR, if supplied, will restrict the make rules to only apply
#    to the headers in directory provided. 'BDIR' is the directory where the .o
#    files will be produced. It defaults to the current directory.

SRC_DIR :=../../
UAPI_INSTALL_DIR_ORIG :=$(SRC_DIR)/usr/include/
UAPI_INSTALL_DIR :=$(SRC_DIR)/usr/include/$(UAPI_DIR)/
CC :=gcc
BUILD_DIR :=./$(BDIR)

HEADERS :=$(shell find $(UAPI_INSTALL_DIR) -name '*.h')
IMPLICIT_UAPI_INCLUDES :=linux/posix_types.h asm-generic/ipcbuf.h
IMPLICIT_UAPI_INCLUDES :=\
	$(addprefix --include=$(UAPI_INSTALL_DIR_ORIG),$(IMPLICIT_UAPI_INCLUDES))
IMPLICIT_STANDARD_INCLUDES := stdarg.h stdint.h stddef.h
IMPLICIT_STANDARD_INCLUDES :=\
	$(addprefix --include=,$(IMPLICIT_STANDARD_INCLUDES))
INCLUDE_HEADERS := $(IMPLICIT_UAPI_INCLUDES) $(IMPLICIT_STANDARD_INCLUDES)
OBJECT_FILES :=$(addprefix $(BUILD_DIR)/,$(HEADERS:%.h=%.o))

all: header_objs

clean:
	@rm -f $(OBJECT_FILES)

header_objs: $(OBJECT_FILES)

$(BUILD_DIR)/%.o: %.h
	$(CC) -I$(UAPI_INSTALL_DIR_ORIG) $(INCLUDE_HEADERS) -c $< -o $@

--------------855D4F0426F7198062015A98
Content-Type: text/x-log;
 name="build.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="build.log"

gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/param.h -o ../..//usr/include//asm/param.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/fcntl.h -o ../..//usr/include//asm/fcntl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/setup.h -o ../..//usr/include//asm/setup.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/shmbuf.h -o ../..//usr/include//asm/shmbuf.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/ioctl.h -o ../..//usr/include//asm/ioctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/byteorder.h -o ../..//usr/include//asm/byteorder.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/termbits.h -o ../..//usr/include//asm/termbits.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/auxvec.h -o ../..//usr/include//asm/auxvec.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/mman.h -o ../..//usr/include//asm/mman.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/kvm.h -o ../..//usr/include//asm/kvm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/unistd.h -o ../..//usr/include//asm/unistd.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/swab.h -o ../..//usr/include//asm/swab.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/ucontext.h -o ../..//usr/include//asm/ucontext.o
../..//usr/include//asm/ucontext.h:25:2: error: unknown type name ‘stack_t’
  stack_t    uc_stack;
  ^~~~~~~
../..//usr/include//asm/ucontext.h:26:2: error: unknown type name ‘sigset_t’
  sigset_t   uc_sigmask;
  ^~~~~~~~
../..//usr/include//asm/ucontext.h:28:37: error: ‘sigset_t’ undeclared here (not in a function); did you mean ‘size_t’?
  __u8    __unused[1024 / 8 - sizeof(sigset_t)];
                                     ^~~~~~~~
                                     size_t
../..//usr/include//asm/ucontext.h:30:20: error: field ‘uc_mcontext’ has incomplete type
  struct sigcontext uc_mcontext;
                    ^~~~~~~~~~~
uapi-compile.mk:31: recipe for target '../..//usr/include//asm/ucontext.o' failed
make: *** [../..//usr/include//asm/ucontext.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/resource.h -o ../..//usr/include//asm/resource.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/stat.h -o ../..//usr/include//asm/stat.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/bpf_perf_event.h -o ../..//usr/include//asm/bpf_perf_event.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/msgbuf.h -o ../..//usr/include//asm/msgbuf.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/sockios.h -o ../..//usr/include//asm/sockios.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/poll.h -o ../..//usr/include//asm/poll.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/ioctls.h -o ../..//usr/include//asm/ioctls.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/sigcontext.h -o ../..//usr/include//asm/sigcontext.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/statfs.h -o ../..//usr/include//asm/statfs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/sembuf.h -o ../..//usr/include//asm/sembuf.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/perf_regs.h -o ../..//usr/include//asm/perf_regs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/bitsperlong.h -o ../..//usr/include//asm/bitsperlong.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/errno.h -o ../..//usr/include//asm/errno.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/socket.h -o ../..//usr/include//asm/socket.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/kvm_para.h -o ../..//usr/include//asm/kvm_para.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/ptrace.h -o ../..//usr/include//asm/ptrace.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/signal.h -o ../..//usr/include//asm/signal.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/ipcbuf.h -o ../..//usr/include//asm/ipcbuf.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/posix_types.h -o ../..//usr/include//asm/posix_types.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/types.h -o ../..//usr/include//asm/types.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/hwcap.h -o ../..//usr/include//asm/hwcap.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/termios.h -o ../..//usr/include//asm/termios.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm/siginfo.h -o ../..//usr/include//asm/siginfo.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/ib_user_sa.h -o ../..//usr/include//rdma/ib_user_sa.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/ib_user_cm.h -o ../..//usr/include//rdma/ib_user_cm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/mthca-abi.h -o ../..//usr/include//rdma/mthca-abi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/ib_user_verbs.h -o ../..//usr/include//rdma/ib_user_verbs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/vmw_pvrdma-abi.h -o ../..//usr/include//rdma/vmw_pvrdma-abi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/hns-abi.h -o ../..//usr/include//rdma/hns-abi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/rdma_user_ioctl.h -o ../..//usr/include//rdma/rdma_user_ioctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/hfi/hfi1_user.h -o ../..//usr/include//rdma/hfi/hfi1_user.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/hfi/hfi1_ioctl.h -o ../..//usr/include//rdma/hfi/hfi1_ioctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/rdma_user_cm.h -o ../..//usr/include//rdma/rdma_user_cm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/rdma_user_ioctl_cmds.h -o ../..//usr/include//rdma/rdma_user_ioctl_cmds.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/nes-abi.h -o ../..//usr/include//rdma/nes-abi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/ib_user_ioctl_verbs.h -o ../..//usr/include//rdma/ib_user_ioctl_verbs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/rdma_user_rxe.h -o ../..//usr/include//rdma/rdma_user_rxe.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/ib_user_ioctl_cmds.h -o ../..//usr/include//rdma/ib_user_ioctl_cmds.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/i40iw-abi.h -o ../..//usr/include//rdma/i40iw-abi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/rdma_netlink.h -o ../..//usr/include//rdma/rdma_netlink.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/cxgb4-abi.h -o ../..//usr/include//rdma/cxgb4-abi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/bnxt_re-abi.h -o ../..//usr/include//rdma/bnxt_re-abi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/mlx5_user_ioctl_verbs.h -o ../..//usr/include//rdma/mlx5_user_ioctl_verbs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/ib_user_mad.h -o ../..//usr/include//rdma/ib_user_mad.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/mlx5_user_ioctl_cmds.h -o ../..//usr/include//rdma/mlx5_user_ioctl_cmds.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/cxgb3-abi.h -o ../..//usr/include//rdma/cxgb3-abi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/ocrdma-abi.h -o ../..//usr/include//rdma/ocrdma-abi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/mlx4-abi.h -o ../..//usr/include//rdma/mlx4-abi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/qedr-abi.h -o ../..//usr/include//rdma/qedr-abi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//rdma/mlx5-abi.h -o ../..//usr/include//rdma/mlx5-abi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/limits.h -o ../..//usr/include//linux/limits.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/wait.h -o ../..//usr/include//linux/wait.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/version.h -o ../..//usr/include//linux/version.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/param.h -o ../..//usr/include//linux/param.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_alg.h -o ../..//usr/include//linux/if_alg.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/fcntl.h -o ../..//usr/include//linux/fcntl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/kernel.h -o ../..//usr/include//linux/kernel.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/uuid.h -o ../..//usr/include//linux/uuid.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/lwtunnel.h -o ../..//usr/include//linux/lwtunnel.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dm-log-userspace.h -o ../..//usr/include//linux/dm-log-userspace.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netdevice.h -o ../..//usr/include//linux/netdevice.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/v4l2-mediabus.h -o ../..//usr/include//linux/v4l2-mediabus.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/hysdn_if.h -o ../..//usr/include//linux/hysdn_if.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ipmi_msgdefs.h -o ../..//usr/include//linux/ipmi_msgdefs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netlink.h -o ../..//usr/include//linux/netlink.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/am437x-vpfe.h -o ../..//usr/include//linux/am437x-vpfe.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/virtio_ids.h -o ../..//usr/include//linux/virtio_ids.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/sound.h -o ../..//usr/include//linux/sound.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/uleds.h -o ../..//usr/include//linux/uleds.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/uvcvideo.h -o ../..//usr/include//linux/uvcvideo.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/qnxtypes.h -o ../..//usr/include//linux/qnxtypes.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/joystick.h -o ../..//usr/include//linux/joystick.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/in_route.h -o ../..//usr/include//linux/in_route.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/stm.h -o ../..//usr/include//linux/stm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/lp.h -o ../..//usr/include//linux/lp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nfs_idmap.h -o ../..//usr/include//linux/nfs_idmap.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge/ebt_log.h -o ../..//usr/include//linux/netfilter_bridge/ebt_log.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge/ebt_arpreply.h -o ../..//usr/include//linux/netfilter_bridge/ebt_arpreply.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge/ebt_redirect.h -o ../..//usr/include//linux/netfilter_bridge/ebt_redirect.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge/ebt_ip6.h -o ../..//usr/include//linux/netfilter_bridge/ebt_ip6.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge/ebt_vlan.h -o ../..//usr/include//linux/netfilter_bridge/ebt_vlan.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge/ebt_ip.h -o ../..//usr/include//linux/netfilter_bridge/ebt_ip.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge/ebt_among.h -o ../..//usr/include//linux/netfilter_bridge/ebt_among.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge/ebt_limit.h -o ../..//usr/include//linux/netfilter_bridge/ebt_limit.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge/ebt_pkttype.h -o ../..//usr/include//linux/netfilter_bridge/ebt_pkttype.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge/ebtables.h -o ../..//usr/include//linux/netfilter_bridge/ebtables.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge/ebt_stp.h -o ../..//usr/include//linux/netfilter_bridge/ebt_stp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge/ebt_mark_m.h -o ../..//usr/include//linux/netfilter_bridge/ebt_mark_m.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge/ebt_nat.h -o ../..//usr/include//linux/netfilter_bridge/ebt_nat.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge/ebt_arp.h -o ../..//usr/include//linux/netfilter_bridge/ebt_arp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge/ebt_mark_t.h -o ../..//usr/include//linux/netfilter_bridge/ebt_mark_t.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge/ebt_nflog.h -o ../..//usr/include//linux/netfilter_bridge/ebt_nflog.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge/ebt_802_3.h -o ../..//usr/include//linux/netfilter_bridge/ebt_802_3.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/vboxguest.h -o ../..//usr/include//linux/vboxguest.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ipv6_route.h -o ../..//usr/include//linux/ipv6_route.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ioctl.h -o ../..//usr/include//linux/ioctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/psp-sev.h -o ../..//usr/include//linux/psp-sev.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/sysctl.h -o ../..//usr/include//linux/sysctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/icmp.h -o ../..//usr/include//linux/icmp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/random.h -o ../..//usr/include//linux/random.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/unix_diag.h -o ../..//usr/include//linux/unix_diag.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dcbnl.h -o ../..//usr/include//linux/dcbnl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ppp-ioctl.h -o ../..//usr/include//linux/ppp-ioctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nfs4_mount.h -o ../..//usr/include//linux/nfs4_mount.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/auto_dev-ioctl.h -o ../..//usr/include//linux/auto_dev-ioctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_phonet.h -o ../..//usr/include//linux/if_phonet.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nsfs.h -o ../..//usr/include//linux/nsfs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/apm_bios.h -o ../..//usr/include//linux/apm_bios.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/net_namespace.h -o ../..//usr/include//linux/net_namespace.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/mroute6.h -o ../..//usr/include//linux/mroute6.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/times.h -o ../..//usr/include//linux/times.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/auxvec.h -o ../..//usr/include//linux/auxvec.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_addr.h -o ../..//usr/include//linux/if_addr.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/coda.h -o ../..//usr/include//linux/coda.o
../..//usr/include//linux/coda.h:214:2: error: unknown type name ‘u_short’
  u_short  va_mode; /* files access mode and type */
  ^~~~~~~
../..//usr/include//linux/coda.h:219:2: error: unknown type name ‘u_quad_t’
  u_quad_t va_size; /* file size in bytes */
  ^~~~~~~~
../..//usr/include//linux/coda.h:224:2: error: unknown type name ‘u_long’
  u_long  va_gen;  /* generation number of file */
  ^~~~~~
../..//usr/include//linux/coda.h:225:2: error: unknown type name ‘u_long’
  u_long  va_flags; /* flags defined for file */
  ^~~~~~
../..//usr/include//linux/coda.h:102:16: error: unknown type name ‘u_quad_t’
 #define cdev_t u_quad_t
                ^
../..//usr/include//linux/coda.h:226:2: note: in expansion of macro ‘cdev_t’
  cdev_t         va_rdev; /* device special file represents */
  ^~~~~~
../..//usr/include//linux/coda.h:227:2: error: unknown type name ‘u_quad_t’
  u_quad_t va_bytes; /* bytes of disk space held by file */
  ^~~~~~~~
../..//usr/include//linux/coda.h:228:2: error: unknown type name ‘u_quad_t’
  u_quad_t va_filerev; /* file modification number */
  ^~~~~~~~
../..//usr/include//linux/coda.h:296:5: error: unknown type name ‘pid_t’
     pid_t pid;
     ^~~~~
../..//usr/include//linux/coda.h:297:5: error: unknown type name ‘pid_t’
     pid_t pgid;
     ^~~~~
../..//usr/include//linux/coda.h:102:16: error: unknown type name ‘u_quad_t’
 #define cdev_t u_quad_t
                ^
../..//usr/include//linux/coda.h:327:5: note: in expansion of macro ‘cdev_t’
     cdev_t dev;
     ^~~~~~
../..//usr/include//linux/coda.h:328:5: error: unknown type name ‘ino_t’
     ino_t inode;
     ^~~~~
../..//usr/include//linux/coda.h:378:5: error: unknown type name ‘caddr_t’
     caddr_t data;  /* Place holder for data. */
     ^~~~~~~
../..//usr/include//linux/coda.h:538:5: error: unknown type name ‘caddr_t’
     caddr_t data;  /* Place holder for data. */
     ^~~~~~~
../..//usr/include//linux/coda.h:713:9: error: unknown type name ‘u_short’
         u_short in_size;        /* Size of input buffer <= 2K */
         ^~~~~~~
../..//usr/include//linux/coda.h:714:9: error: unknown type name ‘u_short’
         u_short out_size;       /* Maximum size of output buffer, <= 2K */
         ^~~~~~~
uapi-compile.mk:31: recipe for target '../..//usr/include//linux/coda.o' failed
make: *** [../..//usr/include//linux/coda.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tee.h -o ../..//usr/include//linux/tee.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ppdev.h -o ../..//usr/include//linux/ppdev.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/shm.h -o ../..//usr/include//linux/shm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/vt.h -o ../..//usr/include//linux/vt.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/gigaset_dev.h -o ../..//usr/include//linux/gigaset_dev.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/cryptouser.h -o ../..//usr/include//linux/cryptouser.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/fdreg.h -o ../..//usr/include//linux/fdreg.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netrom.h -o ../..//usr/include//linux/netrom.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/mman.h -o ../..//usr/include//linux/mman.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/elf-em.h -o ../..//usr/include//linux/elf-em.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_ematch/tc_em_cmp.h -o ../..//usr/include//linux/tc_ematch/tc_em_cmp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_ematch/tc_em_text.h -o ../..//usr/include//linux/tc_ematch/tc_em_text.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_ematch/tc_em_meta.h -o ../..//usr/include//linux/tc_ematch/tc_em_meta.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_ematch/tc_em_ipt.h -o ../..//usr/include//linux/tc_ematch/tc_em_ipt.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_ematch/tc_em_nbyte.h -o ../..//usr/include//linux/tc_ematch/tc_em_nbyte.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/bpfilter.h -o ../..//usr/include//linux/bpfilter.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nfs.h -o ../..//usr/include//linux/nfs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/gameport.h -o ../..//usr/include//linux/gameport.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/elf.h -o ../..//usr/include//linux/elf.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/fs.h -o ../..//usr/include//linux/fs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/kvm.h -o ../..//usr/include//linux/kvm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/i2c.h -o ../..//usr/include//linux/i2c.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/libc-compat.h -o ../..//usr/include//linux/libc-compat.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/matroxfb.h -o ../..//usr/include//linux/matroxfb.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/keyboard.h -o ../..//usr/include//linux/keyboard.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ipmi_bmc.h -o ../..//usr/include//linux/ipmi_bmc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/inet_diag.h -o ../..//usr/include//linux/inet_diag.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dccp.h -o ../..//usr/include//linux/dccp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/lirc.h -o ../..//usr/include//linux/lirc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_team.h -o ../..//usr/include//linux/if_team.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/erspan.h -o ../..//usr/include//linux/erspan.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/cifs/cifs_mount.h -o ../..//usr/include//linux/cifs/cifs_mount.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/minix_fs.h -o ../..//usr/include//linux/minix_fs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/fib_rules.h -o ../..//usr/include//linux/fib_rules.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/sed-opal.h -o ../..//usr/include//linux/sed-opal.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/gpio.h -o ../..//usr/include//linux/gpio.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/timex.h -o ../..//usr/include//linux/timex.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atm_zatm.h -o ../..//usr/include//linux/atm_zatm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/vfio.h -o ../..//usr/include//linux/vfio.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/rio_cm_cdev.h -o ../..//usr/include//linux/rio_cm_cdev.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/synclink.h -o ../..//usr/include//linux/synclink.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/virtio_scsi.h -o ../..//usr/include//linux/virtio_scsi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/max2175.h -o ../..//usr/include//linux/max2175.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/isdn_ppp.h -o ../..//usr/include//linux/isdn_ppp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/wimax.h -o ../..//usr/include//linux/wimax.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atmsvc.h -o ../..//usr/include//linux/atmsvc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/rds.h -o ../..//usr/include//linux/rds.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/capability.h -o ../..//usr/include//linux/capability.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ethtool.h -o ../..//usr/include//linux/ethtool.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ncsi.h -o ../..//usr/include//linux/ncsi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/xilinx-v4l2-controls.h -o ../..//usr/include//linux/xilinx-v4l2-controls.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/kexec.h -o ../..//usr/include//linux/kexec.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/sync_file.h -o ../..//usr/include//linux/sync_file.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/screen_info.h -o ../..//usr/include//linux/screen_info.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/sdla.h -o ../..//usr/include//linux/sdla.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ivtv.h -o ../..//usr/include//linux/ivtv.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nl80211.h -o ../..//usr/include//linux/nl80211.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/virtio_balloon.h -o ../..//usr/include//linux/virtio_balloon.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dlm_device.h -o ../..//usr/include//linux/dlm_device.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/virtio_config.h -o ../..//usr/include//linux/virtio_config.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atmsap.h -o ../..//usr/include//linux/atmsap.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/userfaultfd.h -o ../..//usr/include//linux/userfaultfd.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_macsec.h -o ../..//usr/include//linux/if_macsec.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/unistd.h -o ../..//usr/include//linux/unistd.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tcp_metrics.h -o ../..//usr/include//linux/tcp_metrics.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/pkt_cls.h -o ../..//usr/include//linux/pkt_cls.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/swab.h -o ../..//usr/include//linux/swab.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ptp_clock.h -o ../..//usr/include//linux/ptp_clock.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_pppol2tp.h -o ../..//usr/include//linux/if_pppol2tp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/hsi/cs-protocol.h -o ../..//usr/include//linux/hsi/cs-protocol.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/hsi/hsi_char.h -o ../..//usr/include//linux/hsi/hsi_char.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/virtio_vsock.h -o ../..//usr/include//linux/virtio_vsock.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/hw_breakpoint.h -o ../..//usr/include//linux/hw_breakpoint.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/scif_ioctl.h -o ../..//usr/include//linux/scif_ioctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ndctl.h -o ../..//usr/include//linux/ndctl.o
../..//usr/include//linux/ndctl.h: In function ‘nvdimm_bus_cmd_name’:
../..//usr/include//linux/ndctl.h:139:12: warning: implicit declaration of function ‘ARRAY_SIZE’; did you mean ‘_T_SIZE’? [-Wimplicit-function-declaration]
  if (cmd < ARRAY_SIZE(names) && names[cmd])
            ^~~~~~~~~~
            _T_SIZE
../..//usr/include//linux/ndctl.h: At top level:
../..//usr/include//linux/ndctl.h:212:26: error: ‘PAGE_SIZE’ undeclared here (not in a function); did you mean ‘_T_SIZE’?
  ND_MIN_NAMESPACE_SIZE = PAGE_SIZE,
                          ^~~~~~~~~
                          _T_SIZE
uapi-compile.mk:31: recipe for target '../..//usr/include//linux/ndctl.o' failed
make: *** [../..//usr/include//linux/ndctl.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_infiniband.h -o ../..//usr/include//linux/if_infiniband.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/iso_fs.h -o ../..//usr/include//linux/iso_fs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/mroute.h -o ../..//usr/include//linux/mroute.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/hid.h -o ../..//usr/include//linux/hid.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv6/ip6t_LOG.h -o ../..//usr/include//linux/netfilter_ipv6/ip6t_LOG.o
../..//usr/include//linux/netfilter_ipv6/ip6t_LOG.h:5:2: warning: #warning "Please update iptables, this file will be removed soon!" [-Wcpp]
 #warning "Please update iptables, this file will be removed soon!"
  ^~~~~~~
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv6/ip6t_opts.h -o ../..//usr/include//linux/netfilter_ipv6/ip6t_opts.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv6/ip6_tables.h -o ../..//usr/include//linux/netfilter_ipv6/ip6_tables.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv6/ip6t_rt.h -o ../..//usr/include//linux/netfilter_ipv6/ip6t_rt.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv6/ip6t_HL.h -o ../..//usr/include//linux/netfilter_ipv6/ip6t_HL.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv6/ip6t_srh.h -o ../..//usr/include//linux/netfilter_ipv6/ip6t_srh.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv6/ip6t_hl.h -o ../..//usr/include//linux/netfilter_ipv6/ip6t_hl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv6/ip6t_frag.h -o ../..//usr/include//linux/netfilter_ipv6/ip6t_frag.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv6/ip6t_ipv6header.h -o ../..//usr/include//linux/netfilter_ipv6/ip6t_ipv6header.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv6/ip6t_REJECT.h -o ../..//usr/include//linux/netfilter_ipv6/ip6t_REJECT.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv6/ip6t_mh.h -o ../..//usr/include//linux/netfilter_ipv6/ip6t_mh.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv6/ip6t_ah.h -o ../..//usr/include//linux/netfilter_ipv6/ip6t_ah.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv6/ip6t_NPT.h -o ../..//usr/include//linux/netfilter_ipv6/ip6t_NPT.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/coda_psdev.h -o ../..//usr/include//linux/coda_psdev.o
../..//usr/include//linux/coda_psdev.h:13:22: error: field ‘uc_chain’ has incomplete type
  struct list_head    uc_chain;
                      ^~~~~~~~
../..//usr/include//linux/coda_psdev.h:14:2: error: unknown type name ‘caddr_t’
  caddr_t             uc_data;
  ^~~~~~~
../..//usr/include//linux/coda_psdev.h:15:2: error: unknown type name ‘u_short’
  u_short             uc_flags;
  ^~~~~~~
../..//usr/include//linux/coda_psdev.h:16:2: error: unknown type name ‘u_short’
  u_short             uc_inSize;  /* Size is at most 5000 bytes */
  ^~~~~~~
../..//usr/include//linux/coda_psdev.h:17:2: error: unknown type name ‘u_short’
  u_short             uc_outSize;
  ^~~~~~~
../..//usr/include//linux/coda_psdev.h:18:2: error: unknown type name ‘u_short’
  u_short             uc_opcode;  /* copied from data to save lookup */
  ^~~~~~~
../..//usr/include//linux/coda_psdev.h:20:2: error: unknown type name ‘wait_queue_head_t’
  wait_queue_head_t   uc_sleep;   /* process' wait queue */
  ^~~~~~~~~~~~~~~~~
uapi-compile.mk:31: recipe for target '../..//usr/include//linux/coda_psdev.o' failed
make: *** [../..//usr/include//linux/coda_psdev.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/un.h -o ../..//usr/include//linux/un.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/kernelcapi.h -o ../..//usr/include//linux/kernelcapi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/bsg.h -o ../..//usr/include//linux/bsg.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/audit.h -o ../..//usr/include//linux/audit.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/rio_mport_cdev.h -o ../..//usr/include//linux/rio_mport_cdev.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/kdev_t.h -o ../..//usr/include//linux/kdev_t.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/serio.h -o ../..//usr/include//linux/serio.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/memfd.h -o ../..//usr/include//linux/memfd.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/resource.h -o ../..//usr/include//linux/resource.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_ltalk.h -o ../..//usr/include//linux/if_ltalk.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_decnet.h -o ../..//usr/include//linux/netfilter_decnet.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/openvswitch.h -o ../..//usr/include//linux/openvswitch.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/bt-bmc.h -o ../..//usr/include//linux/bt-bmc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/hyperv.h -o ../..//usr/include//linux/hyperv.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/stat.h -o ../..//usr/include//linux/stat.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/aspeed-lpc-ctrl.h -o ../..//usr/include//linux/aspeed-lpc-ctrl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/pr.h -o ../..//usr/include//linux/pr.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/bpf_perf_event.h -o ../..//usr/include//linux/bpf_perf_event.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/inotify.h -o ../..//usr/include//linux/inotify.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/posix_acl_xattr.h -o ../..//usr/include//linux/posix_acl_xattr.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/mpls_iptunnel.h -o ../..//usr/include//linux/mpls_iptunnel.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atmioc.h -o ../..//usr/include//linux/atmioc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/perf_event.h -o ../..//usr/include//linux/perf_event.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/icmpv6.h -o ../..//usr/include//linux/icmpv6.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/seg6_genl.h -o ../..//usr/include//linux/seg6_genl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/media-bus-format.h -o ../..//usr/include//linux/media-bus-format.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/binfmts.h -o ../..//usr/include//linux/binfmts.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/hdlc/ioctl.h -o ../..//usr/include//linux/hdlc/ioctl.o
../..//usr/include//linux/hdlc/ioctl.h:74:14: error: ‘IFNAMSIZ’ undeclared here (not in a function)
  char master[IFNAMSIZ]; /* Name of master FRAD device */
              ^~~~~~~~
uapi-compile.mk:31: recipe for target '../..//usr/include//linux/hdlc/ioctl.o' failed
make: *** [../..//usr/include//linux/hdlc/ioctl.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/cciss_defs.h -o ../..//usr/include//linux/cciss_defs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/gen_stats.h -o ../..//usr/include//linux/gen_stats.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/seg6_local.h -o ../..//usr/include//linux/seg6_local.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dqblk_xfs.h -o ../..//usr/include//linux/dqblk_xfs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/psample.h -o ../..//usr/include//linux/psample.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/blktrace_api.h -o ../..//usr/include//linux/blktrace_api.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/types_32_64.h -o ../..//usr/include//linux/types_32_64.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/loop.h -o ../..//usr/include//linux/loop.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tiocl.h -o ../..//usr/include//linux/tiocl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_packet.h -o ../..//usr/include//linux/if_packet.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/watchdog.h -o ../..//usr/include//linux/watchdog.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dvb/version.h -o ../..//usr/include//linux/dvb/version.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dvb/dmx.h -o ../..//usr/include//linux/dvb/dmx.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dvb/audio.h -o ../..//usr/include//linux/dvb/audio.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dvb/ca.h -o ../..//usr/include//linux/dvb/ca.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dvb/net.h -o ../..//usr/include//linux/dvb/net.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dvb/osd.h -o ../..//usr/include//linux/dvb/osd.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dvb/video.h -o ../..//usr/include//linux/dvb/video.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dvb/frontend.h -o ../..//usr/include//linux/dvb/frontend.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_arp.h -o ../..//usr/include//linux/if_arp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/fadvise.h -o ../..//usr/include//linux/fadvise.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/coff.h -o ../..//usr/include//linux/coff.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/pps.h -o ../..//usr/include//linux/pps.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/pktcdvd.h -o ../..//usr/include//linux/pktcdvd.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ip6_tunnel.h -o ../..//usr/include//linux/ip6_tunnel.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/chio.h -o ../..//usr/include//linux/chio.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/zorro.h -o ../..//usr/include//linux/zorro.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_pppox.h -o ../..//usr/include//linux/if_pppox.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/kd.h -o ../..//usr/include//linux/kd.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/virtio_9p.h -o ../..//usr/include//linux/virtio_9p.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/mic_ioctl.h -o ../..//usr/include//linux/mic_ioctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ila.h -o ../..//usr/include//linux/ila.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/agpgart.h -o ../..//usr/include//linux/agpgart.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tipc_config.h -o ../..//usr/include//linux/tipc_config.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/usbdevice_fs.h -o ../..//usr/include//linux/usbdevice_fs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nfsacl.h -o ../..//usr/include//linux/nfsacl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/taskstats.h -o ../..//usr/include//linux/taskstats.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/hidraw.h -o ../..//usr/include//linux/hidraw.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nbd.h -o ../..//usr/include//linux/nbd.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/posix_acl.h -o ../..//usr/include//linux/posix_acl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/vmcore.h -o ../..//usr/include//linux/vmcore.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/hash_info.h -o ../..//usr/include//linux/hash_info.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/byteorder/little_endian.h -o ../..//usr/include//linux/byteorder/little_endian.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/byteorder/big_endian.h -o ../..//usr/include//linux/byteorder/big_endian.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ipx.h -o ../..//usr/include//linux/ipx.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/rseq.h -o ../..//usr/include//linux/rseq.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/sockios.h -o ../..//usr/include//linux/sockios.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/android/binder.h -o ../..//usr/include//linux/android/binder.o
../..//usr/include//linux/android/binder.h:249:2: error: unknown type name ‘pid_t’
  pid_t  sender_pid;
  ^~~~~
../..//usr/include//linux/android/binder.h:250:2: error: unknown type name ‘uid_t’
  uid_t  sender_euid;
  ^~~~~
uapi-compile.mk:31: recipe for target '../..//usr/include//linux/android/binder.o' failed
make: *** [../..//usr/include//linux/android/binder.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/in.h -o ../..//usr/include//linux/in.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/major.h -o ../..//usr/include//linux/major.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/pmu.h -o ../..//usr/include//linux/pmu.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nfs2.h -o ../..//usr/include//linux/nfs2.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/reboot.h -o ../..//usr/include//linux/reboot.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netlink_diag.h -o ../..//usr/include//linux/netlink_diag.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/v4l2-common.h -o ../..//usr/include//linux/v4l2-common.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/can.h -o ../..//usr/include//linux/can.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_bridge.h -o ../..//usr/include//linux/netfilter_bridge.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/vhost.h -o ../..//usr/include//linux/vhost.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if.h -o ../..//usr/include//linux/if.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/gtp.h -o ../..//usr/include//linux/gtp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/omap3isp.h -o ../..//usr/include//linux/omap3isp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/batman_adv.h -o ../..//usr/include//linux/batman_adv.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/const.h -o ../..//usr/include//linux/const.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/bcache.h -o ../..//usr/include//linux/bcache.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ife.h -o ../..//usr/include//linux/ife.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/poll.h -o ../..//usr/include//linux/poll.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/soundcard.h -o ../..//usr/include//linux/soundcard.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_bridge.h -o ../..//usr/include//linux/if_bridge.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/rtnetlink.h -o ../..//usr/include//linux/rtnetlink.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/stddef.h -o ../..//usr/include//linux/stddef.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atmapi.h -o ../..//usr/include//linux/atmapi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tcp.h -o ../..//usr/include//linux/tcp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dma-buf.h -o ../..//usr/include//linux/dma-buf.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/v4l2-dv-timings.h -o ../..//usr/include//linux/v4l2-dv-timings.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/raw.h -o ../..//usr/include//linux/raw.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/batadv_packet.h -o ../..//usr/include//linux/batadv_packet.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/selinux_netlink.h -o ../..//usr/include//linux/selinux_netlink.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dn.h -o ../..//usr/include//linux/dn.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_tun.h -o ../..//usr/include//linux/if_tun.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/can/netlink.h -o ../..//usr/include//linux/can/netlink.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/can/vxcan.h -o ../..//usr/include//linux/can/vxcan.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/can/error.h -o ../..//usr/include//linux/can/error.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/can/raw.h -o ../..//usr/include//linux/can/raw.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/can/bcm.h -o ../..//usr/include//linux/can/bcm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/can/gw.h -o ../..//usr/include//linux/can/gw.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ivtvfb.h -o ../..//usr/include//linux/ivtvfb.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/virtio_ring.h -o ../..//usr/include//linux/virtio_ring.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/vm_sockets_diag.h -o ../..//usr/include//linux/vm_sockets_diag.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_vlan.h -o ../..//usr/include//linux/if_vlan.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/virtio_net.h -o ../..//usr/include//linux/virtio_net.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/mii.h -o ../..//usr/include//linux/mii.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/string.h -o ../..//usr/include//linux/string.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/v4l2-subdev.h -o ../..//usr/include//linux/v4l2-subdev.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_arp/arpt_mangle.h -o ../..//usr/include//linux/netfilter_arp/arpt_mangle.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_arp/arp_tables.h -o ../..//usr/include//linux/netfilter_arp/arp_tables.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/virtio_pci.h -o ../..//usr/include//linux/virtio_pci.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/efs_fs_sb.h -o ../..//usr/include//linux/efs_fs_sb.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/mdio.h -o ../..//usr/include//linux/mdio.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/caif/if_caif.h -o ../..//usr/include//linux/caif/if_caif.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/caif/caif_socket.h -o ../..//usr/include//linux/caif/caif_socket.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/xattr.h -o ../..//usr/include//linux/xattr.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/input.h -o ../..//usr/include//linux/input.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/pg.h -o ../..//usr/include//linux/pg.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/btrfs.h -o ../..//usr/include//linux/btrfs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/hiddev.h -o ../..//usr/include//linux/hiddev.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tipc_sockets_diag.h -o ../..//usr/include//linux/tipc_sockets_diag.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/auto_fs.h -o ../..//usr/include//linux/auto_fs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/bpf_common.h -o ../..//usr/include//linux/bpf_common.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/kcmp.h -o ../..//usr/include//linux/kcmp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/cycx_cfm.h -o ../..//usr/include//linux/cycx_cfm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/input-event-codes.h -o ../..//usr/include//linux/input-event-codes.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/usbip.h -o ../..//usr/include//linux/usbip.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/virtio_input.h -o ../..//usr/include//linux/virtio_input.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/isdn.h -o ../..//usr/include//linux/isdn.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dlm.h -o ../..//usr/include//linux/dlm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/zorro_ids.h -o ../..//usr/include//linux/zorro_ids.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/mqueue.h -o ../..//usr/include//linux/mqueue.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/i2c-dev.h -o ../..//usr/include//linux/i2c-dev.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter.h -o ../..//usr/include//linux/netfilter.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/uinput.h -o ../..//usr/include//linux/uinput.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nfs3.h -o ../..//usr/include//linux/nfs3.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/hdreg.h -o ../..//usr/include//linux/hdreg.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ipsec.h -o ../..//usr/include//linux/ipsec.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/switchtec_ioctl.h -o ../..//usr/include//linux/switchtec_ioctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/l2tp.h -o ../..//usr/include//linux/l2tp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/mei.h -o ../..//usr/include//linux/mei.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/sctp.h -o ../..//usr/include//linux/sctp.o
../..//usr/include//linux/sctp.h:304:14: error: ‘MSG_FIN’ undeclared here (not in a function)
  SCTP_EOF  = MSG_FIN,  /* Initiate graceful shutdown process. */
              ^~~~~~~
../..//usr/include//linux/sctp.h:384:26: error: field ‘spc_aaddr’ has incomplete type
  struct sockaddr_storage spc_aaddr;
                          ^~~~~~~~~
../..//usr/include//linux/sctp.h:714:26: error: field ‘sspp_addr’ has incomplete type
  struct sockaddr_storage sspp_addr;
                          ^~~~~~~~~
../..//usr/include//linux/sctp.h:727:26: error: field ‘ssp_addr’ has incomplete type
  struct sockaddr_storage ssp_addr;
                          ^~~~~~~~
../..//usr/include//linux/sctp.h:769:26: error: field ‘spp_address’ has incomplete type
  struct sockaddr_storage spp_address;
                          ^~~~~~~~~~~
../..//usr/include//linux/sctp.h:880:26: error: field ‘spinfo_address’ has incomplete type
  struct sockaddr_storage spinfo_address;
                          ^~~~~~~~~~~~~~
../..//usr/include//linux/sctp.h:995:26: error: field ‘sas_obs_rto_ipaddr’ has incomplete type
  struct sockaddr_storage sas_obs_rto_ipaddr;
                          ^~~~~~~~~~~~~~~~~~
../..//usr/include//linux/sctp.h:1040:26: error: field ‘spt_address’ has incomplete type
  struct sockaddr_storage spt_address;
                          ^~~~~~~~~~~
../..//usr/include//linux/sctp.h:1099:26: error: field ‘sctpi_p_address’ has incomplete type
  struct sockaddr_storage sctpi_p_address;
                          ^~~~~~~~~~~~~~~
uapi-compile.mk:31: recipe for target '../..//usr/include//linux/sctp.o' failed
make: *** [../..//usr/include//linux/sctp.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/mpls.h -o ../..//usr/include//linux/mpls.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ultrasound.h -o ../..//usr/include//linux/ultrasound.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/sem.h -o ../..//usr/include//linux/sem.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/bpf.h -o ../..//usr/include//linux/bpf.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv4/ip_tables.h -o ../..//usr/include//linux/netfilter_ipv4/ip_tables.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv4/ipt_TTL.h -o ../..//usr/include//linux/netfilter_ipv4/ipt_TTL.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv4/ipt_ECN.h -o ../..//usr/include//linux/netfilter_ipv4/ipt_ECN.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv4/ipt_REJECT.h -o ../..//usr/include//linux/netfilter_ipv4/ipt_REJECT.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv4/ipt_LOG.h -o ../..//usr/include//linux/netfilter_ipv4/ipt_LOG.o
../..//usr/include//linux/netfilter_ipv4/ipt_LOG.h:5:2: warning: #warning "Please update iptables, this file will be removed soon!" [-Wcpp]
 #warning "Please update iptables, this file will be removed soon!"
  ^~~~~~~
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv4/ipt_ttl.h -o ../..//usr/include//linux/netfilter_ipv4/ipt_ttl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv4/ipt_ecn.h -o ../..//usr/include//linux/netfilter_ipv4/ipt_ecn.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv4/ipt_CLUSTERIP.h -o ../..//usr/include//linux/netfilter_ipv4/ipt_CLUSTERIP.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv4/ipt_ah.h -o ../..//usr/include//linux/netfilter_ipv4/ipt_ah.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_arcnet.h -o ../..//usr/include//linux/if_arcnet.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/cuda.h -o ../..//usr/include//linux/cuda.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atalk.h -o ../..//usr/include//linux/atalk.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/edd.h -o ../..//usr/include//linux/edd.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/qnx4_fs.h -o ../..//usr/include//linux/qnx4_fs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/vtpm_proxy.h -o ../..//usr/include//linux/vtpm_proxy.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nilfs2_api.h -o ../..//usr/include//linux/nilfs2_api.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_act/tc_defact.h -o ../..//usr/include//linux/tc_act/tc_defact.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_act/tc_ipt.h -o ../..//usr/include//linux/tc_act/tc_ipt.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_act/tc_gact.h -o ../..//usr/include//linux/tc_act/tc_gact.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_act/tc_skbedit.h -o ../..//usr/include//linux/tc_act/tc_skbedit.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_act/tc_nat.h -o ../..//usr/include//linux/tc_act/tc_nat.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_act/tc_tunnel_key.h -o ../..//usr/include//linux/tc_act/tc_tunnel_key.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_act/tc_mirred.h -o ../..//usr/include//linux/tc_act/tc_mirred.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_act/tc_pedit.h -o ../..//usr/include//linux/tc_act/tc_pedit.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_act/tc_ife.h -o ../..//usr/include//linux/tc_act/tc_ife.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_act/tc_sample.h -o ../..//usr/include//linux/tc_act/tc_sample.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_act/tc_bpf.h -o ../..//usr/include//linux/tc_act/tc_bpf.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_act/tc_vlan.h -o ../..//usr/include//linux/tc_act/tc_vlan.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_act/tc_csum.h -o ../..//usr/include//linux/tc_act/tc_csum.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_act/tc_skbmod.h -o ../..//usr/include//linux/tc_act/tc_skbmod.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tc_act/tc_connmark.h -o ../..//usr/include//linux/tc_act/tc_connmark.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/virtio_crypto.h -o ../..//usr/include//linux/virtio_crypto.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_addrlabel.h -o ../..//usr/include//linux/if_addrlabel.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/utime.h -o ../..//usr/include//linux/utime.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ipmi.h -o ../..//usr/include//linux/ipmi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/wireless.h -o ../..//usr/include//linux/wireless.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/bpqether.h -o ../..//usr/include//linux/bpqether.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/serial.h -o ../..//usr/include//linux/serial.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/msg.h -o ../..//usr/include//linux/msg.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/cec-funcs.h -o ../..//usr/include//linux/cec-funcs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/psci.h -o ../..//usr/include//linux/psci.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/elf-fdpic.h -o ../..//usr/include//linux/elf-fdpic.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/time.h -o ../..//usr/include//linux/time.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/fb.h -o ../..//usr/include//linux/fb.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/acct.h -o ../..//usr/include//linux/acct.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/wmi.h -o ../..//usr/include//linux/wmi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/wanrouter.h -o ../..//usr/include//linux/wanrouter.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/b1lli.h -o ../..//usr/include//linux/b1lli.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/n_r3964.h -o ../..//usr/include//linux/n_r3964.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/fsl_hypervisor.h -o ../..//usr/include//linux/fsl_hypervisor.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/wimax/i2400m.h -o ../..//usr/include//linux/wimax/i2400m.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tls.h -o ../..//usr/include//linux/tls.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/sonet.h -o ../..//usr/include//linux/sonet.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/fuse.h -o ../..//usr/include//linux/fuse.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/vm_sockets.h -o ../..//usr/include//linux/vm_sockets.o
../..//usr/include//linux/vm_sockets.h:149:32: error: invalid application of ‘sizeof’ to incomplete type ‘struct sockaddr’
  unsigned char svm_zero[sizeof(struct sockaddr) -
                                ^~~~~~
../..//usr/include//linux/vm_sockets.h:150:18: error: ‘sa_family_t’ undeclared here (not in a function)
           sizeof(sa_family_t) -
                  ^~~~~~~~~~~
uapi-compile.mk:31: recipe for target '../..//usr/include//linux/vm_sockets.o' failed
make: *** [../..//usr/include//linux/vm_sockets.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dlm_netlink.h -o ../..//usr/include//linux/dlm_netlink.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/bfs_fs.h -o ../..//usr/include//linux/bfs_fs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/media.h -o ../..//usr/include//linux/media.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/firewire-cdev.h -o ../..//usr/include//linux/firewire-cdev.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/errno.h -o ../..//usr/include//linux/errno.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ppp-comp.h -o ../..//usr/include//linux/ppp-comp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/membarrier.h -o ../..//usr/include//linux/membarrier.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/socket.h -o ../..//usr/include//linux/socket.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/baycom.h -o ../..//usr/include//linux/baycom.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atmmpc.h -o ../..//usr/include//linux/atmmpc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/radeonfb.h -o ../..//usr/include//linux/radeonfb.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nfs4.h -o ../..//usr/include//linux/nfs4.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/target_core_user.h -o ../..//usr/include//linux/target_core_user.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/cdrom.h -o ../..//usr/include//linux/cdrom.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/filter.h -o ../..//usr/include//linux/filter.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/rfkill.h -o ../..//usr/include//linux/rfkill.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/rose.h -o ../..//usr/include//linux/rose.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atmlec.h -o ../..//usr/include//linux/atmlec.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/bcm933xx_hcs.h -o ../..//usr/include//linux/bcm933xx_hcs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/gfs2_ondisk.h -o ../..//usr/include//linux/gfs2_ondisk.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nvme_ioctl.h -o ../..//usr/include//linux/nvme_ioctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/oom.h -o ../..//usr/include//linux/oom.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/udf_fs_i.h -o ../..//usr/include//linux/udf_fs_i.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tty_flags.h -o ../..//usr/include//linux/tty_flags.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_bonding.h -o ../..//usr/include//linux/if_bonding.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/vbox_vmmdev_types.h -o ../..//usr/include//linux/vbox_vmmdev_types.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atmppp.h -o ../..//usr/include//linux/atmppp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/quota.h -o ../..//usr/include//linux/quota.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ptrace.h -o ../..//usr/include//linux/ptrace.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ip.h -o ../..//usr/include//linux/ip.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/llc.h -o ../..//usr/include//linux/llc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/blkzoned.h -o ../..//usr/include//linux/blkzoned.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/mic_common.h -o ../..//usr/include//linux/mic_common.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/personality.h -o ../..//usr/include//linux/personality.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/kcm.h -o ../..//usr/include//linux/kcm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/irqnr.h -o ../..//usr/include//linux/irqnr.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/auto_fs4.h -o ../..//usr/include//linux/auto_fs4.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/smc_diag.h -o ../..//usr/include//linux/smc_diag.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/virtio_console.h -o ../..//usr/include//linux/virtio_console.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/iio/types.h -o ../..//usr/include//linux/iio/types.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/iio/events.h -o ../..//usr/include//linux/iio/events.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/keyctl.h -o ../..//usr/include//linux/keyctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_ppp.h -o ../..//usr/include//linux/if_ppp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ppp_defs.h -o ../..//usr/include//linux/ppp_defs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/cciss_ioctl.h -o ../..//usr/include//linux/cciss_ioctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nfs_mount.h -o ../..//usr/include//linux/nfs_mount.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/eventpoll.h -o ../..//usr/include//linux/eventpoll.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/thermal.h -o ../..//usr/include//linux/thermal.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atm.h -o ../..//usr/include//linux/atm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_eql.h -o ../..//usr/include//linux/if_eql.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/seg6_hmac.h -o ../..//usr/include//linux/seg6_hmac.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/flat.h -o ../..//usr/include//linux/flat.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/sock_diag.h -o ../..//usr/include//linux/sock_diag.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/i2o-dev.h -o ../..//usr/include//linux/i2o-dev.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/aio_abi.h -o ../..//usr/include//linux/aio_abi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/virtio_rng.h -o ../..//usr/include//linux/virtio_rng.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/genetlink.h -o ../..//usr/include//linux/genetlink.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/btrfs_tree.h -o ../..//usr/include//linux/btrfs_tree.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atm_tcp.h -o ../..//usr/include//linux/atm_tcp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/phonet.h -o ../..//usr/include//linux/phonet.o
../..//usr/include//linux/phonet.h:107:23: error: invalid application of ‘sizeof’ to incomplete type ‘struct sockaddr’
  __u8 spn_zero[sizeof(struct sockaddr) - sizeof(__kernel_sa_family_t) - 3];
                       ^~~~~~
uapi-compile.mk:31: recipe for target '../..//usr/include//linux/phonet.o' failed
make: *** [../..//usr/include//linux/phonet.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/signal.h -o ../..//usr/include//linux/signal.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ip_vs.h -o ../..//usr/include//linux/ip_vs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atm_nicstar.h -o ../..//usr/include//linux/atm_nicstar.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/cec.h -o ../..//usr/include//linux/cec.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/sunrpc/debug.h -o ../..//usr/include//linux/sunrpc/debug.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/mmc/ioctl.h -o ../..//usr/include//linux/mmc/ioctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/mtio.h -o ../..//usr/include//linux/mtio.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/fanotify.h -o ../..//usr/include//linux/fanotify.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/i8k.h -o ../..//usr/include//linux/i8k.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nvram.h -o ../..//usr/include//linux/nvram.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/isdn/capicmd.h -o ../..//usr/include//linux/isdn/capicmd.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/qemu_fw_cfg.h -o ../..//usr/include//linux/qemu_fw_cfg.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tty.h -o ../..//usr/include//linux/tty.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv6.h -o ../..//usr/include//linux/netfilter_ipv6.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/hpet.h -o ../..//usr/include//linux/hpet.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/xfrm.h -o ../..//usr/include//linux/xfrm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nubus.h -o ../..//usr/include//linux/nubus.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nfsd/debug.h -o ../..//usr/include//linux/nfsd/debug.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nfsd/export.h -o ../..//usr/include//linux/nfsd/export.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nfsd/stats.h -o ../..//usr/include//linux/nfsd/stats.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nfsd/cld.h -o ../..//usr/include//linux/nfsd/cld.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nfsd/nfsfh.h -o ../..//usr/include//linux/nfsd/nfsfh.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/rtc.h -o ../..//usr/include//linux/rtc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dm-ioctl.h -o ../..//usr/include//linux/dm-ioctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ax25.h -o ../..//usr/include//linux/ax25.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/pkt_sched.h -o ../..//usr/include//linux/pkt_sched.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/reiserfs_fs.h -o ../..//usr/include//linux/reiserfs_fs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/suspend_ioctls.h -o ../..//usr/include//linux/suspend_ioctls.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/parport.h -o ../..//usr/include//linux/parport.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/phantom.h -o ../..//usr/include//linux/phantom.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/rpmsg.h -o ../..//usr/include//linux/rpmsg.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atm_idt77105.h -o ../..//usr/include//linux/atm_idt77105.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/smiapp.h -o ../..//usr/include//linux/smiapp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/toshiba.h -o ../..//usr/include//linux/toshiba.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/seg6_iptunnel.h -o ../..//usr/include//linux/seg6_iptunnel.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/udp.h -o ../..//usr/include//linux/udp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/mmtimer.h -o ../..//usr/include//linux/mmtimer.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/jffs2.h -o ../..//usr/include//linux/jffs2.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/vbox_err.h -o ../..//usr/include//linux/vbox_err.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/rxrpc.h -o ../..//usr/include//linux/rxrpc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/raid/md_u.h -o ../..//usr/include//linux/raid/md_u.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/raid/md_p.h -o ../..//usr/include//linux/raid/md_p.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/route.h -o ../..//usr/include//linux/route.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/meye.h -o ../..//usr/include//linux/meye.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/serial_core.h -o ../..//usr/include//linux/serial_core.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/capi.h -o ../..//usr/include//linux/capi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/cm4000_cs.h -o ../..//usr/include//linux/cm4000_cs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_slip.h -o ../..//usr/include//linux/if_slip.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_hippi.h -o ../..//usr/include//linux/if_hippi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/veth.h -o ../..//usr/include//linux/veth.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/virtio_types.h -o ../..//usr/include//linux/virtio_types.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/uio.h -o ../..//usr/include//linux/uio.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tipc.h -o ../..//usr/include//linux/tipc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/fsmap.h -o ../..//usr/include//linux/fsmap.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atmbr2684.h -o ../..//usr/include//linux/atmbr2684.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/snmp.h -o ../..//usr/include//linux/snmp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/tipc_netlink.h -o ../..//usr/include//linux/tipc_netlink.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dlmconstants.h -o ../..//usr/include//linux/dlmconstants.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/msdos_fs.h -o ../..//usr/include//linux/msdos_fs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/errqueue.h -o ../..//usr/include//linux/errqueue.o
../..//usr/include//linux/errqueue.h:37:18: error: array type has incomplete element type ‘struct timespec’
  struct timespec ts[3];
                  ^~
uapi-compile.mk:31: recipe for target '../..//usr/include//linux/errqueue.o' failed
make: *** [../..//usr/include//linux/errqueue.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/net.h -o ../..//usr/include//linux/net.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_ether.h -o ../..//usr/include//linux/if_ether.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atm_eni.h -o ../..//usr/include//linux/atm_eni.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/igmp.h -o ../..//usr/include//linux/igmp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/neighbour.h -o ../..//usr/include//linux/neighbour.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/blkpg.h -o ../..//usr/include//linux/blkpg.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/cgroupstats.h -o ../..//usr/include//linux/cgroupstats.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/virtio_gpu.h -o ../..//usr/include//linux/virtio_gpu.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/sched.h -o ../..//usr/include//linux/sched.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/falloc.h -o ../..//usr/include//linux/falloc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_arp.h -o ../..//usr/include//linux/netfilter_arp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ipc.h -o ../..//usr/include//linux/ipc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/in6.h -o ../..//usr/include//linux/in6.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/sonypi.h -o ../..//usr/include//linux/sonypi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/seg6.h -o ../..//usr/include//linux/seg6.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/cramfs_fs.h -o ../..//usr/include//linux/cramfs_fs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/posix_types.h -o ../..//usr/include//linux/posix_types.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/cn_proc.h -o ../..//usr/include//linux/cn_proc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/pfkeyv2.h -o ../..//usr/include//linux/pfkeyv2.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_x25.h -o ../..//usr/include//linux/if_x25.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/types.h -o ../..//usr/include//linux/types.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/v4l2-controls.h -o ../..//usr/include//linux/v4l2-controls.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/uhid.h -o ../..//usr/include//linux/uhid.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/adfs_fs.h -o ../..//usr/include//linux/adfs_fs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/pci.h -o ../..//usr/include//linux/pci.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/connector.h -o ../..//usr/include//linux/connector.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/signalfd.h -o ../..//usr/include//linux/signalfd.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/userio.h -o ../..//usr/include//linux/userio.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_plip.h -o ../..//usr/include//linux/if_plip.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netconf.h -o ../..//usr/include//linux/netconf.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/futex.h -o ../..//usr/include//linux/futex.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/kcov.h -o ../..//usr/include//linux/kcov.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/pci_regs.h -o ../..//usr/include//linux/pci_regs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/spi/spidev.h -o ../..//usr/include//linux/spi/spidev.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/adb.h -o ../..//usr/include//linux/adb.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/elfcore.h -o ../..//usr/include//linux/elfcore.o
../..//usr/include//linux/elfcore.h:20:9: error: unknown type name ‘elf_greg_t’
 typedef elf_greg_t greg_t;
         ^~~~~~~~~~
../..//usr/include//linux/elfcore.h:21:9: error: unknown type name ‘elf_gregset_t’
 typedef elf_gregset_t gregset_t;
         ^~~~~~~~~~~~~
../..//usr/include//linux/elfcore.h:22:9: error: unknown type name ‘elf_fpregset_t’
 typedef elf_fpregset_t fpregset_t;
         ^~~~~~~~~~~~~~
../..//usr/include//linux/elfcore.h:23:9: error: unknown type name ‘elf_fpxregset_t’
 typedef elf_fpxregset_t fpxregset_t;
         ^~~~~~~~~~~~~~~
../..//usr/include//linux/elfcore.h:50:2: error: unknown type name ‘pid_t’
  pid_t pr_pid;
  ^~~~~
../..//usr/include//linux/elfcore.h:51:2: error: unknown type name ‘pid_t’
  pid_t pr_ppid;
  ^~~~~
../..//usr/include//linux/elfcore.h:52:2: error: unknown type name ‘pid_t’
  pid_t pr_pgrp;
  ^~~~~
../..//usr/include//linux/elfcore.h:53:2: error: unknown type name ‘pid_t’
  pid_t pr_sid;
  ^~~~~
../..//usr/include//linux/elfcore.h:61:2: error: unknown type name ‘elf_gregset_t’
  elf_gregset_t pr_reg; /* GP registers */
  ^~~~~~~~~~~~~
../..//usr/include//linux/elfcore.h:86:2: error: unknown type name ‘pid_t’
  pid_t pr_pid, pr_ppid, pr_pgrp, pr_sid;
  ^~~~~
uapi-compile.mk:31: recipe for target '../..//usr/include//linux/elfcore.o' failed
make: *** [../..//usr/include//linux/elfcore.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nfs_fs.h -o ../..//usr/include//linux/nfs_fs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atmarp.h -o ../..//usr/include//linux/atmarp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/map_to_7segment.h -o ../..//usr/include//linux/map_to_7segment.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/magic.h -o ../..//usr/include//linux/magic.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nilfs2_ondisk.h -o ../..//usr/include//linux/nilfs2_ondisk.o
../..//usr/include//linux/nilfs2_ondisk.h: In function ‘nilfs_checkpoint_set_snapshot’:
../..//usr/include//linux/nilfs2_ondisk.h:536:17: warning: implicit declaration of function ‘cpu_to_le32’ [-Wimplicit-function-declaration]
  cp->cp_flags = cpu_to_le32(le32_to_cpu(cp->cp_flags) |  \
                 ^
../..//usr/include//linux/nilfs2_ondisk.h:552:1: note: in expansion of macro ‘NILFS_CHECKPOINT_FNS’
 NILFS_CHECKPOINT_FNS(SNAPSHOT, snapshot)
 ^~~~~~~~~~~~~~~~~~~~
../..//usr/include//linux/nilfs2_ondisk.h:536:29: warning: implicit declaration of function ‘le32_to_cpu’ [-Wimplicit-function-declaration]
  cp->cp_flags = cpu_to_le32(le32_to_cpu(cp->cp_flags) |  \
                             ^
../..//usr/include//linux/nilfs2_ondisk.h:552:1: note: in expansion of macro ‘NILFS_CHECKPOINT_FNS’
 NILFS_CHECKPOINT_FNS(SNAPSHOT, snapshot)
 ^~~~~~~~~~~~~~~~~~~~
../..//usr/include//linux/nilfs2_ondisk.h: In function ‘nilfs_segment_usage_set_clean’:
../..//usr/include//linux/nilfs2_ondisk.h:622:19: warning: implicit declaration of function ‘cpu_to_le64’ [-Wimplicit-function-declaration]
  su->su_lastmod = cpu_to_le64(0);
                   ^~~~~~~~~~~
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/module.h -o ../..//usr/include//linux/module.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/lightnvm.h -o ../..//usr/include//linux/lightnvm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/hdlcdrv.h -o ../..//usr/include//linux/hdlcdrv.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atmdev.h -o ../..//usr/include//linux/atmdev.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/isdn_divertif.h -o ../..//usr/include//linux/isdn_divertif.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/usb/cdc.h -o ../..//usr/include//linux/usb/cdc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/usb/functionfs.h -o ../..//usr/include//linux/usb/functionfs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/usb/gadgetfs.h -o ../..//usr/include//linux/usb/gadgetfs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/usb/tmc.h -o ../..//usr/include//linux/usb/tmc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/usb/ch11.h -o ../..//usr/include//linux/usb/ch11.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/usb/g_printer.h -o ../..//usr/include//linux/usb/g_printer.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/usb/audio.h -o ../..//usr/include//linux/usb/audio.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/usb/midi.h -o ../..//usr/include//linux/usb/midi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/usb/cdc-wdm.h -o ../..//usr/include//linux/usb/cdc-wdm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/usb/charger.h -o ../..//usr/include//linux/usb/charger.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/usb/ch9.h -o ../..//usr/include//linux/usb/ch9.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/usb/video.h -o ../..//usr/include//linux/usb/video.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_xdp.h -o ../..//usr/include//linux/if_xdp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/genwqe/genwqe_card.h -o ../..//usr/include//linux/genwqe/genwqe_card.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/isdnif.h -o ../..//usr/include//linux/isdnif.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/devlink.h -o ../..//usr/include//linux/devlink.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/coresight-stm.h -o ../..//usr/include//linux/coresight-stm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/virtio_blk.h -o ../..//usr/include//linux/virtio_blk.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_tunnel.h -o ../..//usr/include//linux/if_tunnel.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/smc.h -o ../..//usr/include//linux/smc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atmclip.h -o ../..//usr/include//linux/atmclip.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/termios.h -o ../..//usr/include//linux/termios.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/affs_hardblocks.h -o ../..//usr/include//linux/affs_hardblocks.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/ipv6.h -o ../..//usr/include//linux/ipv6.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/hdlc.h -o ../..//usr/include//linux/hdlc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/fd.h -o ../..//usr/include//linux/fd.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_link.h -o ../..//usr/include//linux/if_link.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nbd-netlink.h -o ../..//usr/include//linux/nbd-netlink.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/timerfd.h -o ../..//usr/include//linux/timerfd.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/arcfb.h -o ../..//usr/include//linux/arcfb.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/seccomp.h -o ../..//usr/include//linux/seccomp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/sched/types.h -o ../..//usr/include//linux/sched/types.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/sysinfo.h -o ../..//usr/include//linux/sysinfo.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/pcitest.h -o ../..//usr/include//linux/pcitest.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/hsr_netlink.h -o ../..//usr/include//linux/hsr_netlink.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/fiemap.h -o ../..//usr/include//linux/fiemap.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/dlm_plock.h -o ../..//usr/include//linux/dlm_plock.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/mempolicy.h -o ../..//usr/include//linux/mempolicy.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/videodev2.h -o ../..//usr/include//linux/videodev2.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/x25.h -o ../..//usr/include//linux/x25.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/net_dropmon.h -o ../..//usr/include//linux/net_dropmon.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/arm_sdei.h -o ../..//usr/include//linux/arm_sdei.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/kfd_ioctl.h -o ../..//usr/include//linux/kfd_ioctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/fou.h -o ../..//usr/include//linux/fou.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter_ipv4.h -o ../..//usr/include//linux/netfilter_ipv4.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/firewire-constants.h -o ../..//usr/include//linux/firewire-constants.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/virtio_mmio.h -o ../..//usr/include//linux/virtio_mmio.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/atm_he.h -o ../..//usr/include//linux/atm_he.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_connlabel.h -o ../..//usr/include//linux/netfilter/xt_connlabel.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_TCPOPTSTRIP.h -o ../..//usr/include//linux/netfilter/xt_TCPOPTSTRIP.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_hashlimit.h -o ../..//usr/include//linux/netfilter/xt_hashlimit.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_ipcomp.h -o ../..//usr/include//linux/netfilter/xt_ipcomp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_esp.h -o ../..//usr/include//linux/netfilter/xt_esp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_TCPMSS.h -o ../..//usr/include//linux/netfilter/xt_TCPMSS.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nf_log.h -o ../..//usr/include//linux/netfilter/nf_log.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_TPROXY.h -o ../..//usr/include//linux/netfilter/xt_TPROXY.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nf_osf.h -o ../..//usr/include//linux/netfilter/nf_osf.o
../..//usr/include//linux/netfilter/nf_osf.h:59:24: error: ‘MAX_IPOPTLEN’ undeclared here (not in a function); did you mean ‘MAXGENRELEN’?
  struct nf_osf_opt opt[MAX_IPOPTLEN];
                        ^~~~~~~~~~~~
                        MAXGENRELEN
../..//usr/include//linux/netfilter/nf_osf.h:64:17: error: field ‘ip’ has incomplete type
  struct iphdr   ip;
                 ^~
../..//usr/include//linux/netfilter/nf_osf.h:65:18: error: field ‘tcp’ has incomplete type
  struct tcphdr   tcp;
                  ^~~
uapi-compile.mk:31: recipe for target '../..//usr/include//linux/netfilter/nf_osf.o' failed
make: *** [../..//usr/include//linux/netfilter/nf_osf.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_pkttype.h -o ../..//usr/include//linux/netfilter/xt_pkttype.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_l2tp.h -o ../..//usr/include//linux/netfilter/xt_l2tp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_connmark.h -o ../..//usr/include//linux/netfilter/xt_connmark.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_LED.h -o ../..//usr/include//linux/netfilter/xt_LED.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_comment.h -o ../..//usr/include//linux/netfilter/xt_comment.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nfnetlink_conntrack.h -o ../..//usr/include//linux/netfilter/nfnetlink_conntrack.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_MARK.h -o ../..//usr/include//linux/netfilter/xt_MARK.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_bpf.h -o ../..//usr/include//linux/netfilter/xt_bpf.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nfnetlink_compat.h -o ../..//usr/include//linux/netfilter/nfnetlink_compat.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_set.h -o ../..//usr/include//linux/netfilter/xt_set.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/ipset/ip_set_bitmap.h -o ../..//usr/include//linux/netfilter/ipset/ip_set_bitmap.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/ipset/ip_set.h -o ../..//usr/include//linux/netfilter/ipset/ip_set.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/ipset/ip_set_list.h -o ../..//usr/include//linux/netfilter/ipset/ip_set_list.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/ipset/ip_set_hash.h -o ../..//usr/include//linux/netfilter/ipset/ip_set_hash.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_u32.h -o ../..//usr/include//linux/netfilter/xt_u32.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_SECMARK.h -o ../..//usr/include//linux/netfilter/xt_SECMARK.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_state.h -o ../..//usr/include//linux/netfilter/xt_state.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_CLASSIFY.h -o ../..//usr/include//linux/netfilter/xt_CLASSIFY.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_connbytes.h -o ../..//usr/include//linux/netfilter/xt_connbytes.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nfnetlink_cthelper.h -o ../..//usr/include//linux/netfilter/nfnetlink_cthelper.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nf_tables.h -o ../..//usr/include//linux/netfilter/nf_tables.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_NFQUEUE.h -o ../..//usr/include//linux/netfilter/xt_NFQUEUE.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/x_tables.h -o ../..//usr/include//linux/netfilter/x_tables.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_mac.h -o ../..//usr/include//linux/netfilter/xt_mac.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nf_tables_compat.h -o ../..//usr/include//linux/netfilter/nf_tables_compat.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_cluster.h -o ../..//usr/include//linux/netfilter/xt_cluster.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_rpfilter.h -o ../..//usr/include//linux/netfilter/xt_rpfilter.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_CONNSECMARK.h -o ../..//usr/include//linux/netfilter/xt_CONNSECMARK.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_AUDIT.h -o ../..//usr/include//linux/netfilter/xt_AUDIT.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nf_conntrack_sctp.h -o ../..//usr/include//linux/netfilter/nf_conntrack_sctp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_policy.h -o ../..//usr/include//linux/netfilter/xt_policy.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_tcpudp.h -o ../..//usr/include//linux/netfilter/xt_tcpudp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_ecn.h -o ../..//usr/include//linux/netfilter/xt_ecn.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_limit.h -o ../..//usr/include//linux/netfilter/xt_limit.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_time.h -o ../..//usr/include//linux/netfilter/xt_time.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_mark.h -o ../..//usr/include//linux/netfilter/xt_mark.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_owner.h -o ../..//usr/include//linux/netfilter/xt_owner.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_CT.h -o ../..//usr/include//linux/netfilter/xt_CT.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_IDLETIMER.h -o ../..//usr/include//linux/netfilter/xt_IDLETIMER.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nfnetlink_cttimeout.h -o ../..//usr/include//linux/netfilter/nfnetlink_cttimeout.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_length.h -o ../..//usr/include//linux/netfilter/xt_length.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_osf.h -o ../..//usr/include//linux/netfilter/xt_osf.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_sctp.h -o ../..//usr/include//linux/netfilter/xt_sctp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nf_conntrack_ftp.h -o ../..//usr/include//linux/netfilter/nf_conntrack_ftp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_tcpmss.h -o ../..//usr/include//linux/netfilter/xt_tcpmss.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nfnetlink.h -o ../..//usr/include//linux/netfilter/nfnetlink.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_nfacct.h -o ../..//usr/include//linux/netfilter/xt_nfacct.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_cgroup.h -o ../..//usr/include//linux/netfilter/xt_cgroup.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nfnetlink_queue.h -o ../..//usr/include//linux/netfilter/nfnetlink_queue.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_conntrack.h -o ../..//usr/include//linux/netfilter/xt_conntrack.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nfnetlink_acct.h -o ../..//usr/include//linux/netfilter/nfnetlink_acct.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_helper.h -o ../..//usr/include//linux/netfilter/xt_helper.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_socket.h -o ../..//usr/include//linux/netfilter/xt_socket.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_ipvs.h -o ../..//usr/include//linux/netfilter/xt_ipvs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_cpu.h -o ../..//usr/include//linux/netfilter/xt_cpu.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_TEE.h -o ../..//usr/include//linux/netfilter/xt_TEE.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nf_conntrack_tcp.h -o ../..//usr/include//linux/netfilter/nf_conntrack_tcp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_statistic.h -o ../..//usr/include//linux/netfilter/xt_statistic.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_quota.h -o ../..//usr/include//linux/netfilter/xt_quota.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_dscp.h -o ../..//usr/include//linux/netfilter/xt_dscp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_realm.h -o ../..//usr/include//linux/netfilter/xt_realm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_LOG.h -o ../..//usr/include//linux/netfilter/xt_LOG.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_addrtype.h -o ../..//usr/include//linux/netfilter/xt_addrtype.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_multiport.h -o ../..//usr/include//linux/netfilter/xt_multiport.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_DSCP.h -o ../..//usr/include//linux/netfilter/xt_DSCP.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nf_conntrack_tuple_common.h -o ../..//usr/include//linux/netfilter/nf_conntrack_tuple_common.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_NFLOG.h -o ../..//usr/include//linux/netfilter/xt_NFLOG.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_connlimit.h -o ../..//usr/include//linux/netfilter/xt_connlimit.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_string.h -o ../..//usr/include//linux/netfilter/xt_string.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nf_nat.h -o ../..//usr/include//linux/netfilter/nf_nat.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_CHECKSUM.h -o ../..//usr/include//linux/netfilter/xt_CHECKSUM.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_physdev.h -o ../..//usr/include//linux/netfilter/xt_physdev.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_SYNPROXY.h -o ../..//usr/include//linux/netfilter/xt_SYNPROXY.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_rateest.h -o ../..//usr/include//linux/netfilter/xt_rateest.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_RATEEST.h -o ../..//usr/include//linux/netfilter/xt_RATEEST.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_CONNMARK.h -o ../..//usr/include//linux/netfilter/xt_CONNMARK.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_iprange.h -o ../..//usr/include//linux/netfilter/xt_iprange.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_recent.h -o ../..//usr/include//linux/netfilter/xt_recent.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_dccp.h -o ../..//usr/include//linux/netfilter/xt_dccp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_HMARK.h -o ../..//usr/include//linux/netfilter/xt_HMARK.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/xt_devgroup.h -o ../..//usr/include//linux/netfilter/xt_devgroup.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nf_conntrack_common.h -o ../..//usr/include//linux/netfilter/nf_conntrack_common.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/netfilter/nfnetlink_log.h -o ../..//usr/include//linux/netfilter/nfnetlink_log.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_cablemodem.h -o ../..//usr/include//linux/if_cablemodem.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/scc.h -o ../..//usr/include//linux/scc.o
../..//usr/include//linux/scc.h:20:20: error: ‘SIOCDEVPRIVATE’ undeclared here (not in a function)
  SIOCSCCRESERVED = SIOCDEVPRIVATE,
                    ^~~~~~~~~~~~~~
uapi-compile.mk:31: recipe for target '../..//usr/include//linux/scc.o' failed
make: *** [../..//usr/include//linux/scc.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/btf.h -o ../..//usr/include//linux/btf.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_fc.h -o ../..//usr/include//linux/if_fc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/patchkey.h -o ../..//usr/include//linux/patchkey.o
../..//usr/include//linux/patchkey.h:15:2: error: #error "patchkey.h included directly"
 #error "patchkey.h included directly"
  ^~~~~
uapi-compile.mk:31: recipe for target '../..//usr/include//linux/patchkey.o' failed
make: *** [../..//usr/include//linux/patchkey.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/securebits.h -o ../..//usr/include//linux/securebits.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/packet_diag.h -o ../..//usr/include//linux/packet_diag.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/serial_reg.h -o ../..//usr/include//linux/serial_reg.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_fddi.h -o ../..//usr/include//linux/if_fddi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/gsmmux.h -o ../..//usr/include//linux/gsmmux.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/romfs_fs.h -o ../..//usr/include//linux/romfs_fs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/nfc.h -o ../..//usr/include//linux/nfc.o
../..//usr/include//linux/nfc.h:266:2: error: unknown type name ‘sa_family_t’
  sa_family_t sa_family;
  ^~~~~~~~~~~
../..//usr/include//linux/nfc.h:274:2: error: unknown type name ‘sa_family_t’
  sa_family_t sa_family;
  ^~~~~~~~~~~
uapi-compile.mk:31: recipe for target '../..//usr/include//linux/nfc.o' failed
make: *** [../..//usr/include//linux/nfc.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/if_frad.h -o ../..//usr/include//linux/if_frad.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/prctl.h -o ../..//usr/include//linux/prctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/reiserfs_xattr.h -o ../..//usr/include//linux/reiserfs_xattr.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/vfio_ccw.h -o ../..//usr/include//linux/vfio_ccw.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/qrtr.h -o ../..//usr/include//linux/qrtr.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/utsname.h -o ../..//usr/include//linux/utsname.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/kernel-page-flags.h -o ../..//usr/include//linux/kernel-page-flags.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/cyclades.h -o ../..//usr/include//linux/cyclades.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/net_tstamp.h -o ../..//usr/include//linux/net_tstamp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/vsockmon.h -o ../..//usr/include//linux/vsockmon.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//linux/omapfb.h -o ../..//usr/include//linux/omapfb.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//video/edid.h -o ../..//usr/include//video/edid.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//video/uvesafb.h -o ../..//usr/include//video/uvesafb.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//video/sisfb.h -o ../..//usr/include//video/sisfb.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//xen/gntalloc.h -o ../..//usr/include//xen/gntalloc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//xen/evtchn.h -o ../..//usr/include//xen/evtchn.o
../..//usr/include//xen/evtchn.h:101:2: error: unknown type name ‘domid_t’
  domid_t domid;
  ^~~~~~~
uapi-compile.mk:31: recipe for target '../..//usr/include//xen/evtchn.o' failed
make: *** [../..//usr/include//xen/evtchn.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//xen/privcmd.h -o ../..//usr/include//xen/privcmd.o
../..//usr/include//xen/privcmd.h:39:10: fatal error: xen/interface/xen.h: No such file or directory
 #include <xen/interface/xen.h>
          ^~~~~~~~~~~~~~~~~~~~~
compilation terminated.
uapi-compile.mk:31: recipe for target '../..//usr/include//xen/privcmd.o' failed
make: *** [../..//usr/include//xen/privcmd.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//xen/gntdev.h -o ../..//usr/include//xen/gntdev.o
../..//usr/include//xen/gntdev.h:152:4: error: unknown type name ‘grant_ref_t’
    grant_ref_t ref;
    ^~~~~~~~~~~
../..//usr/include//xen/gntdev.h:154:4: error: unknown type name ‘domid_t’
    domid_t domid;
    ^~~~~~~
uapi-compile.mk:31: recipe for target '../..//usr/include//xen/gntdev.o' failed
make: *** [../..//usr/include//xen/gntdev.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//sound/asound_fm.h -o ../..//usr/include//sound/asound_fm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//sound/asoc.h -o ../..//usr/include//sound/asoc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//sound/skl-tplg-interface.h -o ../..//usr/include//sound/skl-tplg-interface.o
../..//usr/include//sound/skl-tplg-interface.h:146:2: error: unknown type name ‘u32’
  u32 set_params:2;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:147:2: error: unknown type name ‘u32’
  u32 rsvd:30;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:148:2: error: unknown type name ‘u32’
  u32 param_id;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:149:2: error: unknown type name ‘u32’
  u32 max;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:166:2: error: unknown type name ‘u16’
  u16 module_id;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:167:2: error: unknown type name ‘u16’
  u16 instance_id;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:171:2: error: unknown type name ‘u32’
  u32 channels;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:172:2: error: unknown type name ‘u32’
  u32 freq;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:173:2: error: unknown type name ‘u32’
  u32 bit_depth;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:174:2: error: unknown type name ‘u32’
  u32 valid_bit_depth;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:175:2: error: unknown type name ‘u32’
  u32 ch_cfg;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:176:2: error: unknown type name ‘u32’
  u32 interleaving_style;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:177:2: error: unknown type name ‘u32’
  u32 sample_type;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:178:2: error: unknown type name ‘u32’
  u32 ch_map;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:182:2: error: unknown type name ‘u32’
  u32 set_params:2;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:183:2: error: unknown type name ‘u32’
  u32 rsvd:30;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:184:2: error: unknown type name ‘u32’
  u32 param_id;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:185:2: error: unknown type name ‘u32’
  u32 caps_size;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:186:2: error: unknown type name ‘u32’
  u32 caps[HDA_SST_CFG_MAX];
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:190:2: error: unknown type name ‘u8’
  u8 pipe_id;
  ^~
../..//usr/include//sound/skl-tplg-interface.h:191:2: error: unknown type name ‘u8’
  u8 pipe_priority;
  ^~
../..//usr/include//sound/skl-tplg-interface.h:192:2: error: unknown type name ‘u16’
  u16 conn_type:4;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:193:2: error: unknown type name ‘u16’
  u16 rsvd:4;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:194:2: error: unknown type name ‘u16’
  u16 memory_pages:8;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:200:2: error: unknown type name ‘u16’
  u16 module_id;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:201:2: error: unknown type name ‘u16’
  u16 instance_id;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:202:2: error: unknown type name ‘u32’
  u32 max_mcps;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:203:2: error: unknown type name ‘u32’
  u32 mem_pages;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:204:2: error: unknown type name ‘u32’
  u32 obs;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:205:2: error: unknown type name ‘u32’
  u32 ibs;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:206:2: error: unknown type name ‘u32’
  u32 vbus_id;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:208:2: error: unknown type name ‘u32’
  u32 max_in_queue:8;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:209:2: error: unknown type name ‘u32’
  u32 max_out_queue:8;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:210:2: error: unknown type name ‘u32’
  u32 time_slot:8;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:211:2: error: unknown type name ‘u32’
  u32 core_id:4;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:212:2: error: unknown type name ‘u32’
  u32 rsvd1:4;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:214:2: error: unknown type name ‘u32’
  u32 module_type:8;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:215:2: error: unknown type name ‘u32’
  u32 conn_type:4;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:216:2: error: unknown type name ‘u32’
  u32 dev_type:4;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:217:2: error: unknown type name ‘u32’
  u32 hw_conn_type:4;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:218:2: error: unknown type name ‘u32’
  u32 rsvd2:12;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:220:2: error: unknown type name ‘u32’
  u32 params_fixup:8;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:221:2: error: unknown type name ‘u32’
  u32 converter:8;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:222:2: error: unknown type name ‘u32’
  u32 input_pin_type:1;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:223:2: error: unknown type name ‘u32’
  u32 output_pin_type:1;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:224:2: error: unknown type name ‘u32’
  u32 is_dynamic_in_pin:1;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:225:2: error: unknown type name ‘u32’
  u32 is_dynamic_out_pin:1;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:226:2: error: unknown type name ‘u32’
  u32 is_loadable:1;
  ^~~
../..//usr/include//sound/skl-tplg-interface.h:227:2: error: unknown type name ‘u32’
  u32 rsvd3:11;
  ^~~
uapi-compile.mk:31: recipe for target '../..//usr/include//sound/skl-tplg-interface.o' failed
make: *** [../..//usr/include//sound/skl-tplg-interface.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//sound/asequencer.h -o ../..//usr/include//sound/asequencer.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//sound/tlv.h -o ../..//usr/include//sound/tlv.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//sound/emu10k1.h -o ../..//usr/include//sound/emu10k1.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//sound/firewire.h -o ../..//usr/include//sound/firewire.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//sound/snd_sst_tokens.h -o ../..//usr/include//sound/snd_sst_tokens.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//sound/compress_params.h -o ../..//usr/include//sound/compress_params.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//sound/sb16_csp.h -o ../..//usr/include//sound/sb16_csp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//sound/asound.h -o ../..//usr/include//sound/asound.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//sound/usb_stream.h -o ../..//usr/include//sound/usb_stream.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//sound/compress_offload.h -o ../..//usr/include//sound/compress_offload.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//sound/hdsp.h -o ../..//usr/include//sound/hdsp.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//sound/sfnt_info.h -o ../..//usr/include//sound/sfnt_info.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//sound/hdspm.h -o ../..//usr/include//sound/hdspm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//mtd/inftl-user.h -o ../..//usr/include//mtd/inftl-user.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//mtd/nftl-user.h -o ../..//usr/include//mtd/nftl-user.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//mtd/ubi-user.h -o ../..//usr/include//mtd/ubi-user.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//mtd/mtd-abi.h -o ../..//usr/include//mtd/mtd-abi.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//mtd/mtd-user.h -o ../..//usr/include//mtd/mtd-user.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//misc/cxl.h -o ../..//usr/include//misc/cxl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//misc/ocxl.h -o ../..//usr/include//misc/ocxl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/vmwgfx_drm.h -o ../..//usr/include//drm/vmwgfx_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/i810_drm.h -o ../..//usr/include//drm/i810_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/sis_drm.h -o ../..//usr/include//drm/sis_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/nouveau_drm.h -o ../..//usr/include//drm/nouveau_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/armada_drm.h -o ../..//usr/include//drm/armada_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/radeon_drm.h -o ../..//usr/include//drm/radeon_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/exynos_drm.h -o ../..//usr/include//drm/exynos_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/msm_drm.h -o ../..//usr/include//drm/msm_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/tegra_drm.h -o ../..//usr/include//drm/tegra_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/drm_fourcc.h -o ../..//usr/include//drm/drm_fourcc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/v3d_drm.h -o ../..//usr/include//drm/v3d_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/amdgpu_drm.h -o ../..//usr/include//drm/amdgpu_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/savage_drm.h -o ../..//usr/include//drm/savage_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/drm_sarea.h -o ../..//usr/include//drm/drm_sarea.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/vc4_drm.h -o ../..//usr/include//drm/vc4_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/via_drm.h -o ../..//usr/include//drm/via_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/i915_drm.h -o ../..//usr/include//drm/i915_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/qxl_drm.h -o ../..//usr/include//drm/qxl_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/omap_drm.h -o ../..//usr/include//drm/omap_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/virtgpu_drm.h -o ../..//usr/include//drm/virtgpu_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/drm_mode.h -o ../..//usr/include//drm/drm_mode.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/etnaviv_drm.h -o ../..//usr/include//drm/etnaviv_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/r128_drm.h -o ../..//usr/include//drm/r128_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/vgem_drm.h -o ../..//usr/include//drm/vgem_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/drm.h -o ../..//usr/include//drm/drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//drm/mga_drm.h -o ../..//usr/include//drm/mga_drm.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//scsi/cxlflash_ioctl.h -o ../..//usr/include//scsi/cxlflash_ioctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//scsi/scsi_netlink_fc.h -o ../..//usr/include//scsi/scsi_netlink_fc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//scsi/fc/fc_gs.h -o ../..//usr/include//scsi/fc/fc_gs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//scsi/fc/fc_fs.h -o ../..//usr/include//scsi/fc/fc_fs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//scsi/fc/fc_els.h -o ../..//usr/include//scsi/fc/fc_els.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//scsi/fc/fc_ns.h -o ../..//usr/include//scsi/fc/fc_ns.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//scsi/scsi_netlink.h -o ../..//usr/include//scsi/scsi_netlink.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//scsi/scsi_bsg_fc.h -o ../..//usr/include//scsi/scsi_bsg_fc.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/param.h -o ../..//usr/include//asm-generic/param.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/fcntl.h -o ../..//usr/include//asm-generic/fcntl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/setup.h -o ../..//usr/include//asm-generic/setup.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/shmbuf.h -o ../..//usr/include//asm-generic/shmbuf.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/ioctl.h -o ../..//usr/include//asm-generic/ioctl.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/termbits.h -o ../..//usr/include//asm-generic/termbits.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/auxvec.h -o ../..//usr/include//asm-generic/auxvec.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/mman.h -o ../..//usr/include//asm-generic/mman.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/unistd.h -o ../..//usr/include//asm-generic/unistd.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/swab.h -o ../..//usr/include//asm-generic/swab.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/ucontext.h -o ../..//usr/include//asm-generic/ucontext.o
../..//usr/include//asm-generic/ucontext.h:8:2: error: unknown type name ‘stack_t’
  stack_t    uc_stack;
  ^~~~~~~
../..//usr/include//asm-generic/ucontext.h:9:20: error: field ‘uc_mcontext’ has incomplete type
  struct sigcontext uc_mcontext;
                    ^~~~~~~~~~~
../..//usr/include//asm-generic/ucontext.h:10:2: error: unknown type name ‘sigset_t’
  sigset_t   uc_sigmask; /* mask last for extensibility */
  ^~~~~~~~
uapi-compile.mk:31: recipe for target '../..//usr/include//asm-generic/ucontext.o' failed
make: *** [../..//usr/include//asm-generic/ucontext.o] Error 1
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/resource.h -o ../..//usr/include//asm-generic/resource.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/stat.h -o ../..//usr/include//asm-generic/stat.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/bpf_perf_event.h -o ../..//usr/include//asm-generic/bpf_perf_event.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/msgbuf.h -o ../..//usr/include//asm-generic/msgbuf.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/hugetlb_encode.h -o ../..//usr/include//asm-generic/hugetlb_encode.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/sockios.h -o ../..//usr/include//asm-generic/sockios.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/errno-base.h -o ../..//usr/include//asm-generic/errno-base.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/poll.h -o ../..//usr/include//asm-generic/poll.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/ioctls.h -o ../..//usr/include//asm-generic/ioctls.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/statfs.h -o ../..//usr/include//asm-generic/statfs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/sembuf.h -o ../..//usr/include//asm-generic/sembuf.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/bitsperlong.h -o ../..//usr/include//asm-generic/bitsperlong.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/int-ll64.h -o ../..//usr/include//asm-generic/int-ll64.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/errno.h -o ../..//usr/include//asm-generic/errno.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/socket.h -o ../..//usr/include//asm-generic/socket.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/mman-common.h -o ../..//usr/include//asm-generic/mman-common.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/kvm_para.h -o ../..//usr/include//asm-generic/kvm_para.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/int-l64.h -o ../..//usr/include//asm-generic/int-l64.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/signal.h -o ../..//usr/include//asm-generic/signal.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/ipcbuf.h -o ../..//usr/include//asm-generic/ipcbuf.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/posix_types.h -o ../..//usr/include//asm-generic/posix_types.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/types.h -o ../..//usr/include//asm-generic/types.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/termios.h -o ../..//usr/include//asm-generic/termios.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/signal-defs.h -o ../..//usr/include//asm-generic/signal-defs.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/siginfo.h -o ../..//usr/include//asm-generic/siginfo.o
gcc -I../..//usr/include/ --include=../..//usr/include/linux/posix_types.h --include=../..//usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../..//usr/include//asm-generic/shmparam.h -o ../..//usr/include//asm-generic/shmparam.o
make: Target 'all' not remade because of errors.

--------------855D4F0426F7198062015A98--
