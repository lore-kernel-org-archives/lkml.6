Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AA26EC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C110208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeRi6/2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C110208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754921AbeFNSKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 14:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754644AbeFNSKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 14:10:20 -0400
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com [209.85.161.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99688208DD;
        Thu, 14 Jun 2018 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528999819;
        bh=XBif4TbwIsJxm86AsUQeKIhOXkYyXbdPDInZ/8aLJzw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=UeRi6/2y4e9cYTfVLCvmqaGmnSJKsPT435Xrjvx0PCrgRV38/tTISGyFb/ZlrKUCC
         EW8rxaEhRfDS+5dVVeAI9U9rQbDRsa54yPhhl1i8Xks+GIaDqMUBc6/4pmCLU7LVGH
         Kng0NUEkRvDe8zGjfYNPfPOIUKHl8ZOV9ML+klHM=
Received: by mail-yw0-f180.google.com with SMTP id v197-v6so2448985ywc.13;
        Thu, 14 Jun 2018 11:10:19 -0700 (PDT)
X-Gm-Message-State: APt69E1kSKWotka+scWM8V85o5qEV9jtA0HyK4B9wLnxkI6yJsvivNbB
        j7QXunVAHpBkuHgaAJWSgO6LKt0j9VeIbOuA5wg=
X-Google-Smtp-Source: ADUXVKKXTw4MC5SSlrq0u4FxnjsiITOoRPDDoTHegpZZtGUmOaRJgmzJH8UTRy69DW0kokhOvApsDoGi7DRa5Off5pI=
X-Received: by 2002:a81:3c0d:: with SMTP id j13-v6mr1955319ywa.16.1528999818809;
 Thu, 14 Jun 2018 11:10:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:b87:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 11:09:38 -0700 (PDT)
In-Reply-To: <20180614135254.75cfc17d@coco.lan>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
 <948d6c0304eecaf916d21af5cfb0be21df80ed42.1528990947.git.mchehab+samsung@kernel.org>
 <CANk1AXRnnYketpdvrsvN11hL6G9=WinzWHVM4k9VrGJZJ99pLQ@mail.gmail.com> <20180614135254.75cfc17d@coco.lan>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 14 Jun 2018 13:09:38 -0500
X-Gmail-Original-Message-ID: <CANk1AXQwRpqR6LUTVRovcT7te=1q_2PQearZ1XMghhQUzLhxtA@mail.gmail.com>
Message-ID: <CANk1AXQwRpqR6LUTVRovcT7te=1q_2PQearZ1XMghhQUzLhxtA@mail.gmail.com>
Subject: Re: [PATCH v3 21/27] MAINTAINERS: get rid of non-existing Documentation/fpga
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 11:52 AM, Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> Em Thu, 14 Jun 2018 11:39:20 -0500
> Alan Tull <atull@kernel.org> escreveu:
>
>> On Thu, Jun 14, 2018 at 11:09 AM, Mauro Carvalho Chehab
>> <mchehab+samsung@kernel.org> wrote:
>> > This directory seems to have moved to a new place
>> > (Documentation/driver-api/fpga/), with is already at MAINTAINERS.
>> >
>> > So, get rid of the old location.
>>
>> Wow, you caught that fast!
>
> Just a coincidence :-) I had to rebase a pending patch series close to
> the end of the merge window.
>
> When I ran the check tool:
>         ./scripts/documentation-file-ref-check
>
> It detected this.

Nice tool.  Thanks for the explanation, it's always good to learn
about another one.

>
>> There's other documentation coming to this
>> directory soon.  IMO we might as well leave it.  We don't need to keep
>> adding and deleting this line from MAINTAINERS.
>
> Yeah, sure. I'll drop this hunk for v4.
>

Thanks!

>>
>> Also, why didn't you cc linux-fpga mailing list on this?  I guess you
>> ran get_maintainer.pl after adding this patch? :)
>
> Yeah, that was the case. I also had to sanitize the c/c for this
> specific patch as get_maintainers.pl isn't good enough to check for
> MAINTAINERS access... it usually just get some random noise...
>
>>
>> Alan
>>
>> >
>> > Cc: Alan Tull <atull@kernel.org>
>> > Cc: Moritz Fischer <mdf@kernel.org>
>> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>> > ---
>> >  MAINTAINERS | 1 -
>> >  1 file changed, 1 deletion(-)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 783ce44b3e7a..67641f5bb373 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -5632,7 +5632,6 @@ L:        linux-fpga@vger.kernel.org
>> >  S:     Maintained
>> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git
>> >  Q:     http://patchwork.kernel.org/project/linux-fpga/list/
>> > -F:     Documentation/fpga/
>> >  F:     Documentation/driver-api/fpga/
>> >  F:     Documentation/devicetree/bindings/fpga/
>> >  F:     drivers/fpga/
>> > --
>> > 2.17.1
>> >
>
>
>
> Thanks,
> Mauro
