Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7951CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315CA21A29
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgDVJQER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315CA21A29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933794AbeFZStg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:49:36 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38677 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933266AbeFZStf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:49:35 -0400
Received: by mail-ua0-f193.google.com with SMTP id 59-v6so11581134uas.5;
        Tue, 26 Jun 2018 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=svlQ/dRmyZZOOnbmIEdgmng4eovVIw3Pk2T44X/Zfhk=;
        b=MgDVJQERAuZVOFSCPH37H93frvaDW9W33NRk2LaKh4U/IGDT+YLeMf+JcN22zmDxwV
         BdTC2+hpOI+30yHO7uGLfKDkZlaHP0bS1S/xR8y3bLcw4R2rKqGsMwzkHq9V/XyPV1kU
         UpTUOswi0NShLd0yiGdiwfahf27slth9lA2wSoHnGq96GH/ZHpaGfqIxBaqHXTESUCez
         3L8+QB9RAyqdcMZbSzCS2vc9cBbMX5166yg+sKGObyd0yiAj7aUAAFlmCqhVo7/1fwNA
         qb9rzVIZi54YPJ+bTFDmKtVupSTkXlhr3SDs2HtTLOp7si3GpnvY0dZULI1Q4dCLqNku
         Z5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=svlQ/dRmyZZOOnbmIEdgmng4eovVIw3Pk2T44X/Zfhk=;
        b=Ma/rMT4iNB3IE54HonrMekL1lzaze1wIM0iuOuAh/AluCMaFR9D9ZbsjNeQFIRTRfz
         9maR7S/FYAaT6uCjN05PtMFbu47gXRvB4XGYl0fOA/FIptEsv0Qd/bxKY1Exhi0NCdnW
         cISGPfBp4u1yzC39GkSPPR6wd2xsk4hjNIEULYJVnJgOPwHps3ickdnsefaz1nVno2n0
         SsCYcQY9nhYTTCYY1mdhWkuw02sWwOx1GbNWm86Oc6dGhDRHbQ6kr2g3qH46PeYWgMix
         YqkNVywigEnYbc6YOPMbYbWY9RjYrDZqMsw4geRLERiodtHrpEr1Ebe6YOR/fTdrplC4
         u6xA==
X-Gm-Message-State: APt69E36BZK34DSx4nooRPUhAZEqv7Kilnwo6SKV+/b4TosohI/qOA4E
        ojJoRG4fWbrQvsFn0JJzNz7jITvu7INkzdRXfs8=
X-Google-Smtp-Source: AAOMgpfJcsQsy5Ru19Kiers6rB8nacZsTcOp7f3ghKEkStc7Io8VXB78i5bUKocn+QiSJu03tyl4tiMOMoeElHmxngk=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr1735421ual.141.1530038974320;
 Tue, 26 Jun 2018 11:49:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 11:49:33
 -0700 (PDT)
In-Reply-To: <ad0becb1-eece-b89c-c77f-273403052491@redhat.com>
References: <20180626135535.2990-1-hdegoede@redhat.com> <20180626135535.2990-4-hdegoede@redhat.com>
 <CAHp75VfxQMTMMSZvNBtHGGQAyBaURrBTddtuiQqFmpcjWG6Ktg@mail.gmail.com> <ad0becb1-eece-b89c-c77f-273403052491@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 21:49:33 +0300
Message-ID: <CAHp75Vf2x00AdgWj_zuKGkkBGV8HiZHrfHeMx+AAx0ToaxMF4A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] console/fbcon: Add support for deferred console takeover
To:     Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <xieyisheng1@huawei.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 9:29 PM, Hans de Goede <hdegoede@redhat.com> wrote:

>>> +       for (i = 0; i < FB_MAX; i++) {
>>> +               if (registered_fb[i])
>>> +                       fbcon_fb_registered(registered_fb[i]);
>>> +       }

>> Simple git grep shows that we perhaps do
>>
>> #define for_each_registered_fbcon(i) ...
>>
>> (As an example see for_each_pci_bridge() how it's done there)
>
>
> This is probably a worthwhile cleanup for all the fbdev related
> code / drivers. But outside of the scope of this patchset.

True.

Yisheng, in case you are interested in doing such clean up...

-- 
With Best Regards,
Andy Shevchenko
