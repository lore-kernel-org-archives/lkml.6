Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751056AbeC0FTC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 01:19:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40926 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbeC0FTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 01:19:00 -0400
Date: Tue, 27 Mar 2018 01:18:40 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 2/2] KVM: VMX: Add Force Emulation Prefix for "emulate
 the next instruction"
Message-ID: <20180327051840.GF16974@char.us.oracle.com>
References: <1522116735-4861-1-git-send-email-wanpengli@tencent.com>
 <1522116735-4861-3-git-send-email-wanpengli@tencent.com>
 <20180327044020.GB16974@char.us.oracle.com>
 <20180327045558.GC16974@char.us.oracle.com>
 <CANRm+Cw7VVNmA=DvrzbUDoTQZ_O2sTQVJiu-v-fVt+e3jfB_gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+Cw7VVNmA=DvrzbUDoTQZ_O2sTQVJiu-v-fVt+e3jfB_gw@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8844 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=980
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803270052
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 01:03:15PM +0800, Wanpeng Li wrote:
> 2018-03-27 12:55 GMT+08:00 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>:
> > On Tue, Mar 27, 2018 at 12:40:20AM -0400, Konrad Rzeszutek Wilk wrote:
> >> On Mon, Mar 26, 2018 at 07:12:15PM -0700, Wanpeng Li wrote:
> >> > From: Wanpeng Li <wanpengli@tencent.com>
> >> >
> >> > This patch introduces a Force Emulation Prefix (ud2a; .ascii "kvm") for
> >> > "emulate the next instruction", the codes will be executed by emulator
> >> > instead of processor, for testing purposes.
> >>
> >> Can you expand a bit ? Why do you want this in KVM in the first place?
> 
> Please refer to the original discussion(Force Emulation Prefix part).
> https://lkml.org/lkml/2018/3/22/220

That really should be part massaged in this patch as part of the description.
> 
> >> Should this be controlled by a boolean parameter?
> >
> > .. per guest. That is instead of a global one, have a per guest one?
> 
> As Paolo pointed out offline:
> > Testing without the hacks being done by emulator.flat (TLB mismatch between instructions and data).

And also this above.

> I think a global module is enough for testing.

If so, perhaps have it wrapped with #ifdef DEBUG?

No need to put code gadgets that won't be utilized 99% of time.

> 
> Regards,
> Wanpeng Li
