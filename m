Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10F7C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E912085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rp75+3NQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E912085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJHWBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbeJHWBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:01:24 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC69C2085B;
        Mon,  8 Oct 2018 14:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539010159;
        bh=MELPN+DG+xKjsse7OW7DCZ1Qthkf1UtQts5dIjorlAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rp75+3NQ0ufEZfXUoJELTBv1vBFedMnJ1fo412XvwIYR86zZQTGq/ec5LJy6JYvGU
         uNRhZ7k/WCeoqbROAvhVgq1xkiM1smHen9HOMFn86koQ0yk3ZEwdgM5IeyrGLksw3U
         QVLMAJC3r5K1v8bbcui7TqigaOCO/iLyd54boDVo=
Date:   Mon, 8 Oct 2018 10:49:17 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Zhu, Rex" <Rex.Zhu@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC for
 smu7/8
Message-ID: <20181008144917.GE32006@sasha-vm>
References: <20180924113103.999624566@linuxfoundation.org>
 <20180924113125.488862921@linuxfoundation.org>
 <BN6PR12MB18092FFEF5BB3861912C8535F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <BN6PR12MB18092FFEF5BB3861912C8535F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 02:33:56PM +0000, Deucher, Alexander wrote:
>> -----Original Message-----
>> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Sent: Monday, September 24, 2018 7:53 AM
>> To: linux-kernel@vger.kernel.org
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
>> stable@vger.kernel.org; Wentland, Harry <Harry.Wentland@amd.com>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, Rex
>> <Rex.Zhu@amd.com>; Sasha Levin <alexander.levin@microsoft.com>
>> Subject: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC for
>> smu7/8
>>
>> 4.18-stable review patch.  If anyone has any objections, please let me know.
>>
>
>This regresses power usage on 4.18.  Please revert.
>https://bugzilla.kernel.org/show_bug.cgi?id=201275

Hi Alex,

Thank you for the report.

I'm working on improving this process, I'd be very grateful if you could
answer a few questions about this:

1. Is the same breakage seen upstream? (if so, it should be reverted
there as well and we can grab the revert into -stable).
2. Does the issue reported by this patch ("pipes seem to hang with a 4k
DP and 1080p HDMI display") exist in the 4.18 stable tree?
3. If not, could you briefly explain why?


The algorithm I use was very confident about this patch being stable
material, and when I looked at it back then (and again now) I was very
confident of the same. If I can understand where I was wrong I could
improve my process.

Thank you!
