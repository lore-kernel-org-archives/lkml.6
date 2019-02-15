Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46397C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087E421A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550253800;
	bh=EgUU/QduX6u0VziGeV9dbmMFrqcfmfkBp8h2/uFy38k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KPe5Gj4es6q5q8haKci79c/cwnJ4twiCHtk7i1FKYS70xuoLMaSeHL35zD2+aoRlt
	 f4FCv4DF+B2AbbW7Bd6o4Ym+a1EWHU5RNpJ6R8XUXG2HqDJJEgUWYEGPiOp0q2s5ri
	 8yVXLbjJyc7Q31BIocs97/LTkB0g7jLnecOvYELU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbfBOSCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730255AbfBOSCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:02:44 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 084BD21A4C;
        Fri, 15 Feb 2019 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550253764;
        bh=EgUU/QduX6u0VziGeV9dbmMFrqcfmfkBp8h2/uFy38k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XCYF8tvv7y/a5lGP7pHiTLA7ZNvSFrkqfHiijFoZq5Eu78xDW49Jvl5Q+mgvaHCNZ
         upnK1xyb7XRF8fw9XcytbXh8MdpmPdJHtyLlB+IcEsSkUtdQXTPVlM9lrGgbgLxjZb
         qAIsOzg7zJD3xf1q2ZrddPveucAYz56NeJKlO8dk=
Date:   Fri, 15 Feb 2019 13:02:42 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, graham@grahamc.com,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Userspace regression in LTS and stable kernels
Message-ID: <20190215180242.GC10616@sasha-vm>
References: <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
 <CAHk-=wjtH5ombebghG-SDNGppJF4a5bZAUqndtZ3tauWjgw5_w@mail.gmail.com>
 <20190214122027.c0df36282d65dc9979248117@linux-foundation.org>
 <20190215070022.GD14473@kroah.com>
 <20190215091000.GT4525@dhcp22.suse.cz>
 <20190215092013.GA32575@kroah.com>
 <20190215094205.GW4525@dhcp22.suse.cz>
 <20190215151912.GA10616@sasha-vm>
 <20190215155200.GB4525@dhcp22.suse.cz>
 <CAN1fySWnazf3Z7tCnK1p10+XYV1zGfBO-YqoE3LNoOfKpPO3zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAN1fySWnazf3Z7tCnK1p10+XYV1zGfBO-YqoE3LNoOfKpPO3zQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:18:30AM -0500, Samuel Dionne-Riel wrote:
>I'm sorry to interject here, but the issue was reported on the
>Kernel.org Bugzilla on February 2nd
>
> - https://bugzilla.kernel.org/show_bug.cgi?id=202497
>
>In the interest of better communication, if the need arises again, how
>should bugs in the RC kernels be reported so they (1) are spotted by
>the right maintainers and (2) not backported even though they were
>reported as causing breaking changes?

Sadly our bugzilla is rarely used, even though the information in that
particular bug report is perfect.

Maybe pinging LKML and stable@vger.kernel.org would be enough, specially
if you know that it's a stable commit that caused the regression.

--
Thanks,
Sasha
