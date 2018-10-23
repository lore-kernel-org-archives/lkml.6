Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB37DC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B265B20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZIErCGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B265B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeJXAMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbeJXAMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:12:02 -0400
Received: from localhost (unknown [185.7.230.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8309320652;
        Tue, 23 Oct 2018 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540309686;
        bh=dO1+o7PyIRWJ7a26ZZ1qG4D9FRDPdNue2NpDlY61XfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uZIErCGb+z75nnIuzXpXQ/XB1kGIzOrQrWINIwIqSRKyOe2uFTbNkFiliJmhxp3sI
         Wc0OM0PHopCSBlErc/uzcANHbiOuDDAypTh70MSC5UF81IlpHew4ZE64bOBVgOIWEE
         VAgE5d2WZ46XOh4a92gIdzggkE07TK/r6dke+p/Y=
Date:   Tue, 23 Oct 2018 11:48:02 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH AUTOSEL 4.18 04/27] Input: i8042 - enable keyboard
 wakeups by default when s2idle is used
Message-ID: <20181023154802.GA24189@sasha-vm>
References: <20181022101924.40531-1-sashal@kernel.org>
 <20181022101924.40531-4-sashal@kernel.org>
 <20181022165821.GA27929@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181022165821.GA27929@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 09:58:21AM -0700, Dmitry Torokhov wrote:
>Hi Sasha,
>
>On Mon, Oct 22, 2018 at 06:19:01AM -0400, Sasha Levin wrote:
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
>I disagree that this should be included in stable as it does not fix a
>regression on the aforementioned platforms and has a potential to alter
>the behavior. The fact that the system does not wake up on keyboard is
>not a showstopper, wakeup usually happens on lid open anyway.
>
>It is hitting 4.19 LTS train and that should be enough. Please do not
>pick up for earlier stables.

Dropped, thanks!
