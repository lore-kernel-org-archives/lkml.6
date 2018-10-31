Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433E9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9A920838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9A920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbeJaMfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:35:38 -0400
Received: from relay.sw.ru ([185.231.240.75]:55596 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbeJaMfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:35:38 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gHhLl-0004IV-L6; Wed, 31 Oct 2018 06:39:21 +0300
Subject: Re: [PATCH v2 11/11] ext4: access to uninitialized bh fields in
 ext4_xattr_set_handle()
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <cover.1540935522.git.vvs@virtuozzo.com>
 <b8523c3a-0eb2-3aeb-fdf9-2e9d6d320d5c@virtuozzo.com>
 <48BA929C-9BF7-4092-BDD3-BECB64AF0599@dilger.ca>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <0db97e14-c87d-9507-4c87-875835b64212@virtuozzo.com>
Date:   Wed, 31 Oct 2018 06:39:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <48BA929C-9BF7-4092-BDD3-BECB64AF0599@dilger.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/2018 04:30 AM, Andreas Dilger wrote:
> Could you please explain your statement below that on-stack
> initialization does not zero unspecified fields?  According 
> to documents I found, for example:
> 
> https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
> 
> they *are* initialized to zero. 

I did not know it,
I re-checked it in generated assembler code and found that you are right and I was wrong.

Please drop this patch,
should I resend of rest of this patch set once again?

Thank you,
	Vasily Averin
