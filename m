Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D674C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A56C222D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OBIZh2NH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L33Ba0dS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392282AbfBOVex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:34:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58848 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbfBOVew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:34:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8D06460740; Fri, 15 Feb 2019 21:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550266491;
        bh=iINz1J/kWeXA8OIScImdjmAqVvGyFD8fIdrQ0CUopQs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OBIZh2NHUYXYDHx961KmuAGuma6iC/jq8gWaL41DHTvP2ATU13ZM82gz1lrQUq1Gk
         lCLyuedKJVWnuYUXRMSQO9dYGg7iXf0isf+3agn8wVtCK7/6n6tMAXUFqf18ENObBm
         tibIYKhNShgTYlm5E3gIhC8A5QVgbYTI5nn1KxAk=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2744860709;
        Fri, 15 Feb 2019 21:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550266490;
        bh=iINz1J/kWeXA8OIScImdjmAqVvGyFD8fIdrQ0CUopQs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L33Ba0dSDLM9f3k4fFNLzhgUQIZyic3VCYKs0LNAggPm1taI68wA60nV9LTX3w9k4
         j/LdcWDRgVb6qSWMZ7D+aR8gc04KYTowQq0pk7OPpI9/TV+wES+iL9+vElr0hk4Q1I
         3+M1vTxoG7xl66muUCgMF9uDiWkz0qf8oWqXmsfs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2744860709
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
 <488f5033-c7a5-b49b-b973-c1415e533019@codeaurora.org>
 <155026616459.115909.14315694127255521155@swboyd.mtv.corp.google.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <b5e37298-eb2b-be4e-e5b6-ecbd06bc12b5@codeaurora.org>
Date:   Fri, 15 Feb 2019 14:34:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <155026616459.115909.14315694127255521155@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/2019 2:29 PM, Stephen Boyd wrote:
> Quoting Jeffrey Hugo (2019-02-15 11:29:26)
>> On 2/15/2019 11:47 AM, Stephen Boyd wrote:
>>> Quoting Jeffrey Hugo (2019-02-11 08:09:00)
>>>> On 1/28/2019 11:10 PM, Stephen Boyd wrote:
>>>>
>>>>> +static int clk_init_parent(struct clk_core *core)
>>>>> +{
>>>>> +     core->parent = __clk_init_parent(core, true);
>>>>> +     if (IS_ERR(core->parent))
>>>>> +             return PTR_ERR(core->parent);
>>>>> +
>>>>> +     /*
>>>>> +      * Populate core->parent if parent has already been clk_core_init'd. If
>>>>> +      * parent has not yet been clk_core_init'd then place clk in the orphan
>>>>> +      * list.  If clk doesn't have any parents then place it in the root
>>>>> +      * clk list.
>>>>> +      *
>>>>> +      * Every time a new clk is clk_init'd then we walk the list of orphan
>>>>> +      * clocks and re-parent any that are children of the clock currently
>>>>> +      * being clk_init'd.
>>>>> +      */
>>>>> +     if (core->parent) {
>>>>> +             hlist_add_head(&core->child_node,
>>>>> +                             &core->parent->children);
>>>>> +             core->orphan = core->parent->orphan;
>>>>> +     } else if (!core->num_parents) {
>>>>> +             hlist_add_head(&core->child_node, &clk_root_list);
>>>>> +             core->orphan = false;
>>>>> +     } else {
>>>>> +             hlist_add_head(&core->child_node, &clk_orphan_list);
>>>>
>>>> Missing "core->orphan = true;"?
>>>> The snippet below had that line.  Its not clear why it appears to be
>>>> dropped here.
>>>>
>>>
>>> Hmm. Weird. I think I may have been getting ahead of myself and moving
>>> the orphan updating code into __clk_init_parent(). I can't remember why
>>> though, so I guess I'll go all the way and move it all into
>>> __clk_init_parent() now. Thanks for pointing it out.
>>>
>>
>> No problem.
>>
>> Just FYI, I've rebased the 8998 mmcc series on top of this, and as far
>> as I can tell, everything seems to be working great.
>>
> 
> Cool. Are you using the new way to specify parents or have you
> maintained the previous design of using string names for parents?
> 

I fully converted to the new way, although I did it in stages, so both 
paths got tested during the conversion.  I plan on posting v2 next week.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
