Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52469C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F2E2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545125618;
	bh=buywPGq1052qgGav0I39/DP57TwvoUAiba10lEeDZVI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0775JZXlEtPKjbSxr4BOB5Jra3Ds8s8usjl7Sky7fC4GoQIlI72x4VeCotmDxepX3
	 J2nHqixNO4hNMnVddGIuolL7bGs0hjwWL+5R/GXEOOHYLydZ3IBhGFdZiH381IpRy1
	 PH3EP1VOaU3h2/UHGU4PwmquBRToqEKXjYLCpdHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeLRJdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:33:37 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:33857 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLRJdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:33:36 -0500
Received: by mail-oi1-f180.google.com with SMTP id h25so1446743oig.1;
        Tue, 18 Dec 2018 01:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buywPGq1052qgGav0I39/DP57TwvoUAiba10lEeDZVI=;
        b=N/SoHyo2PkSbvsIOQrzc5JcldPcl0IK9uCwKk6Jor8ftPKQYxiWrv1D/pFTJ5z67bn
         Yct1KuS5saCUXh7dkMzlJPgb5FjE8XMgAu6+RAP4OJU8YYNIMotoPoTRkl4VbXq44tGn
         m40cP8qe6m8RO9F2gjiqE+YLI1aSoernCOMvLE1sjiU7dwwV4DCGBMdpuoKnAW+mIHOT
         MNzxBmWQyis3Rc1HAJMDtbBfT8HT0FZYVaDUw0Hy66By8ySBg5QdKYix0wR+6H90b46W
         7BPtBoreGAHW3cn/Jspm1+V8sewlG9GsbyEF2HvEqbBjTPxBgzrimwxI14pdDyBImpMC
         NDxg==
X-Gm-Message-State: AA+aEWaIvazyetDwxM+AVW7l8T52SnLRyunue0JFKrrAFkloTLh0+KeW
        9KyoKRyM3u/4kmgk4DnclRBvBiID8HIMuD42ojQ=
X-Google-Smtp-Source: AFSGD/V6WI/4lsPP6zXZs/K+Sit2askL6gh70CRrFAEkWDNA8WOpsKcYLC3EK9Lf+FpOYoLB/VC0RMeBP4myR6bNAg4=
X-Received: by 2002:aca:b642:: with SMTP id g63mr7024439oif.195.1545125615676;
 Tue, 18 Dec 2018 01:33:35 -0800 (PST)
MIME-Version: 1.0
References: <d8d3438a-04a3-2c64-ea04-92a888e59db4@kernel.org>
In-Reply-To: <d8d3438a-04a3-2c64-ea04-92a888e59db4@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Dec 2018 10:33:24 +0100
Message-ID: <CAJZ5v0hdA=kT-iDPSCEQOOT8_baBJ09Nz10CQBDZxr=yvJ_0+w@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 4.21-rc1
To:     Shuah Khan <shuah@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Renninger <trenn@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

On Mon, Dec 17, 2018 at 6:42 PM shuah <shuah@kernel.org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 4.21-rc1.
>
> This cpupower update Linux 4.21 adds support for auto-completion for
> cpupower tool from Abhishek Goel.
>
> diff is attached.

Pulled, thank you!
