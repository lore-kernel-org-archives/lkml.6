Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26CFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19D02075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfBVLy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:54:28 -0500
Received: from ns.iliad.fr ([212.27.33.1]:58798 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfBVLy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 06:54:27 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id B0BFE20E2A;
        Fri, 22 Feb 2019 12:54:25 +0100 (CET)
Received: from [192.168.108.68] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 9368A20B77;
        Fri, 22 Feb 2019 12:54:25 +0100 (CET)
Subject: Re: [PATCH v2 3/5] soc: qcom: socinfo: Expose custom attributes
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Vaishali Thakkar <vaishali.thakkar@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
References: <20190220045829.6852-1-vaishali.thakkar@linaro.org>
 <20190221121841.GA32108@pendragon.ideasonboard.com>
 <20190221155742.GD2122@tuxbook-pro>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <a65d1ec4-8078-a878-3db0-084d1504c4df@free.fr>
Date:   Fri, 22 Feb 2019 12:54:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221155742.GD2122@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Fri Feb 22 12:54:25 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2019 16:57, Bjorn Andersson wrote:

> On Thu 21 Feb 04:18 PST 2019, Laurent Pinchart wrote:
> 
>> On Wed, Feb 20, 2019 at 10:28:29AM +0530, Vaishali Thakkar wrote:
>> 
>>> The Qualcomm socinfo provides a number of additional attributes,
>>> add these to the socinfo driver and expose them via debugfs
>>> functionality.
>> 
>> What is the use case for these attributes ? I fear they will be used in
>> production systems, and that would require debugfs in production, which
>> isn't a good idea. If you need to expose those attributes for anything
>> else than debugging then we need a proper API, likely sysfs-based.
> 
> The use case of these attributes, beyond development/debugging, are
> unfortunately somewhat unknown and is the reason why they where moved to
> debugfs from the earlier attempts to upstream this.
> 
> I think the production requirements at hand prohibits debugfs to be
> present, so attributes that are required beyond development/debugging
> purposes would have to be migrated out to sysfs - but the idea here is
> that such migration would have come with the missing motivation to add
> them there today.

On a tangential note, I saw the following message when using PCIe:

atl1c 0000:01:00.0: vpd r/w failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update
pcilib: sysfs_read_vpd: read failed: Connection timed out

Is this in any way related to custom attributes?

Regards.
