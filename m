Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbeCNRIW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:08:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751835AbeCNRIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:08:18 -0400
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Safford, David (GE Global Research, US)" <david.safford@ge.com>,
        Jiandi An <anjiandi@codeaurora.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-ima-devel@lists.sourceforge.net"
        <linux-ima-devel@lists.sourceforge.net>,
        "linux-ima-user@lists.sourceforge.net"
        <linux-ima-user@lists.sourceforge.net>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Wed, 14 Mar 2018 13:08:06 -0400
In-Reply-To: <1521038471.4508.25.camel@HansenPartnership.com>
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
         <1520897400.3547.253.camel@linux.vnet.ibm.com>
         <1520899605.4522.67.camel@HansenPartnership.com>
         <BCA04D5D9A3B764C9B7405BBA4D4A3C002367FEF@ALPMBAPA12.e2k.ad.ge.com>
         <1521038471.4508.25.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18031417-0020-0000-0000-000004047A29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031417-0021-0000-0000-000042987F28
Message-Id: <1521047286.3547.470.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140190
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-14 at 07:41 -0700, James Bottomley wrote:
> On Tue, 2018-03-13 at 12:57 +0000, Safford, David (GE Global Research,
> US) wrote:
> > > 
> > > -----Original Message-----
> > > From: James Bottomley [mailto:James.Bottomley@HansenPartnership.com
> > > ]
> > > Sent: Monday, March 12, 2018 8:07 PM
> > > To: Mimi Zohar <zohar@linux.vnet.ibm.com>; Jiandi An
> [...]
> > > > > The key question is not whether the component could
> > > > > theoretically
> > > > > access the files but whether it actually does so.
> > > > 
> > > > As much as you might think you know what is included in the
> > > > initramfs, IMA-measurement is your safety net, including
> > > > everything accessed in the TCB.
> > > 
> > > The initrd *is* part of the Trusted Computing Base because it's
> > > part of the boot custody chain.  That's really my point.  If I
> > > don't know what's in my initrd, I've broken the chain there and IMA
> > > can't fix it.
> > > 
> > > James
> > 
> > That's exactly the point - how do you know what's in your initrd?
> > The initrd is normally built on the possibly compromised system in
> > question.
> 
> The point of deploying security measures is to make sure my system
> isn't compromised.  I realise the institutional view is "we didn't
> build the initrd" and my individual view is well, I built my own kernel
> as well, so what's the difference?  But the initrd in both models is
> still part of the chain.
> 
> > It's not signed as a whole by someone trusted. How can the
> > attestation server say a given hash of the initrd as a whole is good?
> 
> I trust myself.  I can get the hash at build time.  In the same way as
> I sign my own kernel at build time for secure boot.
> 
> > If IMA is running from the very start, it can at least measure (and
> > eventually appraise) every individual file in the initrd. Given this
> > more detailed measurement list, the attestation server can verify all
> > the components in the initrd, even when it is assembled on the
> > untrusted system.
> > 
> > On many embedded systems, there is no initrd, and IMA has to start
> > measuring and appraising immediately, anyway.
> > 
> > Perhaps there is a use case where there is a known set of initrd
> > images, and so the bootloader's measurement of the initrd is
> > sufficient for verification. I've not run into that situation yet. If
> > you want an option for this use case,  that's fine, (I'm all for
> > choice) but it should not be the default for IMA.
> 
> Actually, we seem to have wandered away from the main concern which was
> trying to select built in TPM drivers.

IMA selecting the generic TPM drivers has never been an issue.  As I
mentioned previously, this is simply a convenience.  Anyone building a
kernel can configure the vendor specific TPM drivers as builtin.

In terms of distro's, configuring vendor specific TPMs as builtin is a
 TPM vandor/distro discussion.  On OpenPower, we've requested the
Atmel, Infineon, and Nuvoton TPM drivers be builtin by the different
distro's.

> What about a compromise: we
> already get the boot loader to do measurements and PCR extensions using
> the BIOS TPM driver, there's no reason why we can't do the same in the
> early kernel until a real TPM driver is found.

Your proposal requires changes to the existing boot loaders, not all
of which are X86 based.  Grub, to the best of my knowledge, is not
interested in having anything to do with TPM based measurements.  Many
attempts have been made to upstream trusted boot patches, but none
have been accepted.  Any support would need to piggyback on the
callback hooks introduced for secure boot and then be carried by the
distros.

As for Linux based boot loaders, the driver needs to be builtin for
these measurements.  So this wouldn't help you.

> That way IMA would have
> no dependency on any built in TPM driver ... is that an acceptable
> compromise to everyone?

Adding additional support for post IMA-initialization for TPM's built
as kernel modules is clearly not optimal for all of the reasons
provided to now and will be confusing, but could be supported.  This
delayed loading of the TPM needs to be clearly indicated in both the
audit log and in IMA's measurement list.

In terms of attestation, if a measurement policy is enabled before the
TPM is loaded, any records up to the delayed TPM entry in the IMA
measurement list would need to be ignored.

In addition, your changes should not in any way change the existing
IMA-measurement initialization.

Mimi
