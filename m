Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA393C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36F52086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eZwy7aGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36F52086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJJXsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:48:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37342 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJJXsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WoyPE1ZAp/531dwLgXUH6MtrSMJoYHdoFw+mcIzLmCM=; b=eZwy7aGVlZ6U5uPN7xRMGbPz8
        S6WH7n3A0+asFkxPkIn+5rVtY/8fpGpCrdxc8Jfy0MTF5wyuYnMqiNahBMl/1wmVvv8vcouoRWSbA
        iLhmjIzTQdjKrUhaisGHd4aF2Q0MmxIfm/ERvDI+tsjePVBjPt5lCtKmP0cBRNsJpZYYmaqYtahr8
        /m7UMlkMf1w/xvao4pm2UhkS1kHOPHBz5KMO4ozMlwFdeh7QoaPf9uvA99DjOHn1Cc2sFLvbVCxh3
        ViOmuiNv0KpYuruyS8vurEdxdeYqRZKxQ/BDy7oeyg+ogxOwEitguGPDcmQ3TxdVJmOfaszvKAftE
        R4mrOiP7Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAHIn-0007rG-Hi; Wed, 10 Oct 2018 16:25:37 +0000
Subject: Re: [Ksummit-discuss] [PATCH 0/2] code of conduct fixes
To:     Pavel Machek <pavel@ucw.cz>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <CAKMK7uFvmXtk=WiZJxGrzQQD1RHv7srA-_e8KdwXZ9Kn5rcmiQ@mail.gmail.com>
 <1538934030.4010.1.camel@HansenPartnership.com> <20181010161256.GB19941@amd>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5e5c745b-5b59-6655-99b1-c40874fdbdf2@infradead.org>
Date:   Wed, 10 Oct 2018 09:25:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181010161256.GB19941@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 9:12 AM, Pavel Machek wrote:
> Hi!
> 
>>> Personally I'm not happy at all with how the new code of conduct was
>>> rushed in, least because I still don't understand why it happened,
>>> but also for all the other reasons we've discussed here in the past
>>> few weeks.
> 
> These are exactly my thoughts.

Exactly.  We have a process and the 4.19-rc4 CoC patch did not follow it.

>>> But I also understand that there's lots of people (me included) who
>>> don't want to ship a release with the code of conduct in it's current
>>> in-between state. I think adding a disclaimer at the top, along the
>>> lines of
>>>
>>> "Please note that this code of conduct and it's enforcement are still
>>> under discussion."
>>
>> I don't disagree with the position, but eliminating our old code of
>> conduct in favour of another we cast doubt on with this disclaimer
>> effectively leaves us with nothing at all, which seems to be a worse
>> situation.  In that case, I think reverting the CoC commit
>> (8a104f8b5867c682) and then restarting the replacement process is
>> better than adding a disclaimer to the new one.
> 
> Reverting it then having proper discussion sounds suitable to me.
> 
> (And it would be nice to have something on the mailing lists, too, as
> I probably won't make it to kernel summit this year.)

Ditto.

-- 
~Randy
