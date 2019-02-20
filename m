Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FD8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41012147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550659285;
	bh=z8UuGjINIH1IhIjdrJ86cBQfZd/xl4M5arcq5RFDrw8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kHY6YEwHKBTrxj9WW11nxtN4L+wfCTcsoX8ilcZQKgaGWvnyHSPEsIEkqQ7V2TEnQ
	 9wNC8X7Yj90zTXLpfXKSVSgtUCFB2C7JgoE2/FqxaRI86gNW7cMwmsScWWpytRJnEA
	 ecN2hmfWSptGisDzjpxEvcWhj4F4tlvvC27tgudw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfBTKlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:41:24 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37330 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfBTKlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:41:23 -0500
Received: by mail-ot1-f66.google.com with SMTP id b3so39368992otp.4;
        Wed, 20 Feb 2019 02:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nY68LkdjJ3/JOmcpfiPJR1n+ChChInaf/c1v8eXK99A=;
        b=Uf/NRPYXYv81TZwT2sEa23ZXI0WN1at4SiuDnHVcaXs/bRmyMkVAh1r31CaNLAk+V8
         5VibGcffsE7wU1xR7Ps1tw5OmkCfq6MwNBoQ+HLNGyfljAW4L85kjFbaKYTMi3cl/iK9
         HfBBV7H9rcdjDS2R1Sd9yFJSlZmJj14JKYMwkLupJRUrDdQK5CexjUbm61Khib/oPFZJ
         f73Xg2kfFHonnif+i5Rux+isVeNcn5yILDXRY/B51WVLdVRgI+zf0fc4VnTe4CihBvP5
         pSS6cM6a4BY7DA3BLgsORuxDEhSag9f2OsKSyu8XPXXqCgbWYc63KnsIR1Ry+lOa58ID
         e3IQ==
X-Gm-Message-State: AHQUAua+JxbYCivuGUaMXINhw5AWUTeuCrbRl7mX8LXetS3/0JC3XIjm
        R/E9rL1yD1FZbc03DwJa3/r6brToYk9kHd5Ael4=
X-Google-Smtp-Source: AHgI3IbBR661esWaVatBL8SaslH7ODDEmYwTAyx9fYYHVm4r/EeR9ut4Z9O5UJV0N3+XUKi6ZCHzFWc//1VlKb/b56I=
X-Received: by 2002:aca:ed0f:: with SMTP id l15mr5560023oih.76.1550659282889;
 Wed, 20 Feb 2019 02:41:22 -0800 (PST)
MIME-Version: 1.0
References: <20190220101017.19587-1-e.velu@criteo.com>
In-Reply-To: <20190220101017.19587-1-e.velu@criteo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Feb 2019 11:41:11 +0100
Message-ID: <CAJZ5v0i5BVFRKsCVxDwG90vBAuS3QYB=-GkC0pbGLy5DWDXuMg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Report if CPU doesn't report boost technologies
To:     Erwan Velu <erwanaliasr1@gmail.com>
Cc:     Erwan Velu <e.velu@criteo.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 11:11 AM Erwan Velu <erwanaliasr1@gmail.com> wrote:
>
> There is some rare cases where CPB (and possibly IDA) are missing on processors.
> This is the case fixed by commit f7f3dc00f612 ("x86/cpu/AMD: Fix erratum 1076 (CPB bit)") and following.
>
> In such context, the boost status isn't reported by /sys/devices/system/cpu/cpufreq/boost.

So I'm not really sure why the extra message is needed.  It looks like
this message will always be printed (with debug output enabled) if the
current cpufreq driver is acpi-cpufreq and the boost attribute is not
present in sysfs, which only is the case if CPB/IDA aren't there.

Does it provide any additional information, then?
