Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbeCLXFK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:05:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37803 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbeCLXFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:05:08 -0400
X-Google-Smtp-Source: AG47ELsohsnoH7L90bGnCvCJJ7k0fUYeipZZlVodRdsUXf4b4iQdcAQmBKxPBnqq7iqej5NF3EYYnA==
Date: Mon, 12 Mar 2018 17:05:01 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jiandi An <anjiandi@codeaurora.org>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-ima-devel@lists.sourceforge.net,
        linux-ima-user@lists.sourceforge.net,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Safford <david.safford@ge.com>
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
Message-ID: <20180312230501.GJ24717@ziepe.ca>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520895525.3547.226.camel@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 06:58:45PM -0400, Mimi Zohar wrote:
> On Mon, 2018-03-12 at 15:59 -0600, Jason Gunthorpe wrote:
> > On Mon, Mar 12, 2018 at 05:53:18PM -0400, Mimi Zohar wrote:
> > 
> > > Using Kconfig to force the TPM to be builtin is not required, but
> > > helpful.  Users interested in IMA-measurement could configure the TPM
> > > as builtin themselves.  Without the TPM builtin, IMA goes into TPM-
> > > bypass mode.
> > 
> > This issues, broadly speaking, we have lots of TPM drivers, selecting
> > only some to actually support IMA shows we have some kind of problem
> > here.
> 
> True, IMA is not selecting the older TPM vendor specific modules, but
> only the newer TPM_TIS and now TPM_CRB modules.  That doesn't imply
> that IMA only supports some TPMs.  It means that by default, these
> TPMs are builtin.  Anyone building a kernel, can select the vendor
> specific TPM to be builtin.

That doesn't help distros, which is the main point of the complaint
with this scheme :)

Jaason
