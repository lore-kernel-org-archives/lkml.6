Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647AFECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182EE2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NezzpCD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182EE2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbeGQIN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:13:29 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:37197 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbeGQIN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:13:28 -0400
Received: by mail-vk0-f67.google.com with SMTP id h22-v6so78191vke.4;
        Tue, 17 Jul 2018 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3VO2fd6xCMPqGXWUT5pZLhmFJV1fT4c1kCq5Ud5KqIU=;
        b=NezzpCD0H6p/GQHzpyLXKAXo6PzvdmddHhnOqR/f+l1MVtcgfb9ml2s+YAqAHvVgcU
         IHMyxS/G2w9QaS9cEZpg+3wyLBUl0urfNcc9iLSAzrMQbWhFD1FmyRAsQEGKGyH0cdiS
         tyy1f+uacf2hSc2l+shEpR25fp2RNTqppYoaJtxE2m/d5te1YJL55s1lea8KxvZzPZtN
         gMDQpx0g7/UO6NT+wZPlRuMYobzaYAtFrtgQZgmXeQP/t29V7tMdJmYZ5M6r3Ak0I8qf
         PyHwU0y9qtQODrQMEPAfPANhn00iDBCLpVpZjcHyFj1WvtOqEUIkiyEiL/vNOTyFoShN
         1h4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3VO2fd6xCMPqGXWUT5pZLhmFJV1fT4c1kCq5Ud5KqIU=;
        b=AqCBntHdznPctkKI7ZL4Z/rRoz/b8sXdMYxxlY3uAfHzrHVnNazyI/fqkjQqz9+5M1
         lnLXUFhJxeTSHyEj8Y302In1zRU8xkcla6mexaBDaAMI5+cvETZZZie+OWACwIrUYs3K
         kE8ud/SPPF4uWcmzXtu98h8Bo4DdijV2Zs/c5BkV92whrRMp/aA71o2PnF6EjoRxL4hX
         5GHspRX4P04Qmq7WpaFI8E9zx/ftf6fgHgu3Xs1WxpJByJmzw1ksvmOqGoGW3x3yuCts
         iLf3DUHOEsTsr4UlYNS+3Z3NbY5q61R/t3jV9ilH3o4h07KMsEZw1e7c4CLfUvNCg9oJ
         VYFw==
X-Gm-Message-State: AOUpUlGp4ZBnxC8kHh5MtFAWzOz+IT5oVCWCty5MUObMyldvDKBPyfS/
        w4m6zOaQjgJOf+5dPlNKToLoOWnzt3SqTPSeXMw=
X-Google-Smtp-Source: AAOMgpedSLuPER2VNlvOD5pfANF85b5gtjBt8bjYfFkpblzY6rSP+dgzOUb6ZmqWePAoKAiYJv0+g3ainh0WjDmCXyo=
X-Received: by 2002:a1f:5d86:: with SMTP id r128-v6mr239079vkb.179.1531813332610;
 Tue, 17 Jul 2018 00:42:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f59a:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 00:42:12
 -0700 (PDT)
In-Reply-To: <CANhJrGN9UkmAAp7-O1dgcviP21uYrAT3-BPLinKuAozR2uQvhQ@mail.gmail.com>
References: <20180628075453.GA7793@localhost.localdomain> <153111802456.143105.16373079820431081414@swboyd.mtv.corp.google.com>
 <CANhJrGN9UkmAAp7-O1dgcviP21uYrAT3-BPLinKuAozR2uQvhQ@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Tue, 17 Jul 2018 10:42:12 +0300
Message-ID: <CANhJrGM0pF1ZmJBSE0f=tKa3jtV-tmdsgGdNhS0G1f-ij5PiVQ@mail.gmail.com>
Subject: Re: [PATCH] clk: clkdev - add managed versions of lookup registrations
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux@armlinux.org.uk,
        "Vaittinen, Matti" <matti.vaittinen@fi.rohmeurope.com>,
        sboyd@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Sorry for html email. I'm not used to send mails using gmail app.
Trying to resend as plain text now...

On 7/17/18, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> ma 9. hein=C3=A4k. 2018 klo 9.33 Stephen Boyd <sboyd@kernel.org> kirjoitt=
i:
>
>> Quoting Matti Vaittinen (2018-06-28 00:54:53)
>> > Add devm_clk_hw_register_clkdev, devm_clk_register_clkdev and
>> > devm_clk_release_clkdev as a first styep to clean up drivers which are
>>
>> s/styep/step/
>>
>
> Snip...
>
> I'll respond to these comments when I am back from my summer vacation tri=
p
> after a week or two.
>
> Best regards
> Matti Vaittinen
>
>
>>
>


--=20
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-Matti "Maz" Vaittinen

When you feel blue, no one sees your tears...
When your down, no one understands your struggle...
When you feel happy, no one notices your smile...
But fart just once...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
