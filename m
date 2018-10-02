Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76736C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E76B20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OeP8sxWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E76B20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeJBQJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:09:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43037 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeJBQJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:09:02 -0400
Received: by mail-io1-f68.google.com with SMTP id y10-v6so1515764ioa.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kOwhV85mZVsKuSC20f5Sm5ndrH5hLQYV7V5UWnZznus=;
        b=OeP8sxWG08eIOB0O1bfA3c99v2abR+iRolN0Wv7gekizUnEhImsPnppJmiMCdHKWXC
         br53V5HHxS0YnGMAar1YJ78r0nwrjouFgqwCzk2Wh0gm0QDq+AYlOc7dNihycRxwOG7m
         BtG58HGHRzA4yKxrXDef9az9AnXEulji6w0mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kOwhV85mZVsKuSC20f5Sm5ndrH5hLQYV7V5UWnZznus=;
        b=du3C+6Iag4YTUjgWQyPwbV17PxmharYTpDh7qijTRbtxY5V4gGtWhEvS8Pm2nyOejc
         b7QIs3PM3TmcU7N314AZVCIk8as8J43zP+XiMhB6oN1n2BnCeqffXRVMZuZoadmvFH0Y
         gZD20KCP/e16V5A62RTH6poE17kuuyrsjb/Qm+7eHF1fVYsosczzShZQHWVbMKT12Kuw
         LrbBj2jnQU3KxYNxuMc+DnbAeHa5cJK258aoiTOuIm7bEv2vDABshOeDm6P3aoagQWTt
         9aUK9/CgyE13TqgOk7sJSUkBGRxVlStpLEy+jNI6d2qK27Z5Ogr12KqzL56pHJfnVnfu
         Kagg==
X-Gm-Message-State: ABuFfoh/LaYXJ0XHx8CSmRwIFRCg2DM6O5MebgTEqbb65CQLgceSkWeK
        uoJbKWJj5PO6nd3RqR4y7nHMEZKkjykEOy8KCxkoVQ==
X-Google-Smtp-Source: ACcGV61lhiEFb5AJKv3JRoCmKejg/wRPxcYb/Vi6U4WWORPSbbebTDT9opAoqKGqU+fsbP6V1466gFgD6I9SdZDtCSc=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr9656087iof.173.1538472402604;
 Tue, 02 Oct 2018 02:26:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 02:26:42 -0700 (PDT)
In-Reply-To: <20181002083817.GC120270@gmail.com>
References: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
 <7c25a402-0fc8-fe70-ac95-348a93f4fe69@arm.com> <20181002083456.GB120270@gmail.com>
 <20181002083817.GC120270@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 2 Oct 2018 11:26:42 +0200
Message-ID: <CAKv+Gu9HWPrsaQnFzNi-Kt7kq8yXwFsP5W-4dZrD6eozKbT9zQ@mail.gmail.com>
Subject: Re: [GIT PULL 00/11] EFI updates for v4.20
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Aaron Ma <aaron.ma@canonical.com>,
        Alistair Strachan <astrachan@google.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ivan Hu <ivan.hu@canonical.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Robinson <pbrobinson@redhat.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 October 2018 at 10:38, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
>>
>> * Marc Zyngier <marc.zyngier@arm.com> wrote:
>>
>> > Hi all,
>> >
>> > On 27/09/18 09:50, Ard Biesheuvel wrote:
>> > > Thomas, Ingo,
>> > >
>> > > Please pull/cherry-pick the below. Note that the first three patches will
>> > > be depended upon by an irqchip series that Marc Zyngier has sent out last
>> > > week, and that targets the next release as well. So please advise how to
>> > > proceed with that: we could simply apply those patches first and use the
>> > > resulting commit in tip.git as a stable branch, I suppose, but I'll let
>> > > Marc chime in in case he has any other ideas.
>> >
>> > A stable branch with these three patches would be great. The irqchip code
>> > will also end-up in tip, so it should all be quite easy to manage anyway.
>>
>> Yeah - nevertheless, to keep it all separated nicely, I've created a new
>> topic tree for this: tip:efi/irqchip (2e3ac98133a3), with just these three
>> patches on top of latest -git.
>>
>> That way it can then all be iterated separately.
>>
>> Does this approach work for you?
>
> It's a23d3bb05ccb - i.e. the commit ID of Ard's tree, so if you already based your work on top
> of that then you won't even need to rebase anything.
>

Thanks Ingo
