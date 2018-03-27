Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsJ2s6L+NBObAWDxIEW/mN0nvpSjMJJwybb7JZZwNh/oI1i8vRYwzTY48MCwXQz7Y42XNTm
ARC-Seal: i=1; a=rsa-sha256; t=1522118558; cv=none;
        d=google.com; s=arc-20160816;
        b=npWMLQKfZGoHmKFKL1ixSlBrZzvjbpEBO2QGH7ot+64VoQCf7+uW/g86G1o9IRTw3Y
         iZbwMT29adD2MPWSCxUIDHSC+oc+aHmfepy97WiDivkP1IJZEzMOH8M5Sh76Y28tzoje
         qBYdlFXKrkttnr0FNX6Sq9jy85wH9iAno7rOUUl1Fw6UUOhzUuJ42yliVQVBTFdoqgd+
         aGlGpppRaJ8d6BJiBukML8OMyUnmgQqZxYNttyh3OteZhuU4Y8lFEXo086W4v3Bb0Scd
         m/XhkkNMamE1j/s5VO0aqNpnQhgLJAy0sPjR61AqRNsTRzfRLgujma2BvadjrMB57+d9
         aWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=ipTTgGvADmLHOwe5R2VQdz+K1zcLdrGnmsHhzUwGW+4=;
        b=NNIhRsfsd8eIkXTTVpwvtlaXvCZSJzBcZbJ3u7xhWZg4BTjhFriBgZFr8jj75pp816
         xHCNWOEhLfbSS0UK63nrx+jsq8NT2sQ+a7fYFCx2b9UgyhFgGvHO1ZjmrtB9W560Ttt9
         G1nSV20roPYKMiQxxCqiSGDGAizuO1MTtznNFR+hY/TuHwi9me9OiegxNguh5YLRsPjt
         9IOF+DbvF8/k2xd1ejvls1ulHtZauevfkNTB9xHd7iDyyx6uKanOfbhCcC8WKj8Txx8Y
         uKUfjRqu2/pXKm+OKxpyMKka7UQiKFxfXSu0wuQFKTk58276235gtOMc3JlXcaO3RfuI
         g3Cw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeC0Cmi (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Mar 2018 22:42:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:49056 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752206AbeC0Cmh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Mar 2018 22:42:37 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,366,1517904000";
   d="scan'208";a="27237409"
Date: Tue, 27 Mar 2018 10:33:16 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: changbin.du@intel.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests/bpf: fix compiling errors
Message-ID: <20180327023315.zjxrxfmhuzfqqpos@intel.com>
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
X-GMAIL-MSGID: =?utf-8?q?1596056990339362574?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Starovoitov,

This one does have the issue you mentioned.
[PATCH 2/4] selftests/gpio: fix paths in Makefile

And can be fixed by:

--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0

+OUTPUT ?= $(shell pwd)
 TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh $(BINARIES)
 BINARIES := gpio-mockup-chardev
@@ -24,7 +25,7 @@ LDLIBS += -lmount -I/usr/include/libmount
 $(BINARIES): gpio-utils.o ../../../../usr/include/linux/gpio.h

 gpio-utils.o:
-       make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
+       make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) OUTPUT=$(OUTPUT)/ -C ../../../gpio

 ../../../../usr/include/linux/gpio.h:


I will update it later.

On Mon, Mar 26, 2018 at 07:55:13AM -0700, Alexei Starovoitov wrote:
> On Mon, Mar 26, 2018 at 05:23:28PM +0800, changbin.du@intel.com wrote:
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > This patch fixed below errors of missing head files.
> > 
> > tools/testing/selftests$ make
> > ...
> > clang -I. -I./include/uapi -I../../../include/uapi -Wno-compare-distinct-pointer-types \
> > 	 -O2 -target bpf -emit-llvm -c test_pkt_access.c -o - |      \
> > llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf//test_pkt_access.o
> > In file included from test_pkt_access.c:9:
> > In file included from ../../../include/uapi/linux/bpf.h:11:
> > In file included from ./include/uapi/linux/types.h:5:
> > /usr/include/asm-generic/int-ll64.h:11:10: fatal error: 'asm/bitsperlong.h' file not found
> >  #include <asm/bitsperlong.h>
> >          ^
> > 1 error generated.
> > clang -I. -I./include/uapi -I../../../include/uapi -Wno-compare-distinct-pointer-types \
> > 	 -O2 -target bpf -emit-llvm -c test_xdp.c -o - |      \
> > llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf//test_xdp.o
> > In file included from test_xdp.c:9:
> > In file included from ../../../include/uapi/linux/bpf.h:11:
> > In file included from ./include/uapi/linux/types.h:5:
> > /usr/include/asm-generic/int-ll64.h:11:10: fatal error: 'asm/bitsperlong.h' file not found
> >  #include <asm/bitsperlong.h>
> >          ^
> > 1 error generated.
> > clang -I. -I./include/uapi -I../../../include/uapi -Wno-compare-distinct-pointer-types \
> > 	 -O2 -target bpf -emit-llvm -c test_l4lb.c -o - |      \
> > llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf//test_l4lb.o
> > In file included from test_l4lb.c:10:
> > In file included from /usr/include/linux/pkt_cls.h:4:
> > In file included from ./include/uapi/linux/types.h:5:
> > /usr/include/asm-generic/int-ll64.h:11:10: fatal error: 'asm/bitsperlong.h' file not found
> >  #include <asm/bitsperlong.h>
> >          ^
> > 1 error generated.
> > clang -I. -I./include/uapi -I../../../include/uapi -Wno-compare-distinct-pointer-types \
> > 	 -O2 -target bpf -emit-llvm -c test_tcp_estats.c -o - |      \
> > llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf//test_tcp_estats.o
> > In file included from test_tcp_estats.c:35:
> > In file included from ../../../include/uapi/linux/bpf.h:11:
> > In file included from ./include/uapi/linux/types.h:5:
> > /usr/include/asm-generic/int-ll64.h:11:10: fatal error: 'asm/bitsperlong.h' file not found
> >  #include <asm/bitsperlong.h>
> > ...
> > 
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

-- 
Thanks,
Changbin Du
