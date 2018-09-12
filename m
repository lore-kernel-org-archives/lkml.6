Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0212AC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CF72087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSYlmXnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CF72087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeILVhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:37:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39663 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeILVhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:37:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so1274322pff.6;
        Wed, 12 Sep 2018 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f8FtWTdVZW5g6uBUuvIXYdUlKMP2b4Y+SqYwjFy8qDg=;
        b=nSYlmXnp95UM5+93xxjY/Z+voyrHg0SLdXMipm+F2MD1YID71D9cFtyYB/lxofJa6T
         1ei+5GGK0g0p5kjppF9qvkveuZZopLy0umVulen412L85QnD0fAZ33UJODCjBY/LqBmN
         j/9xrOdBxj19Z+sbeQXkrHMzZ4ksHyPPn5pNoYHVV5JjNB/zau4dcTho7XuUsXrrF84o
         ndBklohlOVjjhcJPGa5GuRwNjmX22FCfrMEsodhpbx3hnYVUwMKJoRr0D34vyU6xnxML
         cc8onwKMqegKFHIsy+FioOS1kmOIiNlhfR0zYD9hAdgjOeVtPpZc3hSlH0h4WKO0OZHn
         WMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f8FtWTdVZW5g6uBUuvIXYdUlKMP2b4Y+SqYwjFy8qDg=;
        b=DCcbATye77Ms+ElLcZFl3ylJ53AJDzS0bGd3bBzmx0qa5PbAbASjeli4gsaAuHhNys
         zeYrbgZPlHMydbM7o6zhqLp4eP1Dh+sFeP9kqANZ3YLCpGRKn17lV/HxOW2SCealXx/7
         IQxYYR2YA2Td5SQnVBHvhfiFWozlQpEuTZmzYoIXW7QJABNkzlicToOYD/cZ0ehD0fVF
         KP069LDbDUAog1st8z9CzrydzVwUFmg4vIfNicta04IX3f9pBnCQTtuyebqX7+eLIAXN
         NCfA43aTrMNZN5od9My8wiWhUELGnu6Z1BJrEMXh74ee2ARAIbl5C3ZdQdOwRn5qiRt0
         MhXw==
X-Gm-Message-State: APzg51CXNww50mcNMw88nnFZAE5qB7eIzhVjqD0L6lnHkuAsFMFv/7eg
        XpOhrOmNcN0aM4XRDPoHY/c2PcIM9g0=
X-Google-Smtp-Source: ANB0VdZBOQyS4bCQeGUs9p/kMNENtTdXZbgKR/2RxvvhrkygneZO6fCclKZ1j4WFJBBnqx9Mcw04+Q==
X-Received: by 2002:a63:c912:: with SMTP id o18-v6mr3115941pgg.331.1536769936553;
        Wed, 12 Sep 2018 09:32:16 -0700 (PDT)
Received: from [192.168.1.5] ([119.42.83.160])
        by smtp.googlemail.com with ESMTPSA id 3-v6sm3268549pfq.10.2018.09.12.09.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 09:32:15 -0700 (PDT)
Subject: Re: [PATCH] option: Improve Quectel EP06 detection
To:     Kristian Evensen <kristian.evensen@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180908125754.1947-1-kristian.evensen@gmail.com>
 <20180910103022.GR1089@localhost>
 <CAKfDRXiVbE3-eteTCZjEqyR0LaLMpN8t4P_ihzHPChse9=FxmQ@mail.gmail.com>
 <8ce10eef-f332-a1c0-e16e-fb1c2055131a@gmail.com>
 <CAKfDRXgTL6L27JLbbOLLsXd9KK8vBtVCjrTNpv6R_MYCJoZqPg@mail.gmail.com>
From:   Lars Melin <larsm17@gmail.com>
Message-ID: <de1b5aa3-d9d6-da49-7e49-553694f5b666@gmail.com>
Date:   Wed, 12 Sep 2018 23:32:12 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKfDRXgTL6L27JLbbOLLsXd9KK8vBtVCjrTNpv6R_MYCJoZqPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/2018 21:34, Kristian Evensen wrote:
> On Tue, Sep 11, 2018 at 4:00 PM Lars Melin <larsm17@gmail.com> wrote:

>> My opinion is that the option and qmi-wwan drivers should support EP06
>> in the factory delivery configuration and not in a configuration the
>> user has selected with a Quectel proprietary AT cmd.
>> Can you give some good reason for disabling an interface instead of
>> letting it stay but not use it if you don't need it?
> 
> Yes. I am working with two boards, one based on MT7621 and the other
> on MT7623, and I would like to connect two EP06-modems to these
> boards. However, the USB-controller used on these SoCs has a (very)
> limited number of USB endpoints. With the default configuration, there
> are only enough endpoints for one EP06-modem to work properly. By
> disabling diag, there are enough endpoints for both modems to work
> correctly.
> 
> BR,
> Kristian
> 

You have chosen a platform which has limited usb resources and want to 
solve that problem by adjusting the device driver?
Why don't you just unbind those interfaces which you are not using and
which are eating up your usb resources?

Thanks
/Lars
