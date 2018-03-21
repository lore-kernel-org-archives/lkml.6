Return-Path: <natechancellor@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521610154; cv=none;
        d=google.com; s=arc-20160816;
        b=Lo2QS7SvaOoJYJtCQyVtNUCffqTZ4B1hirdulqh2u81fuFeq99SSrYVIRC680D7zax
         13V7VNRKc06x/+sxUFbqY0CaP5lz6f3dfVLclRHhDCPnsO0VnLYDAAt8uco5OzB9KGIi
         l5kag3v86Lk5DmxgDoEZU8IwGht/giSRAhLqH1GgHovFeyEFdaH6ROWb/XXpexeQOzgK
         6SkLz83POsv8rxhP09D1meP59r0ePKbordhODk/K9rw7EsE3Mxg9NujSnweDBcaA91hL
         WBAxkJ4nf1HgkihRZzNzHRh9+uI7pL/WuQufUDQS4xS2IF5dqgc0bf40Rw2ROjsC45W8
         XgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ZZaWvw5oFM32Dp1cZMM18CXdkXc5+IgomdZtaWNtSuI=;
        b=GSnhhxq+ps8LGvR9e51y07I+pwuO1WWGj775U24xUtr25MqX+8FueOAnu3pzFE08TW
         lQmcOG6xSB6ICk0Dp0kAO6UWIRUBduPPiINiEIC/dx++fqCuhATR1QXDyACikVM8x8Mw
         XQyxk0xPqvepfAPyafU7g7pPUSukKXelsDNnQqkCYMMe4bTek8vNFCalW3TOjH+iD6e6
         iSeI90kgtEYaDF/4QUPdGiCWbqL+afm1Ik3bNrmmwnaAa4S5KvQgoJtRHR6JOww3o8Ii
         pAPxfXAN+OLvy1xZKvVAjZ/Z8SvG1WHteL6DpwAvJ/PaWynlE/+fGdduFjVFzdSvbPxs
         r5Zg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=K4nPwyGx;
       spf=pass (google.com: domain of natechancellor@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=natechancellor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=K4nPwyGx;
       spf=pass (google.com: domain of natechancellor@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=natechancellor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELth7qCY4r2VY+31aYR2PQipC7395rnbuDA0GA+b3JcvEC38WVeS+6Q0hZhv85Q5KCVlL3dcGQ==
Date: Tue, 20 Mar 2018 22:29:11 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuahkh@osg.samsung.com,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/134] 4.4.123-stable review
Message-ID: <20180321052911.GA14175@flashbox>
References: <20180319171849.024066323@linuxfoundation.org>
 <29591855-050f-073a-bc29-f0ff2832ab40@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29591855-050f-073a-bc29-f0ff2832ab40@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595390786580465385?=
X-GMAIL-MSGID: =?utf-8?q?1595523889758363439?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 06:32:00AM -0700, Guenter Roeck wrote:
> On 03/19/2018 11:04 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.123 release.
> > There are 134 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar 21 17:18:04 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> For v4.4.122-134-gb4e03b4:
> 
> Build results:
> 	total: 145 pass: 140 fail: 5
> Failed builds:
> 	arm:allmodconfig
> 	powerpc:defconfig
> 	powerpc:allmodconfig
> 	powerpc:cell_defconfig
> 	powerpc:maple_defconfig
> 
> arm:allmodconfig:
> 
> drivers/net/ethernet/marvell/mvpp2.c: In function 'mvpp2_probe':
> drivers/net/ethernet/marvell/mvpp2.c:6451:10: error: 'struct mvpp2' has no member named 'hw_version'
>   if (priv->hw_version == MVPP22) {
>           ^
> drivers/net/ethernet/marvell/mvpp2.c:6451:26: error: 'MVPP22' undeclared (first use in this function)
>   if (priv->hw_version == MVPP22) {
> 

Caused by commit 6349601ed3e1 ("net: mvpp2: set dma mask and coherent
dma mask on PPv2.2"), which seems irrelevant for 4.4 since PPv2.2
support was added in 4.12 per upstream commit fc5e1550e5c3 ("net: mvpp2:
finally add the PPv2.2 compatible string").

> powerpc:
> 
> arch/powerpc/mm/hugetlbpage.c: In function 'add_huge_page_size':
> arch/powerpc/mm/hugetlbpage.c:840:2: error: implicit declaration of function 'radix_enabled'
> 

Caused by commit 17cd5e81ded7 ("powerpc/mm/hugetlb: Filter out hugepage
size not supported by page table layout"). It is introduced in 4.7 in
upstream commit 566ca99af026 ("powerpc/mm/radix: Add dummy
radix_enabled()") and not properly turned on until upstream commit
a8ed87c92adf ("powerpc/mm/radix: Add MMU_FTR_RADIX"). I am going to
assume from the fact there is a lot of MMU work after this and the
wording of the Kconfig entry that this is probably not suitable fo
a stable backport.

> Guenter

Cheers,
Nathan
