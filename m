Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51100C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1043B20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OuqdPRVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1043B20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJWO1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:27:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37094 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeJWO1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V0EA3nJBiiuqStvAdk7CCXeXgzc8xm9hsMN/2Q9Zj9Q=; b=OuqdPRVlEEB16kOiHyTqOXlYC
        8jhVLkPJITjTCbkIUJCzGm3phajG80UubNP7Oc6QQOGE1Oj2QydL8l4nhbLe/U53hM2ZMgDJxG0lc
        n0d6+LFBIiXdhPaWOtlYJx4WanYOeVr1dJq4EUy/VkGmB/0PHXSY0FmuFPfukDTsOHmBsVk3fxiQL
        bMFfOEAGCvsFmpEDljZwbIz436WiKN8jpLV+GZ3YcbdD16UvvkyhhSbnta5BTqIZKCMRVy2zxaffF
        HywpYgwUsNsWm3k/SRKorGzLAa8XZ5KfTeS0AmFMHDTa4TKRlp57DEuAMNMsItmhYajLqFAiu2h2r
        UiSINPmgw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEpoV-00079a-2Z; Tue, 23 Oct 2018 06:05:11 +0000
Subject: Re: [Ksummit-discuss] [GIT PULL] code of conduct fixes for 4.19-rc8
To:     Joe Perches <joe@perches.com>, Greg Kroah-Hartman <greg@kroah.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
References: <1540066514.3464.22.camel@HansenPartnership.com>
 <20181022211025.GA8911@kroah.com>
 <23e41205115d317908c63d37a20ee316b44a8404.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <800b68eb-9cf4-9c72-104d-0d4d9ae26ea1@infradead.org>
Date:   Mon, 22 Oct 2018 23:05:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <23e41205115d317908c63d37a20ee316b44a8404.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/18 9:16 PM, Joe Perches wrote:
> On Mon, 2018-10-22 at 22:10 +0100, Greg Kroah-Hartman wrote:
>> On Sat, Oct 20, 2018 at 01:15:14PM -0700, James Bottomley wrote:
>>> This is the series of patches which has been discussed on both ksummit-
>>> discuss and linux-kernel for the past few weeks.  As Shuah said when
>>> kicking off the process, it's designed as a starting point for the next
>>> phase of the discussion, not as the end point, so it's only really a
>>> set of minor updates to further that goal.
>>>
>>> The merger of the three patches to show the combined effect is attached
>>> below.  However, Greg recently posted the next phase of the discussion,
>>> so people will be asking what the merger of the series looks like. 
>>> Ignoring the non-CoC documents, I think it looks like this
>>
>> Sorry for not responding sooner for this, travel and the meeting today
>> took up my time.
>>
>> Anyway, as we discussed today in the Maintainers summit, let's leave the
>> Code of Conduct text alone for now.  It matches what "upstream" has with
>> the exception of removing that one paragraph.  If you have issues with
>> the wording in it, please work with upstream to fix the issues there as
>> hundreds of other projects will benefit with your changes if they are
>> really needed.
> 
> Given the different development models, that's not
> a very compelling argument.
> 
> As James Bottomley has suggested multiple times,
> I'd much rather kernel development use the debian
> code of conduct verbatim than even this modified one.
> 
> https://www.debian.org/code_of_conduct

Yes, that and the Samba URL are good.

And it's disappointing how patches from James are acked or reviewed on the
mailing lists and then mostly ignored (until the maintainer summit) while
other patches are merged into the mainline git tree.

It seems to be very one-sided.

-- 
~Randy
