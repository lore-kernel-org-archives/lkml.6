Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225oQ8Ksv65Z6npI8qhVxhNREsF27irIAQwnoK9gemXP1HKkSf7B8xgBjS4ZyUwfHCbcI4tz
ARC-Seal: i=1; a=rsa-sha256; t=1518210682; cv=none;
        d=google.com; s=arc-20160816;
        b=Lij03ePZjb3UojuCAJPyMGbseje9OF/FqLcn6s6z96vfU2gpwepserhOFO7mdEvnkN
         f8zrClwKW7ZzEmEe9zHjJ8xxCongOUOECH0tgzhn8RcMcuNyV6HEdQHkq6/m7w6eQffO
         HnpkZwFi6LTQ5JQ5qm5eazs7ma+6+6EF3ogMo+V+cgcdxNNVZTaz9ZKlf824GMnU6cEn
         QZBb+N8lqyxXjnEWYvELTAV088UnMfmru3S+jNC4Lf6gC11HQ4LDYcLBM/Tnej2UnHPJ
         LpI4GYVKn4t1cFCVXDDZ1Xe35RF3/pxBs/4mDfJGAVkG/u4QOXq1qhONelEI6Xuja+4S
         qLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=eUQsPlAIXJNkMnDxrW+aUBY0w5zoZrySx1n4IRF1U8M=;
        b=YIXHzNeaCSaZ/SRDt82GNMoa01hNO1K3drkeJn05boX/E+hXNZueqoZ7MsuoGhuz/U
         C5OkMlUgaIaRnF55KqSREWMxkAN6+I2PgN3232YlcuG0Ss0rxfQ0cT+N+puLleuJxxqA
         g7JnxC77U+H7L/rpnQ1tS1leciUnAgtdxvGFopfNJ2cidb+aeLF7cp6GCR21C2u0GRmW
         2MudqBa+KKCZPayXVfitfef2VkWAnYXm4Biau3vpx+vFVb2Vaz0H7jm+aiSo8wXTteTN
         H38nNX1xLE69Ht3TfCPdtH1Bzk4CtWLpyM0qmFT+FPyvnJmdDhFhqU8DFwSw2fiOywPp
         NVgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=YNU66keI;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=YNU66keI;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeBIVLW (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 9 Feb 2018 16:11:22 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:44422 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeBIVLV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Feb 2018 16:11:21 -0500
Date: Fri, 9 Feb 2018 15:11:19 -0600
From: Dan Rue <dan.rue@linaro.org>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: linux-kselftest@vger.kernel.org,
        "Li, Philip" <philip.li@intel.com>, linux-kernel@vger.kernel.org,
        "Li Zhijian(intel)" <zhijianx.li@intel.com>
Subject: Re: [kselftests] compaction_test is blocked
Message-ID: <20180209211119.xbch2eok6holyvel@xps>
References: <700acd92-2b0b-d2da-615e-1f228708d216@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <700acd92-2b0b-d2da-615e-1f228708d216@cn.fujitsu.com>
User-Agent: NeoMutt/20171215
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591909123815142975?=
X-GMAIL-MSGID: =?utf-8?q?1591959284606545712?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 03:53:59PM +0800, Li Zhijian wrote:
> Hi
> 
> kselftests is integrated Intel 0Day project.
> Sometimes we found compaction_test is blocked for more than 1 hours until i kill it.
> 
> Try to figure out where it is running, i added some log to this case.
> 
> the test log is like:
> -------------------
>  [  111.750543] main: 248
>  [  111.750544]-
>  [ 111.750821] check_compaction: 98
>  [  111.750822]-
>  [  111.751102] check_compaction: 105
>  [  111.751103]-
>  [  111.751362] check_compaction: 111
>  [  111.751363]-
>  [  111.751621] check_compaction: 118
>  [  111.751622]-
>  [  111.751879] check_compaction: 123
>  [  111.751880]-
> -------------------
> 118         fprintf(stderr, "%s: %d\n", __func__, __LINE__);
> 119         lseek(fd, 0, SEEK_SET);
> 120
> 121         /* Request a large number of huge pages. The Kernel will allocate
> 122            as much as it can */
> 123         fprintf(stderr, "%s: %d\n", __func__, __LINE__);         <<<======== the last line we can catch.
> 124         if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {        <<<<============ blocking position
> 125                 perror("Failed to write 100000 to /proc/sys/vm/nr_hugepages\n");
> 126                 goto close_fd;
> 127         }
> 128
> 129         lseek(fd, 0, SEEK_SET);
> 130
> 131         fprintf(stderr, "%s: %d\n", __func__, __LINE__);
> 132         if (read(fd, nr_hugepages, sizeof(nr_hugepages)) <= 0) {
> 133                 perror("Failed to re-read from /proc/sys/vm/nr_hugepages\n");
> 134                 goto close_fd;
> 135         }
> -------------------
> 
> According to above log and code, it most likely it is blocking at the writing operation.
> 
> my environment is like:
> OS: debian
> kernel: v4.15
> model: Ivytown Ivy Bridge-EP
> nr_cpu: 48
> memory: 64G

Hi Zhijian,

Please try this patch in mainline:

    4c1baad22390 kselftest: fix OOM in memory compaction test

Dan

> 
> 
> NOTE: 0Day can reproduce this issue in 20% on 0Day.
> 
> Anybody can help have a look?
> 
> Thanks
> Zhjian
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kselftest" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
