Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbeCNJ7S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:59:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751413AbeCNJ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:59:17 -0400
Subject: Re: [linux-next][bisected c7c133f3][gcc 4.8.5] build fail with
 error: first argument to
 =?UTF-8?Q?=E2=80=98=5F=5Fbuiltin=5Fchoose=5Fexpr=E2=80=99?= not a constant
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-next <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, mpe <mpe@ellerman.id.au>,
        sachinp <sachinp@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 15:29:06 +0530
In-Reply-To: <20180314193957.5f835d33@canb.auug.org.au>
References: <1521016194.31953.9.camel@abdul.in.ibm.com>
         <20180314193957.5f835d33@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18031409-0056-0000-0000-0000042D5008
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008671; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01002856; UDB=6.00510322; IPR=6.00782186;
 MB=3.00020027; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 09:59:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031409-0057-0000-0000-0000086F50A0
Message-Id: <1521021546.31953.12.camel@abdul.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140117
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-14 at 19:39 +1100, Stephen Rothwell wrote:
> Hi Abdul,
> 
> On Wed, 14 Mar 2018 13:59:54 +0530 Abdul Haleem <abdhalee@linux.vnet.ibm.com> wrote:
> >
> > Today's next kernel fails to build with gcc 4.8.5 on powerpc machine.
> 
> Thanks for the report.  Just for the future, please include  the
> next-XXXXXXXX tag when making reports about linux-next.

Sure, I will. next-20180313 is the bad tag
> 
> > ./include/linux/jiffies.h: In function ‘jiffies_delta_to_clock_t’:
> > ./include/linux/kernel.h:855:2: error: first argument to ‘__builtin_choose_expr’ not a constant
> >   __builtin_choose_expr(__builtin_constant_p(x) &&  \
> >   ^
> > ./include/linux/kernel.h:867:19: note: in expansion of macro ‘__max’
> >  #define max(x, y) __max(typeof(x), typeof(y), x, y)
> > 
> > Machine Type: Power8 Baremetal
> > gcc: 4.8.5
> > 
> > 
> > Builds fine when below patch is reverted
> > c7c133f3 kernel.h: skip single-eval logic on literals in min()/max()
> 
> Those patches have been removed from today's linux-next (next-20180314).

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
