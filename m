Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81DEC282DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 19:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A87920857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 19:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549135857;
	bh=XNgHHiJjLJu1vQSrtbA5+eojGYwqlHSIquzIOzrotKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B0rv+V59Z6iqd8zA+djRxWeI3d62RXy5ezFVFh1b5Dbzbg5bhQ2vQX6YrZuayyZ7l
	 klyb2ghxy73w+6Ifpua0/yv8KD7xa/MsaU7iULzS1LT6bkc4VwrlmprXlpPgZtBiKT
	 uk6D7+3O0zhvlBMUIY/aJGN96i7E527DImhmVwzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfBBTax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 14:30:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:48908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfBBTaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 14:30:52 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38B652084C;
        Sat,  2 Feb 2019 19:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549135851;
        bh=XNgHHiJjLJu1vQSrtbA5+eojGYwqlHSIquzIOzrotKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gLqdlmKAfsBEd+2IMHPkWXHtZYwg4DvGrZe7WXp9uBuT1R9Ale21sJ41l/dqZ30Fg
         bkeOQrzdBEYPXQ8Gy3YExeuUIjvXAn4yiw1u8Df3q+vTh3Tcm8vnvm0apO7+yKekfW
         xyFBpyNffgk7JH7Xl7I0Zt4Xn1/E+JAN/dI0d5+E=
Date:   Sat, 2 Feb 2019 14:30:50 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Babu Moger <Babu.Moger@amd.com>, Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        David Miller <davem@davemloft.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Dmitry Safonov <dima@arista.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Joerg Roedel <jroedel@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Pu Wen <puwen@hygon.cn>, qianyue.zj@alibaba-inc.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rian Hunter <rian@alum.mit.edu>,
        Sherry Hurwitz <sherry.hurwitz@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, xiaochen.shen@intel.com
Subject: Re: [PATCH AUTOSEL 4.19 059/258] x86/resctrl: Fixup the user-visible
 strings
Message-ID: <20190202193050.GA3973@sasha-vm>
References: <20190128155924.51521-1-sashal@kernel.org>
 <20190128155924.51521-59-sashal@kernel.org>
 <c9c45e03-aef3-e1be-2c81-d903a1669499@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c9c45e03-aef3-e1be-2c81-d903a1669499@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 11:07:34AM -0800, Reinette Chatre wrote:
>Hi Sasha,
>
>On 1/28/2019 7:56 AM, Sasha Levin wrote:
>> From: Babu Moger <Babu.Moger@amd.com>
>>
>> [ Upstream commit 723f1a0dd8e26a7523ba068204bee11c95ded38d ]
>>
>> Fix the messages in rdt_last_cmd_printf() and rdt_last_cmd_puts() to
>> make them more meaningful and consistent.
>
>It is not clear to me why this patch is considered for stable since it
>just changes user visible strings to be more consistent.
>
>If user visible string consistency/correctness is of concern and is what
>prompted its consideration then please also consider to include upstream
>commit
>456824896de2b68df40b3ea5777ef49dc6cc8fda "x86/resctrl: Use
>rdt_last_cmd_puts() where possible" that fixes two typos that was
>introduced in this commit. This may introduce difficultly though since
>the file layout changed between the kernel versions these patches are
>found in.

I've dropped it, it shouldn't have been included to begin with.

--
Thanks,
Sasha
