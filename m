Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A90C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD74021708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD74021708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbeI1Aht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:37:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728488AbeI1Ahs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:37:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8RIELi7087663
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 14:18:17 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ms2dn5ayh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 14:18:17 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 27 Sep 2018 14:18:15 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Sep 2018 14:18:08 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8RII7gI27656416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Sep 2018 18:18:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9439EB2066;
        Thu, 27 Sep 2018 14:16:25 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CA8DB206B;
        Thu, 27 Sep 2018 14:16:25 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.131.147])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Sep 2018 14:16:25 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5599116C1B35; Thu, 27 Sep 2018 11:18:06 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:18:06 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     shuah kh <shuah.kh@samsung.com>, rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        stable <stable@vger.kernel.org>, shuah <shuah@kernel.org>
Subject: Re: [PATCH] rseq/selftests: fix parametrized test with -fpie
Reply-To: paulmck@linux.ibm.com
References: <20180918135328.32034-1-mathieu.desnoyers@efficios.com>
 <1367962117.10271.1537897176578.JavaMail.zimbra@efficios.com>
 <CGME20180927132250epcas4p3d0775cc258f6112d27bdad359fc6e416@epcas4p3.samsung.com>
 <20180927092235.77282e35@vmware.local.home>
 <a7bae2ff-1f4d-dbfc-43f8-e7a89f319abb@samsung.com>
 <44897232.11546.1538071328396.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44897232.11546.1538071328396.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18092718-0052-0000-0000-000003389248
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009782; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01094502; UDB=6.00565782; IPR=6.00874538;
 MB=3.00023532; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-27 18:18:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092718-0053-0000-0000-00005E382474
Message-Id: <20180927181806.GI4222@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809270168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 02:02:08PM -0400, Mathieu Desnoyers wrote:
> ----- On Sep 27, 2018, at 9:58 AM, Shuah Khan shuah.kh@samsung.com wrote:
> 
> > On 09/27/2018 07:22 AM, Steven Rostedt wrote:
> >> On Tue, 25 Sep 2018 13:39:36 -0400 (EDT)
> >> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >> 
> >>> ----- On Sep 18, 2018, at 9:53 AM, Mathieu Desnoyers
> >>> mathieu.desnoyers@efficios.com wrote:
> >>>
> >>>> On x86-64, the parametrized selftest code for rseq crashes with a
> >>>> segmentation fault when compiled with -fpie. This happens when the
> >>>> param_test binary is loaded at an address beyond 32-bit on x86-64.
> >>>>
> >>>> The issue is caused by use of a 32-bit register to hold the address
> >>>> of the loop counter variable.
> >>>>
> >>>> Fix this by using a 64-bit register to calculate the address of the
> >>>> loop counter variables as an offset from rip.
> >>>
> >>> Should this fix go through tip or the selftests tree ?
> >>>
> >> 
> >> I usually have changes like this pulled through Shuah's tree with an
> >> ack from the maintainer of the code that it tests.
> >> 
> >> -- Steve
> >> 
> > 
> > Right that is what I prefer. I usually wait for an Ack. I can pull this
> > in.
> 
> I am maintainer of the code that it tests as well, so being both author
> of the selftest patch and giving an ack to it seems a bit silly. :) Other
> rseq co-maintainers could weight in though: Peter, Paul, and Boqun.

Here you go!  ;-)

Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>

> Thanks,
> 
> Mathieu
> 
> > 
> > thanks,
> > -- Shuah
> > 
> > --
> > Shuah Khan
> > Sr. Linux Kernel Developer
> > Open Source Innovation Group
> > Samsung Research America(Silicon Valley)
> > shuah.kh@samsung.com
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 

