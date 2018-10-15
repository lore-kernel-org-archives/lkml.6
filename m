Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D05C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B942083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B942083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbeJOUGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:06:47 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:60737 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeJOUGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:06:46 -0400
Subject: Re: 32-bit poweroc compile failure in v4.19-rc7-166-g7ec21823634d
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <17d36e6c-f99a-abfb-12cd-fa4b14bc7e09@linux.ee>
 <87tvlnzegi.fsf@concordia.ellerman.id.au>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <7c9c56d8-df58-eac7-e41e-8d2746f1c0d5@linux.ee>
Date:   Mon, 15 Oct 2018 15:20:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87tvlnzegi.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I tried to test the fix to 32-bit poweroc boot hang but found that current git does not compile on 32bit poweroc at all for me:
> 
> That's GCC 8 I think?

Yes, gcc version 8.2.0 (Debian 8.2.0-7).

> I have seen that but couldn't work out what the hell GCC is thinking.
> 
> I don't think there's an actual bug, the size of the copy is bounded by
> the count parameter, which *doesn't* come from user space, it's hard
> coded.
> 
> I suspect the logic is just to convoluted for GCC.
> 
> We should fix it somehow, but I haven't worked out what's the best option.
> 
> cheers

-- 
Meelis Roos <mroos@linux.ee>
