Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B66EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED8F206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfAGNiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:38:00 -0500
Received: from gruss.cc ([80.82.209.135]:51704 "EHLO mail.gruss.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbfAGNiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:38:00 -0500
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jan 2019 08:37:59 EST
Received: from [192.168.0.30] (80-110-159-138.static.upcbusiness.at [80.110.159.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: lava@gruss.cc)
        by mail.gruss.cc (Postfix) with ESMTPSA id 519502A00C5;
        Mon,  7 Jan 2019 13:29:04 +0000 (UTC)
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Jiri Kosina <jikos@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20190107043227.GA3325@nautica>
 <151b4ac8-5cfc-ed30-db30-e4d67a324c4b@suse.cz>
 <20190107110827.GA15249@nautica>
From:   Daniel Gruss <daniel@gruss.cc>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel@gruss.cc; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3b6525a6-4d8b-b5f4-67cd-0e230eb2691e@gruss.cc>
Date:   Mon, 7 Jan 2019 14:29:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107110827.GA15249@nautica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 12:08 PM, Dominique Martinet wrote:
>> That's my bigger concern here. In [1] there's described a remote attack
>> (on webserver) using the page fault timing differences for present/not
>> present page cache pages. Noisy but works, and I expect locally it to be
>> much less noisy. Yet the countermeasures section only mentions
>> restricting mincore() as if it was sufficient (and also how to make
>> evictions harder, but that's secondary IMHO).
> 
> I'd suggest making clock rougher for non-root users but javascript tried
> that and it wasn't enough... :)
> Honestly won't be of much help there, good luck?

Restricting mincore() is sufficient to fix the hardware-agnostic part.
If the attack is not hardware-agnostic anymore, an attacker could also
just use a hardware cache attack, which has a higher temporal and
spatial resolution, so there's no reason why the attacker would use page
cache attacks instead then.


Cheers,
Daniel
