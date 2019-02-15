Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2E3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8F1222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iFnPJz2x";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QRRNVvaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfBOT3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:29:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59056 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfBOT3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:29:30 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1F66160740; Fri, 15 Feb 2019 19:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550258969;
        bh=vC3nU2+7vIcRopeSLMrSbcjM6O+DDXSUpzvbzveJga4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iFnPJz2xHgPAfCYN8MkQH/lNSsQOxZr+phMHRNqW0A95R9E1B2oY0eJjRS3lJHlTy
         +XiOW6mmsz46WfxO6Ph9GJN0tIoRxhmq0i7JYidStTDWxDxwNYGxRrKYhy/naoIVjd
         UWNiSbx7IPMfM4Om80rkMCTEFTvYRBLIqor3K280=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4835360740;
        Fri, 15 Feb 2019 19:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550258967;
        bh=vC3nU2+7vIcRopeSLMrSbcjM6O+DDXSUpzvbzveJga4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QRRNVvaV0icUtH/94BZbB0gSAsRcS56lzSbRFakD9ObeZ5ggffDl+r73vJpHKrOhQ
         bqb2fFBYMaCC9Be8Lw8CgdxOpjIJ3frADEuKVQf4mZ+UuqvFU01lsrrDdYY6ofDbDL
         oHeVvBik89kxGY6Q5EwhWwjVSSXRljmUBYG78taM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4835360740
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH 2/9] clk: Introduce get_parent_hw clk op
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
References: <20190129061021.94775-1-sboyd@kernel.org>
 <20190129061021.94775-3-sboyd@kernel.org>
 <41f8f325-2738-3995-1fc8-354a9412041e@codeaurora.org>
 <155025643198.115909.9355230466710329335@swboyd.mtv.corp.google.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <488f5033-c7a5-b49b-b973-c1415e533019@codeaurora.org>
Date:   Fri, 15 Feb 2019 12:29:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <155025643198.115909.9355230466710329335@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/2019 11:47 AM, Stephen Boyd wrote:
> Quoting Jeffrey Hugo (2019-02-11 08:09:00)
>> On 1/28/2019 11:10 PM, Stephen Boyd wrote:
>>
>>> +static int clk_init_parent(struct clk_core *core)
>>> +{
>>> +     core->parent = __clk_init_parent(core, true);
>>> +     if (IS_ERR(core->parent))
>>> +             return PTR_ERR(core->parent);
>>> +
>>> +     /*
>>> +      * Populate core->parent if parent has already been clk_core_init'd. If
>>> +      * parent has not yet been clk_core_init'd then place clk in the orphan
>>> +      * list.  If clk doesn't have any parents then place it in the root
>>> +      * clk list.
>>> +      *
>>> +      * Every time a new clk is clk_init'd then we walk the list of orphan
>>> +      * clocks and re-parent any that are children of the clock currently
>>> +      * being clk_init'd.
>>> +      */
>>> +     if (core->parent) {
>>> +             hlist_add_head(&core->child_node,
>>> +                             &core->parent->children);
>>> +             core->orphan = core->parent->orphan;
>>> +     } else if (!core->num_parents) {
>>> +             hlist_add_head(&core->child_node, &clk_root_list);
>>> +             core->orphan = false;
>>> +     } else {
>>> +             hlist_add_head(&core->child_node, &clk_orphan_list);
>>
>> Missing "core->orphan = true;"?
>> The snippet below had that line.  Its not clear why it appears to be
>> dropped here.
>>
> 
> Hmm. Weird. I think I may have been getting ahead of myself and moving
> the orphan updating code into __clk_init_parent(). I can't remember why
> though, so I guess I'll go all the way and move it all into
> __clk_init_parent() now. Thanks for pointing it out.
> 

No problem.

Just FYI, I've rebased the 8998 mmcc series on top of this, and as far 
as I can tell, everything seems to be working great.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
