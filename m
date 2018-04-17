Return-Path: <andrew.donnellan@au1.ibm.com>
X-Google-Smtp-Source: AIpwx49S0BCUzOrH2Brx3SKgjBqAUrSh30LgvM/mxKKETH2pa9Syraq+Zs0+sJj6JPcsKr8vLNVR
ARC-Seal: i=1; a=rsa-sha256; t=1523938881; cv=none;
        d=google.com; s=arc-20160816;
        b=YvytjHfkzHxDs9P3Q8nOEgDfFMcrWH2MKMGsCYv+2Iegib9IFtq1/fVkclzi8RyhuR
         j9dKuhFM2o+JYcQsuYmfjnCZRmNDqF03bjZa19fYh7ABwYc//gbGrSVbOLpoTLXoXyQL
         gHDnKnKKS0bDvKi+/IL5jH7Nd9SggAQ0RB2feafmE/zerTG4WMLO9xqDfmnG3FOQT3M6
         2DW3TxsoIY6EVkd7wkb2fKuRRLRMve0IlDhbpzOzAgEepZOWR6d9jBbsnRChmJMAmuJS
         x0dNZO5v11f0ZYlMbSBqW6Zdx7uJmynZ13YYijmI0e8yPkxKq4K149POvsslmtQNKsgE
         IvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=0VNjdQncFwjR/yLCyX9j4iD6x8EOZL0Wr6+SvVqNWrw=;
        b=SeyIsJWhiwFmAyls9ZKut/tFvXZtGzf5nVb8Jk4YAzCeabbfXF4SVntqIZ9nB17DQb
         mUSCGMNV+RHLPmX9cr26lHqZstynsHS/sjylVJBFuFSi5KDViuVUgcoPqKM4pQe9OaeR
         DKLV+otsWaOGf5oDHX3n7jY2zh4bSixQ+Gttm/n6VtcWQRRirI2IynrjW9VlJHmis4z+
         QbYOE+NwrZGD8zs7LY5ymG4PKDkzf/xbkxIhPCLRGarc3el21yDoWZQUUUs14tFag6Sv
         lNmAAkFq81NPkq1ZCmbK/lLnq6hVwkwUSrfAzWvmf/+q2AIzo1pOxahJHTVJA3vE280A
         upYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 2/7] powerpc: Use TIDR CPU feature to control TIDR
 allocation
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180417020950.21446-3-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 17 Apr 2018 14:21:10 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417020950.21446-3-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041704-0044-0000-0000-00000549000A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041704-0045-0000-0000-000028890B4F
Message-Id: <89476138-a279-761a-21be-4a7cd1d80167@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170039
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957550458920157?=
X-GMAIL-MSGID: =?utf-8?q?1597965736471865906?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 17/04/18 12:09, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Switch the use of TIDR on it's CPU feature, rather than assuming it
> is available based on architecture.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

There's a use of TIDR in restore_sprs() that's behind the ARCH_300 flag 
as well, ideally it should never trigger in the !P9_TIDR case, but you 
might want to update that too for clarity?

> ---
>   arch/powerpc/kernel/process.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 1237f13fed51..a3e0a3e06d5a 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
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

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
