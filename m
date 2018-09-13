Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D5EC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D337220882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XrYnrj3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D337220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeIMPFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 11:05:11 -0400
Received: from m12-14.163.com ([220.181.12.14]:42721 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeIMPFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 11:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=12PIk
        rbyDH141P5nOQXg/XjsqpEE2dEo7iYHdV4Mb7U=; b=XrYnrj3Wa2IkHmTSAPggc
        KZSDXnZmVpZVnyrK8s22rVwtLPO+n/MhFYaRCRUXUXShkqSWsQDIJTVlO0ABZYOm
        MKfOXbQj1N7hfVBZPzY8CycSC5iy/vuPVQB7gYKxcHZVPvpi+VKrCt8IhBfNSa/Y
        C/ILa22r+YLdSZZrC/glCY=
Received: from localhost.localdomain (unknown [49.65.59.196])
        by smtp10 (Coremail) with SMTP id DsCowABn0NYONJpbgEk7Qw--.28196S2;
        Thu, 13 Sep 2018 17:55:28 +0800 (CST)
Subject: Re: [PATCH] sched/core: Fix compiling warring in smp=n case
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
References: <20180810023523.23923-1-douly.fnst@cn.fujitsu.com>
From:   Dou Liyang <dou_liyang@163.com>
Message-ID: <2278505d-94ce-ab68-dbe3-5e4e1c9094ef@163.com>
Date:   Thu, 13 Sep 2018 17:55:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180810023523.23923-1-douly.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowABn0NYONJpbgEk7Qw--.28196S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU60tCUUUUU
X-Originating-IP: [49.65.59.196]
X-CM-SenderInfo: pgrxszxl1d0wi6rwjhhfrp/1tbiIBDAolWBjWXkrQAAsn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



At 08/10/2018 10:35 AM, Dou Liyang wrote:
> When compiling kernel with SMP disabled, the build warns with:
> 
> kernel/sched/core.c: In function ‘update_rq_clock_task’:
> kernel/sched/core.c:139:17: warning: unused variable ‘irq_delta’ [-Wunused-variable]
>    s64 steal = 0, irq_delta = 0;
> 
> Fix this by revert the HAVE_SCHED_AVG_IRQ to
> 
>    defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> 
> Fixes: 2e62c4743adc ("sched/fair: Remove #ifdefs from scale_rt_capacity()")

Hi,

  Miguel also found this warning. Can we pick it up now? ;-)

Thanks,
	dou





