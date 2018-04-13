Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754164AbeDMJ3S (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:29:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753588AbeDMJ3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:29:16 -0400
Date: Fri, 13 Apr 2018 17:29:08 +0800
From: Baoquan He <bhe@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Philipp Rudo <prudo@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v1 0/2] kexec: Remove "weak" annotations from headers
Message-ID: <20180413092908.GB2119@localhost.localdomain>
References: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180413110820.662d4879@ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413110820.662d4879@ThinkPad>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

There are changes I have made to solve 5-level conflict with
kexec/kdump and also interface unification task, they will involve x86
64 only changes on these functions, I don't think we need remove them if
without any obvious impact or error reported.

Thanks
Baoquan

On 04/13/18 at 11:08am, Philipp Rudo wrote:
> Hi Bjorn,
> 
> in recent patches AKASHI [1] and I [2] made some changes to the declarations
> you are touching and already removed some of the weak statements. The patches
> got accepted on linux-next and will (hopefully) be pulled for v4.17. So you
> should prepare for some merge conflicts. Nevertheless three weak statements
> still remain (arch_kexec_walk_mem & arch_kexec_apply_relocations*) so your
> patch still makes totally sense.
> 
> Thanks
> Philipp
> 
> [1] https://lkml.org/lkml/2018/3/6/201
> [2] https://lkml.org/lkml/2018/3/21/278
> 
> On Thu, 12 Apr 2018 13:23:29 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > "Weak" annotations in header files are error-prone because they make
> > every definition weak.  Remove them from include/linux/kexec.h.
> > 
> > These were introduced in two separate commits, so this is in two
> > patches so they can be easily backported to stable kernels (some of
> > them date back to v4.3 and one only goes back to v4.10).
> > 
> > ---
> > 
> > Bjorn Helgaas (2):
> >       kexec: Remove "weak" from kexec_file function declarations
> >       kexec: Remove "weak" from arch_kexec_walk_mem() declaration
> > 
> > 
> >  include/linux/kexec.h |   24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
