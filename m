Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4A6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7D1217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549990243;
	bh=Y3CSSx75Y/hO0GPrKCgc6I+o5fwCbw3WykLU+L+ihSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=crfN8YgccEiB3G7TdPh2jPhzBMalsY6bfOi6DQmAR3gulSKExj9EOUBSKXmmdcPE1
	 88XIGf0LWWzX4c/U+lIOEoxjW01KFCVj6VrJqTvgPO+7IKjgk4zHMMMuHM/YVFDbcS
	 wgcWENSccqRGJ0odmyXap0ACHstmm6CEL93KQIHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfBLQum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:50:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731300AbfBLQuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:50:37 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29E69217D9;
        Tue, 12 Feb 2019 16:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549990237;
        bh=Y3CSSx75Y/hO0GPrKCgc6I+o5fwCbw3WykLU+L+ihSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p58lw/6/lRGrEa5EMdS/sDLZwPZyH9vw+VG/iKEW87lKs+u1xcGobvOTO33JMRqVj
         HTgu9YSJkou7eS0kacGL+9QV16Olm2e7qHFOEPBapGdry8QmC7EQ1tihyu1VACKHy+
         BXqSOZH0euJpy1XyhDnYdsNN0tmr+HyqgIiXaTMQ=
Date:   Tue, 12 Feb 2019 11:50:36 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 4.9 034/137] ARM: mmp/mmp2: dt: enable the clock
Message-ID: <20190212165036.GE69686@sasha-vm>
References: <20190211141811.964925535@linuxfoundation.org>
 <20190211141815.120436242@linuxfoundation.org>
 <20190211205125.GB22473@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190211205125.GB22473@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 09:51:25PM +0100, Pavel Machek wrote:
>Hi!
>
>> 4.9-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> [ Upstream commit f36797ee43802b367e59f0f9a9805304a4ff0c98 ]
>>
>> The device-tree booted MMP2 needs to enable the timer clock, otherwise
>> it would stop ticking when the boot finishes.
>>
>> It can also use the clock rate from the clk, the non-DT boards need to
>> keep using the hardcoded rates.
>>
>> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>> Acked-by: Pavel Machek <pavel@ucw.cz>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>While I agree this is good idea for mainline (thus my ack), I don't
>think it is suitable for stable, as older kernels will not run on OLPC
>in useful way, anyway.

Interesting, so OLPC doesn't run on 4.20?

--
Thanks,
Sasha
