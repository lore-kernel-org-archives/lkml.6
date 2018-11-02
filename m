Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2153C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FFE20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wLiIaaN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FFE20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeKCI0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 04:26:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728643AbeKCI0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 04:26:43 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31F2D20831;
        Fri,  2 Nov 2018 23:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541200655;
        bh=WZTQ+y334Cc6YsU7d91wldJ/MJOX9a2nmyrIdg9Z1Oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wLiIaaN79eRSlKBSHT0xd2fNVT/sIr38QbkZZdsqQ13fx9SxAydbuePE3FjiP1cNx
         cZ2dNzt/0ARxlsSG8dmM4z7zXZJmSvgzW2TR5LaBIIEQgeuQRn05Gf9S/kMLhYupQV
         8XUyswPNp231Q3AIlJmiU91XetcPEnqlsOy3uwYs=
Date:   Fri, 2 Nov 2018 19:17:34 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, a.p.zijlstra@chello.nl,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4.14 053/143] x86/power: Fix some ordering bugs in
 __restore_processor_context()
Message-ID: <20181102231734.GI194472@sasha-vm>
References: <20181102182857.064326086@linuxfoundation.org>
 <20181102182901.303280657@linuxfoundation.org>
 <CADVatmNE4VcpjoEKdXTf_d0_M27shgB+x6FiXo1-JzRf+0sw9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CADVatmNE4VcpjoEKdXTf_d0_M27shgB+x6FiXo1-JzRf+0sw9w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 08:19:36PM +0000, Sudip Mukherjee wrote:
>Hi Greg,
>
>On Fri, Nov 2, 2018 at 6:51 PM Greg Kroah-Hartman
><gregkh@linuxfoundation.org> wrote:
>>
>> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
>This has been fixed by another upstream commit:
>7ee18d677989 ("x86/power: Make restore_processor_context() sane")
>
>You can not directly apply it, will need backporting.

It depends on the following commits:

5b06bbcfc2c6 x86/power: Fix some ordering bugs in __restore_processor_context()
090edbe23ff5 x86/power/64: Use struct desc_ptr for the IDT in struct saved_context
896c80bef4d3 x86/power/32: Move SYSENTER MSR restoration to fix_processor_context()
7ee18d677989 x86/power: Make restore_processor_context() sane

Greg, any objections to pulling them all in?

--
Thanks,
Sasha
