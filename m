Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEBAC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C631C2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUx3pgfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C631C2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbeKBAut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbeKBAut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:50:49 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43D092064C;
        Thu,  1 Nov 2018 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541087238;
        bh=Wgum0xJ58utTgeg4nreWxtxPMg+pgn5vLCPyUZYLPmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUx3pgfJXhhLGiLQwPFxoQlzo29j3q5ADKeu6sZ862pcAc9nm4Q0eLO71B/rNyd4b
         VUeMiqEcZA4doR5JtQ/p2clXDQS7prFZaEPVYTYzQm1aLukziZuE701bx/1WBJet3Q
         GYtzm02fmcOkl/T7CGRUtYquRzUR40VYvT+Ne9bo=
Date:   Thu, 1 Nov 2018 11:47:17 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 022/146] cpupower: Fix coredump on VMWare
Message-ID: <20181101154717.GZ194472@sasha-vm>
References: <20181031230541.28822-1-sashal@kernel.org>
 <20181031230541.28822-22-sashal@kernel.org>
 <7c08983b-a8c5-0dbc-c8aa-2c6a6799e1ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7c08983b-a8c5-0dbc-c8aa-2c6a6799e1ee@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 07:43:35AM -0400, Prarit Bhargava wrote:
>
>
>On 10/31/2018 07:03 PM, Sasha Levin wrote:
>> From: Prarit Bhargava <prarit@redhat.com>
>>
>> [ Upstream commit f69ffc5d3db8f1f03fd6d1df5930f9a1fbd787b6 ]
>>
>> cpupower crashes on VMWare guests.  The guests have the AMD PStateDef MSR
>> (0xC0010064 + state number) set to zero.  As a result fid and did are zero
>> and the crash occurs because of a divide by zero (cof = fid/did).  This
>> can be prevented by checking the enable bit in the PStateDef MSR before
>> calculating cof.  By doing this the value of pstate[i] remains zero and
>> the value can be tested before displaying the active Pstates.
>>
>> Check the enable bit in the PstateDef register for all supported families
>> and only print out enabled Pstates.
>>
>
>Hi Sasha,
>
>This patch, f69ffc5d3db8, depends on 8c22e2f69592 ("cpupower: Fix AMD Family
>0x17 msr_pstate size").  Without 8c22e2f69592 the patch below will always read a
>value of "0" and not output the correct data.
>
>8c22e2f69592 must be applied to any stable branch that f69ffc5d3db8 is applied to.

I'll grab it too, thank you.

--
Thanks,
Sasha
