Return-Path: <fbarrat@linux.ibm.com>
X-Google-Smtp-Source: AB8JxZoTYwe2yHI74Kcb1PNB18FqFb64BTHeOLdUq4f+D2+z9ezfSDUkmt6fv5RX4LoCMJfQH/G6
ARC-Seal: i=1; a=rsa-sha256; t=1525713455; cv=none;
        d=google.com; s=arc-20160816;
        b=CoSx62Tf3mmXj1NJR1lsIvkXrCD0GhruYm+Ntqw2CPqF2y1mykjY9TQhct/PUanJ/J
         r37xB5VrESoKwP224bnOy2xTrh1fQAET3VGYwludz3VV2ngcLxoarfmQmgJGEUskPJg6
         U3P4BbxoDItceK4GZejgqVeU7d0ahglKjCWNh9U+ozG928tbiFEGxm/hR9rf1TjIf21N
         RhexQgcwZ3i5jKZdhyzdeB9WZO9D9w3SEr2rQsEWHL56YBtPPheYFJtOrMFRVQOG3M8/
         10LRGE3YLf9VmsaVSOCKl/wOi0AzoPkMZI2m37htGyi6geY4S6jTzBm8ONVm3UAQ4VaI
         4nkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Ypu2reNV0szjaf9OaIS0yBdaSAryevjpO+8uku/ViRo=;
        b=cs3YdijzRM8bkiWQ9ShfAVGJVV3J2//l9jLxrXO2Mnn714vBqwBFgvr4Uy9ac/nT/q
         5LWK3b+mdTmwb2RUKIR+TY83pTtT/lQF1WftxLbEB/SJibFybVgm4LZSqgTHzbJfB317
         3eu3YGofvOZj+5JYC3teGSVb8nrdPeeZLk1y8OL9xZi5qn1iv8cTxCSwbR6YPK2bP8eK
         avLQIwXX5QZekopECmvAlYdVAF2jLB7kw74gyZl7jFOYOcWh6ImbeZxjgm5NctvdTLD3
         vYonOtM+bQ7ACWNwsE7JLV5JScfsD8j8YyDZGEjJ1y3hEEWoHDuFWhJ7VFXKGnBXvYdR
         R0zQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fbarrat@linux.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=fbarrat@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fbarrat@linux.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=fbarrat@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 1/7] powerpc: Add TIDR CPU feature for Power9
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-2-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Mon, 7 May 2018 19:17:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418010810.30937-2-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050717-0040-0000-0000-000004560C64
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050717-0041-0000-0000-000020FA486F
Message-Id: <2f95cc6f-9843-e2b9-6fca-2f4153317a5f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070173
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957549327672109?=
X-GMAIL-MSGID: =?utf-8?q?1599826512060366931?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> This patch adds a CPU feature bit to show whether the CPU has
> the TIDR register available, enabling as_notify/wait in userspace.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>   arch/powerpc/include/asm/cputable.h | 3 ++-
>   arch/powerpc/kernel/dt_cpu_ftrs.c   | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> index 4e332f3531c5..54c4cbbe57b4 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -215,6 +215,7 @@ static inline void cpu_feature_keys_init(void) { }
>   #define CPU_FTR_P9_TM_HV_ASSIST		LONG_ASM_CONST(0x0000100000000000)
>   #define CPU_FTR_P9_TM_XER_SO_BUG	LONG_ASM_CONST(0x0000200000000000)
>   #define CPU_FTR_P9_TLBIE_BUG		LONG_ASM_CONST(0x0000400000000000)
> +#define CPU_FTR_P9_TIDR			LONG_ASM_CONST(0x0000800000000000)
> 
>   #ifndef __ASSEMBLY__
> 
> @@ -462,7 +463,7 @@ static inline void cpu_feature_keys_init(void) { }
>   	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
>   	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_ARCH_207S | \
>   	    CPU_FTR_TM_COMP | CPU_FTR_ARCH_300 | CPU_FTR_PKEY | \
> -	    CPU_FTR_P9_TLBIE_BUG)
> +	    CPU_FTR_P9_TLBIE_BUG | CPU_FTR_P9_TIDR)
>   #define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1) & \
>   			     (~CPU_FTR_SAO))
>   #define CPU_FTRS_POWER9_DD2_0 CPU_FTRS_POWER9
> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> index 11a3a4fed3fb..10f8b7f55637 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -722,6 +722,7 @@ static __init void cpufeatures_cpu_quirks(void)
>   	if ((version & 0xffff0000) == 0x004e0000) {
>   		cur_cpu_spec->cpu_features &= ~(CPU_FTR_DAWR);
>   		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TLBIE_BUG; > +		cur_cpu_spec->cpu_features |= CPU_FTR_P9_TIDR;


Isn't it redundant with adding the flag to CPU_FTRS_POWER9?

   Fred


>   	}
>   }
> 
