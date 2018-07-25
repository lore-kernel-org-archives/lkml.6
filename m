Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451B2C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E4920843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E4920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbeGYVTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:19:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729529AbeGYVTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:19:55 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PJruKa072515
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:06:41 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ketx2w37s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:06:41 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Wed, 25 Jul 2018 14:06:40 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Jul 2018 14:06:35 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6PK6YjJ459106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 13:06:34 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAE84C6055;
        Wed, 25 Jul 2018 14:06:34 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4643CC6065;
        Wed, 25 Jul 2018 14:06:34 -0600 (MDT)
Received: from localhost (unknown [9.85.190.157])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Jul 2018 14:06:33 -0600 (MDT)
Date:   Wed, 25 Jul 2018 17:06:31 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     LEROY Christophe <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org, "Tobin C . Harding" <me@tobin.cc>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Cyril Bur <cyrilbur@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        "Alastair D'Silva" <alastair@d-silva.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] powerpc/traps: Print signal name for unhandled
 signals
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <20180724192720.32417-7-muriloo@linux.ibm.com>
 <20180725174927.Horde.Sfg4oyTmcaLgHIJr3Gf-oQ1@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180725174927.Horde.Sfg4oyTmcaLgHIJr3Gf-oQ1@messagerie.si.c-s.fr>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-TM-AS-GCONF: 00
x-cbid: 18072520-0012-0000-0000-000016913CF2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009426; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01066064; UDB=6.00547676; IPR=6.00843924;
 MB=3.00022322; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-25 20:06:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072520-0013-0000-0000-000053CD0281
Message-Id: <20180725200631.GC23643@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christophe.

On Wed, Jul 25, 2018 at 05:49:27PM +0200, LEROY Christophe wrote:
> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :
>
> > This adds a human-readable name in the unhandled signal message.
> >
> > Before this patch, a page fault looked like:
> >
> >     Jul 11 16:04:11 localhost kernel: pandafault[6303]: unhandled signal
> > 11 at 00000000100007d0 nip 000000001000061c lr 00007fff93c55100 code 2
> > in pandafault[10000000+10000]
> >
> > After this patch, a page fault looks like:
> >
> >     Jul 11 18:14:48 localhost kernel: pandafault[6352]: segfault (11) at
> > 000000013a2a09f8 nip 000000013a2a086c lr 00007fffb63e5100 code 2 in
> > pandafault[13a2a0000+10000]
> >
> > Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> > ---
> >  arch/powerpc/kernel/traps.c | 43 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 39 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> > index e6c43ef9fb50..e55ee639d010 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -96,6 +96,41 @@ EXPORT_SYMBOL(__debugger_fault_handler);
> >  #define TM_DEBUG(x...) do { } while(0)
> >  #endif
> >
> > +static const char *signames[SIGRTMIN + 1] = {
> > +	"UNKNOWN",
> > +	"SIGHUP",			// 1
> > +	"SIGINT",			// 2
> > +	"SIGQUIT",			// 3
> > +	"SIGILL",			// 4
> > +	"unhandled trap",		// 5 = SIGTRAP
> > +	"SIGABRT",			// 6 = SIGIOT
> > +	"bus error",			// 7 = SIGBUS
> > +	"floating point exception",	// 8 = SIGFPE
> > +	"illegal instruction",		// 9 = SIGILL
> > +	"SIGUSR1",			// 10
> > +	"segfault",			// 11 = SIGSEGV
> > +	"SIGUSR2",			// 12
> > +	"SIGPIPE",			// 13
> > +	"SIGALRM",			// 14
> > +	"SIGTERM",			// 15
> > +	"SIGSTKFLT",			// 16
> > +	"SIGCHLD",			// 17
> > +	"SIGCONT",			// 18
> > +	"SIGSTOP",			// 19
> > +	"SIGTSTP",			// 20
> > +	"SIGTTIN",			// 21
> > +	"SIGTTOU",			// 22
> > +	"SIGURG",			// 23
> > +	"SIGXCPU",			// 24
> > +	"SIGXFSZ",			// 25
> > +	"SIGVTALRM",			// 26
> > +	"SIGPROF",			// 27
> > +	"SIGWINCH",			// 28
> > +	"SIGIO",			// 29 = SIGPOLL = SIGLOST
> > +	"SIGPWR",			// 30
> > +	"SIGSYS",			// 31 = SIGUNUSED
> > +};
> > +
> >  /*
> >   * Trap & Exception support
> >   */
> > @@ -314,10 +349,10 @@ static void show_signal_msg(int signr, struct
> > pt_regs *regs, int code,
> >  	if (!unhandled_signal(current, signr))
> >  		return;
> >
> > -	pr_info("%s[%d]: unhandled signal %d at "REG_FMT \
> > -		" nip "REG_FMT" lr "REG_FMT" code %x",
> > -		current->comm, current->pid, signr, addr,
> > -		regs->nip, regs->link, code);
> > +	pr_info("%s[%d]: %s (%d) at "REG_FMT" nip "REG_FMT \
> > +		" lr "REG_FMT" code %x",
> > +		current->comm, current->pid, signames[signr],
> > +		signr, addr, regs->nip, regs->link, code);
>
> Are we sure that signr is always within the limits of the table ?

Looking at the code, we only pass the following signals:

    SIGBUS
    SIGFPE
    SIGILL
    SIGSEGV
    SIGTRAP

All of them are within the limits of the table.  We've added other
signals for completeness.

Cheers
Murilo

