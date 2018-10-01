Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A619EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A200208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQ5BrFzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A200208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbeJAVoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:44:21 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52554 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbeJAVoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:44:21 -0400
Received: by mail-it1-f195.google.com with SMTP id 134-v6so11725931itz.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TPolmJ1kdOss+EaiRTsFGAWXsQSv/arorMt7WVyfd3M=;
        b=bQ5BrFzuf2SuVFYEaUiBpmiGi2wf0C9NsXhoFPK88qjdPuZ7zOlvzwxKFFkAsk01Gi
         W6WPZoXC9n9VU3htWkgs+bXqobz7NeUUVOoTJ8plChSS5I5JWSEbthNNbwv2ZMAhC7dh
         vyG/Z5Wmy3Wmjloeq8jYA3B3QZJEDO/YqBBpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TPolmJ1kdOss+EaiRTsFGAWXsQSv/arorMt7WVyfd3M=;
        b=ShxwDz9hfcyAAyFBOg6EreIqTmLsyfgF6gJ/rpERU0qy2E0GuYrdJ9pIV2BYM9/yzZ
         qgs0i7U3GohWaUNPni8Xi8nI6/nVb3UUhYqeDNmzxCaHcYcbrOaSpb8xWzx/H/kMXaP4
         4Re40yMZwPPxyaDmM9drNyQq90foNvkYpEgKQIsIuNX8ujpP4p09TnbcJhxNbsPUN0z1
         rsbhfo6TBORsoJJn5FtgzhMqWK4ZxYfevFi1u2SGtjDvJPu/yY1OKtDj0UP4NbGggZjv
         tSmZnrgJNO3yugSlJmGuDhubdzsnFqR2KRm+1u7oFYAPtsYiaxu5FSFUSdgiZVUac+J7
         rScQ==
X-Gm-Message-State: ABuFfogoJz21pukXyau/tBkist607Y7HXJRwjbCHPoxPSHxOjrl9juNv
        dSkhtKhi/uvXFRsFA7+lETZuSVoJGvrf8FSIN7pfAA==
X-Google-Smtp-Source: ACcGV61SoVP1Tc0XTwQLgQC8FDF9//xPVLMMBbX5r7etoXIiEHUe1U1ANv8Tl1WzINBzPzqOly6NT7jGrJENFBlkBT4=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr6528471itc.123.1538406366837;
 Mon, 01 Oct 2018 08:06:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 08:06:06 -0700 (PDT)
In-Reply-To: <20181001150353.GA2634@lst.de>
References: <20181001140910.086E768BC7@newverein.lst.de> <20181001141643.331EE68BC7@newverein.lst.de>
 <CAKv+Gu-ZtJ-BpfPWU=soDCb2+dAd81p8OtaarWhmTe+Fk6A8ig@mail.gmail.com> <20181001150353.GA2634@lst.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 1 Oct 2018 17:06:06 +0200
Message-ID: <CAKv+Gu9tvbM=tb-LJVJtGaq5wD0woX2gtdST+22xJnjZmc_SxQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] DYNAMIC_FTRACE configurable with and without REGS
To:     Torsten Duwe <duwe@lst.de>
Cc:     Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 October 2018 at 17:03, Torsten Duwe <duwe@lst.de> wrote:
> On Mon, Oct 01, 2018 at 04:52:27PM +0200, Ard Biesheuvel wrote:
>>
>> I guess we now have Kbuild/Kconfig support for this, no? I mean, we
>> can now show/hide options depending on the capabilities of the
>> toolchain.
>
> Config options depending on flags availability?
>

Yes. Note that 'make menuconfig' now prints the compiler version at
the top, and kconfig options can now 'depend' on compiler features,
although I must admit I don't know how it works.

>> I am not saying it would be a better approach, though - I'd rather
>> have a warning than have things silently disabled, but other people
>> may think differently.
>
> Even then this switch has to be enabled, no matter who or what sets it.
> Note that this patch leaves everything as-is. Only arm64 users with
> "old" compilers would need to take action.
>
>         Torsten
>
