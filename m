Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034075AbeBOQZ4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:25:56 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:53966 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1033750AbeBOQZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:25:53 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Subject: Re: [PATCH] Drivers/mfd: Remove Non-standard Case Statements
To: Progyan Bhattacharya <bprogyan@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC: Lee Jones <lee.jones@linaro.org>, <patches@opensource.cirrus.com>
References: <20180215160441.4548-1-progyanb@acm.org>
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <f90497b0-89b9-f07f-3951-9a2fcd9073ae@opensource.cirrus.com>
Date: Thu, 15 Feb 2018 16:25:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180215160441.4548-1-progyanb@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802150199
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/18 16:04, Progyan Bhattacharya wrote:
> Remove Range Expressions from Case Statements and replace them with equivalent If-Else ladder. Comments are kept as is for understanding.
> 

Why?

Your commit message should at least say why you are making this change.
(It also should be wrapped to a sensible line length).

The "case x ... y:" style is used in many places all over the kernel. As
are other gcc extensions.

Is this a change in kernel coding style guidelines? Or are you trying to
make it a compile with a different compiler to normal?

Although I'm not a fan of non-standard C extensions, in my opinion the
case ... is more readable than the chain of if statements.

> Signed-off-by: Progyan Bhattacharya <progyanb@acm.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: patches@opensource.cirrus.com
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/mfd/cs47l24-tables.c | 30 +++++++++++++++++-------------
>   1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mfd/cs47l24-tables.c b/drivers/mfd/cs47l24-tables.c
> index c090974340ad..99eeb6bac5d5 100644
> --- a/drivers/mfd/cs47l24-tables.c
> +++ b/drivers/mfd/cs47l24-tables.c
> @@ -783,19 +783,23 @@ static const struct reg_default cs47l24_reg_default[] = {
>   
>   static bool cs47l24_is_adsp_memory(unsigned int reg)
>   {
> -	switch (reg) {
> -	case 0x200000 ... 0x205fff:	/* DSP2 PM */
> -	case 0x280000 ... 0x281fff:	/* DSP2 ZM */
> -	case 0x290000 ... 0x2a7fff:	/* DSP2 XM */
> -	case 0x2a8000 ... 0x2b3fff:	/* DSP2 YM */
> -	case 0x300000 ... 0x308fff:	/* DSP3 PM */
> -	case 0x380000 ... 0x381fff:	/* DSP3 ZM */
> -	case 0x390000 ... 0x3a7fff:	/* DSP3 XM */
> -	case 0x3a8000 ... 0x3b3fff:	/* DSP3 YM */
> -		return true;
> -	default:
> -		return false;
> -	}
> +    if (reg >= 0x200000 && reg <= 0x205fff) /* DSP2 PM */
> +        return true;
> +    if (reg >= 0x280000 && reg <= 0x281fff) /* DSP2 ZM */
> +        return true;
> +    if (reg >= 0x290000 && reg <= 0x2a7fff) /* DSP2 XM */
> +        return true;
> +    if (reg >= 0x2a8000 && reg <= 0x2b3fff) /* DSP2 YM */
> +        return true;
> +    if (reg <= 0x300000 && reg >= 0x308fff) /* DSP3 PM */
> +        return true;
> +    if (reg <= 0x380000 && reg >= 0x381fff) /* DSP3 ZM */
> +        return true;
> +    if (reg <= 0x390000 && reg >= 0x3a7fff) /* DSP3 XM */
> +        return true;
> +    if (reg <= 0x3a8000 && reg >= 0x3b3fff) /* DSP3 YM */
> +        return true;
> +    return false;
>   }
>   
>   static bool cs47l24_readable_register(struct device *dev, unsigned int reg)
> 
