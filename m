Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BE7C3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BB92089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="B6hG/CQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfAUWoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:44:23 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:44663 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfAUWoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:44:22 -0500
Received: by mail-pf1-f182.google.com with SMTP id u6so10740471pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 14:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8tlNCZiTVTFXRRGmrQnWWjppReDSvWAoc8TD0PHMa/k=;
        b=B6hG/CQooNh3/SP1yvWyyxqpKZK7o5G8APj51L6aC6yLrvZ6ORKmKzPvE1ldy6VGEh
         qjGRA8kJ/sJWcf+/wJhtf5cSC40CF5fyRYj1lS22RgDg6D+0ldSsV7BHtLiF4QKQ1Dbg
         QN3CmqXYN7B5tYZAoiGIFr0oPv4kvzpr9mfmvuiiHB+uy4oPZwXr9060SAIYnIitzkDH
         0ILvJ/6UToNShGk2hLw+W1rx660s7S+XVaX7JuhRkIe/+OR1LYgMfHVffyiLuQg505iC
         KOQH2wXh6Amy9L44OH27aW7wYTvYo6O6LTlc9cDZjZ9Yx8AjLaqFz1vmp7UQ8LHjMQ/l
         y7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8tlNCZiTVTFXRRGmrQnWWjppReDSvWAoc8TD0PHMa/k=;
        b=WPbAZ3B/6bS3sprTJqwxfQ2aisVxKEF7e1pMwlN/pAqv7xLKARbI8DEW6CjlvZ7h3k
         AonN5sYa619s1vBosZsBsu95O4Qicpa1+KvVQaq6ZZzKINc6ImYDpKpuVX+Gc5gnBPsC
         tCIY59i7DZR+VuxKUfvyyqnF3NmRfBvS8fTNoAU/qHWoz8aMPoCE45wDxxNKy/2qaA+T
         AZMS6lXtsyR+38xY46qCv04jaX/AfwskyXcEkTGZPTowd9hU/dteGcMf47feq9crUBjt
         kvpoT5Y2uWCHDJjHwuW4Ml2cNteeJ5cbmS1179uB3iTVCYb8jMoxIipa6BPYGng8s3zu
         pS3Q==
X-Gm-Message-State: AJcUukekmjyd03PtLSk8Gbu+1V+teLucEAwbY/dhJzSSDoFFcn1p68VU
        S+5Uv2eepiQcuXHbFWyEuYXC1g==
X-Google-Smtp-Source: ALg8bN5AMFxbFEQcqws9JhbC69GA5NqV3HA8tzLfbjkPQosJYLvJlNE2Wq7HQtmkoOmupRMBUc9kvg==
X-Received: by 2002:a63:451a:: with SMTP id s26mr17060669pga.150.1548110661566;
        Mon, 21 Jan 2019 14:44:21 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id n73sm19123751pfj.148.2019.01.21.14.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 14:44:20 -0800 (PST)
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
To:     Christian Brauner <christian@brauner.io>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
References: <20190121143951.68956db3@canb.auug.org.au>
 <CAK8P3a0Yth+f8AANE6g8c_zE0Zt1CvCdzMDFK=pr8eNqmrBV0Q@mail.gmail.com>
 <20190121191306.ifga5aw5atu2vvb7@brauner.io>
 <CAK8P3a2CkXJ=giXQgxEcQAeH1Wt8jKc_P+YTOLJpUPVKYU8m9g@mail.gmail.com>
 <20190121202328.rgrv54lybilsvitu@brauner.io>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <da262bd9-1de0-eabb-ee44-e0ee152d15bb@kernel.dk>
Date:   Mon, 21 Jan 2019 15:44:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190121202328.rgrv54lybilsvitu@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/19 1:23 PM, Christian Brauner wrote:
> On Mon, Jan 21, 2019 at 09:15:27PM +0100, Arnd Bergmann wrote:
>> On Mon, Jan 21, 2019 at 8:13 PM Christian Brauner <christian@brauner.io> wrote:
>>> On Mon, Jan 21, 2019 at 06:16:22PM +0100, Arnd Bergmann wrote:
>>>> On Mon, Jan 21, 2019 at 4:40 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>
>>> I plan on sending the pidfd branch with the new pidfd_send_signal()
>>> syscall for the 5.1 window. Should we somehow coordinate so that our
>>> branches don't conflict? Any suggestions?
>>
>> A conflict can't be avoided, but if you pick system call number 427
>> for pidfd_send_signal, and Jens picks numbers 424 through 426 for
> 
> That sounds good to me. Since it's only one syscall for the pidfd branch
> is there anything that speaks against me using 424? Given that the other
> patchset has 4 new syscalls. :)
> Jens, any objections?

I'm fine with either one, I'll have to renumber in any case. But it's 3
new syscalls (424, 425, 426), not 4.

Arnd, what's the best way to make this switch now, in my tree? Would be
great if I didn't have to change it again once I make the change.

-- 
Jens Axboe

