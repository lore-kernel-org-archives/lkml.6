Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZpuV7o/iCfqaJDb+LlCjWA4Jey4vsOjFHyBmmIvzXABLpRidOfyIxHUD6CH5tdP5pupTw3o
ARC-Seal: i=1; a=rsa-sha256; t=1525749227; cv=none;
        d=google.com; s=arc-20160816;
        b=ie8pq2I3lfldbrMpha13lSadr3uzKHwDrbU0Ao9QPYdWMouBsbpHHeDlLmtNjk2aB1
         hxefQbtKTq80czkgprN3QVgjp3slm8BlhL+C4wHV8mPCGFa73ZQ2TaGj7dxuxvHrEdnk
         S+tUtqllJdAcEJcBKv/3e5OjBBCIYnkBW56VUE+Ti+mEKoNUPIcT+JaQX175uTv2WZr1
         uETNBBCWltEGH7jQvSFZbTi/wGR63y4KRNxG/K/VzoEoCq+/phAH3UrCwDjZfzzMwmaR
         3dtWGjzVz1OVWWD2n2lliJipJ17FYjhjQPZiccNkoSiDsqCLWXszd6CDUdwNyI6cbiO6
         62hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:organization
         :references:in-reply-to:date:cc:to:from:subject
         :arc-authentication-results;
        bh=c1i+xZIElj0NDVBE0x3DiEhkNtvMgpW5DPog7qenn9k=;
        b=dGEmFsMFcCSI2Vkc0vHaR9G3rymue2NgWFTkJEfAldMBP9WrKCfvgzXLtqbiyNQytg
         rF8TUNrnksJqvWW1mmLUnAQPbkiFr/3yi8G5E9CCFPwnuBbPj/37bxNNDOd6LpZhbvDX
         bp8RHrPJwcJ5J4r39r9rEVcFL3uy5c021ZZXdCUpidsaKRKuylB/1w6qjJOEcLeDS7Xw
         Mfuhwce6wqyd3ciqxCb50CK2hzj1bR91KooiESPd+nsQbc0pD6Ati9Y5W3t1BJk2XnTT
         POLax9gXI174t6rXML+OthzRJMZ2bb9SZaB7XzZqBrXpNW6YyXwwLaKM3In7ttoVQw93
         SRPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 1/7] powerpc: Add TIDR CPU feature for Power9
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, arnd@arndb.de, linux-doc@vger.kernel.org,
        malat@debian.org, gregkh@linuxfoundation.org, corbet@lwn.net,
        vaibhav@linux.vnet.ibm.com, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, fbarrat@linux.vnet.ibm.com,
        aneesh.kumar@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com,
        pombredanne@nexb.com, felix@linux.vnet.ibm.com,
        sukadev@linux.vnet.ibm.com
Date: Tue, 08 May 2018 13:13:37 +1000
In-Reply-To: <2f95cc6f-9843-e2b9-6fca-2f4153317a5f@linux.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
	 <20180418010810.30937-1-alastair@au1.ibm.com>
	 <20180418010810.30937-2-alastair@au1.ibm.com>
	 <2f95cc6f-9843-e2b9-6fca-2f4153317a5f@linux.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050803-0012-0000-0000-000005D3CC1E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050803-0013-0000-0000-00001950D915
Message-Id: <1525749217.7796.48.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805080030
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957549327672109?=
X-GMAIL-MSGID: =?utf-8?q?1599864021955066261?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-05-07 at 19:17 +0200, Frederic Barrat wrote:
> 
> Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > This patch adds a CPU feature bit to show whether the CPU has
> > the TIDR register available, enabling as_notify/wait in userspace.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >   arch/powerpc/include/asm/cputable.h | 3 ++-
> >   arch/powerpc/kernel/dt_cpu_ftrs.c   | 1 +
> >   2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/include/asm/cputable.h
> > b/arch/powerpc/include/asm/cputable.h
> > index 4e332f3531c5..54c4cbbe57b4 100644
> > --- a/arch/powerpc/include/asm/cputable.h
> > +++ b/arch/powerpc/include/asm/cputable.h
> > @@ -215,6 +215,7 @@ static inline void cpu_feature_keys_init(void)
> > { }
> >   #define CPU_FTR_P9_TM_HV_ASSIST		LONG_ASM_CONST(0x0
> > 000100000000000)
> >   #define CPU_FTR_P9_TM_XER_SO_BUG	LONG_ASM_CONST(0x00002000
> > 00000000)
> >   #define CPU_FTR_P9_TLBIE_BUG		LONG_ASM_CONST(0x0000
> > 400000000000)
> > +#define CPU_FTR_P9_TIDR			LONG_ASM_CONST(0x00
> > 00800000000000)
> > 
> >   #ifndef __ASSEMBLY__
> > 
> > @@ -462,7 +463,7 @@ static inline void cpu_feature_keys_init(void)
> > { }
> >   	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
> >   	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_ARCH_207S |
> > \
> >   	    CPU_FTR_TM_COMP | CPU_FTR_ARCH_300 | CPU_FTR_PKEY | \
> > -	    CPU_FTR_P9_TLBIE_BUG)
> > +	    CPU_FTR_P9_TLBIE_BUG | CPU_FTR_P9_TIDR)
> >   #define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 |
> > CPU_FTR_POWER9_DD1) & \
> >   			     (~CPU_FTR_SAO))
> >   #define CPU_FTRS_POWER9_DD2_0 CPU_FTRS_POWER9
> > diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c
> > b/arch/powerpc/kernel/dt_cpu_ftrs.c
> > index 11a3a4fed3fb..10f8b7f55637 100644
> > --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> > +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> > @@ -722,6 +722,7 @@ static __init void cpufeatures_cpu_quirks(void)
> >   	if ((version & 0xffff0000) == 0x004e0000) {
> >   		cur_cpu_spec->cpu_features &= ~(CPU_FTR_DAWR);
> >   		cur_cpu_spec->cpu_features |=
> > CPU_FTR_P9_TLBIE_BUG; > +		cur_cpu_spec->cpu_features 
> > |= CPU_FTR_P9_TIDR;
> 
> 
> Isn't it redundant with adding the flag to CPU_FTRS_POWER9?
> 
>    Fred
> 

No, cpu_features is populated from device tree, not from
CPU_FTRS_POWER9. Since TIDR will not be explicitly requested in the
device tree, we need to handle it in quirks.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
