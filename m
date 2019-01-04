Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346E7C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5E52184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ssbc8c61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfADC0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 21:26:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44686 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfADC0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 21:26:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so17536241pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 18:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=t6FXvHIoL5V6ieq/6gT4KVrc2DPo1EeQkePL34Ostbg=;
        b=Ssbc8c611j+YmWU6sLtBHTxqO1NqcHVz8Gg4no8nU286aGYMR6odZcfwQl37rRd2kQ
         v80GiiCSNArWNoDZAYPlnH0VGKKldcU/V0JMaRdKyMHKO88Ia/MOrg9G53TyhNs29TU3
         TeWxkORHWGKx9bDbwSQBsbIajsuNFwqPc02JrmdN/qBAqjn+qe7eASBofBoHw6hFhkKY
         EGHWcpXzxFkg+BzxA0DeZxijzK4UBIZvffCC5zWOJrmiVLpRdgpaD/xbGlwN84X6Qkgw
         HSchPANIMmXs4gvOG3LwCujYdmRnVtRxaMrqTauOCfWVbXkuMMAHlKVYNFoeF6ArRSgw
         L/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=t6FXvHIoL5V6ieq/6gT4KVrc2DPo1EeQkePL34Ostbg=;
        b=Xh49BlbmAEgOpBp2VWHNeGC53FH1/hZV9R5afyo6FIVLayiZpxJmC88hpHLzQtFUZx
         dNbyIlG5vgPrOhfB96vUvzDUyQpEqImjjsMvTP+/dSPyclYBUV8gbeBWNpwcpFgPkLTm
         R5/eHRzAiw8MqLi4b60F4f85Gs4Q7QQYlz7jKokoptm7DRYj9FisZpEVYP1FpOXFmD/M
         ybS5ZfLcL1B2rqxW5GRLa7iQ2zm0pa3/9HSKeNyAG1xTvcagJJyYH2yiGgr2KGxDKkzl
         W+FEsAghZsJpux3bOdP+93NUAF/2cMB3xh3VeN/9cBMTjFdX7+BEBNT0Z5M7MCThiaaj
         FyxQ==
X-Gm-Message-State: AJcUukeSpIxjhWEKJzHJ/ktPomulCzZJLKnEsE06YctW80a5xScKVXAZ
        a9orU/AisI8BjB9LlXvNtmE8SyZj
X-Google-Smtp-Source: ALg8bN7/XMRPb6DvwJSM5HxtW7XJfMVWgBHcAfbTdNyMDmq0mnmIvi4+JdgjWJOm/jaeITsR2iZOzA==
X-Received: by 2002:a65:4b82:: with SMTP id t2mr110706pgq.189.1546568793497;
        Thu, 03 Jan 2019 18:26:33 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.49? ([2402:f000:1:1501:200:5efe:a66f:4731])
        by smtp.gmail.com with ESMTPSA id g26sm74036839pfh.61.2019.01.03.18.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 18:26:33 -0800 (PST)
Subject: Re: [PATCH] fsi:fsi-sbefifo: Fix possible concurrency use-after-free
 bugs in sbefifo_user_release
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        dhowells@redhat.com, joel@jms.id.au, eajames@linux.vnet.ibm.com,
        andrew@aj.id.au
Cc:     linux-kernel@vger.kernel.org
References: <20181226135618.12784-1-baijiaju1990@gmail.com>
 <0adee96b58a533bc8c5927039e96b5ed77c9bbad.camel@kernel.crashing.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <798fbb98-0cba-07f8-2165-180c63012e95@gmail.com>
Date:   Fri, 4 Jan 2019 10:26:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <0adee96b58a533bc8c5927039e96b5ed77c9bbad.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/4 8:47, Benjamin Herrenschmidt wrote:
> On Wed, 2018-12-26 at 21:56 +0800, Jia-Ju Bai wrote:
>> In drivers/fsi/fsi-sbefifo.c, the functions sbefifo_user_release(),
>> sbefifo_user_read() and sbefifo_user_write() may be concurrently executed.
> So after refreshing my mind, looking at the code and talking with Al, I
> really dont' see what race you are trying to fix here.
>
> read/write should never be concurrent with release for a given file and
> the stuff we are protecting here is local to the file instance.
>
> Do you have an actual problem you observed ?
>

Thanks for the reply.

In fact, this report is found by a static tool written by myself, 
instead of real execution.
My tool found that in some drivers, for the structure "struct 
file_operations", the code in intetrfaces ".read" , "write" and 
".release" are protected by the same lock.
The functions kcs_bmc_read(), kcs_bmc_write() and kcs_bmc_release() are 
examples.
Thus, my tool inferred that the intetrfaces ".read" , "write" and 
".release" of "struct file_operations" can be concurrently executed, and 
generated this report.
I manually checked this report, but I was not very sure of it, so I 
marked it as a "possible bug" and reported it.

 From your message, now I know my report is false, and ".read" , "write" 
cannot be concurrently executed with ".release" for a given file.
Sorry for my false report, and thanks for your message.


Best wishes,
Jia-Ju Bai
