Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFD6C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 00:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6372081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 00:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="rXfq8FJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6372081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeLIAd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 19:33:59 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51175 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeLIAd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 19:33:58 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so12461974iti.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 16:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7JCnuAVpmU+9HYO/EntxxgeLj24G13undlSmpFzSjV8=;
        b=rXfq8FJup/21aQTqyALsbHQk83nCS+qhaR+Upk5ZvcE3XywZySA2YKv5uc5/0zy2kr
         XG5aKlwK13Q2zmW1niDHbYoVXI4UOtFPLi804n5tBwvB4CQh+b0N/S0YTFxdRY2wCoa3
         mrZu2cDcW6snLzHerHFEshpxRptQxcOoZpSeAwTqgpYaJwJly4DAuap0TS6TX+TR/EUW
         IudQJgCPUptHKzMVH4pPMPiTb/nkIzbSCiyYjk/qj9BMv1jaTrnGIHvqCigBEEjtItk/
         yvyjTVakgQ05nBFfpFkMVdK8bG9LdNcR/JlFoHp2XZ2KxfHRxZt/JN8Ckjl1/Wc6nHW9
         d1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7JCnuAVpmU+9HYO/EntxxgeLj24G13undlSmpFzSjV8=;
        b=Lf0S08GrvPT9BOFwRl7gOPTvmdFYzOzTCEskEj+NGDaKM/X7cCY2YijITbXmVJJZY9
         E95iJl8pvTobeLC1zzFcaybsdLtFHdbSM5yP9ByMu4w0onerTSZpoOPmBhpl+aPUo9Rh
         9rPjySUnjk4Q030tc6O4LKPY+M/v3ZSdx4pVHrd9+/aVr4Yle/N9/7jrSX7f/BA7pYs+
         1OTNXStX2YfYYPCSEQhywPDj5RltIgTeHfFvwJmcTENG6R3vDSj7OVh+RrLfW6FPKyr2
         06dH7Ot8JdbrYYtjIZH89phDY3WR0XtRag/UaZX2qEdN+00RH/o7o2xNu2ilxRqmV/5P
         XpDA==
X-Gm-Message-State: AA+aEWZvwhd+HDtT8J+ZVK1Zk124l7mugmno0vwDYbsDB/s5MSLUOgBd
        KbQks3YaHgoR6CgIja2MS4EM0CKS3tSkHIFtSCVykQ==
X-Google-Smtp-Source: AFSGD/VhEV03x1++WZFk1bM+bpp9j/d4H12Ln0lm3PtnRX1RdiADw4snoUCcqCJu26KpTpJvqHKX3fyfYVy0ouliXXE=
X-Received: by 2002:a24:ce42:: with SMTP id v63mr5602246itg.136.1544315637464;
 Sat, 08 Dec 2018 16:33:57 -0800 (PST)
MIME-Version: 1.0
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
In-Reply-To: <20181208170216.32555-1-georgi.djakov@linaro.org>
From:   Olof Johansson <olof@lixom.net>
Date:   Sat, 8 Dec 2018 16:33:46 -0800
Message-ID: <CAOesGMgZYheG77L_nuNtTA8xY-PtDpseHOKf8kCjusiYsv5Mmw@mail.gmail.com>
Subject: Re: [PATCH v12 0/7] Introduce on-chip interconnect API
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, Doug Anderson <dianders@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

On Sat, Dec 8, 2018 at 9:02 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> graphics, modem). These cores are talking to each other and can generate a
> lot of data flowing through the on-chip interconnects. These interconnect
> buses could form different topologies such as crossbar, point to point buses,
> hierarchical buses or use the network-on-chip concept.
>
> These buses have been sized usually to handle use cases with high data
> throughput but it is not necessary all the time and consume a lot of power.
> Furthermore, the priority between masters can vary depending on the running
> use case like video playback or CPU intensive tasks.
>
> Having an API to control the requirement of the system in terms of bandwidth
> and QoS, so we can adapt the interconnect configuration to match those by
> scaling the frequencies, setting link priority and tuning QoS parameters.
> This configuration can be a static, one-time operation done at boot for some
> platforms or a dynamic set of operations that happen at run-time.
>
> This patchset introduce a new API to get the requirement and configure the
> interconnect buses across the entire chipset to fit with the current demand.
> The API is NOT for changing the performance of the endpoint devices, but only
> the interconnect path in between them.
>
> The API is using a consumer/provider-based model, where the providers are
> the interconnect buses and the consumers could be various drivers.
> The consumers request interconnect resources (path) to an endpoint and set
> the desired constraints on this data flow path. The provider(s) receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.

This patch series description fails to describe why you need a brand
new subsystem for this instead of either using one of the current
ones, or adapting it to fit the needs you have.

Primarily, I'm wondering what's missing from drivers/devfreq to fit your needs?

The series also doesn't seem to provide any kind of indication how
this will be used by end points. You have one driver for one SoC that
just contains large tables that are parsed at probe time, but no
driver hooks anywhere that will actually change any settings depending
on use cases. Also, the bindings as posted don't seem to include any
of this kind of information. So it's hard to get a picture of how this
is going to be used in reality, which makes it hard to judge whether
it is a good solution or not.

Overall, exposing all of this to software is obviously a nightmare
from a complexity point of view, and one in which it will surely be
very very hard to make the system behave properly for generic
workloads beyond benchmark tuning.

Having more information about the above would definitely help tell if
this whole effort is a step in the right direction, or if it is
needless complexity that is better solved in other ways.


-Olof
