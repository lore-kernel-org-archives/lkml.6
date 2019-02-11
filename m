Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47203C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E83B20818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="i5+K+a0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfBKJKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:10:36 -0500
Received: from uho.ysoft.cz ([81.19.3.130]:46593 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfBKJKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:10:35 -0500
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 74B4FA225A;
        Mon, 11 Feb 2019 10:10:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1549876233;
        bh=wZOXExipXFo+uZDMvzDUK9PbTu4AF5susYUi/EFlvAg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i5+K+a0vE4HH9YAYL6q+/hzQrbMdy40HZCEYgq9Iwnf0apBgoWwHofMWr/qEf5Fyi
         fgOmft9fSMjcRnbDxsBCtm8aok+SiWY04jJ+SjmcU/2kiXI82Cd98slTtqMVeB8BDq
         NNcuGEfbEVOAXvN9PSMPbm+M6ffp1l3g6Mj4ts58=
Subject: Re: linux-next: Fixes tag needs some work in the fbdev tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190211072443.1cbedb29@canb.auug.org.au>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <4cf3fb95-e7d6-8813-c6f6-2075ca50e18c@ysoft.com>
Date:   Mon, 11 Feb 2019 10:10:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211072443.1cbedb29@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 02. 19 21:24, Stephen Rothwell wrote:
> Hi Bartlomiej,
> 
> In commit
> 
>    7d7e58d30e04 ("dt-bindings: display: ssd1307fb: Remove reset-active-low from examples")
> 
> Fixes tag
> 
>    Fixes: 519b4db ("fbdev: ssd1307fb: Remove reset-active-low from the DT binding document")
> 
> has these problem(s):
> 
>    - SHA1 should be at least 12 digits long
>      Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>      or later) just making sure it is not set (or set to "auto").

Hi Stephen,

Sorry, that is my fault, I put the Fixes tag into the submitted patch.
Thanks for the git configuration hint. All my machines were configured
correctly except the one I generated the Fixes tag on, ups :(

Normally checkpatch.pl does a good job identifying errors in referenced
commits. Unfortunately it did not complain in this case. Would be nice
to add this check. I skimmed through the appropriate part of the script
but I do not feel like adding this feature myself, Perl is not my domain.

Sorry for the inconvenience.
Michal

