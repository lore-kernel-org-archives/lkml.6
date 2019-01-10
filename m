Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25397C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3A7214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547133705;
	bh=5hrf5GRD3IDm5vEuIRqidGjf8mJO4n9YL5sHjsclO/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AnLZqgBc2X7tYt7QOkWV2SbyA9H13CxBWjMnoYYEc2z1cubdvr0ioLjqveCKhWQAy
	 YGPk6wG6fAWgOegR343coO42/80K+9lMccoU+ijXJ8Mm6hr4PUN9kBjTi6Urxld09b
	 x2xzRLRLVblMT2zuQMk0bN0PYd08BwEOymy6JBMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfAJPVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:21:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbfAJPVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:21:43 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92965214C6;
        Thu, 10 Jan 2019 15:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547133702;
        bh=5hrf5GRD3IDm5vEuIRqidGjf8mJO4n9YL5sHjsclO/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fCoiAjCH5jwxeH+pL8f1BoV0ktvujC4OdPs/LK11VHBfNlA6o2L1ynHxiNOJJZyA+
         d45z1fZ1nE3THX1wz9duZJb7lFFx4/S1E26O9bsaHsLkT5gWqizmge8kJsUGUocXcS
         QdyBGoRhofBnubIU/PXDbu0Me/JbuaPRhz29+ba8=
Date:   Thu, 10 Jan 2019 10:21:41 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v2] Hyper-V commits for 5.0
Message-ID: <20190110152141.GN166797@sasha-vm>
References: <20190110070547.BE9A620657@mail.kernel.org>
 <20190110074323.GB20273@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190110074323.GB20273@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 08:43:23AM +0100, Greg KH wrote:
>On Thu, Jan 10, 2019 at 02:05:46AM -0500, Sasha Levin wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA512
>>
>> Hi Greg,
>>
>> Three bug fixes for different parts of the hyper-v code:
>>
>>  - Fix for a lockup when changing NIC's MTU from Dexuan.
>>  - Fix of use of uninitialized memory from Dexuan.
>>  - Fix for memory corruption caused by ballooning from Vitaly.
>>
>> All 3 were tested internally.
>>
>> - --
>> Thanks,
>> Sasha
>>
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
>> hyperv-fixes-signed
>>
>> - ----------------------------------------------------------------
>
>What changed?  In the tag, the above "one line" message is all that is
>there, just like in the first version of this pull request.
>
>That's what I asked to be changed, please put the information you have
>above "Three bug...", in the tag itself.
>
>Then, when I do a 'git pull' I can see that in the changelog message and
>I do not have to go and manually cut/paste from the email, into the git
>commit terminal, the needed information.
>
>As it is, again, only the one line "hyperv-fixes-signed" shows up in the
>commit log when I want to do the pull.
>
>Try it yourself and see what I mean.

Ah, I see. Coming right up.

--
Thanks,
Sasha
