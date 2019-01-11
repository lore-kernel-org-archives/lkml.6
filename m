Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA9BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA032177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547215816;
	bh=/jkkZd237u5HdzQ/E7W3S9OFYnn+EnCTvYYYHPh4y4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eGgr6Jic+qLSYhOL/HeYsdBdg0ALFPuNWLMYeighfFDu68bOMlUOaexfoDW1tgmlV
	 WvS89C8mZkMW1S1khz8XSLFmw9XLDOUmTAmg4oDgx+JfTRCbe32Iw7g4dLBDaMXmGo
	 aUj+7420YPXMjIorxMaDjlMEGwYi9DyQyE1B76xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733062AbfAKOKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:10:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbfAKOKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:10:15 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 023F920872;
        Fri, 11 Jan 2019 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547215814;
        bh=/jkkZd237u5HdzQ/E7W3S9OFYnn+EnCTvYYYHPh4y4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zf5NNYnX/AWL0mWOY6zgN57pR99qIB06MDTsENSIoO9qwOuF5ui7GxtEVzhqfbuK1
         zc6IvxMjPsyYYtrRkEcjj1UQD3hV00+j4etgFPWxdV4ryVE2hFn7EeiYps5IDFrX+K
         mls6X6REmxWViwFSxSvHRaIuDuoFa2NUHyVYvjrw=
Date:   Fri, 11 Jan 2019 09:10:12 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v3] Hyper-V commits for 5.0
Message-ID: <20190111141012.GO166797@sasha-vm>
References: <20190110152432.75529214C6@mail.kernel.org>
 <20190111091552.GA16264@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190111091552.GA16264@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 10:15:52AM +0100, Greg KH wrote:
>On Thu, Jan 10, 2019 at 10:24:31AM -0500, Sasha Levin wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA512
>>
>> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>>
>>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed
>>
>> for you to fetch changes up to b5679cebf780c6f1c2451a73bf1842a4409840e7:
>>
>>   vmbus: fix subchannel removal (2019-01-09 19:20:31 -0500)
>>
>> - ----------------------------------------------------------------
>> Three bug fixes for different parts of the hyper-v code:
>>
>>  - Fix for a lockup when changing NIC's MTU from Dexuan.
>>  - Fix of use of uninitialized memory from Dexuan.
>>  - Fix for memory corruption caused by ballooning from Vitaly.
>>
>> All 3 were tested internally.
>>
>> - ----------------------------------------------------------------
>
>Did you really push out an updated tag?  I still get the following text
>when doing a pull of this tag:
>
>-----------
>hyperv-fixes-signed
>-----------
>
>So it looks like nothing changed from your previous request.
>
>Note, when creating the signed tag, with 'git tag -s' you have to enter
>the text you want to show up in the tag into the editor at that time.

Ugh, I haven't actually pushed it, so while the text appeared on
git-request-pull because it was in my local tag, you didn't see it
because the remote tag with the same name didn't have it.

I've pushed it out and made sure the 'git pull' you'd do looks right.
Sorry!

--
Thanks,
Sasha
