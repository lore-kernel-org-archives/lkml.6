Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F8FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802B921841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545101183;
	bh=HkltPihwmyOlTXZVDAe8tLtLgUuCWmQzS2knf9FAWCM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=AkM5a0aA9UG77FxKeepnAFgRRMRrmI8ZZYI3SfkkD+oTa6LonW3DZQFMD2yBkVOQj
	 dJBHEOHtI2148DQD6xIcveiDAuxtsu/J3nXm1Tbq0VWmYDWQyL9kBNMUTgD+0RHY60
	 yF54jf9wpzK0NyuS4YlxV3mUVNu7ROAzREYIQbnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeLRCqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 21:46:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbeLRCqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 21:46:21 -0500
Received: from [10.20.30.225] (net77-43-75-18.mclink.it [77.43.75.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB502145D;
        Tue, 18 Dec 2018 02:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545101181;
        bh=HkltPihwmyOlTXZVDAe8tLtLgUuCWmQzS2knf9FAWCM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JkyPb6gPIo364imJM/i39aCkUbs54vJGtNNSyptORvYqathDYSyO2GNw6vgNyKnM5
         LHktzgbX/Sc3L6eddF4rd6JAENO1j60mQSUoU8fTWK7BxHJ+FkpEc0iKZpxsR/7IXu
         k/sPS0ZcsGYkajvsxUGTFr4Os5pQ4XoOO5DZLdEc=
Subject: Re: [PATCH v10 6/6] ACPI/IORT: Stub out ACS functions when CONFIG_PCI
 is not set
To:     Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181215010247.26101-1-okaya@kernel.org>
 <20181215010247.26101-7-okaya@kernel.org>
 <40e31e86-a4ac-d9a6-d752-b04203d5ced7@huawei.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <80c186fe-e5ff-1d13-fad5-6386b21b45c4@kernel.org>
Date:   Tue, 18 Dec 2018 03:46:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <40e31e86-a4ac-d9a6-d752-b04203d5ced7@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/2018 3:14 AM, Hanjun Guo wrote:
> I prefer stub function for iort_enable_acs(), not adding #ifdef/#endif pair inside
> this function.

Yes, I'm reworking this per input from Lorenzo.

> 
> By the way, there are other pci function called in iort.c, could you explain a
> little bit why no need to update other function calls in commit message?

I added few words about why other code was not stubbed out.
