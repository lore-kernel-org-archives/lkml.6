Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbeDFBei (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 21:34:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58590 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeDFBef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 21:34:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B79DA60274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
To: linux-mips@linux-mips.org, arnd@arndb.de, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <41e184ae-689e-93c9-7b15-0c68bd624130@codeaurora.org>
Date: Thu, 5 Apr 2018 21:34:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/2018 8:55 AM, Sinan Kaya wrote:
> While a barrier is present in writeX() function before the register write,
> a similar barrier is missing in the readX() function after the register
> read. This could allow memory accesses following readX() to observe
> stale data.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/mips/include/asm/io.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index fd00ddaf..6ac502f 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -377,6 +377,7 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
>  		BUG();							\
>  	}								\
>  									\
> +	rmb();								\
>  	return pfx##ioswab##bwlq(__mem, __val);				\
>  }
>  
> 

Can we get these merged to 4.17? 

There was a consensus to fix the architectures having API violation issues.
https://www.mail-archive.com/netdev@vger.kernel.org/msg225971.html


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
