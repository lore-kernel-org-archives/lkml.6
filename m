Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbeFEU4S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:56:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55212 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751871AbeFEU4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:56:17 -0400
Date: Tue, 5 Jun 2018 16:56:00 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, andrew.cooper3@citrix.com
Subject: Re: [PATCH v1] AMD SSB bits.
Message-ID: <20180605205600.GR5867@char.us.oracle.com>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
 <f1281c9e-7efd-cf87-c093-b86a9014aa24@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1281c9e-7efd-cf87-c093-b86a9014aa24@amd.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8915 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=819
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806050232
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 08:23:13AM -0500, Tom Lendacky wrote:
> On 6/1/2018 9:59 AM, Konrad Rzeszutek Wilk wrote:
> > Hi,
> > 
> > I was reading the AMD whitepaper on SSBD and noticed that they have added
> > two new bits in the 8000_0008 CPUID. EBX:
> >  1) Bit[26] - similar to Intel's SSB_NO not needed anymore.
> >  2) Bit[24] - use SPEC_CTRL MSR (0x48) instead of VIRT SPEC_CTRL MSR
> >     (0xC001_011f).
> > 
> > See 124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf
> > (A copy of this document is available at
> >     https://bugzilla.kernel.org/show_bug.cgi?id=199889)
> > 
> > Being that I don't have the hardware (not even sure if AMD has developed it yet)
> > I ended up cobbling up a DEBUG patch, the last one - which is well, debug
> > (see below).
> 
> So I'm not sure what is debug and what isn't, so I'm just commenting as if
> they weren't debug.  If this patch is just for debug, then you can
> probably ignore.

It is just for debugging.
