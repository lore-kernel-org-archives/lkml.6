Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933417AbeBLJvR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:51:17 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43312 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932505AbeBLJvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:51:14 -0500
Date: Mon, 12 Feb 2018 09:50:16 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: tglx@linutronix.de, karahmed@amazon.de, sironi@amazon.de,
        x86@kernel.org, kvm@vger.kernel.org, torvalds@linux-foundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        peterz@infradead.org, jmattson@google.com, rkrcmar@redhat.com,
        arjan.van.de.ven@intel.com, dave.hansen@intel.com
Subject: Re: [PATCH v2 1/6] x86/speculation: Update Speculation Control
 microcode blacklist
Message-ID: <20180212095016.i5w3iimemu74ypf6@starbug-vm.ie.oracle.com>
Mail-Followup-To: David Woodhouse <dwmw@amazon.co.uk>, tglx@linutronix.de,
        karahmed@amazon.de, sironi@amazon.de, x86@kernel.org,
        kvm@vger.kernel.org, torvalds@linux-foundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        peterz@infradead.org, jmattson@google.com, rkrcmar@redhat.com,
        arjan.van.de.ven@intel.com, dave.hansen@intel.com
References: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
 <1518305967-31356-2-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1518305967-31356-2-git-send-email-dwmw@amazon.co.uk>
User-Agent: NeoMutt/20171215
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8802 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 11:39:22PM +0000, David Woodhouse wrote:
>Intel have retroactively blessed the 0xc2 microcode on Skylake mobile
>and desktop parts, and the Gemini Lake 0x22 microcode is apparently fine
>too. We blacklisted the latter purely because it was present with all
>the other problematic ones in the 2018-01-08 release, but now it's
>explicitly listed as OK.
>
>We still list 0x84 for the various Kaby Lake / Coffee Lake parts, as
>that appeared in one version of the blacklist and then reverted to
>0x80 again. We can change it if 0x84 is actually announced to be safe.
>
>Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> arch/x86/kernel/cpu/intel.c | 4 ----
> 1 file changed, 4 deletions(-)
>
>diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
>index 319bf98..f73b814 100644
>--- a/arch/x86/kernel/cpu/intel.c
>+++ b/arch/x86/kernel/cpu/intel.c
>@@ -123,8 +123,6 @@ static const struct sku_microcode spectre_bad_microcodes[] = {
> 	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x84 },
> 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
> 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
>-	{ INTEL_FAM6_SKYLAKE_MOBILE,	0x03,	0xc2 },
>-	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
> 	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
> 	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
> 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
>@@ -136,8 +134,6 @@ static const struct sku_microcode spectre_bad_microcodes[] = {
> 	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
> 	{ INTEL_FAM6_HASWELL_X,		0x04,	0x10 },
> 	{ INTEL_FAM6_IVYBRIDGE_X,	0x04,	0x42a },
>-	/* Updated in the 20180108 release; blacklist until we know otherwise */
>-	{ INTEL_FAM6_ATOM_GEMINI_LAKE,	0x01,	0x22 },
> 	/* Observed in the wild */
> 	{ INTEL_FAM6_SANDYBRIDGE_X,	0x06,	0x61b },
> 	{ INTEL_FAM6_SANDYBRIDGE_X,	0x07,	0x712 },
>-- 
>2.7.4
>
