Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbeEBJBH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:01:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750895AbeEBJBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:01:03 -0400
Subject: Re: [PATCH 1/2] arm64/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
To: Ganesh Mahendran <opensource.ganesh@gmail.com>,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1525247672-2165-1-git-send-email-opensource.ganesh@gmail.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 2 May 2018 11:00:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525247672-2165-1-git-send-email-opensource.ganesh@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18050209-0012-0000-0000-000005D10C23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050209-0013-0000-0000-0000194E2B8C
Message-Id: <15c56137-e7c4-dbfa-ce5d-f5feeea79e98@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805020074
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2018 09:54, Ganesh Mahendran wrote:
> Set ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT for arm64. This
> enables Speculative Page Fault handler.
> 
> Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
> ---
> This patch is on top of Laurent's v10 spf
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index eb2cf49..cd583a9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -144,6 +144,7 @@ config ARM64
>  	select SPARSE_IRQ
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
> +	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT if SMP

There is no need to depend on SMP here as the upper
CONFIG_SPECULATIVE_PAGE_FAULT is depending on SMP.

>  	help
>  	  ARM 64-bit (AArch64) Linux support.
> 
