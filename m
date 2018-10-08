Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2012AC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E459A2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E459A2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeJHXm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:42:58 -0400
Received: from mail1.windriver.com ([147.11.146.13]:41964 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeJHXm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:42:57 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w98GUFoV019858
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 8 Oct 2018 09:30:15 -0700 (PDT)
Received: from [128.224.162.216] (128.224.162.216) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 8 Oct
 2018 09:30:15 -0700
Subject: Re: [PATCH v5 4/4] printk: Give error on attempt to set log buffer
 length to over 4G
To:     Petr Mladek <pmladek@suse.com>
CC:     <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>
References: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
 <1538239553-81805-4-git-send-email-zhe.he@windriver.com>
 <20181008135916.gg4kkmoki5bgtco5@pathway.suse.cz>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <2a9ea0e6-f1df-7dcd-e2e8-383e297ccc5f@windriver.com>
Date:   Tue, 9 Oct 2018 00:30:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008135916.gg4kkmoki5bgtco5@pathway.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.216]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年10月08日 21:59, Petr Mladek wrote:
> I tried this patch with log_buf_len=5G. The kernel did not crash
> but dmesg shown some mess. There are several 32-bit variables
> to store the size, for example:
>
> static u32 log_buf_len = __LOG_BUF_LEN;
> u32 log_buf_len_get(void)
> static u32 log_first_idx;
> static u32 log_next_idx;
>
> I guess that the code somewhere does not detect an overflows
> correctly.
>
> I am not motivated enought to add support for such huge message
> buffer. Therefore I suggest to limit it to 32G for now.

I'm also fine with this suggestion. Thanks.

Zhe

