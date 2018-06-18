Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B399FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D8520862
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D8520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935025AbeFRKGo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:06:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58978 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934228AbeFRKGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:06:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFABA80D;
        Mon, 18 Jun 2018 03:06:40 -0700 (PDT)
Received: from [192.168.67.35] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 538653F25D;
        Mon, 18 Jun 2018 03:06:39 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH v2] drm/xen-front: fix pointer casts
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        boris.ostrovsky@oracle.com
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>
References: <20180523113630.29811-1-andr2000@gmail.com>
 <b516542b-a0f5-cbce-d351-25b88a7f3288@suse.com>
 <a8cff47d-a990-924a-0a63-b6f3aea3279b@gmail.com>
From:   Andre Przywara <andre.przywara@arm.com>
Message-ID: <ad523698-9c33-3fe1-9eeb-165cc775a936@arm.com>
Date:   Mon, 18 Jun 2018 11:06:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a8cff47d-a990-924a-0a63-b6f3aea3279b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/05/18 06:32, Oleksandr Andrushchenko wrote:
> On 05/23/2018 02:46 PM, Juergen Gross wrote:
>> On 23/05/18 13:36, Oleksandr Andrushchenko wrote:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>> Building for a 32-bit target results in warnings from casting
>>> between a 32-bit pointer and a 64-bit integer. Fix the warnings
>>> by casting those pointers to uintptr_t first.
>>>
>>> Signed-off-by: Oleksandr Andrushchenko
>>> <oleksandr_andrushchenko@epam.com>
>> Reviewed-by: Juergen Gross <jgross@suse.com>

> Thank you, applied to drm-misc-next

Is this the right branch? Shouldn't this go to drm-misc-fixes instead,
so it reaches the tree before the 4.18 release?
Just stumbled over the issue when compiling 4.18-rc1 for arm32, so it
definitely needs fixing in this cycle.

Cheers,
Andre.
