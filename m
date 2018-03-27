Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuPALVfTlDDv4SUhywElKPOkC1xnYGi981kLs55gKYyHJmrg1vZob8vaPYjrURreaHkrHJs
ARC-Seal: i=1; a=rsa-sha256; t=1522120537; cv=none;
        d=google.com; s=arc-20160816;
        b=OijxiEOtKWgCW++3urGuUg3wtBlgM3L8R4M10ItIsKNi/8320Lpdw+fMprnLeK16a1
         mI375ZylVrpbOFWMucgotX2q3oZayAvHp2DyphOUio9RPLnEUj2XkVbs6YKxHqOtSfSS
         GpvQr1L1r2nWIY+mtAzwJFqW3y4muWJgRLBwULyBjIz5nNI9dQedlWbTb9yVZzw/7kzl
         IyRk0ZFhtdtiTDc8v82pC9G+njSQc7c3nG/kGrSHwS1wYSRji8hf3JPWXZQ22lhNBoFT
         sljKby7+/Mnt3LpoTPJPhw/DAJxLPlzg3yPEzqgqejCStlY5WoSmbFMgMlxvpIEbfEW1
         MW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=d5uzlIbLDAXlEknQqENhXkdXvUaTD/YzkP0+7DoNdew=;
        b=KQYCfOiU+HzFPoqx/OmG68IzXbhCjAatTiNpr2VTeMo6RB7kklkE4f3O3BKSdDxP8Y
         BSB9mAHy347p0XpC4969ySDWpTjsSM9/9jk9f+k4L/dAFNXvTdbzc9GPLNaNpv9crWE8
         9TWG84bZdIzkzTtMNGeUOOdRzp/cftOGrvAYI25U0zQFgVAk/HILjS6u5tVuMyt91ENm
         JYm3X1GMLGjePIEV4iuWloqRO5ojuGOid3y+o0DqmQkwSWgWiOL17PCTUv9EH1w4sqQN
         2UsXjN7Kf2mBcrd0TH1igYPvW9EggBbkXQ0xj5cg4LmHQzA5HX/HVdRqu60U1E4QU/0g
         AgOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeC0DPg (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Mar 2018 23:15:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:32001 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbeC0DPf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Mar 2018 23:15:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,366,1517904000";
   d="scan'208";a="38377473"
Date: Tue, 27 Mar 2018 11:06:13 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Du, Changbin" <changbin.du@intel.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests/bpf: fix compiling errors
Message-ID: <20180327030613.hkp7hox3g4prnbsg@intel.com>
References: <1522056208-4004-1-git-send-email-changbin.du@intel.com>
 <1522056208-4004-5-git-send-email-changbin.du@intel.com>
 <20180326145511.lzoi6wja6iht5lvq@ast-mbp.dhcp.thefacebook.com>
 <20180327022010.57u6rn73inbkrycn@intel.com>
 <20180327030229.txifuth2qmnjo3hy@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327030229.txifuth2qmnjo3hy@ast-mbp>
User-Agent: NeoMutt/20171027-42-ad8712
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595992264368569998?=
X-GMAIL-MSGID: =?utf-8?q?1596059064210264657?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 08:02:30PM -0700, Alexei Starovoitov wrote:
> On Tue, Mar 27, 2018 at 10:20:10AM +0800, Du, Changbin wrote:
> > On Mon, Mar 26, 2018 at 07:55:13AM -0700, Alexei Starovoitov wrote:
> > > On Mon, Mar 26, 2018 at 05:23:28PM +0800, changbin.du@intel.com wrote:
> > > > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/Makefile | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > > > index 5c43c18..dc0fdc8 100644
> > > > --- a/tools/testing/selftests/bpf/Makefile
> > > > +++ b/tools/testing/selftests/bpf/Makefile
> > > > @@ -10,7 +10,8 @@ ifneq ($(wildcard $(GENHDR)),)
> > > >    GENFLAGS := -DHAVE_GENHDR
> > > >  endif
> > > >  
> > > > -CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(GENDIR) $(GENFLAGS) -I../../../include
> > > > +CFLAGS += -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(GENDIR) $(GENFLAGS) \
> > > > +	  -I../../../include -I../../../../usr/include
> > > >  LDLIBS += -lcap -lelf -lrt -lpthread
> > > >  
> > > >  # Order correspond to 'make run_tests' order
> > > > @@ -62,7 +63,7 @@ else
> > > >    CPU ?= generic
> > > >  endif
> > > >  
> > > > -CLANG_FLAGS = -I. -I./include/uapi -I../../../include/uapi \
> > > > +CLANG_FLAGS = -I. -I./include/uapi -I../../../include/uapi -I../../../../usr/include \
> > > >  	      -Wno-compare-distinct-pointer-types
> > > 
> > > Nack.
> > > I suspect that will break the build for everyone else who's doing it in the directory
> > > itself instead of the outer one.
> > >
> > 
> > This one? But I didn't see any problem.
> 
> because the build was lucky and additional path ../../../../usr/include didn't point
> to a valid dir?
I am sorry but I don't understand why you mean *lucky*. Of cause, the path is valid.

> Please test with in-source and out-of-source builds.
> 
agree.

-- 
Thanks,
Changbin Du
