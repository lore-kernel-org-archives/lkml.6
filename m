Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55BDC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761E92085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdgAYYHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761E92085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeJZTc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbeJZTc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:32:58 -0400
Received: from localhost (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0EDC20856;
        Fri, 26 Oct 2018 10:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540551382;
        bh=aGATmLcXOagDPQFZuTeqfQE2MZY+inZuSEiSB2Sg2uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MdgAYYHHXFHymFE6jkRTHtn4jCqJqfiJ4/LlF7FU9MN3YwbYw5Z/HsNIoDO53HLoe
         Eig+Z5eCkW7shb3fW0PQJmcfZd5LQxy310RPZOjheXHBJWOIbTycBK/8DKPCPssdco
         FAdr92XSMDlZ7K/N8LTUQlSPwPBme13HAZtkMUxg=
Date:   Fri, 26 Oct 2018 06:56:20 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH AUTOSEL 4.14 03/15] Input: i8042 - enable keyboard
 wakeups by default when s2idle is used
Message-ID: <20181026105620.GC2015@sasha-vm>
References: <20181022102026.40869-1-sashal@kernel.org>
 <20181022102026.40869-3-sashal@kernel.org>
 <20181026090452.GB20200@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181026090452.GB20200@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 11:04:52AM +0200, Pavel Machek wrote:
>On Mon 2018-10-22 06:20:14, Sasha Levin wrote:
>> From: Daniel Drake <drake@endlessm.com>
>>
>> [ Upstream commit 684bec1092b6991ff2a7751e8a763898576eb5c2 ]
>>
>> Previously, on typical consumer laptops, pressing a key on the keyboard
>> when the system is in suspend would cause it to wake up (default or
>> unconditional behaviour). This happens because the EC generates a SCI
>> interrupt in this scenario.
>>
>> That is no longer true on modern laptops based on Intel WhiskeyLake,
>> including Acer Swift SF314-55G, Asus UX333FA, Asus UX433FN and Asus
>> UX533FD. We confirmed with Asus EC engineers that the "Modern Standby"
>> design has been modified so that the EC no longer generates a SCI
>> in this case; the keyboard controller itself should be used for wakeup.
>>
>> In order to retain the standard behaviour of being able to use the
>> keyboard to wake up the system, enable serio wakeups by default on
>> platforms that are using s2idle.
>
>Behaviour change, not a bugfix. Someone may like their laptop sleeping
>after keypress, we should not change it in the middle of -stable
>series.

Dmitry already asked for it to be dropped, so it's gone.

--
Thanks,
Sasha
