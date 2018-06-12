Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 961C7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467C5208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=boo.tc header.i=@boo.tc header.b="jqz35AwI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hdIAcItB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467C5208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=boo.tc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934495AbeFLQUC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:20:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40149 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933363AbeFLQT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:19:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 97E3821CF1;
        Tue, 12 Jun 2018 12:19:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 12 Jun 2018 12:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boo.tc; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=TpwjBs9HlxtJTF6GLRzKfeW2xz34m
        rZzb9i3TRw7rpY=; b=jqz35AwIlziYhalm6s4Trlp6RRRndTCgQjE04kdOJPEud
        XCSmYPqDtRw9CtLaWKeOLUl2ByrXn0h9ti+kITfVWwI1AbkgTjG1mu1UklHoXsTP
        ZCWIyHXcZ5B8KjrxNfSFXH6GiBZA2sgRqNVeweBUpivfHHWlePPzCrCguarW8qIs
        kQdot0d+3qrv7BfKpKBnELxBArUw9QwOdO+xjH7g0OjyapfZF4crRp0HyJC2xemN
        onrKvdm3Mb6FFAJdrxA9fkK6wxeypfRJOPbVcBAeBGC52eMaRGyVzy3yzxW0hg09
        iRf1SKLrxv7jjcdb84Z9ylrx0wrWT1bvpfw0Ih5Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=TpwjBs
        9HlxtJTF6GLRzKfeW2xz34mrZzb9i3TRw7rpY=; b=hdIAcItBKhm+8Eq63j+WXX
        HReHckLuj0etIdPgVqbsRl7ztrP7ny7QQjOhnCwVZVapUeyJSmklXmwx2F6gP+YY
        6bOqvC7FZo7/DXz8OPfkH3LaFdyb5oYfnvTPDzdGU+GyYoBo6OnDXkcF0n5+HvzB
        073RFxcb/emeN4Dz4qM8+i1imi55ZuuB0B9Z2e3qJARwlQrlJJ6SFuEfuS7eYnNa
        HSCvZsYxtWjfQxpXbWQwa2R0JBc5ROR6203JFZOogeZGXL95ELRvjcdoVHHwV1FC
        UR/d8dxUh3y8VLif23uR4z4Ky9IFtwC1kCbIfZoe5XNQhdu2PAZojaViXzz0SF7w
        ==
X-ME-Proxy: <xmx:rvIfWxzTQa4hQFqE-PaoCQvKUW3BglhyY1yP8t5ogOsSiI0QfgXLcA>
X-ME-Proxy: <xmx:rvIfW-y6UWsW00lpvq_og9CQxFfXqsAq0mXJF1nrR_UQDemT8TzrbA>
X-ME-Proxy: <xmx:rvIfW3a0wSMbXLMAlPDxQkvHe2bIxz3Be71cnRS7SDG-upj9YSZ3Lg>
X-ME-Proxy: <xmx:rvIfWwzC1JBLo3xBBC9NMN9ntLAXFJGk-RWEtDTiRtnBEQKYq4oHfA>
X-ME-Proxy: <xmx:rvIfW1jo1rcZvclxl9fsXlGAuaSH-6PBUh0C-TyJP7--hPhvX16LWQ>
X-ME-Proxy: <xmx:rvIfWyewdjMJ1eh0BBs15PuVUpjYIgqGmdl4zGHV5GHbHN45L_VqZg>
X-ME-Sender: <xms:rvIfWw6_7Y1F9uDcGaKVwNdBMJLSzexB1kq6lGJSR76yJIR43BX_UA>
Received: from [81.187.55.88] (ripley.boo.tc [81.187.55.88])
        by mail.messagingengine.com (Postfix) with ESMTPA id D999310266;
        Tue, 12 Jun 2018 12:19:57 -0400 (EDT)
Subject: Re: Hard lockup in blk_mq_free_request() / wbt_done() / wake_up_all()
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <9788e0e6-a448-bf85-1f41-88f42dc0071d@boo.tc>
 <ac2c7156-f405-4047-564d-816159d5968b@kernel.dk>
From:   Chris Boot <bootc@boo.tc>
Openpgp: id=846753CB19213142C56DC918F5C83C05D9CEEEEE
Autocrypt: addr=bootc@boo.tc; prefer-encrypt=mutual;
 keydata= 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
Message-ID: <7080a91c-8d9a-6305-2b67-dc27a374327a@boo.tc>
Date:   Tue, 12 Jun 2018 17:19:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ac2c7156-f405-4047-564d-816159d5968b@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/18 17:09, Jens Axboe wrote:
> On 6/12/18 9:38 AM, Chris Boot wrote:
>> Hi folks,
>>
>> I maintain a large (to me) system with 112 threads (4x Intel E7-4830 v4)
>> which has a MegaRAID SAS 9361-24i controller. This system is currently
>> running Debian's 4.16.12 kernel (from stretch-backports) with blk_mq
>> enabled.
>>
>> I've run into a lockup which appears to involve blq_mq and writeback
>> throttling. It's hard to tell if I've run into this same thing with
>> older kernels; I'm trying to track down a deadlock but so far I've been
>> fairly certain that involved the OOM killer, but this doesn't seem to.
[snip]
> 
> Hmm that's really weird, I don't see how we could be spinning on the
> waitqueue lock like that. I haven't seen any wbt bug reports like this
> before.
> 
> Are things generally stable if you just turn off wbt? You can do that
> for sda, for instance, by doing:
> 
> # echo 0 > /sys/block/sda/queue/wbt_lat_usec
> 
> It'd be interesting to get this data point. Eg leave blk-mq enabled, and
> then just disable wbt.

Hi Jens,

Thanks for the speedy response. I'll see if I can get that tested soon;
if the system is stable without blk_mq I can see the users wanting to
keep it that way for a while. I'll let you know.

> Is anything disabling wbt in the system otherwise?

Not that I'm aware of, no.

Thanks,
Chris

-- 
Chris Boot
bootc@boo.tc
