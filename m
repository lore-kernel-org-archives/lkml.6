Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELu4d232gj+AkGLNSxTsA3w5nEI6f/SSepTfd0moKYcEVGnnTvXpaV39Qt/kLXc/MJ+eAFOp
ARC-Seal: i=1; a=rsa-sha256; t=1522119772; cv=none;
        d=google.com; s=arc-20160816;
        b=Dq1wqbrqHcdgFsmRKnzkMWuQocHz2IpsR0gWW/TikpYLpSreQj6bsUPOb8WZd3bqpw
         Z8bbXNRkVQOJOMY258PrUXNKuwRDvgT4JY/+txWqfpBs44fxXLkwfrKCwXWILP2t88xa
         zR6B7YK66qiUupmAGcohzDaBgZgT0kXapq5Nq3Olv5wVb7c5Yy/QAVi7H+IvmKPYOJfo
         UU+672YbSkSCQFSTQXD9tk7aY+88QxBkPqGa4ceHYwLIJlfnmeDVGrb2reZzq+RirZSS
         FVqdBNot8qH2bKMcl1t39Hjomp8pzbrb7uS+GqNa0YRD0J3iouWcVAOjsWC/9oRH86Fq
         JQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=2t0wJSFEpTdz0WQxVJWocR/EfdKScmEQBhb1ZyybtcI=;
        b=y6jO44KXbzp6ClvloegO95O4VdU+274zu6O7zXnRhkbFuoeyYbwBTvLhtfTmFp7Mvk
         QQJn9UQgKOHgh1jSMf8FBqFttLguLKWmdtPTHHQzYS7M6uw8WGMTZNhcKOgzarph/lRN
         ejasZlRYl4OkP7n0ljBZb3QyN5W0XbWqoIjmwxJxCwQxeBadgDhCxU0L0C00hdWvm/QE
         KPxWpVkEbKlh+62tipKUpIBOEclRXKrYHuPDf9ebn8HNyM/8Ye6Af/rNZ8ej7u8UUIZ8
         QEA0/d2MGb/lo4ZFcq+ixoqYp534yQqRKghgJPu1J0TH1tw3OULkmYdCHTPcwjtRGY0a
         ZOTw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=f6G0L+E7;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=f6G0L+E7;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeC0DCf (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Mar 2018 23:02:35 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39960 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752571AbeC0DCe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Mar 2018 23:02:34 -0400
Date: Mon, 26 Mar 2018 20:02:30 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests/bpf: fix compiling errors
Message-ID: <20180327030229.txifuth2qmnjo3hy@ast-mbp>
References: <1522056208-4004-1-git-send-email-changbin.du@intel.com>
 <1522056208-4004-5-git-send-email-changbin.du@intel.com>
 <20180326145511.lzoi6wja6iht5lvq@ast-mbp.dhcp.thefacebook.com>
 <20180327022010.57u6rn73inbkrycn@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327022010.57u6rn73inbkrycn@intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595992264368569998?=
X-GMAIL-MSGID: =?utf-8?q?1596058262559151227?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 10:20:10AM +0800, Du, Changbin wrote:
> On Mon, Mar 26, 2018 at 07:55:13AM -0700, Alexei Starovoitov wrote:
> > On Mon, Mar 26, 2018 at 05:23:28PM +0800, changbin.du@intel.com wrote:
> > > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > > ---
> > >  tools/testing/selftests/bpf/Makefile | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > > index 5c43c18..dc0fdc8 100644
> > > --- a/tools/testing/selftests/bpf/Makefile
> > > +++ b/tools/testing/selftests/bpf/Makefile
> > > @@ -10,7 +10,8 @@ ifneq ($(wildcard $(GENHDR)),)
> > >    GENFLAGS := -DHAVE_GENHDR
> > >  endif
> > >  
> > > -CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(GENDIR) $(GENFLAGS) -I../../../include
> > > +CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(GENDIR) $(GENFLAGS) \
> > > +	  -I../../../include -I../../../../usr/include
> > >  LDLIBS += -lcap -lelf -lrt -lpthread
> > >  
> > >  # Order correspond to 'make run_tests' order
> > > @@ -62,7 +63,7 @@ else
> > >    CPU ?= generic
> > >  endif
> > >  
> > > -CLANG_FLAGS = -I. -I./include/uapi -I../../../include/uapi \
> > > +CLANG_FLAGS = -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include \
> > >  	      -Wno-compare-distinct-pointer-types
> > 
> > Nack.
> > I suspect that will break the build for everyone else who's doing it in the directory
> > itself instead of the outer one.
> >
> 
> This one? But I didn't see any problem.

because the build was lucky and additional path ../../../../usr/include didn't point
to a valid dir?
Please test with in-source and out-of-source builds.

