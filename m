Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FABC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA652083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1RYI7+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA652083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbeGZOJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:09:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33304 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729915AbeGZOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:09:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id r24-v6so2055952wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 05:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nZkdPL5YMew1zbk1juE6ODfYbAKD2+CDx4te/Au6EHQ=;
        b=W1RYI7+tttAkS/2Emf53D8eUmKoGotVfbJn66/0aYQ16dPsLAqEtW6zVvhSelhyE+Z
         qvUugl6deg8ffN9/+YGVbRe35muWS4Y+FvZCVNRs5J7ji6VcisAJwH8Ksh6kxulO7MSj
         kLDMqXgyL/WP8nz7+/B89P1cXF+ofTgir66EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nZkdPL5YMew1zbk1juE6ODfYbAKD2+CDx4te/Au6EHQ=;
        b=IzffZpWzaIVXvAAp4N2gKthZZsCodAKQirGUyg83v8SCgA86RrOomnYj9waUci00Us
         vbhQY3VORtHhE4m9Gnj8ixy2g2qqMnKxdjbv2AJ6RoHuucf1k0etPYEyquD3lItku7+p
         Q5q2NvIG57w17ad4xSJOLx7nqwuxDPdfhARGtAOSb2kp/XiGzqZenXDjLDXeyidCesry
         pYtR6m9jkmpDU8OWmbOGQz9LasFB1sYDcLhrI5bksS1L1ffRlZM7mS3vuevr8fm8Suo9
         DW5gLQ33CATs1/15K0kc9flRVmAthNhDkQ+DQAyMnjt95EAuGjN98Jl5RP51Gk2cf0bv
         VNlA==
X-Gm-Message-State: AOUpUlEMSXMYNoMo+Z8qg6pQ2BmCkhpvIMecL3E2ZF/414cYrtuikXNi
        LIM0LXMFqYvBWxHiz/atnPa7lg==
X-Google-Smtp-Source: AAOMgpcqlN5zcwWNb287dneCMnD91gIN1zIIuqXoNaWjsVeI9+p6nB2i8ORch5qxye7Kp7B3+EMYAg==
X-Received: by 2002:a1c:6d94:: with SMTP id b20-v6mr1568047wmi.28.1532609543845;
        Thu, 26 Jul 2018 05:52:23 -0700 (PDT)
Received: from [100.125.208.68] (193.84.136.77.rev.sfr.net. [77.136.84.193])
        by smtp.gmail.com with ESMTPSA id w204-v6sm2221522wmw.5.2018.07.26.05.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 05:52:23 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RT] rtc: Disable RTC_DRV_EFI on RT
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <20180726124613.xgmidioqd4mcqpiw@linutronix.de>
Date:   Thu, 26 Jul 2018 14:52:21 +0200
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8640BE46-B141-44F9-BD92-58A21A2B0EA7@linaro.org>
References: <20180726090449.hfvtey3ruzzhzdaz@linutronix.de> <CAKv+Gu_+t_VwY3xDq3nWbnOTfzBc6OtQeRD2GKsseO2uK-uruw@mail.gmail.com> <20180726121504.ba35z3j3wsesryy3@linutronix.de> <5052E25B-9942-40C1-BD53-86E3D7014557@linaro.org> <20180726124613.xgmidioqd4mcqpiw@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 26 Jul 2018, at 14:46, Sebastian Andrzej Siewior <bigeasy@linutronix.de=
> wrote:
>=20
>> On 2018-07-26 14:26:25 [+0200], Ard Biesheuvel wrote:
>> What i mean is whatever you end up with if you pass efi=3Dnoruntime to th=
e kernel.
> ah. So I wouldn't have to patch this, just document it. That might work.
>=20

We could also make it the default on -rt, but not disable it entirely, so th=
at efi=3Druntime can be used to re-enable it.


>> But as i mentioned before, you may also lose the ability to reboot/shut d=
own your system this way. Can you please double check?
>=20
> I checked before posting the patch. psci is used instead (on softiron
> here, have nothing else). psci_sys_poweroff() works.
>=20
> Sebastian
