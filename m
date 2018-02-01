Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AH8x2259MMbXNmqZC2Z4nFX3AYWsjJVepQV8x7e8dFdOjS0J6gja3s7cxRoO1VToTt8o9fmWWw5r
ARC-Seal: i=1; a=rsa-sha256; t=1517517128; cv=none;
        d=google.com; s=arc-20160816;
        b=DodsIHKPH/fRduii+nlrv0PCCtvNca6A85Ei31lMSYfcR80WZ00QenRodU6FDj8AMv
         celX8nZ2jLpcMTOmXt41WUdGIh5b7ZLTCs3hpCcoMxw9Vg5TrE3taPHtJwC1MdPdUAN1
         dMeg9p/qysZIEnrSzJ2V9bCdVyInw8xVPDHNqAVmUcMNuovSX9f+fOgeCX8+QOWdoYPU
         wEdaMz6bHvJAHdtcp6OFrLOuV0T3bbJby+tUCZnlgU2xm1tbAFuCShePLWq/ZjvvGf/h
         H35q8dQtc17Gz4U/rE4f52Qw35hruTcoTQuHIQcYJErWO81hJDF0qmP9eop+6ECAEeQR
         7Keg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=iZm1EB+dbt+57fKiQsdmV0YESAd3wviOA94REWVKJTY=;
        b=Uj+2aP7BMxRRJrjSJ9Og5379nxqoidiK5kLaeA8z2AeA3PLOq3wC6cFSkmQThw5UoJ
         Yhp59nIIUlaDMZBoYMlzHe/MVOrYD7Nef9IQpkE90rmAahrfoepmcRNgNtnU8I9gMXbv
         bltH9qnAbVozZQbOg83oxoG4k1+Lc5pZIDnlvEyIybZBfAJHm24GHHBM4yVeIQtSO+oA
         71MU3bRndPK/VhcJduHl4pPtV8ML+84ICpsDHGI80EfdrBcC0Hd3KsJg7zMH4yAhWYVr
         kJ7KDO8zqDHBujM+iBE/TN2X2or/tUaUcYJ54fa3R558WkRYLmWDL5XanOlhdri1H/+M
         iMPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.164 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.164 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3867:3868:3870:3871:3872:4250:4321:4605:5007:6119:6742:6743:8660:10004:10400:10848:11026:11473:11657:11658:11914:12043:12438:12555:12679:12740:12760:12895:12986:13069:13148:13161:13229:13230:13255:13311:13357:13439:14659:14721:21080:21451:21611:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: tub56_12039a317fb29
X-Filterd-Recvd-Size: 2966
Message-ID: <1517517122.7489.47.camel@perches.com>
Subject: Re: [PATCH v11 03/10] sparc64: Add support for ADI register fields,
 ASIs and traps
From: Joe Perches <joe@perches.com>
To: Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net,
	dave.hansen@linux.intel.com
Cc: mhocko@suse.com, mingo@kernel.org, gregkh@linuxfoundation.org,
 glx@linutronix.de, kstewart@linuxfoundation.org, vijay.ac.kumar@oracle.com,
  kirill.shutemov@linux.intel.com, nitin.m.gupta@oracle.com,
 tom.hromatka@oracle.com, allen.pais@oracle.com, rob.gardner@oracle.com,
 david.j.aldridge@oracle.com, babu.moger@oracle.com, bob.picco@oracle.com,
 steven.sistare@oracle.com, pasha.tatashin@oracle.com,
 vegard.nossum@oracle.com,  pombredanne@nexb.com, jane.chu@oracle.com,
 anthony.yznaga@oracle.com,  sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
Date: Thu, 01 Feb 2018 12:32:02 -0800
In-Reply-To: <e4ad304a57afeff9e3bd6f1fc57a927c943506b0.1517497017.git.khalid.aziz@oracle.com>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
	 <e4ad304a57afeff9e3bd6f1fc57a927c943506b0.1517497017.git.khalid.aziz@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591222601953119188?=
X-GMAIL-MSGID: =?utf-8?q?1591232040322679268?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-02-01 at 11:01 -0700, Khalid Aziz wrote:
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
[]
> @@ -164,6 +164,8 @@ bool kern_addr_valid(unsigned long addr);
>  #define _PAGE_E_4V	  _AC(0x0000000000000800,UL) /* side-Effect          */
>  #define _PAGE_CP_4V	  _AC(0x0000000000000400,UL) /* Cacheable in P-Cache */
>  #define _PAGE_CV_4V	  _AC(0x0000000000000200,UL) /* Cacheable in V-Cache */
> +/* Bit 9 is used to enable MCD corruption detection instead on M7 */
> +#define _PAGE_MCD_4V      _AC(0x0000000000000200,UL) /* Memory Corruption    */

trivia:

There are some whitespace alignment issues here

> diff --git a/arch/sparc/include/asm/ttable.h b/arch/sparc/include/asm/ttable.h
[]
> @@ -219,6 +219,16 @@
>  	nop;						\
>  	nop;
>  
> +#define SUN4V_MCD_PRECISE				\
> +	ldxa	[%g0] ASI_SCRATCHPAD, %g2;		\
> +	ldx	[%g2 + HV_FAULT_D_ADDR_OFFSET], %g4;	\
> +	ldx	[%g2 + HV_FAULT_D_CTX_OFFSET], %g5;	\
> +	ba,pt	%xcc, etrap;				\
> +	 rd	%pc, %g7;				\
> +	ba,pt	%xcc, sun4v_mcd_detect_precise;		\
> +	 nop;						\
> +	nop;

and here and elsewhere.

It would be nicer to make all these use
similar indentation.

> diff --git a/arch/sparc/kernel/sun4v_mcd.S b/arch/sparc/kernel/sun4v_mcd.S
[]
> +sun4v_mcd_detect_precise:
> +	mov	%l4, %o1
> +	mov 	%l5, %o2
> +	call	sun4v_mem_corrupt_detect_precise
> +	 add	%sp, PTREGS_OFF, %o0
> +	ba,a,pt	%xcc, rtrap
> +	 nop

etc...
