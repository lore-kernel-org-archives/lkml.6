Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25B4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E43020685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raqxfohp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E43020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbeGWOAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:00:24 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39699 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388245AbeGWOAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:00:23 -0400
Received: by mail-pl0-f65.google.com with SMTP id m1-v6so198624plt.6;
        Mon, 23 Jul 2018 05:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=E7Msz+qgDSES4Lwo0Oub7SQkLrkl8nKH7KIUjvPJ6Js=;
        b=raqxfohpJnpCs0RJkm6jiCyhQfLuBYGPYz6Tc1xFXsxGsGpv26o6FZj3VtzmWc2lwC
         2hc/89JGObAFyy2f93A8kBMYozh9IhQQKll5E+rKTf1dhCOtOYhWq+fBlfhcoHEsIuTi
         V4+IRiIxgG0pNmPMBnYNVtiZj3eLLR8L1Tc86B5+LiDCYZljTFiDDH19MigmrKK8amhR
         EpsZXbHR4ivECtzmJfpQnZFN9Fh2gH1v76CnSabywh3zRSbCsJzWzydLqJ9o6JkkBs1R
         YQBjQuz87J8ABxpeXpwY5vJTKDu8Z5oFuiajfeRAeG12025mqE8bMhoFKpSNxF9ld/Mz
         iQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=E7Msz+qgDSES4Lwo0Oub7SQkLrkl8nKH7KIUjvPJ6Js=;
        b=Ci2dp4JI1mcR071XYevToxV/MrWX6D0SNp0JrGOkHBGzm9hYhqGc8K5jPHqnL/VUpd
         wd8/5L/SFAIZmSnwwxiAIkKesjZkpyymqtlVJOoqslZUJ7Chl4sidpLjKxWZGUe6nG6x
         dDCMeP3i88Bn7T1uAklC9FLxthftOq2IkW8eG7DTkn4RHDza/spVah148twOIySdmrxG
         0YXPJHABYzndqOoPCAHYLjdhMA0pJW+dLoERLn441aiRkLZJltp0qSCKTYgBynUMXKiU
         c+Zhd4WPZk0WumLXCCmdVcImqba7NUroZoFGNXmWt1hfzvzkU27FPJgAN7EHXLO3biZA
         Dj4w==
X-Gm-Message-State: AOUpUlET4xefZABa0oSDYths+j3Nu/5qjV3etohKURP+nyk/nVNrhoKH
        XQlt11EirdcEp4PH16cqBfqrrmVa
X-Google-Smtp-Source: AAOMgpfPevsej8RySYKazYTg+7bIAI6d4Uh+As5SBfwXXVPNLCA4mOchnL2znXibFXHJeTsjiV14gA==
X-Received: by 2002:a17:902:8e81:: with SMTP id bg1-v6mr12790927plb.129.1532350755151;
        Mon, 23 Jul 2018 05:59:15 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:101.5.211.5? ([2402:f000:1:1501:200:5efe:6505:d305])
        by smtp.gmail.com with ESMTPSA id g7-v6sm9378363pfi.175.2018.07.23.05.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 05:59:14 -0700 (PDT)
Subject: Re: [PATCH] block: ioprio: Replace GFP_ATOMIC with GFP_KERNEL in
 set_task_ioprio()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180723022116.6919-1-baijiaju1990@gmail.com>
 <20180723071803.GA30817@infradead.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <4517e5f9-84db-aa1f-609f-a01f1d4f5d79@gmail.com>
Date:   Mon, 23 Jul 2018 20:59:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180723071803.GA30817@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply :)


On 2018/7/23 15:18, Christoph Hellwig wrote:
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> But to me it seems that btrfs and maybe ext4 as well would be much
> better off just setting a per-IO priority in the bio.
>
> Any chance yo could look into that?

In fact, my tool does not report any defects in btrfs and ext4.


Best wishes,
Jia-Ju Bai
