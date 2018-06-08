Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nEKhHFYeGlt9MgAAmS7hNA
	; Fri, 08 Jun 2018 06:12:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0FEC5608BF; Fri,  8 Jun 2018 06:12:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MURCvPcy"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9716F6089E;
	Fri,  8 Jun 2018 06:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9716F6089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751095AbeFHGMh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:12:37 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44320 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeFHGMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:12:36 -0400
Received: by mail-lf0-f67.google.com with SMTP id 36-v6so18233761lfr.11;
        Thu, 07 Jun 2018 23:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XBMjvTN4y3jK2H34/vDS/c/SUAl4aI9KotNn91P11jI=;
        b=MURCvPcySOjUr4VPzyKYQoKIQk8U4G9d84OR7dTnmtw2onxMLZp7RAxNE8FwY0mxg3
         +k84e0lzmdTrUIT8kJd+oq6lDNyzLPYXFo94gu40oBvukevAnPclfSeB1jYLA5W/t/UL
         c/bfSyzO/sCDKomLQVLkEkjnSw83UxA7FjuYM/qNya1vq4C43gEj1M8+LO+28a3ocLfc
         aaJxoOPy6DMundWmdQm43mjq2IpcfHPN2yWb9EAGQfYzzYYTvu6TMPkfdRDWKW0eHSpo
         2g55NHyETbRLQdSLM6x29SwV49Q0+HCAFpBw/Wwf1oIYAeGa0nvVcCXl/Mf9uI2MuHGl
         GmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XBMjvTN4y3jK2H34/vDS/c/SUAl4aI9KotNn91P11jI=;
        b=P7M/TjgXerLx6WqT+LuMCSfNnXhT+e7AhO3ZvNmbQv0JaOCfQKv9o/MDOyGRy2O3C/
         fGcAx9y1EaVET/j1jtSrE/KbNJaeC/YZZ26Iegl78DRHuKLS29Bf6Vk26xTYnTKCJ+OZ
         X1qt08F/IeO6GyEcrvHJWeERdNy6NXxKwyFhNQohJizQoLERKLMMKyr2OKxsiEE78GlW
         OTByKcKaCOysVy3MXnh6V0e/caso+gQanho3IZnV4z6foEDRkZC7yB+CzxiNTxxcvPQr
         s4G3Zk8F6zC5aFFrnfoNQ2DpStrri5IWVF2l55HpoWpKmDWwOv5gAN7Rly3rvvlgNIj2
         VBVg==
X-Gm-Message-State: APt69E3JgjPHiozz4uJYrLgGvafYrvQJAN0V1aSpcBgo+FD9G3Wavsc+
        5Swm/0czdWYlHK4ZYyGD58KIc0MDFRuAwIfWMLg=
X-Google-Smtp-Source: ADUXVKLZPDYyUWO7LH2VHk2YrmITjfFBaHVfl2gRegk695EnxK9iLHNJUXnkM5lq7kVkugaBXXxNW9KHUPfwLlBqiQ0=
X-Received: by 2002:a2e:84d7:: with SMTP id q23-v6mr3363839ljh.126.1528438354514;
 Thu, 07 Jun 2018 23:12:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9a58:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 23:12:34 -0700 (PDT)
In-Reply-To: <75ca49d6-0a09-20d5-20c9-dac77604fdd4@kernel.dk>
References: <CAEemH2fbPv2wphVBHxSSS+KEK5S-rercXhvgLJ7YMOZnrTpexg@mail.gmail.com>
 <20180606084105.GA10720@kmo-pixel> <015f6160-216a-31ba-e251-11336e7ff5d6@kernel.dk>
 <CABATaM7FHcXF7rO5kuMVFRFKFqhqnkoJ_t4w-y4=mNx42=b3Cg@mail.gmail.com>
 <39e797fa-b24c-d122-c06b-196ba2a2d395@kernel.dk> <75ca49d6-0a09-20d5-20c9-dac77604fdd4@kernel.dk>
From: Chunyu Hu <chuhu.ncepu@gmail.com>
Date: Fri, 8 Jun 2018 14:12:34 +0800
Message-ID: <CABATaM6575m0g3B4_tuEfh3-14hZUuEV4=32zfZ+7jr+mJnz9Q@mail.gmail.com>
Subject: Re: Block IO issue in kernel-v4.17
To: Jens Axboe <axboe@kernel.dk>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Li Wang <liwang@redhat.com>, Coly Li <colyli@suse.de>,
        hch@lst.de, darrick.wong@oracle.com, snitzer@redhat.com,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 June 2018 at 23:41, Jens Axboe <axboe@kernel.dk> wrote:
> On 6/7/18 8:46 AM, Jens Axboe wrote:
>> On 6/7/18 12:33 AM, Chunyu Hu wrote:
>>> kasan reported a user-after-free. I'm using a kvm machine, it panic
>>> during boot. I'm using the latest linux tree. which contains below.
>>>
>>> commit d377535405686f735b90a8ad4ba269484cd7c96e
>>> Author: Kent Overstreet <kent.overstreet@gmail.com>
>>> Date:   Tue Jun 5 05:26:33 2018 -0400
>>>
>>>     dm: Use kzalloc for all structs with embedded biosets/mempools
>>
>> Can you try with the below? Li Wang, would be great if you could too.
>
> Please try this one instead.

My kvm machine boot successfully with this and works fine under pressure.
Thanks for the fix.
