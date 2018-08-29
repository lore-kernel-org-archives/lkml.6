Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E9EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACD0204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6GRUptP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACD0204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbeH2Rym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:54:42 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40461 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbeH2Rym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:54:42 -0400
Received: by mail-oi0-f66.google.com with SMTP id l202-v6so9252155oig.7;
        Wed, 29 Aug 2018 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=darkds5IiQuT7nNNT8vmMugjQbIhAt+CKuhVElhpgX0=;
        b=o6GRUptPkCCVWouEnkG1K6l1BqAVdhns9O4h0/J9AzdauBsNsWpk4nC84pbXaRXjqq
         aAguSxTzUf+X3cEnLYkPjuA39GSLrqF5SdqLEs9GcjvRbKSriOxyyml8jJFXV1UlDLbZ
         553yoW9BOnG/ef916nsYa2+uuU1YEqC2Eg0fwLvBbLMLUxKd9U68LKAIZvlFgpKbL2zm
         yHqXnkkre5hfC1YStwG3PRpksH7fekmWwl4Chhw+2mWFOx7q8g0h0qA4mzTXF3IslfyO
         jBhYhEzrtv66G6YALcFqsjZmxxgRKrQgxPxqjQxu2umntYJ9L9TTeZhsOSSJoqMbT7Dh
         RuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=darkds5IiQuT7nNNT8vmMugjQbIhAt+CKuhVElhpgX0=;
        b=j0G4/m2ASSTRsf4fEZwNtpDFliwV/pc8fikAo3Mqkf5tQC49vdlmot/MKZJwD142L5
         95UOH7D0zVM9BHzfSz8q8H8AstkozZLJVm5aP9t/OkwNmCbstPGhaoRF6giUpQjSg4vw
         TmGecKhSlXW2ArmEGA/VyR2UHyf65ElLvYeJkGz26rSqTe0+8YBD+XZVR3GMhgxyq8LA
         qgAHhw6nyaFnCaqEfzKrYiDACkpr4L31PgDrZZoLFq9QHMXInSrHObdJ2ZdGlRQ440q4
         cRw8JnZeq6q1SWiWg7P8d4UdgDcmGj8eQf2mFlGv1L13ZOEQd9V/ObaG2brA/DW55ctM
         uvUw==
X-Gm-Message-State: APzg51AKOJU3qfuVY3p2AtcNUSd59rpxPcerNjdzNsMM7PdyOUHgCBmm
        L54H0sybNJBm5+XUi5HOPfGnsv6BKowhlvyDRXM=
X-Google-Smtp-Source: ANB0VdYDY1j9GTJsfJd4SWxMacXXncEL6vpzIimki9UF/dLAiC4ob4IgVTl7BWyHwtnXgtMZ1UPrGj3RRAlrCyYrDLY=
X-Received: by 2002:aca:df42:: with SMTP id w63-v6mr2963789oig.295.1535551057541;
 Wed, 29 Aug 2018 06:57:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:284e:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 06:57:37
 -0700 (PDT)
In-Reply-To: <AM6PR04MB5158CB868A4E2AD5AFC5B476E3090@AM6PR04MB5158.eurprd04.prod.outlook.com>
References: <b2ea002f-4fe8-0738-b346-69ed138cecd0@prevas.dk>
 <b2505963-0fdc-81d2-6b8a-315a31eb922e@prevas.dk> <AM6PR04MB5158CB868A4E2AD5AFC5B476E3090@AM6PR04MB5158.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 29 Aug 2018 10:57:37 -0300
Message-ID: <CAOMZO5Bvj=kB8m7DcX2vSLr3e0_uW-CnURtwM71YJ=NWT+DCgQ@mail.gmail.com>
Subject: Re: reboot on wandboard fails with v4.14.67 (bisected to 2059e527a6)
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

> On 2018-08-29 11:55, Rasmus Villemoes wrote:
>> We're using imx_v6_v7_defconfig on our Wandboards. After upgrading to
>> v4.14.67, reboot no longer works (or, well, takes a very long time when
>> the watchdog is configured).
>>
>> v4.14.66 works fine, the breakage bisects to
>> 2059e527a659cf16d6bb709f1c8509f7a7623fc4 (ARM: imx_v6_v7_defconfig:
>> Select ULPI support), and reverting that on top of v4.14.67 again works.
>
> FWIW, v4.18 (the mainline release containing the upstream commit
> 157bcc0609) works fine, while v4.17.19 which also has that commit
> backported (as df06ca1f56) fails. So I'm guessing there must be some
> other commits in v4.18 that happen to make imx_v6_v7_defconfig work.

Thanks for reporting.

Commit 157bcc06094c3 ("ARM: imx_v6_v7_defconfig: Select ULPI support")
was meant to be applied for 4.18 only.

I think we should revert it from earlier stable versions.

Thanks
