Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48730C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BC721759
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PoQMGVpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BC721759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeHCNiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:38:04 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:53026 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeHCNiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:38:04 -0400
Received: by mail-it0-f42.google.com with SMTP id d9-v6so7946296itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 04:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+OzYxOL1NAocZcUTysGCgjBpjOhJUFmqMpJTa3Uj7uY=;
        b=PoQMGVpJzf6+hrDPHAcAtQ4i5RKHN6zNxrDKYzDLXIBq3fZJ5L+qP64R19N5GxdHaX
         mqIFAA4XU+pPLDwbLV6k8YsEUklnt2QrlWgQFGzmv7q5y8KXInTZ+OcOC/ckRnIgfz0M
         POvh6iVQsMrQG9+V/tsum3wIARGU0JeEovQMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+OzYxOL1NAocZcUTysGCgjBpjOhJUFmqMpJTa3Uj7uY=;
        b=Kh4xRoTXUYdo8hbe5kA524PKjHKoWlmZ9ODsHegAJK6g1zqUakxJqtl7tPs7pAc2u1
         gLcyaamZrNg91UcleqHMwyvuVWcSMLI/hATcpvq1vzbqJFbA2TNgrEVcDHudKVx3fyUp
         rvXLaU6/JWRaCf5DUu1LYc8XCO4ZNpeh62VksCJwCbCANtmq8v989I7SaIsZj5CTjnAV
         2lmQ2hdubCp28b/ZdJJRiPWVIcRo8n1vSv9La2rdPM0n9W5/0Cjph1go0abUYg1GgqrN
         qd8ypEYzUoMY71hhyWzEIc5JxIiGHtTzTECNGyzVunBPcuToXuCvOOQ6H9vZojaAy1Wo
         DM4g==
X-Gm-Message-State: AOUpUlEIkhNV8mozYEVg84opXNJ+xqGalLHUb71cGDRDXXQyfkIuNIDY
        J/v1MZwte+yasXLWRrN/GCAp7nENqAw4p0lmZtVOrA==
X-Google-Smtp-Source: AAOMgpeGlomKtFbPuPIlkk2xhvo7Kw3qEL8Wf/Fs0oHb3Wl+oKWEUvpThH+j/snsXpq8gJNotJUPo+PUxMdsDfS8EOw=
X-Received: by 2002:a24:4524:: with SMTP id y36-v6mr6064149ita.97.1533296527213;
 Fri, 03 Aug 2018 04:42:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 04:42:06 -0700 (PDT)
In-Reply-To: <1726374.375PCQfjLZ@aspire.rjw.lan>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <2056372.NMt4aPaF4h@aspire.rjw.lan> <2205807.cU2puvubpP@aspire.rjw.lan> <1726374.375PCQfjLZ@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Aug 2018 13:42:06 +0200
Message-ID: <CAPDyKFrmP15+_hyRp44Jw-wsTmsNFKORdCeGJEgW8o0OoKiHhA@mail.gmail.com>
Subject: Re: [PATCH v8 09/26] kernel/cpu_pm: Manage runtime PM in the idle
 path for CPUs
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>>
>> Assuming that I have got that right, there are concerns, mostly regarding
>> patch [07/26], but I will reply to that directly.
>
> Well, I haven't got that right, so never mind.
>
> There are a few minor things to address, but apart from that the general
> genpd patches look ready.

Alright, thanks!

I will re-spin the series and post a new version once 4.19 rc1 is out.
Hopefully we can queue it up early in next cycle to get it tested in
next for a while.

>
>> The $subject patch is fine by me by itself, but it obviously depends on the
>> previous ones.  Patches [01-02/26] are fine too, but they don't seem to be
>> particularly useful without the rest of the series.
>>
>> As far as patches [10-26/26] go, I'd like to see some review comments and/or
>> tags from the people with vested interest in there, in particular from Daniel
>> on patch [12/26] and from Sudeep on the PSCI ones.
>
> But this still holds.

Actually, patch 10 and patch11 is ready to go as well. I ping Daniel
on patch 12.

In regards to the rest of the series, some of the PSCI/ARM changes
have been reviewed by Mark Rutland, however several changes have not
been acked.

On the other hand, one can also interpret the long silence in regards
to PSCI/ARM changes as they are good to go. :-)

Kind regards
Uffe
