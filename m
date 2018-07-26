Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2189CC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8A220647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8A220647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbeGZEnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 00:43:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:43680 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbeGZEnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 00:43:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2E23AE8B;
        Thu, 26 Jul 2018 03:28:56 +0000 (UTC)
Subject: Re: [PATCH v4 1/3] lib: add crc64 calculation routines
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20180718165545.1622-1-colyli@suse.de>
 <20180718165545.1622-2-colyli@suse.de>
 <20180724042637.GA1944@sol.localdomain>
 <dd95ab25-562e-1318-19e9-c8163969252f@suse.de>
 <399c1cc851f983370a0308c76c68a97ff41a5d4f.camel@linux.intel.com>
 <01f8e352-a49f-2f41-6264-bb6395bb0bf2@suse.de>
 <20180725142246.23e354fcc21ef041bb3f87e6@linux-foundation.org>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=colyli@suse.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ad442c01-8fd7-12ac-3b8d-bfab738c7bde@suse.de>
Date:   Thu, 26 Jul 2018 11:28:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725142246.23e354fcc21ef041bb3f87e6@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/26 5:22 AM, Andrew Morton wrote:
> On Wed, 25 Jul 2018 10:37:23 +0800 Coly Li <colyli@suse.de> wrote:
> 
>>> IIUC this series in Andrew's quilt. So, it's still possible to replace
>>> it with better one, I suppose. Ask Andrew (at least I remember recent
>>> case where he just replaced series by fixed one).
>>
>> Hi Andrew,
>>
>> It seems there should be some fix/update for this series. I see current
>> series is in linux-next for now. If I want to add the fix, should I post
>> a new version of the series, or the incremental patches to fix current
>> series ?
> 
> mm...  it sounds like the changes will be large, so probably a new
> series would be better at this early stage.  If the changes are small
> then little fixup patches would be nicer to the people who have already
> reviewed v1.
> 

Yes, it is large (patch 3/3 will be removed). So I will post a new
series to replace current series.

Thanks for the hint.

Coly Li
