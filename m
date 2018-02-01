Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AH8x224Godz1i/RF1jIH2Bzqlba/+TK5Bj+Llj8vCp6L7yN06K5yl4tH8L2VZEeP5XGM1bgsaJjB
ARC-Seal: i=1; a=rsa-sha256; t=1517522976; cv=none;
        d=google.com; s=arc-20160816;
        b=li/RKpYPxO1slRpf4PrU+1JT6eWPFTYNBRHY9/h055r2khTHtyEz+2kqsXykqOgNxH
         iwL2MbIqoJwslb2quA6Pu82oq9WnSX1OF/MDYGa19H3YH6iQhvlTFsL4ftT+AX2O3Fzs
         R2Uaob7nV+wdOp5xHxd06Qnfq0K82gHYHZwErT7AeT1qu96H5wTtTR6+f2trM+WueJyO
         8YiaIu+l1hWBHKvgk48Uw9YrDdoiE+b838HFIPWALNaOT7+phfKQYpTIHM4XZjLCFgCU
         bpBGvhLf5I/aEUN9E0JjSCTDpJMV8HX8MvpvfPyTYy+wvCOlakUAaOa4Mqct6jNx4b+z
         YaNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=0mfSGWvejqpyaZf2h9JSsA/zQj8MuutGdLljsWd7+z8=;
        b=LrVyB5X5wuOjJ907wwJeKrH2ZJToh/TeRWMWyY3QjMDLx2bo7MphCE8r6dpVqZJ9XO
         wn8nRQIqOUW0C/wIXrsNY2BOXx4uj81BsOZkYtV2x6U3uvTWDbgvyBxRXL/HnwNfirtO
         ud088G7yEI3P7H8u0L/CkUGxw5G8aiGfk42iRzgVh3yfKUZJ8nLhFCsPQM/fJHKM94wN
         qATch0CQ3mr4mWFzw5MdrJ1Es86hfox71Gx0qtMDNX8gBMPqT4IBBi9K3xDwsz9Y5Q/B
         5B8J0Lj9aRJAYQdF0GxzLZEcGajzb1VnNA6bwlTL0t9jDxz7GvTeWtRIZRD+tOdtJ97m
         7AEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.141 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.141 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3867:3868:3870:3871:3872:3874:4321:4605:5007:6117:6119:6742:6743:7558:7576:7903:8531:10004:10400:10848:10967:11026:11232:11473:11657:11658:11914:12043:12295:12438:12679:12740:12760:12895:13161:13229:13255:13439:14096:14097:14181:14659:14721:21060:21080:21451:21611:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bells67_8d6a8801a3916
X-Filterd-Recvd-Size: 4281
Message-ID: <1517522970.7489.72.camel@perches.com>
Subject: Re: [PATCH v11 03/10] sparc64: Add support for ADI register fields,
 ASIs and traps
From: Joe Perches <joe@perches.com>
To: David Miller <davem@davemloft.net>, Sam Ravnborg <sam@ravnborg.org>
Cc: khalid.aziz@oracle.com, dave.hansen@linux.intel.com, mhocko@suse.com,
 mingo@kernel.org, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
  vijay.ac.kumar@oracle.com, kirill.shutemov@linux.intel.com,
 nitin.m.gupta@oracle.com, tom.hromatka@oracle.com, allen.pais@oracle.com,
 rob.gardner@oracle.com, david.j.aldridge@oracle.com, babu.moger@oracle.com,
  bob.picco@oracle.com, steven.sistare@oracle.com,
 pasha.tatashin@oracle.com,  vegard.nossum@oracle.com, pombredanne@nexb.com,
 jane.chu@oracle.com,  anthony.yznaga@oracle.com,
 sparclinux@vger.kernel.org,  linux-kernel@vger.kernel.org,
 khalid@gonehiking.org
Date: Thu, 01 Feb 2018 14:09:30 -0800
In-Reply-To: <20180201.153903.1719756519690647679.davem@davemloft.net>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
	 <e4ad304a57afeff9e3bd6f1fc57a927c943506b0.1517497017.git.khalid.aziz@oracle.com>
	 <1517517122.7489.47.camel@perches.com>
	 <20180201.153903.1719756519690647679.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591222601953119188?=
