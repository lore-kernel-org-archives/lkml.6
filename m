Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521552722; cv=none;
        d=google.com; s=arc-20160816;
        b=ZPX2uMrXuAk2bL2z65LvXFOYV2v1U3AayikfEEF+N1ojEsMCG+5BQe8RwtTnCc1VuC
         6uh6aMaKILTOI0dgx+fK2nOz020N/haqa8K3U/m7/fl2vsan2GCCBAGhogKVF67JBQQ3
         NnOOJlj/AX8+ckuDXPS0gL0f0sAuKsRfKd5db+O6LXduHIr/F0g75EiDymSGRUzuM/WK
         kz07EoQOjdcshhFIoo3CDAs1K3G2NPEYi3UDyRmFGt6WUjD92+6kZgpLC8+P4OSbyKMq
         UnyuCYfpgHyXEwQL5s5xxkq2RUOzydOEYOrufO+eBjYFct0CpOKzm1/qtilTfqL87FGJ
         csPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:sender
         :dkim-signature:arc-authentication-results;
        bh=eHNdNcQ7PV+IGxnjt2gDTQegLc3xZc9J+pTtxfXaP74=;
        b=IeEFKh/SuPUgi2Epkb+i4a7/1RONMZ23wZm73q9B7WQf61kSiD19Prjsm5HRcUECgi
         QoyWkYTp1FYmMUqMBKM8E8rhTlcYLexMMfPVULn7227rI6GBiWFZoVYFpsfOXkSz2O1m
         0vBQik1FEOxymlNAaBlDyNbpDh4cyWri9I3QvcnsJ3SrNDWui7NfhNLp/QTtx3WjFjOP
         ILHrFV6q0tqGEQyxU41KIY0kVIXqqBtaXBnFMCi4eLcJdoyLSXvjxEbwWcljEQ7MC+cA
         2aQuJyC5G1MEoGrInkzKKh2oSqgegkJckpfMDMcUQDxWnuIgmRyKWrsFHJQHRNfqRuKc
         zI4w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=awaEbaCi;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=awaEbaCi;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AG47ELso8qNaUKOCNFFzLMCAqph3h+qzojwY5DhnAnBRTuUcFG5EHuIJcw/oAcfkZpkL2ILX/zFk8g==
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 4.4 000/134] 4.4.123-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 shuahkh@osg.samsung.com, patches@kernelci.org,
 ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
 stable@vger.kernel.org
References: <20180319171849.024066323@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <29591855-050f-073a-bc29-f0ff2832ab40@roeck-us.net>
Date: Tue, 20 Mar 2018 06:32:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595390786580465385?=
X-GMAIL-MSGID: =?utf-8?q?1595463667450971574?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/19/2018 11:04 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.123 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 21 17:18:04 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.4.122-134-gb4e03b4:

Build results:
	total: 145 pass: 140 fail: 5
Failed builds:
	arm:allmodconfig
	powerpc:defconfig
	powerpc:allmodconfig
	powerpc:cell_defconfig
	powerpc:maple_defconfig

arm:allmodconfig:

drivers/net/ethernet/marvell/mvpp2.c: In function 'mvpp2_probe':
drivers/net/ethernet/marvell/mvpp2.c:6451:10: error: 'struct mvpp2' has no member named 'hw_version'
   if (priv->hw_version == MVPP22) {
           ^
drivers/net/ethernet/marvell/mvpp2.c:6451:26: error: 'MVPP22' undeclared (first use in this function)
   if (priv->hw_version == MVPP22) {
                           ^
powerpc:

arch/powerpc/mm/hugetlbpage.c: In function 'add_huge_page_size':
arch/powerpc/mm/hugetlbpage.c:840:2: error: implicit declaration of function 'radix_enabled'

Guenter
