Return-Path: <fbarrat@linux.ibm.com>
X-Google-Smtp-Source: AB8JxZoqSPcIMyghan+Wm93eF94oCn21vrDbYv4YOC/2M5oE2uCRN97/RToN/xY4iY7d2JbAP4KD
ARC-Seal: i=1; a=rsa-sha256; t=1525713604; cv=none;
        d=google.com; s=arc-20160816;
        b=F5/ScflC58+nLE5yYzHZ6OOMwqYSr1MltA7XMgigR907+Q1WINolVMkFalQFzfhoOB
         PJhK9M4Y78X86OgZWAV0vQrOFjnKyfL4fS990HgOcCRmm/CnFLCvl8kMn4y+uZ1yw7TG
         ku9Nnma69EoF3Hk78LoF8kBEiZLg9dOIo7e+sX3Ykop2skb8L4nupfLR24Ji3azsz0xH
         cGROgb9g02UBuRZjI6iST8Nlxt4uXxjcQq7xhnNChImMSNUwQd2gWalypbgpN1UXu2Ip
         fHx4cszZKGwmNQULvhZ3TOhyIkeXIZ8vbR1qKmFWnRCETguPKN9Bv79NjUGe37ILR1J7
         nJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=c7D2eg2IGbfK8dR/9w5updnMQhkx5dpMxghed3+XGf8=;
        b=NI+HtEswdUF8scGIMXuAI1JQzPynUObzns/oWfiz+PTlX/pix3uVHYUhwmBcHqh1he
         wLwc98quvotzDc0hlxvD9TB4RMkmI0z86Ykt4hSoEyLEQjcYo+BqCPUb7pS2SqBxANJr
         4gLLA7umff1xXQw35huHKPGeQ8Ps0VjGf/UfcLAZRHgvOJHd7G1LReEDRLyGBuVkkBPE
         eEdVv8gw4Q0fjEVtEqmAV6ifIy16tePyphT4MeuzTXKEz/WCiH125VysnHKIS/tO+Nzh
         fPjS4xf2jK2TfqdZZoUOfMELs5ZmBEh/cta26OsTENFmOqRVVoQH0lVV969yKLvGNdj7
         jpUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fbarrat@linux.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=fbarrat@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fbarrat@linux.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=fbarrat@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 2/7] powerpc: Use TIDR CPU feature to control TIDR
 allocation
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
 <20180418010810.30937-3-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Mon, 7 May 2018 19:19:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418010810.30937-3-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050717-0020-0000-0000-0000041A0B20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050717-0021-0000-0000-000042AF3FB8
Message-Id: <772d6e5d-54c2-0512-b8e6-21d12d8c44cc@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070174
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957550458920157?=
X-GMAIL-MSGID: =?utf-8?q?1599826668072549214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Switch the use of TIDR on it's CPU feature, rather than assuming it
> is available based on architecture.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   arch/powerpc/kernel/process.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 1237f13fed51..3b00da47699b 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1154,7 +1154,7 @@ static inline void restore_sprs(struct thread_struct *old_thread,
>   			mtspr(SPRN_TAR, new_thread->tar);
>   	}
> 
> -	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
> +	if (cpu_has_feature(CPU_FTR_P9_TIDR) &&
>   	    old_thread->tidr != new_thread->tidr)
>   		mtspr(SPRN_TIDR, new_thread->tidr);
>   #endif
> @@ -1570,7 +1570,7 @@ void clear_thread_tidr(struct task_struct *t)
>   	if (!t->thread.tidr)
>   		return;
> 
> -	if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
> +	if (!cpu_has_feature(CPU_FTR_P9_TIDR)) {
>   		WARN_ON_ONCE(1);
>   		return;
>   	}
> @@ -1593,7 +1593,7 @@ int set_thread_tidr(struct task_struct *t)
>   {
>   	int rc;
> 
> -	if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +	if (!cpu_has_feature(CPU_FTR_P9_TIDR))
>   		return -EINVAL;
> 
>   	if (t != current)
> 