X-GMAIL-MSGID: =?utf-8?q?1591238172206587065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-02-01 at 15:39 -0500, David Miller wrote:
> From: Joe Perches <joe@perches.com>
> Date: Thu, 01 Feb 2018 12:32:02 -0800
> 
> >> diff --git a/arch/sparc/include/asm/ttable.h b/arch/sparc/include/asm/ttable.h
> > []
> >> @@ -219,6 +219,16 @@
> >>      nop;                                            \
> >>      nop;
> >>  
> >> +#define SUN4V_MCD_PRECISE                           \
> >> +    ldxa    [%g0] ASI_SCRATCHPAD, %g2;              \
> >> +    ldx     [%g2 + HV_FAULT_D_ADDR_OFFSET], %g4;    \
> >> +    ldx     [%g2 + HV_FAULT_D_CTX_OFFSET], %g5;     \
> >> +    ba,pt   %xcc, etrap;                            \
> >> +     rd     %pc, %g7;                               \
> >> +    ba,pt   %xcc, sun4v_mcd_detect_precise;         \
> >> +     nop;                                           \
> >> +    nop;
> > 
> > and here and elsewhere.
> 
> Joe, this is intentional in Sparc assembler.
> 
> Branches on sparc have delay slots, and this is annotated by indenting
> the delay slot instruction one space more than the branch preceeding
> it.

OK, that is new to me and seems a sensible convention.

btw:

There seem to be only a few instances where that
convention is not followed in arch/sparc/...

(maybe some missing or false positives below)

$ git ls-files arch/sparc/ | \
  xargs grep-2.5.4 -P -n '^([ \t]+)b\w+,p.*\n\1[^ ]\S' | \
  perl -p -e 's/(:\d+:)/\1\n/'
arch/sparc/include/asm/tsb.h:168:
	brz,pn		REG1, FAIL_LABEL; \
	sethi		%uhi(_PAGE_PUD_HUGE), REG2; \
arch/sparc/include/asm/ttable.h:281:
	ba,pt	%xcc, etrap_save;			\
	wrpr	%g1, %cwp;				\
arch/sparc/kernel/head_64.S:472:
	bne,pn	%icc, 49f
	add	%g7, 1, %g7
arch/sparc/kernel/head_64.S:474:
	bne,pt	%xcc, 41b
	add	%g1, 1, %g1
arch/sparc/kernel/rtrap_64.S:72:
		ba,pt			%xcc, rtrap_no_irq_enable
		nop
arch/sparc/kernel/rtrap_64.S:161:
		brz,pt			%l3, 1f
		mov			%g6, %l2
arch/sparc/lib/GENmemcpy.S:100:
	bne,pt		%XCC, 1b
	add		%o0, 1, %o0
arch/sparc/lib/M7memcpy.S:896:
	bgu,pt	%xcc, .Lsmallnotalign4	! loop til 3 or fewer bytes remain
	EX_ST(STORE(stb, %o3, %o0-1), memcpy_retl_o2_plus_4)
arch/sparc/lib/M7memcpy.S:902:
	bz,pt	%xcc, .Lsmallx
	EX_ST(STORE(stb, %o3, %o0), memcpy_retl_o2_plus_1)	! store one byte
arch/sparc/lib/M7memcpy.S:905:
	bz,pt	%xcc, .Lsmallx
	EX_ST(STORE(stb, %o3, %o0+1), memcpy_retl_o2_plus_1)! store second byte
arch/sparc/lib/NG2memcpy.S:299:
	bne,pt		%XCC, 1b
	add		%o0, 1, %o0
arch/sparc/lib/NG4fls.S:23:
	brz,pn	%o0, 1f
	LZCNT_O0_G2	!lzcnt	%o0, %g2
arch/sparc/lib/NGmemcpy.S:216:
	bne,pt		%XCC, 1b
	add		%o0, 1, %o0
arch/sparc/lib/csum_copy.S:103:
	ba,pt		%xcc, 1f
	LOAD(prefetch, %o0 + 0x140, #n_reads)
