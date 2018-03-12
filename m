Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751690AbeCLXTx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:19:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751450AbeCLXTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:19:51 -0400
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jiandi An <anjiandi@codeaurora.org>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-ima-devel@lists.sourceforge.net,
        linux-ima-user@lists.sourceforge.net,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Safford <david.safford@ge.com>
Date: Mon, 12 Mar 2018 19:19:42 -0400
In-Reply-To: <20180312230501.GJ24717@ziepe.ca>
References: <1520448953.10396.565.camel@linux.vnet.ibm.com>
         <1520449719.5558.28.camel@HansenPartnership.com>
         <1520450495.10396.587.camel@linux.vnet.ibm.com>
         <1520451662.24314.5.camel@HansenPartnership.com>
         <1520461156.10396.654.camel@linux.vnet.ibm.com>
         <191cfd49-0c66-a5ef-3d2b-b6c4132aa294@codeaurora.org>
         <1520615461.12216.6.camel@HansenPartnership.com>
         <1520891598.3547.190.camel@linux.vnet.ibm.com>
         <20180312215957.GI24717@ziepe.ca>
         <1520895525.3547.226.camel@linux.vnet.ibm.com>
         <20180312230501.GJ24717@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18031223-0012-0000-0000-000005BD15EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031223-0013-0000-0000-00001939166B
Message-Id: <1520896782.3547.245.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803120254
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-12 at 17:05 -0600, Jason Gunthorpe wrote:
> On Mon, Mar 12, 2018 at 06:58:45PM -0400, Mimi Zohar wrote:
> > On Mon, 2018-03-12 at 15:59 -0600, Jason Gunthorpe wrote:
> > > On Mon, Mar 12, 2018 at 05:53:18PM -0400, Mimi Zohar wrote:
> > > 
> > > > Using Kconfig to force the TPM to be builtin is not required, but
> > > > helpful.  Users interested in IMA-measurement could configure the TPM
> > > > as builtin themselves.  Without the TPM builtin, IMA goes into TPM-
> > > > bypass mode.
> > > 
> > > This issues, broadly speaking, we have lots of TPM drivers, selecting
> > > only some to actually support IMA shows we have some kind of problem
> > > here.
> > 
> > True, IMA is not selecting the older TPM vendor specific modules, but
> > only the newer TPM_TIS and now TPM_CRB modules.  That doesn't imply
> > that IMA only supports some TPMs.  It means that by default, these
> > TPMs are builtin.  Anyone building a kernel, can select the vendor
> > specific TPM to be builtin.
> 
> That doesn't help distros, which is the main point of the complaint
> with this scheme :)

Years ago because of faulty TPM drivers, IMA was disabled in one of
the main distro's.  Deciding which vendor specific TPMs should be
builtin, is a discussion between the distro's and TPM vendors.

Mimi
