Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80592ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286E420850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK5jd3EV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286E420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbeGRR4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:56:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37995 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731351AbeGRR4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:56:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14-v6so5438837wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 10:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ujFAT+QRiNRZcmbidbx5qrcSAc7YP1aSQ1yTRwB37YQ=;
        b=RK5jd3EVYf1prnrp8ttZKHnzIWZ5duAex7lwHkKD8P3PIOKpMW38jX7TSRFIVYgKGh
         HtKfmWH6OE9Kp4mR0BEJla3Esx5H0lJWbDPtna6JmREXZSTPqYCzDkHlBG+R2zTvjb2A
         9aUnAx6nU0bwBcfO72nh4LfQiwMUDlrMOxxzVTBCcYwa1USf8Xfb3den/zCJtcf6j9pm
         E1VveC8p6RypnhSnYN4+sSOG/A28NjMzeHSw3ysjT/9ZO/UYow0SjOS5K9wEYVBoVdHS
         sNuLTqgV0+ZGT+0pw6k3XluCLP/HBgTCwKipn0cWdW9t/7jpuK+AjHLKFnx0V4ZJwYuN
         bgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ujFAT+QRiNRZcmbidbx5qrcSAc7YP1aSQ1yTRwB37YQ=;
        b=PP3n5hQHOTHfF+T9Ye5UbHedc8znBXpZvIk3e9LVkfvheBjDsigoq53Losu+njJyw+
         sDexnooCoRN+6BM+C8TILver0EfkhneM8vpB1RDEG3onXsXGguW3x8KLqqRWYgwK8IGA
         I9RdA22PSTx4rCoJ1dkd5NAfleD8BatXsAY11jkxxWV74E03Vj4X7uF4onukjX0T+rLt
         P8AMXPqL0xUw48Cmb5rtZ9ruqzWQNNanjhETN/XycBzSxThebMDUSzkgpGQ0DU3DyYPN
         aI0o35IqMm3r4/1PtOcze0ySBf0UCNxhUWx4vbNjJOlFUn1NRne6ZwwF7iMjCkZfwRw1
         +tCw==
X-Gm-Message-State: AOUpUlGKSAGG7Xt9Tm/N44KN0oelw4u4gCJhC911FXkB0G7fpuU/cyLO
        Ko2USRAm+H80BOMfVNTVWlg=
X-Google-Smtp-Source: AAOMgpeVNLT0aderuglN0HU21zjesyle8BmeBSrNr3QU19HVwfr5l6FHnnPSsbJ3PfF6kPtKaH4bdQ==
X-Received: by 2002:a5d:4210:: with SMTP id n16-v6mr4830311wrq.55.1531934267435;
        Wed, 18 Jul 2018 10:17:47 -0700 (PDT)
Received: from [192.168.2.28] (218.83.broadband9.iol.cz. [90.176.83.218])
        by smtp.gmail.com with ESMTPSA id g15-v6sm7378427wrh.48.2018.07.18.10.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 10:17:47 -0700 (PDT)
Subject: Re: [PATCH 4/5] crypto: Add IV generation templates
To:     Mark Brown <broonie@kernel.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, agk@redhat.com,
        snitzer@redhat.com, herbert@gondor.apana.org.au,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        jonathan.cameron@huawei.com
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
 <1531899055-29362-5-git-send-email-wangxiongfeng2@huawei.com>
 <b6eaf471-7279-ca4f-bb7c-d25df8db2419@gmail.com>
 <20180718164625.GA20360@sirena.org.uk>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gmazyland@gmail.com; prefer-encrypt=mutual; keydata=
 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
 vzRmJp4=
Message-ID: <82248c13-42fe-b598-0cd7-68e5db0b51be@gmail.com>
Date:   Wed, 18 Jul 2018 19:17:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.3.0
MIME-Version: 1.0
In-Reply-To: <20180718164625.GA20360@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/18 18:46, Mark Brown wrote:
> On Wed, Jul 18, 2018 at 10:16:05AM +0200, Milan Broz wrote:
> 
>> So we are here again and moving INTERNAL dm-crypt functionality into
>> cryptoapi.
> 
>> The TCW,LMK  IVs generator make sense only for dm-crypt 
>> for compatible old disk encryption mappings.
> 
>> I strongly disagree to move this outside of dm-crypt.
> 
>> Sorry, the last discussion was that it remains inside dm-crypt
>> and it will be only registered through crypto API.
> 
> Sorry, I'm partly to blame for this in that I asked Xiongfeng to pick up
> Binoy Jayan's old patch set.  I seem to have missed that particular part
> of the discussion and so haven't forwarded it on to him - do you have a
> link, I can't seem to see it in my local archives of the prior
> discussions but they might not be complete?

I think the last iteration was this patch
https://lore.kernel.org/lkml/1498106510-19793-2-git-send-email-binoy.jayan@linaro.org/

But I have still some questions, because I really do not understand
the real reason for this patchset.
For now, it adds a lot of complexity for ... what?

1) If the reason is to make cryptoapi to include IV algorithms, I think we should
focus on universal algorithms (sequential aka plain64 in dmcrypt) as used
in XTS mode. ESSIV is intended for CBC mode only and I think general
consensus today is that XTS mode is preferred to CBC (despite it known problems).
But I see ESSIV used elsewhere, so maybe it makes sense to export this one as well.

But definitely not other internal IVs - some IV generators inside dm-crypt
(namely TCW and LMK) do much more that IV - they modify encryption mode.
This was a hack to support some FDE encryption modes (old Truecrypt and loopAES)
and that should not spread outside dm-crypt (and blame me for this code hacks :).

2) If the reason is performance, please provide numbers with the patch.
What I see now is that the performance is almost the same. So why you are doing it?
Any real hw that benefits from it?

I added 4k sector support in dmcrypt and IMO this helps much more
than some hw IV accelerations (AFAIK is is already used in some mainframe
accelerators this way because of performance).

Milan
