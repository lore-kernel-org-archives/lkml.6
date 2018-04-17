Return-Path: <andrew.donnellan@au1.ibm.com>
X-Google-Smtp-Source: AIpwx4+vxDmMlQy8nD69mmAfamoz3hH1U8xaLS6/RdUoA55qGsD5IsqSz5pn6HhPlR2poE0gOfwV
ARC-Seal: i=1; a=rsa-sha256; t=1523938191; cv=none;
        d=google.com; s=arc-20160816;
        b=HT7F1cbk/asbgTIgCwtYIoFIbPpWbULcc5AZMhTfpzbGZQxKPdsqG8KPCp5QUZ6YBK
         rAefrwaSfRcoLiei8Cbt4DVNew8tLhvJ0fYNGWk7J+ILW2VJEFAttv/W0Ef9zZK7dV3z
         CqcN5aR027GY3rip9Ws/IDmOc81Y39gcQWzCqHzeaMl8uBJjQNMMYGywaOxUDt/9e5z6
         DHkDDf5md2XwdA5KJTEpa2/5Dgik3wHLoaAOwiQaySe1kA4a5z/7nN2lsh6+CDwN19Hu
         4ZQc+MpItH0FCR5exf6ib6q69k0xPB1kqP++OPPxpKQYrg63Bpu1/sayCoHYRywvJIsY
         RxOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=p92Iby5TIQcYFHfYgKIq2pj9lJCo0G/NuaI4Mce1hHQ=;
        b=Ln3/Hk0EbS91fM3LoV1Y0n0C/60WrCiW7al8XKsgjW/wzoCM4KxBtiEJs4Dvi+NB3w
         Mmy4K+9+3PgxhV1APofbOtkdL8S82LXeQ5qlZmbO3JS71iOgaGIOynbidEjw8v8xH9Zo
         THLmarpSpJXXYjCt7tKnmGEMavO6rf1GOJIz6itdN7r67g6PQzIQpxO57mrEWA1vhD1s
         k2fEPwNjG1aXzycq7y/2hlVc4dQBSFAqGDS8R/QtgQtM8Wo1U0sUji1a/h7EiF6kLEQU
         8LTHdq9aDTDjl+lycw/aU1kkTeW314E+mgyrgdSmj5fs66xqfq7yX9WyrAimuZFdld4O
         RoaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 1/7] powerpc: Add TIDR CPU feature for Power9
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180417020950.21446-2-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 17 Apr 2018 14:09:41 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417020950.21446-2-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041704-0008-0000-0000-000004EC150D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041704-0009-0000-0000-00001E80165A
Message-Id: <68ec9aff-b523-dd30-cd73-42dc8c792ba1@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170038
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957549327672109?=
X-GMAIL-MSGID: =?utf-8?q?1597965013579064809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 17/04/18 12:09, Alastair D'Silva wrote:
> diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
> index be8c9fa23983..5b03d8a82409 100644
> --- a/arch/powerpc/include/asm/switch_to.h
> +++ b/arch/powerpc/include/asm/switch_to.h
> @@ -94,6 +94,5 @@ static inline void clear_task_ebb(struct task_struct *t)
>   extern int set_thread_uses_vas(void);
>   
>   extern int set_thread_tidr(struct task_struct *t);
> -extern void clear_thread_tidr(struct task_struct *t);

This hunk looks like it really belongs in patch 3.

Apart from that, I'm not really familiar with the CPU features code but 
nothing seems overly wrong...

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
