Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E37FC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6394A2085A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549128740;
	bh=3xu71e3Cn2CfjZBhaICEDB1igaFLcpFkc5SNMDya+Xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nHDLkfPWKvDFOHBYLQqOwTvnZ/MIuQd3AkHgz6QLck1uYJsM/4SaeUrfwxmZ3zjHK
	 O2UWe74RcYjuhHscdzHyn1HyLKXIUaz5kTzGiejW2SeeFX4dKF9JuWYSgjt508rn3/
	 NlXd4CsUZH3mD04nSFv5wi9USCZYmR25Fzdv9Bkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfBBRcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:32:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfBBRcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:32:18 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F3912085A;
        Sat,  2 Feb 2019 17:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549128737;
        bh=3xu71e3Cn2CfjZBhaICEDB1igaFLcpFkc5SNMDya+Xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ECjsgS/gj4MtK2OQZtQJmTB+uajhQAQjqot4NYwczIxBAil53FEfxa2sKhQyLOua2
         AknTIXksKBzgzkSXoNe9DmLAtk2a/k+iaCNPkzl7jcD3dNnqxskAE29TD/chyfBxwM
         AwS+kpoTKuFbcRGY6R1y8oLmSZonyjPcwpT/fLpw=
Date:   Sat, 2 Feb 2019 12:32:16 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Sean Paul <sean@poorly.run>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 4.19 083/258] drm: Move drm_mode_setcrtc() local
 re-init to failure path
Message-ID: <20190202173216.GZ3973@sasha-vm>
References: <20190128155924.51521-1-sashal@kernel.org>
 <20190128155924.51521-83-sashal@kernel.org>
 <20190128210341.GT114153@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190128210341.GT114153@art_vandelay>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 04:03:41PM -0500, Sean Paul wrote:
>On Mon, Jan 28, 2019 at 10:56:29AM -0500, Sasha Levin wrote:
>> From: Sean Paul <seanpaul@chromium.org>
>>
>> [ Upstream commit c232e9f41b136c141df9938024e521191a7b910d ]
>>
>> Instead of always re-initializing the variables we need to clean up on
>> out, move the re-initialization into the branch that goes back to retry
>> label.
>>
>> This is a lateral move right now, but will allow us to pull out the
>> modeset locking into common code. I kept this change separate to make
>> things easier to review.
>>
>> Changes in v2:
>> - None
>>
>> Reviewed-by: Daniel Vetter <daniel@ffwll.ch>
>> Signed-off-by: Sean Paul <seanpaul@chromium.org>
>> Link: https://patchwork.freedesktop.org/patch/msgid/20181129150423.239081-2-sean@poorly.run
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This probably doesn't need to get pulled back to stable. It was a pre-cursor for
>some new helper macros that also don't need to be pulled back.
>
>(Same comment for the 4.20 version)

Now dropped, thank you.

--
Thanks,
Sasha
