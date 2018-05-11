Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeEKPol (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:44:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38736 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbeEKPok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:44:40 -0400
Date: Fri, 11 May 2018 11:43:59 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tim Shearer <tshearer@advaoptical.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 2/3] KVM: X86: Allow userspace to disable ioport intercept
Message-ID: <20180511154359.GC26700@char.us.oracle.com>
References: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
 <1523943962-25415-3-git-send-email-wanpengli@tencent.com>
 <20180511154246.GH27459@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180511154246.GH27459@char.us.oracle.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8890 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=471
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805110148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4BFikI6021233

On Fri, May 11, 2018 at 11:42:46AM -0400, Konrad Rzeszutek Wilk wrote:
> On Mon, Apr 16, 2018 at 10:46:01PM -0700, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> > 
> > Allow to disable ioport intercept by userspace.
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Krčmář <rkrcmar@redhat.com>
> > Cc: Tim Shearer <tshearer@advaoptical.com>
> > Cc: Liran Alon <liran.alon@oracle.com>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> > ---
> >  Documentation/virtual/kvm/api.txt | 11 +++++++++++
> >  arch/x86/include/asm/kvm_host.h   |  2 ++
> >  arch/x86/kvm/x86.c                |  5 +++++
> >  include/uapi/linux/kvm.h          |  1 +
> >  4 files changed, 19 insertions(+)
> > 
> > diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> > index 1c7958b..3d0488e 100644
> > --- a/Documentation/virtual/kvm/api.txt
> > +++ b/Documentation/virtual/kvm/api.txt
> > @@ -4378,6 +4378,17 @@ all such vmexits.
> >  
> >  Do not enable KVM_FEATURE_PV_UNHALT if you disable HLT exits.
> >  
> > +7.14 KVM_CAP_IOPORT_DISABLE_INTERCEPT
> > +
> > +Architectures: x86

And to be exact: Intel only..
