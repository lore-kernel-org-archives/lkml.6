Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B42CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537AB214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546982614;
	bh=CXv07+17/GObEjoV+q22ZxUN/Z3MA2Wrw0leW3XBZ9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iDciatLXY40pHP/MODG9M4gDlxgh+Jsq/TAoa2M1k12aeqBLJbFAMbUBKjuLn4ctJ
	 WtUZRa0t4NCi1WrZD29VefCRqjcw4MHTokpgxuupMaBx2bF5SQ8KcvlCXDKIRC0S84
	 Eoi/kD6V+JciZaKEwuYhD8bgpMtj1tX4pWC2uNZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfAHVXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:23:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729511AbfAHVXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:23:32 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09FF420883;
        Tue,  8 Jan 2019 21:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546982612;
        bh=CXv07+17/GObEjoV+q22ZxUN/Z3MA2Wrw0leW3XBZ9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5k4AqLsfuRF27e5QFg+3gFFhkpSxDfmf7J8/XOdVDbX0/OWjBnEhGnRaP5MT5m2Z
         /VI9v4bqh+mSlDB8yRTPnaF1B3uCN3RMmcSwN0TXOBKu80F+ekizQAgg+iLc3tFwL1
         XMOlQjF44K7dRPMHCuGIrS0p0n7isT81U+r2BsZE=
Date:   Tue, 8 Jan 2019 16:23:30 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, devel@linuxdriverproject.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] hv_balloon: avoid touching uninitialized struct page
 during tail onlining
Message-ID: <20190108212330.GI166797@sasha-vm>
References: <20190104141942.19126-1-vkuznets@redhat.com>
 <2ea7e975-6aae-de71-83e5-9302518802ef@redhat.com>
 <87d0p837lt.fsf@vitty.brq.redhat.com>
 <20190107175650.GG166797@sasha-vm>
 <87a7kc2u03.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87a7kc2u03.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 07:38:20PM +0100, Vitaly Kuznetsov wrote:
>Sasha Levin <sashal@kernel.org> writes:
>
>> On Mon, Jan 07, 2019 at 02:44:30PM +0100, Vitaly Kuznetsov wrote:
>>>P.S. I still think about bringing mem_hotplug_begin()/done() to
>>>hv_balloon but that's going to be a separate discussion, here I want to
>>>have a small fix backportable to stable.
>>
>> This should probably be marked for stable then :)
>>
>
>Yes, please :-)

Queued up for hyperv-fixes with a -stable tag, thank you!

--
Thanks,
Sasha
