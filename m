Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E675BC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C40523F2A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfGrpCbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C40523F2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932615AbeGCOQZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:16:25 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:38515 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932146AbeGCOQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:16:23 -0400
Received: by mail-yb0-f194.google.com with SMTP id i9-v6so780513ybo.5;
        Tue, 03 Jul 2018 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zwjRBK5MRajJOPz/DAY0e8UnXxTHqH1J+OHPgFmBt9g=;
        b=HfGrpCbATR2uU3ineZnG8Z6ufb5+rFWSMPYCH9fZSleqhTbiugfziIsxEzaI1ALfqz
         4IQubnt3rOMcj8Z939vkjyoaAIqlWDtN/oPRUbpaOV3++uVn18glDPrNFiVKb+teuP4z
         /0cr5+DbbqdGtzD2teCBxLwKk802HEmbRJ7OHAWOH0cwxTBY5rJm43SOm/WbsnzhPEuz
         rHiM+myd/XQ/V2lCUJDGmny1ZaWhg/u2MXCtHpPaw0iV9xybmicK4Lw2P5cQUegtk19n
         WzJQ2iYIEPjmZAzgMV03TsgUTMjoZOXYAZ+rPp9mDhF05nD9zfdZ1saf1F8ke7YMFK+S
         ECzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zwjRBK5MRajJOPz/DAY0e8UnXxTHqH1J+OHPgFmBt9g=;
        b=GJS4AQyM6prQRrV2nwFylb6KW+Hg15cw2nfcHNUv3fn7TalXX75VsXqGcHhY7A6aG/
         JxPTaA2tsmjn6JlY59kauvo5Wys0A50gMtHzbEkiFynymxdpSv0hf06l++uIjPYO79D+
         ZnmYEN9Kk8bYScJ3KRUbCevwmP0xN20Npn4pMmj6zH3psTiOQh6celp2FF78R0vkAX5C
         skL09kMmJeHPY8MHhEMtcDuuyj2sk8o15hnpVhFp/pWVPr5a+Js3+ntDYUJgy9mx4xnx
         i2KkrfTkUfRJfSwgRIreL1AkEdWyJsvD4yYxHAuMMNLFYFyI+ussvD3nR5mutAu8Doww
         BYKg==
X-Gm-Message-State: APt69E2JrkYxPhCv9b4Gdo/KUgRu5TBuOvuLRrp5xLHVfKwbjCFxtqoK
        Pbx4Odgm3qcYxMHReRvu/ZQ=
X-Google-Smtp-Source: ADUXVKLXyQSl/OBA4GJ9kdELAWpPY0PXKZMCItHSMeDwZV5vvEuHks/q86v8lQpo9asD5PPCmqwo+A==
X-Received: by 2002:a25:6ac6:: with SMTP id f189-v6mr15808070ybc.499.1530627382711;
        Tue, 03 Jul 2018 07:16:22 -0700 (PDT)
Received: from sophia ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id s125-v6sm467345yws.49.2018.07.03.07.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 07:16:22 -0700 (PDT)
Date:   Tue, 3 Jul 2018 10:16:20 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [v7,03/10] docs: Add Generic Counter interface documentation
Message-ID: <20180703141620.GB14958@sophia>
References: <7606bdc53c26c332b2bbff0f865380fb0e874b56.1529607879.git.vilhelm.gray@gmail.com>
 <b7c690eb-274e-3377-cf8a-2f9ab836677e@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7c690eb-274e-3377-cf8a-2f9ab836677e@lechnology.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 02:37:53PM -0500, David Lechner wrote:
>On 06/21/2018 04:07 PM, William Breathitt Gray wrote:
>> +Userspace Interface
>> +===================
>> +
>> +Several sysfs attributes are generated by the Generic Counter interface,
>> +and reside under the /sys/bus/counter/devices/counterX directory, where
>> +counterX refers to the respective counter device. Please see
>> +Documentation/ABI/testing/sys-bus-counter-generic-sysfs for detailed
>> +information on each Generic Counter interface sysfs attribute.
>> +
>> +Through these sysfs attributes, programs and scripts may interact with
>> +the Generic Counter paradigm Counts, Signals, and Synapses of respective
>> +counter devices.
>> +
>
>Have you considered a character device in addition to the sysfs interface?
>
>I basically have many of the same concerns that resulted in a char dev for
>gpio[1].
>
>- With sysfs, you *can* technically poll for events, but then you have to
>   seek and read or re-open the file.
>- File permissions are annoying if you want a non root user to be able to
>   use the device.
>- A single program can't claim exclusive access to a device.
>- There is no automatic cleanup if a userspace program accessing the device
>    crashes.
>
>[1]: https://www.elinux.org/images/7/74/Elce2017_new_GPIO_interface.pdf

Those look like good technical reasons for implementing a character
device for the Generic Counter interface. I chose to implement the sysfs
interface because I was using the IIO code as a reference, but I
personally don't have much opposition to a character device in addition.

I'd like to get Jonathan's opinion on this as well if possible -- I
vaguely recall us considering this option briefly last year when the
Generic Counter interface was still in its beginnings. I've CC'd Linus
Walleij as well for input as the GPIO maintainer.

William Breathitt Gray
