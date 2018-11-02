Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCA4C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685A22082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685A22082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeKBVh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:37:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33612 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeKBVh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:37:56 -0400
Received: from [IPv6:2a02:8109:92c0:207d:adf1:b546:cba2:bcad] (unknown [IPv6:2a02:8109:92c0:207d:adf1:b546:cba2:bcad])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robertfoss)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8D04B27DF2A;
        Fri,  2 Nov 2018 12:30:51 +0000 (GMT)
Subject: Re: [PATCH v2] drm/msm: Move fence put to where failure occurs
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181102121313.23271-1-robert.foss@collabora.com>
 <154116100076.30246.13155169401499183452@skylake-alporthouse-com>
From:   Robert Foss <robert.foss@collabora.com>
Message-ID: <0e882e0f-07a0-e217-6e88-082a09e87986@collabora.com>
Date:   Fri, 2 Nov 2018 13:30:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154116100076.30246.13155169401499183452@skylake-alporthouse-com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Chris,

On 2018-11-02 13:16, Chris Wilson wrote:
> Quoting Robert Foss (2018-11-02 12:13:13)
>> If dma_fence_wait fails to wait for a supplied in-fence in
>> msm_ioctl_gem_submit, make sure we release that in-fence.
>>
>> Also remove this dma_fence_put() from the 'out' label.
>>
>> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> 
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

Danke!

> 
> Rob, this probably merits a cc:stable tag -- if the wait was interrupted
> by a signal, the fence would be leaked.

Ack, CC-ed the v2 submission.


Rob.
