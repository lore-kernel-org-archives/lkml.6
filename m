Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C211BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771DE20657
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771DE20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeHXAKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:10:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbeHXAKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:10:40 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NKYtP1014232
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:39:17 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m231vjrqu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:39:17 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 23 Aug 2018 16:39:15 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 16:39:12 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7NKdBPl36438234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 20:39:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24B8DB206A;
        Thu, 23 Aug 2018 16:38:15 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10DCFB2068;
        Thu, 23 Aug 2018 16:38:15 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 16:38:15 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5D27016C374D; Thu, 23 Aug 2018 13:39:11 -0700 (PDT)
Date:   Thu, 23 Aug 2018 13:39:11 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     nicolas.pitre@linaro.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel-only deployments?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180823174359.GA13033@linux.vnet.ibm.com>
 <20180823185417.y3ung3b553f2d24a@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180823185417.y3ung3b553f2d24a@angband.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18082320-0068-0000-0000-0000032E9153
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009599; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01077838; UDB=6.00555746; IPR=6.00857812;
 MB=3.00022893; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-23 20:39:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082320-0069-0000-0000-0000457E69AF
Message-Id: <20180823203911.GV4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=654 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 08:54:17PM +0200, Adam Borowski wrote:
> On Thu, Aug 23, 2018 at 10:43:59AM -0700, Paul E. McKenney wrote:
> > The mkinitramfs approach results in about 40MB of initrd, and dracut
> > about 10MB.  Most of this is completely useless for rcutorture, which
> > isn't interested in mounting filesystems, opening devices, and almost
> > all of the other interesting things that mkinitramfs and dracut enable.
> > 
> > Those who know me will not be at all surprised to learn that I went
> > overboard making the resulting initrd as small as possible.  I started
> > by throwing out everything not absolutely needed by the dash and sleep
> > binaries, which got me down to about 2.5MB, 1.8MB of which was libc.
> > This situation of course prompted me to create an initrd containing
> > a statically linked binary named "init" and absolutely nothing else
> > (not even /dev or /tmp directories), which weighs in at not quite 800KB.
> > This is a great improvement over 10MB, to say nothing of 40MB, but 800KB
> > for a C-language "for" loop containing nothing more than a single call to
> > sleep()?
> 
> .globl _start
> .data
> req:    .8byte 999999999, 999999999
> .text
> _start:
>         mov     $35, %rax       # syscall: nanosleep
>         mov     $req, %rdi
>         xor     %rsi, %rsi
>         syscall
>         jmp     _start
> 
> 
> as sl.s -o sl.o
> ld sl.o -o init
> 
> 'Ere you go, no libc needed.  If your arch is not amd64, just say so.

I need to be arch-independent, but I will save off your solution,
thank you!

> If you want to do anything more complex, though -- you really want musl
> or another lightweight libc instead.  Glibc is utterly unfit for static
> linking.

Got it, thank you!

							Thanx, Paul

> Meow!
> -- 
> ⢀⣴⠾⠻⢶⣦⠀ .globl _start↵.data↵rc: .ascii "/etc/init.d/rcS\0"↵.text↵_start
> ⣾⠁⢰⠒⠀⣿⡁ mov $57,%rax↵syscall↵cmp $0,%rax↵jne child↵parent:↵mov $61,%rax
> ⢿⡄⠘⠷⠚⠋⠀ mov $-1,%rdi↵xor %rsi,%rsi↵xor %rdx,%rdx↵syscall↵jmp parent↵child:
> ⠈⠳⣄⠀⠀⠀⠀ mov $59,%rax↵mov $rc,%rdi↵xor %rsi,%rsi↵xor %rdx,%rdx↵syscall
> 

