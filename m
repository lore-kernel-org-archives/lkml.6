Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE95AC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A55921871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545150027;
	bh=O0eLo7REp3cQc0ofV/CFX8S+nD7DIju1/SYBRr7ei8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FdzuFg7D7sgNnCcKJ9SKa4e0DpRK93zFIcwb6qe9YNb+8aw17MSQjHuzNcYgHXlMq
	 5yp5t4asXNLN+rlXSG3guX3xjGl2Td/WAZNU6RiYvCFEL2vGebdlqKSrGApnTOM/PU
	 OxNcyJXnLWf0zuh+HoGrReuwHhTW2ZqRZ1f++YIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeLRQU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:20:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbeLRQU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:20:26 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16F1421841;
        Tue, 18 Dec 2018 16:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545150024;
        bh=O0eLo7REp3cQc0ofV/CFX8S+nD7DIju1/SYBRr7ei8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qEH3GAjWwQ3jKv6QYvrX+J5HrdQfKYNRiOx0PuXBnNSpYU+ixyOa1xkHyGrxdUpXQ
         7Oks1hfSrIzXh/NM+ZrgWGcUDMZViseGOImPUcUhEWALBDMBN1qzVF0JfHahXRK2Gj
         iawOG3LRFtKGdnA5VUFWPmiCK8F2pdaeLMNBRJKI=
Date:   Tue, 18 Dec 2018 11:20:21 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Andy Gross <andy.gross@linaro.org>, bp@alien8.de,
        Daniel Drake <dsd@laptop.org>,
        David Brown <david.brown@linaro.org>, dou_liyang@163.com,
        Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Rutland <mark.rutland@arm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 0/7] v4.19-stable randconfig fixes
Message-ID: <20181218162021.GZ2746@sasha-vm>
References: <20181214221023.3878670-1-arnd@arndb.de>
 <20181218002028.GX2746@sasha-vm>
 <20181218151230.GA30844@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181218151230.GA30844@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 04:12:30PM +0100, Greg Kroah-Hartman wrote:
>On Mon, Dec 17, 2018 at 07:20:28PM -0500, Sasha Levin wrote:
>> On Fri, Dec 14, 2018 at 11:10:05PM +0100, Arnd Bergmann wrote:
>> > Hi Greg,
>> >
>> > I did some randconfig testing on linux-4.19 arm/arm64/x86. So far I needed
>> > 27 patches, most of which are also still needed in mainline Linux. I
>> > had submitted some before, and others were not submitted previously
>> > for some reason. I'll try to get those fixed in mainline and then
>> > make sure we get them into 4.19 as well.
>> >
>> > This series for now contains four patches that did make it into mainline:
>> >
>> > 2e6ae11dd0d1 ("slimbus: ngd: mark PM functions as __maybe_unused")
>> > 33f49571d750 ("staging: olpc_dcon: add a missing dependency")
>> > 0eeec01488da ("scsi: raid_attrs: fix unused variable warning")
>> > 11d4afd4ff66 ("sched/pelt: Fix warning and clean up IRQ PELT config")
>> >
>> > Feel free to either cherry-pick those from mainline or apply the
>> > patch from this series, whichever works best for you.
>> >
>> > The other three patches are for warnings in code that got removed in
>> > mainline kernels:
>> >
>> > 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events properly")
>> > 972910948fb6 ("ARM: dts: qcom: Remove Arrow SD600 eval board")
>> > effec874792f ("drm/msm/dpu: Remove dpu_dbg")
>> >
>> > My feeling was that it's safer to just address the warning by fixing
>> > the code correctly in each of these cases, but if you disagree,
>> > applying the mainline change should work equally well, so decide
>> > for yourself.
>>
>> Thanks Arnd, I took the series as is.
>>
>> We really need to discuss how -stable deals with removed code upstream.
>> For some cases, we should probably follow suit and remove it from
>> -stable as well (I'm mostly thinking dodgy code with potential security
>> issues).
>
>It would be nice to do that at times (like lustre and ipx), but it's
>good to keep that code around as maybe someone is using it?  I don't
>know, it's a tough call...

Yeah, it's really a case-by-case basis. I'm really concerned about an
unmaintained piece of code in stable kernels, no one actually fixes bug
in it.

With the example here where that eval board was removed because no one
was using it is a great example of code we should be removing from
stable trees as well. If no one is using it - great! but if someone
does, then the removal should be reverted upstream as well.

--
Thanks,
Sasha
