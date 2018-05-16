Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeEPSlR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:41:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40054 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbeEPSlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:41:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5DD4B6055C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [RFC PATCH] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
To: Timur Tabi <timur@codeaurora.org>, linux-pci@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Jones <pjones@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
 <3120434b-9831-bf33-25b8-11aba1c1b648@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <9f8ea8f6-6005-1b46-4d75-4f89e04ad9c1@codeaurora.org>
Date: Wed, 16 May 2018 14:41:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3120434b-9831-bf33-25b8-11aba1c1b648@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/2018 2:31 PM, Timur Tabi wrote:
> On 05/16/2018 01:23 PM, Sinan Kaya wrote:
>> +        win_start = window->res->start - window->offset;
> 
> Can you guarantee that window->res->start is always >= window->offset?
> 

Resource offset is generally 0 when not translating or a positive number
that you subtract from the resource start to reach to the translating window.

Having a bigger offset than resource start should be considered a BIOS bug.

>> +        win_size = window->res->end - window->res->start + 1;
> 
> Use resource_size() instead.
> 

I'll fix it.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
