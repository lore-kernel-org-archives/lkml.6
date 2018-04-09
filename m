Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeDIR1w (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:27:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751549AbeDIR1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:27:51 -0400
Date: Mon, 9 Apr 2018 19:27:43 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Kees Cook <keescook@chromium.org>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [bisected] 3c8ba0d61d04ced9f8d9ff93977995a9e4e96e91 oopses on
 s390
In-Reply-To: <CA+55aFy1jJPX2fu7ce2Z7hxn49RaSghtnziwsyUU1Em5WEH2yw@mail.gmail.com>
References: <alpine.LFD.2.21.1804061125390.1819@schleppi> <CAGXu5jKTtU3fvqP-ygV51WcOAmTkm=y5fysKNv+k0crhJACtVg@mail.gmail.com> <alpine.LFD.2.21.1804091809310.1698@schleppi> <CA+55aFw1MoQ=7=U6QCGXAAiCniMKy8_igxgc8sMLykSRcDk-0g@mail.gmail.com>
 <CA+55aFy1jJPX2fu7ce2Z7hxn49RaSghtnziwsyUU1Em5WEH2yw@mail.gmail.com>
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
x-cbid: 18040917-0012-0000-0000-000005C8C679
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040917-0013-0000-0000-00001944EE1C
Message-Id: <alpine.LFD.2.21.1804091926080.1698@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804090177
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Apr 2018, Linus Torvalds wrote:
> On Mon, Apr 9, 2018 at 10:03 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Our old "min()" had the internal variables called "min1" and "min2",
> > which is crazy too.
> 
> Actually, no, it used the really cumbersome "__UNIQUE_ID" and then
> passed that odd as the name 'min1/2',
> 
> Ugh, I find that really nasty to read, but it was obviously done
> because we hit this before.
> 
> And our __UNIQUE_ID() macro is garbage anyway, since it falls back on
> the line number, which doesn't really work for macros anyway. But we
> have proper macros for both clang and gcc, so maybe we should ignore
> the broken fallback.
> 
> A patch like the attached, perhaps?

I applied this on top of 38c23685b273cfb4ccf31a199feccce3bdcb5d83
and everything works as expected.

Thanks!
