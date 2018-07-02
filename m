Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAD7C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7972925232
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVXjDW2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7972925232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeGBPVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:21:43 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:37729 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbeGBPVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:21:41 -0400
Received: by mail-ua0-f195.google.com with SMTP id u8-v6so4979677uao.4;
        Mon, 02 Jul 2018 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pGni/ZhikmMCgbPRuYI0W33MGhckiYBQ7gyn8PCI5wE=;
        b=UVXjDW2OJOEMs8LaDL9H9ELRCrp/LusBZ/MFhLJXYng19i18JhwB1AuLrjl/2wyOUr
         vZhHfd7w78FQekfJlOQTLxP09YWmLH2fASOpjP9gvl/HI0zeFwCEC3RLUzdw90riFTvd
         5Cck3QxmGRyeA6LUGHTsljjPYvbFCsrDOtmPzCHxbNIavAQ/pempTxbbj//muDWyaZ4w
         wKmHn/mvzbfoLAeQuMGAF8iXxsqZbdOSyDv3mdxNDYvpbvw3jv4z8kX3ygRFXGDfUXkc
         Z+oa/W0tfGJOc7frYUnvCTkBhUMnXNuyZsE6wx1NqUHqG/DS0tVFccHAgL/Mx+m+04jq
         LIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pGni/ZhikmMCgbPRuYI0W33MGhckiYBQ7gyn8PCI5wE=;
        b=Jfk9m+tG+Ks0wxA6mLvW0KEPAH0p7Sao9aIZUcyRSithlb45fvNvnmkI6y9JRjknOE
         005PeTCYcHNP1JWNKO71ooWxJMbni9TxtiD3ke00FpdUHLMWs86xN7ZiaRoOriYVUAo1
         t3n+pXirh29mxc05+QnbXw4cvZciLrDITqqw5x3K9HWMwokIvrPr+HSEyqY+dbU+PPh6
         3C4uUFq+z2p2+B80ecR83gOo+edCxH6wf6c/bAEJTJ8Tmos6OQhqJz/eMKBlJYgNF2Nc
         Ta+QabcxNB2CJ0/f+Yn4ET4atDzDaekn3KSzu1zmKu0aGkb2QKK8HDMWH7m2w+v6fDAw
         XjKA==
X-Gm-Message-State: APt69E0Wo8IHoqol5jNwvRs4THMne4HO3snmRZ8s5+DZiZKv6KOxBtwf
        6Jr1C8nnSJy7YQONiGLmXWhUIqpKqGmMNCkSWM4=
X-Google-Smtp-Source: AAOMgpcg89RvlHzocgsL+WV2M7xCPGVYU+4HtQT1sBcLyvWIHSHMhMKlMgquGMcHrf3tkjpzlV0koxpdlNB/8tjpiys=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr16138336uae.12.1530544900482;
 Mon, 02 Jul 2018 08:21:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 08:21:39 -0700 (PDT)
In-Reply-To: <e17fbb51b98d45318001adb7eb6a51b2@ausx13mpc120.AMER.DELL.COM>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com> <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain> <CAHp75VcA5ZWahraDP69_hBHuqxw6cng93zAa1op5EBYfuCSPwg@mail.gmail.com>
 <b59027b3-a48e-f168-5f12-c67758c0c2c7@gmail.com> <CAHp75VcK78jL_7sF+ZGaPpwDED-6Xd+SdH_5WCfSBsVJW2GnDg@mail.gmail.com>
 <8307f1e0-c480-3f78-9327-e248208e5349@gmail.com> <CAHp75VdTGXqE__VHjRphEmpMVfxaVVik=u-_0NRhQAKeq=+ZKA@mail.gmail.com>
 <b5652ed8-5fff-4f8b-ec0f-467bce853bf8@gmail.com> <CAHp75VfL3v8U6o36-e3+XPL53sb9wMUOXsL6gn3XE4=-kJjuKQ@mail.gmail.com>
 <367a12e9-7d10-98e4-4791-69cdc7d01129@gmail.com> <CAHp75VdSVLzNHnrOzzrBMf4X2Cg4QACRrnxKNkQzcYJ0h5W+tw@mail.gmail.com>
 <e17fbb51b98d45318001adb7eb6a51b2@ausx13mpc120.AMER.DELL.COM>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 2 Jul 2018 18:21:39 +0300
Message-ID: <CAHp75VfNo9NVfgGn4Fqa5fA9zp47TkqHwn1MJ044qMQoMNMB-Q@mail.gmail.com>
Subject: Re: [PATCH v3] dcdbas: Add support for WSMT ACPI table
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 5:07 PM,  <Mario.Limonciello@dell.com> wrote:

>> >> OK, now the most important question, did you investigate "SMM
>> >> Communication ACPI Table"?
>> >> Can you utilize information in it?
>>
>> > Dell BIOS does not provide a "SMM Communication ACPI Table", just the EPS.  It
>> appears
>> > that the "SMM Communication ACPI Table" is deprecated in the UEFI 2.7 spec.
>> Also, the
>> > dcdbas driver is for Dell systems only.
>>
>> > The EPS table isn't an ACPI table,
>> > it's just a Dell-defined table.
>>
>> Hmm... It's either strange or has some background why is so.
>> OK it has a note that there is no use case, but here it is!
>>
>> Mario, can we consider this as a BIOS bug which doesn't provide SMM
>> Communication ACPI table?
>>
>> Can it be escalated on UEFI committee?

> I don't believe SMM communication ACPI table has ever been implemented by Dell
> on server or client BIOS.  I do agree this table describes the behavior that DCDBAS driver
> has used since before even UEFI BIOS pretty accurately.

So, EPS table has been for ages in Dell machines?
Can we consider it as a predecessor of that SMM communication ACPI table?

> Stuart and I did discuss with server BIOS (who uses this EPS mechanism) to see if its possible
> to move EPS to SMM communication ACPI table however since it's been deprecated by
> UEFI 2.7 they weren't willing to adopt it.

It's pity, but the motivation to deprecate is "lack of use" which is
not true. That's why I would suggest to escalate this to UEFI
committee.

> Stuart, anything else you want to add here?

Darren, what's your opinion about this?

P.S. I'm not against this approach (just some technical comments I
already shared), but on the other hand it would be nice to have undo
that deprecation and follow the standard in new firmwares.
Would you agree?

-- 
With Best Regards,
Andy Shevchenko
