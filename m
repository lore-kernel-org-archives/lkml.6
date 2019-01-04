Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC5BC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B7A2070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfADHDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 02:03:38 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:37216 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbfADHDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 02:03:37 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07863735|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07383;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.DhF606j_1546585413;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.DhF606j_1546585413)
          by smtp.aliyun-inc.com(10.147.42.135);
          Fri, 04 Jan 2019 15:03:33 +0800
Subject: Re: [RFC v4 0/3] pstore/rom: new support logger for block devices
To:     "Luck, Tony" <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1546501533-1855-1-git-send-email-liaoweixiong@allwinnertech.com>
 <3908561D78D1C84285E8C5FCA982C28F7D4B623C@ORSMSX110.amr.corp.intel.com>
From:   =?UTF-8?B?5buW5aiB6ZuE?= <liaoweixiong@allwinnertech.com>
Message-ID: <e94cfa87-9f25-101e-708c-c116b90e8e45@allwinnertech.com>
Date:   Fri, 4 Jan 2019 15:03:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D4B623C@ORSMSX110.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Tony:
On 2019-01-04 01:18, Luck, Tony wrote:
> I'm curious why you call this "pstore/rom" rather than the more descriptive "pstore/block".
Because there is "pstore/ram", so i name it as "pstore/rom".
It's nice to rename it "pstore/block", i will change it in next version
of patch.
> 
> It looks to be a really good idea.
Should i add "Acked-by" in next version of patch?
I have little experience in sending patch to upstream linux.
> 
> I think you need to document how the "write" function for the block device must be written.
> Since pstore calls this at "panic" time, the write path:
> 
> + Cannot allocate any memory
> + Must be polled, not interrupt driven
> + Cannot take any locks that may be held by regular code
> + ... perhaps other restrictions that I can't think of right now
> 
> The memory allocation restriction is likely easy to get around. Just allocate anything
> you need at pstore "init" time rather than waiting until the panic.
>I will provide a documemt for it in next version of patch.
> -Tony
> 
