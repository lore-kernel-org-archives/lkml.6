Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeEJUYt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 16:24:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751438AbeEJUYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 16:24:47 -0400
Date: Thu, 10 May 2018 13:24:36 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com
Subject: Re: [PATCH 9/8] powerpc/pkeys: Drop private VM_PKEY definitions
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180508145948.9492-9-mpe@ellerman.id.au>
 <20180510135422.6585-1-mpe@ellerman.id.au>
MIME-Version: 1.0
In-Reply-To: <20180510135422.6585-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18051020-0040-0000-0000-0000043852CF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051020-0041-0000-0000-0000263C98A5
Message-Id: <20180510202435.GB6257@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805100188
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Agree. Was going to send that the moment the other patches
landed upstream. Glad I dont have to do it :-)

Reviewed-by: Ram Pai <linuxram@us.ibm.com>



On Thu, May 10, 2018 at 11:54:22PM +1000, Michael Ellerman wrote:
> Now that we've updated the generic headers to support 5 PKEY bits for
> powerpc we don't need our own #defines in arch code.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/pkeys.h | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> One additional patch to finish cleaning things up.
> 
> I've added this to my branch.
> 
> cheers
> 
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 18ef59a9886d..5ba80cffb505 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -15,21 +15,6 @@ DECLARE_STATIC_KEY_TRUE(pkey_disabled);
>  extern int pkeys_total; /* total pkeys as per device tree */
>  extern u32 initial_allocation_mask; /* bits set for reserved keys */
> 
> -/*
> - * Define these here temporarily so we're not dependent on patching linux/mm.h.
> - * Once it's updated we can drop these.
> - */
> -#ifndef VM_PKEY_BIT0
> -# define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
> -# define VM_PKEY_BIT0	VM_HIGH_ARCH_0
> -# define VM_PKEY_BIT1	VM_HIGH_ARCH_1
> -# define VM_PKEY_BIT2	VM_HIGH_ARCH_2
> -# define VM_PKEY_BIT3	VM_HIGH_ARCH_3
> -# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
> -#elif !defined(VM_PKEY_BIT4)
> -# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
> -#endif
> -
>  #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
>  			    VM_PKEY_BIT3 | VM_PKEY_BIT4)
> 
> -- 
> 2.14.1

-- 
Ram Pai
