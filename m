Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbeCTFpp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 01:45:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45332 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeCTFpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 01:45:41 -0400
Message-ID: <1521524675.3354.302.camel@oracle.com>
Subject: Re: [PATCH v4 1/1] runchecks: Generalize make C={1,2} to support
 multiple checkers
From: Knut Omang <knut.omang@oracle.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        =?ISO-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Tom Saeger <tom.saeger@oracle.com>,
        Michal Marek <michal.lkml@markovi.net>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        John Haxby <john.haxby@oracle.com>,
        =?ISO-8859-1?Q?=C5smund_=D8stvold?= <asmund.ostvold@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        cocci@systeme.lip6.fr, Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 20 Mar 2018 06:44:35 +0100
In-Reply-To: <1517815200.3118.383.camel@oracle.com>
References: <cover.a7e2d48abd08947a9bb46ef5d18a8f33066cc40d.1516356501.git-series.knut.omang@oracle.com>
         <c271ba8f99393585d69db71f40db3c01c44769e4.1516356501.git-series.knut.omang@oracle.com>
         <1517812899.3118.372.camel@oracle.com>
         <CAK7LNAS8QG947WpFn6bCnNVLj=x7jbAyLKVRS429wP+1jYbOUA@mail.gmail.com>
         <1517815200.3118.383.camel@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8837 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200006
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-05 at 08:20 +0100, Knut Omang wrote:
> On Mon, 2018-02-05 at 16:03 +0900, Masahiro Yamada wrote:

Hi Masahiro,

I know these are busy times but any hope of getting forward on this?
Anything more I can do to ease the process?

Thanks for your time,
Knut

> > 2018-02-05 15:41 GMT+09:00 Knut Omang <knut.omang@oracle.com>:
> > > On Fri, 2018-01-19 at 11:14 +0100, Knut Omang wrote:
> > >> Add scripts/runchecks which has generic support for running
> > >> checker tools in a convenient and user friendly way that
> > >> the author hopes can contribute to rein in issues detected
> > >> by these tools in a manageable and convenient way.
> > >>
> > >> scripts/runchecks provides the following basic functionality:
> > >>
> > >> * Makes it possible to selectively suppress output from individual
> > >>   checks on a per file or per subsystem basis.
> > >> * Unifies output and suppression input from different tools
> > >>   by providing a single unified syntax and presentation for the
> > >>   underlying tools in the style of "scripts/checkpatch.pl --show-types".
> > >> * Allows selective run of one, or more (or all) configured tools
> > >>   for each file.
> > >>
> > >> In the Makefile system, the sparse specific setup has been replaced
> > >> by setup for runchecks.
> > >
> > > Hi all,
> > >
> > > - Anything more I can/need to do to bring this forward?
> > > - Any quiet concerns?
> > >
> > > I realize it is a subsystem crossing change,
> > 
> > Is it?  Only Kbuild this is related to.
> 
> Ok, I see!
> 
> > > and a lot going on elsewhere,
> > > nevertheless I believe this is a time saver in the slightly longer run,
> > > as it allows automation of checking, even without a "perfect"
> > > code base to begin with.
> > >
> > 
> > Sorry for the delay.
> 
> I understand, no problem - just was afraid it was about to get lost 
> in between subsystems,
> 
> > I have not been able to find time to dive into the detail yet.
> > (Actually, I tried to do that for v2 or v3, where Python code was so dirty,
> > then consumed my time to figure out what the code was trying to do)
> 
> Hopefully v4 is cleaner from a Python code style point of view at least,
> but let me know if you have any particular part of the code in mind wrt 
> readability. Also hopefully the docs should be of help.
> 
> > I find my concern here:
> > https://lkml.org/lkml/2018/1/5/497
> 
> I believe I have addressed the issues there in v4.
> 
> > Anyway, I will take a look again when I find some time.
> > You do not need to take care of the detail until I request to do so.
> 
> Ok, thanks a lot for your time and the quick response now!
> 
> Best regards,
> Knut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
