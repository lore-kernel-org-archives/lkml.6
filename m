Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvt2tMgYasFLtEbBr1/jq0FV4O7o/1AFoqizklQRVqzwjVySO+4IFBStDwZnBNMTT4RePcG
ARC-Seal: i=1; a=rsa-sha256; t=1522141767; cv=none;
        d=google.com; s=arc-20160816;
        b=MCNSuPN5gU6GDMr02pi1WDhbS5yxCTU/a1PrQahwt13VQQ/lpLmNk97s+JbbdnRlRj
         NbRzJWfLm0JR7s9eb2t840YZuUJZIRvFm9tFVU8QYHI7Pr8Hxro7eAtPqOmeI8UMlNos
         OMIptLBUWRLBkcLMMy3ZqoJN9U5nGArkvhDT2pTFsDXFPDlPOVQTKUpcod1UP3imJ91b
         rtt5+IYt2JEtE/mPYQ/sUYywXIuYay6o3mVhBWd+GOJDkDeOdXPSvLvEp6PxdqqPs9r0
         zAQXdyMpCh9FBSYvGmTDg0AkGf9ks5tJW/sDUKqDBd2GXQl4sgksgO3a3WKKn2/Ef/Wr
         xEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=xMRK9x4yJhA3LMRgn17z0um9+QpE/Os0Q7xZwkmdk74=;
        b=MbMJpWUvI/xVnlu9hzhvclO3WzEXHJxbU7EyhEUs6LkZX70+oXlyg6Eev3paAsx8gd
         w9117gkbOW/jyytG0njbtKcnD90f2QQxbgQ5YH4d5gGl2MS0OUZPFMy/MTVUwMCCub3V
         whrADEwed2BQXCoW6j00xO2oVMbGP8iF7fIRlkae4GXmMju+xE1fzfX2GOeRi3bEUCpn
         HoCVYv6GDh6seI22DMFwAgfBLkS+kQJ+2AQ1J07wC/R7r2n/piV0PP09LKEOrGv4Mefh
         L8ssjsQJEPYPVEPieRxQSIM/RZy3o5W/pv7BTi43hFJQtKIQ678ktJJ/w6w6L33DKaW/
         RsrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeC0JJ0 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Mar 2018 05:09:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:1064 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750918AbeC0JJZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Mar 2018 05:09:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,366,1517904000";
   d="scan'208";a="29207506"
Date: Tue, 27 Mar 2018 17:00:00 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: "Du, Changbin" <changbin.du@intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests/bpf: fix compiling errors
Message-ID: <20180327090000.fou6oyvr663lbyuq@intel.com>
References: <1522056208-4004-1-git-send-email-changbin.du@intel.com>
 <1522056208-4004-5-git-send-email-changbin.du@intel.com>
 <20180326145511.lzoi6wja6iht5lvq@ast-mbp.dhcp.thefacebook.com>
 <20180327022010.57u6rn73inbkrycn@intel.com>
 <20180327030229.txifuth2qmnjo3hy@ast-mbp>
 <20180327030613.hkp7hox3g4prnbsg@intel.com>
 <2dd7c04a-eb10-e730-148e-3b04a18e9b44@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dd7c04a-eb10-e730-148e-3b04a18e9b44@iogearbox.net>
User-Agent: NeoMutt/20180323-6-5ca392
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595992264368569998?=
X-GMAIL-MSGID: =?utf-8?q?1596081326125951473?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 10:52:57AM +0200, Daniel Borkmann wrote:
> On 03/27/2018 05:06 AM, Du, Changbin wrote:
> > On Mon, Mar 26, 2018 at 08:02:30PM -0700, Alexei Starovoitov wrote:
> >> On Tue, Mar 27, 2018 at 10:20:10AM +0800, Du, Changbin wrote:
> >>> On Mon, Mar 26, 2018 at 07:55:13AM -0700, Alexei Starovoitov wrote:
> >>>> On Mon, Mar 26, 2018 at 05:23:28PM +0800, changbin.du@intel.com wrote:
> >>>>> Signed-off-by: Changbin Du <changbin.du@intel.com>
> >>>>> ---
> >>>>>  tools/testing/selftests/bpf/Makefile | 5 +++--
> >>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> >>>>> index 5c43c18..dc0fdc8 100644
> >>>>> --- a/tools/testing/selftests/bpf/Makefile
> >>>>> +++ b/tools/testing/selftests/bpf/Makefile
> >>>>> @@ -10,7 +10,8 @@ ifneq ($(wildcard $(GENHDR)),)
> >>>>>    GENFLAGS := -DHAVE_GENHDR
> >>>>>  endif
> >>>>>  
> >>>>> -CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(GENDIR) $(GENFLAGS) -I../../../include
> >>>>> +CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(GENDIR) $(GENFLAGS) \
> >>>>> +	  -I../../../include -I../../../../usr/include
> >>>>>  LDLIBS += -lcap -lelf -lrt -lpthread
> >>>>>  
> >>>>>  # Order correspond to 'make run_tests' order
> >>>>> @@ -62,7 +63,7 @@ else
> >>>>>    CPU ?= generic
> >>>>>  endif
> >>>>>  
> >>>>> -CLANG_FLAGS = -I. -I./include/uapi -I../../../include/uapi \
> >>>>> +CLANG_FLAGS = -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include \
> >>>>>  	      -Wno-compare-distinct-pointer-types
> >>>>
> >>>> Nack.
> >>>> I suspect that will break the build for everyone else who's doing it in the directory
> >>>> itself instead of the outer one.
> >>>
> >>> This one? But I didn't see any problem.
> >>
> >> because the build was lucky and additional path ../../../../usr/include didn't point
> >> to a valid dir?
> 
> Agree.
> 
> > I am sorry but I don't understand why you mean *lucky*. Of cause, the path is valid.
> 
> The problem is that this suddenly requires users to do a 'make headers_install' in
> order to populate usr/include/ directory in the first place. While it's annoying
> enough for BPF samples where this is needed, I absolutely don't want to introduce
> this for BPF kselftests. It's the wrong approach. Besides, in tools infra, there is
> a tools/arch/*/include/uapi/asm/bitsperlong.h header copy already, so we really need
> to use that instead. Please adapt your patch accordingly and respin. Please also Cc
> us and netdev@vger.kernel.org for BPF kselftests changes.
> 
> Thanks,
> Daniel
Thanks for the explanation. So we expect that tools/arch/*/include is in the searching list, right?
The corrent makefile seems not. How do you get this built?

changbin@gvt-dell-host:~/work/linux/tools/testing/selftests/bpf$ make -p
[...]
clang -I. -I./include/uapi -I../../../include/uapi -Wno-compare-distinct-pointer-types \
         -O2 -target bpf -emit-llvm -c test_pkt_access.c -o - |      \
llc -march=bpf -mcpu=generic -filetype=obj -o /home/changbin/work/linux/tools/testing/selftests/bpf/test_pkt_access.o
In file included from test_pkt_access.c:9:
In file included from ../../../include/uapi/linux/bpf.h:11:
In file included from ./include/uapi/linux/types.h:5:
/usr/include/asm-generic/int-ll64.h:11:10: fatal error: 'asm/bitsperlong.h' file not found
#include <asm/bitsperlong.h>


-- 
Thanks,
Changbin Du
