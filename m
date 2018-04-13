Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754192AbeDMJIc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:08:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754167AbeDMJI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:08:28 -0400
Date: Fri, 13 Apr 2018 11:08:20 +0200
From: Philipp Rudo <prudo@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Dave Young <dyoung@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] kexec: Remove "weak" annotations from headers
In-Reply-To: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
Organization: IBM
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041309-0020-0000-0000-0000041175B8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041309-0021-0000-0000-000042A5A767
Message-Id: <20180413110820.662d4879@ThinkPad>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804130084
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

in recent patches AKASHI [1] and I [2] made some changes to the declarations
you are touching and already removed some of the weak statements. The patches
got accepted on linux-next and will (hopefully) be pulled for v4.17. So you
should prepare for some merge conflicts. Nevertheless three weak statements
still remain (arch_kexec_walk_mem & arch_kexec_apply_relocations*) so your
patch still makes totally sense.

Thanks
Philipp

[1] https://lkml.org/lkml/2018/3/6/201
[2] https://lkml.org/lkml/2018/3/21/278

On Thu, 12 Apr 2018 13:23:29 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> "Weak" annotations in header files are error-prone because they make
> every definition weak.  Remove them from include/linux/kexec.h.
> 
> These were introduced in two separate commits, so this is in two
> patches so they can be easily backported to stable kernels (some of
> them date back to v4.3 and one only goes back to v4.10).
> 
> ---
> 
> Bjorn Helgaas (2):
>       kexec: Remove "weak" from kexec_file function declarations
>       kexec: Remove "weak" from arch_kexec_walk_mem() declaration
> 
> 
>  include/linux/kexec.h |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
