Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158F9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5DC222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550139769;
	bh=OTiy0vqM7RfW1sOiWTmz8gYlyj/+vJg4zFUHsj2YuO0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ETrb3m660pnzczNAYfPjk5N4WAa4MUNjMVom+BcLO+KpArejomfa5GdERnBdj5Q0K
	 wThDJN/W+631f0oZnF3QXCvYr28ikx/uAO0CuD3UwxnSAZMPzwGDEG9OgrccnQVFvl
	 xhWtKBRddV3UYHciDIOuYaXYHlMJjxPyktgczYS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438274AbfBNKWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:22:48 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34614 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391132AbfBNKWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:22:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id 98so9680550oty.1;
        Thu, 14 Feb 2019 02:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x8d641DEDyXDlJxfn1B5naalJto0DjJHKiQWb1VJmNw=;
        b=fJqtrpeIx4JMIy0kaBWKi8RrxJIu/VXkrR5gsq0kCnas/MapypeVlIAml8BCjbtKvX
         /6u+gutMBEKqwnSy3oDQIO+MDf31Va7VK55fJZupSIwToxqF3RZyqJKJaBS9+X8dYajl
         2Lots7rfq4b9rqpsr7Pnzhp1/Lmhb9/ZxdVLSZKPQOUrFC35EUMTw7/KQt+fhrcDCFRL
         Na+kQhWKIIhjmkx2lVFcC7gwLF3H6y5fdLPzwURRUWli5NGKMys66Lwk546aZZHqOE6F
         aSfGTHNntuKv4UejIVSotVDDMVqooPgXQjNtQpT893pKBaSER8mqxsUufMxTkmdvR4no
         9Lnw==
X-Gm-Message-State: AHQUAuapsIMhLlSx455tSBizeEd+GoYlK/mpJ6jp5gnMZMfxv37Rc79i
        PYsPRgUAz5BQdVAG2AdJN8IChRBQ6TGqTGv4MvY=
X-Google-Smtp-Source: AHgI3IacgpPIb16dVh21s53Hoe1ZSRJaZgjY2sraIR32OAJktMgWNNoyDbVjhNVeLoBE2PpkdhsfSmE8Y3UAKq1qxVA=
X-Received: by 2002:a9d:638c:: with SMTP id w12mr1876111otk.139.1550139765121;
 Thu, 14 Feb 2019 02:22:45 -0800 (PST)
MIME-Version: 1.0
References: <20190213122105.14270-1-e.velu@criteo.com> <ae38f70b-f352-8567-2dac-5f6c7723a668@criteo.com>
In-Reply-To: <ae38f70b-f352-8567-2dac-5f6c7723a668@criteo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Feb 2019 11:22:34 +0100
Message-ID: <CAJZ5v0geHMDMLqg98BZEGLjNrSRy3juB9y54ots357wVeK-shQ@mail.gmail.com>
Subject: Re: [PATCH v6] cpufreq: intel_pstate: Reporting reasons why driver
 prematurely exit
To:     Erwan Velu <e.velu@criteo.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        Erwan Velu <erwanaliasr1@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:INTEL PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 10:28 AM Erwan Velu <e.velu@criteo.com> wrote:
>
> Hey rafael,
>
> Does the V6 looks good to you ?

I've queued it up with some manual changes.  No need to update.

Thanks,
Rafael
