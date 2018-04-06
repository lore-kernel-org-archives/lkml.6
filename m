Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeDFSLM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:11:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750807AbeDFSLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:11:10 -0400
Date: Fri, 6 Apr 2018 20:10:57 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
X-X-Sender: sebott@schleppi
To: Kees Cook <keescook@chromium.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [bisected] 3c8ba0d61d04ced9f8d9ff93977995a9e4e96e91 oopses on
 s390
In-Reply-To: <CAGXu5jKLsdfHEySg1w5EKO3Tt3=nWh7txWVsU6V65i3vS=Z2xw@mail.gmail.com>
References: <alpine.LFD.2.21.1804061125390.1819@schleppi> <CAGXu5jKTtU3fvqP-ygV51WcOAmTkm=y5fysKNv+k0crhJACtVg@mail.gmail.com>  <CAGXu5jKLsdfHEySg1w5EKO3Tt3=nWh7txWVsU6V65i3vS=Z2xw@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Martina?=
 =?ISO-8859-15?Q?_Koederitz_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 18040618-0044-0000-0000-00000544580A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040618-0045-0000-0000-000028847B56
Message-Id: <alpine.LFD.2.21.1804062009040.1819@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-06_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804060182
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2018, Kees Cook wrote:
> On Fri, Apr 6, 2018 at 9:47 AM, Kees Cook <keescook@chromium.org> wrote:
> > On Fri, Apr 6, 2018 at 2:47 AM, Sebastian Ott <sebott@linux.vnet.ibm.com> wrote:
> >> Today's kernel oopsed on s390. Bisect points to:
> >> 3c8ba0d61d04 ("kernel.h: Retain constant expression output for max()/min()")
> >>
> >> [    1.898277] dasd-eckd 0.0.3304: DASD with 4 KB/block, 21636720 KB total size, 48 KB/track, compatible disk layout
> >> [    1.898308] ------------[ cut here ]------------
> >> [    1.898310] kernel BUG at block/bio.c:1798!
> >
> > Well that's extremely bad. :(
> >
> >> Bisect log and config attached. I'll look at min/max users in the affected
> >> areas later today.
> >
> > Seems like a comparison of objdump output with/without the patch may
> > be needed. And why is this s390 only? Ugh.
> 
> I did a objdump diff with your .config and it's rather large -- mostly
> seems to be register swaps, so it's not easy to browse.

Yes, I'm looking at that too.

> BTW, what version of gcc did you use? I built using:

gcc version 7.2.0 (GCC)
