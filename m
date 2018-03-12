Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932409AbeCLXaL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:30:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932255AbeCLXaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:30:09 -0400
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jiandi An <anjiandi@codeaurora.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, linux-ima-devel@lists.sourceforge.net,
        linux-ima-user@lists.sourceforge.net,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Safford <david.safford@ge.com>
Date: Mon, 12 Mar 2018 19:30:00 -0400
In-Reply-To: <1520893847.4522.62.camel@HansenPartnership.com>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
         <20180307185132.GA30102@ziepe.ca>
         <1520448953.10396.565.camel@linux.vnet.ibm.com>
         <1520449719.5558.28.camel@HansenPartnership.com>
         <1520450495.10396.587.camel@linux.vnet.ibm.com>
         <1520451662.24314.5.camel@HansenPartnership.com>
         <1520461156.10396.654.camel@linux.vnet.ibm.com>
         <191cfd49-0c66-a5ef-3d2b-b6c4132aa294@codeaurora.org>
         <1520615461.12216.6.camel@HansenPartnership.com>
         <1520891598.3547.190.camel@linux.vnet.ibm.com>
         <1520893847.4522.62.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18031223-0020-0000-0000-000004029583
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031223-0021-0000-0000-00004296E7C3
Message-Id: <1520897400.3547.253.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803120256
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-12 at 15:30 -0700, James Bottomley wrote:
> On Mon, 2018-03-12 at 17:53 -0400, Mimi Zohar wrote:
[...]
> > - This use case, when the TPM is not builtin and unavailable before
> > IMA is initialized.
> > 
> > I would classify this use case as an IMA testing/debugging
> > environment, when it cannot, for whatever reason, be builtin the
> > kernel or initialized before IMA.
> > 
> > From Dave Safford:
> >     For the TCG chain of trust to have any meaning, all files have to
> >     be measured and extended into the TPM before they are accessed.
> > If
> >     the TPM driver is loaded after any unmeasured file, the chain is
> >     broken, and IMA is useless for any use case or any threat model.
> 
> I don't think this is quite the correct characterisation.  In principle
> the kernel could also touch the files before IMA is loaded.  However,
> we know from the way the kernel operates that it doesn't.  We basically
> trust that the kernel measurement tells us this.  The same thing can be
> made to apply to the initrd.

With the builtin "tcb" policy, IMA-measurement is enabled from the
very beginning.  Afterwards, the system can transition to a custom
policy based on finer grain LSM labels, which aren't available on
boot.

> The key question is not whether the component could theoretically
> access the files but whether it actually does so.

As much as you might think you know what is included in the initramfs,
IMA-measurement is your safety net, including everything accessed in
the TCB.

Mimi
