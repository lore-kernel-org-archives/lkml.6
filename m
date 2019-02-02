Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08CBC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9428720869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549128610;
	bh=aSXeqrCcxAYDIoqNYoZUE5F9DY3WLDkJpLVMkUpyOTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IdX7MuFFeztQ9mD2UB6rqp0BZgM6jEtvMBjML+tHzR8cJrywyl8OrVOBmd4Dmt9o8
	 7Z99TDbad/M3CNBK0Lp+aQ5eGvH85/8qyZW8ELpZqMqxSrX4NXJnwx7Oz9ll+ydev8
	 obn5L7cCwVTNAA14FopOUryih6mdjT94793hBbKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfBBRaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfBBRaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:30:05 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4F952085A;
        Sat,  2 Feb 2019 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549128605;
        bh=aSXeqrCcxAYDIoqNYoZUE5F9DY3WLDkJpLVMkUpyOTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyhfzuZZQCtVkVww+TtsK88JFfIZjsPDjt/GRMwqqDz1mei4KBlT6+3CROptEVdxT
         MfEWVRjm19qSCCLoQllh3q24uIWQcRtUByFLUZlSpLCIp1tH3HcQpZlrtnjNs4Nz3C
         sPCErpTTTI6NV5tRmlnA2apgjMOGydJ/rY3nbtvg=
Date:   Sat, 2 Feb 2019 12:30:03 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <ren_guo@c-sky.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.19 181/258] tools uapi asm: Update
 asm-generic/unistd.h copy
Message-ID: <20190202173003.GY3973@sasha-vm>
References: <20190128155924.51521-1-sashal@kernel.org>
 <20190128155924.51521-181-sashal@kernel.org>
 <CAK8P3a2Xi-P9CxVgxxzf1iFg9htus670GHu7MAo2VPT1Tw+E-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK8P3a2Xi-P9CxVgxxzf1iFg9htus670GHu7MAo2VPT1Tw+E-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 05:56:55PM +0100, Arnd Bergmann wrote:
>On Mon, Jan 28, 2019 at 5:07 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>>
>> [ Upstream commit 89a0948984896352cac1ebe079cb3d64d6c3adc6 ]
>>
>> To get the change in:
>>
>>   b7d624ab4312 ("asm-generic: unistd.h: fixup broken macro include.")
>>
>> That doesn't imply in any changes in the tools.
>
>This one should only be in linux-4.20, not any earlier tree that
>does not also backport b7d624ab4312, otherwise the uapi headers
>are wrong.
>
>I don't think we want b7d624ab4312 backported, it would only
>be useful if we backport all y2038 patches.

I dropped it, thanks!

--
Thanks,
Sasha
