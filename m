Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FB5C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44002208EC
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIzy0s9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44002208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeHRDP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 23:15:27 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41305 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbeHRDP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 23:15:26 -0400
Received: by mail-qt0-f196.google.com with SMTP id e19-v6so10616314qtp.8;
        Fri, 17 Aug 2018 17:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2TuhWT8ius8NY+PfNfD4YBOeMe2sWqZtrRc5aL1mwXQ=;
        b=dIzy0s9wAV6Uzv+jrB92kiocKuJZmxCYPo/V1lUXJ2OLIerhujdTc1E5rrILQ+WhYE
         ryBz5oro5gZQW0TXaLc6V8mi80rADaV7gW3rwJm/U0pklq1xz+VYpBP1ov6An4fH46Ot
         OGqVgj3lOzv63hbD/BJ5gZh3z+sg4gak84xEbPqVUuCwVZh3w2E3fBlBReLA12hcnHJv
         oDYlVpve/MatOonz//PYUcff0dPj2j13fNvqGHv0ojNe5TWk561w5qC8gJ3h3jvMD15e
         yabnECgshE8SBdBItoTPz5ApACDFUnOuFlwyWfqkw45FAAqlojgPHxFqCXslho2Cfz4K
         E6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2TuhWT8ius8NY+PfNfD4YBOeMe2sWqZtrRc5aL1mwXQ=;
        b=ovM4Ey9kydKspUgjlDqT6L2nhFc+qjo3z0NIASzCNsNj7BJZkNG3vGlHga+HXqhVsm
         LbOg/+Tv4wIyd6dpMJhHrXxVRBn9lLzLeZPqSyfXdX9URL3noeaWBgxJFgCeRfBP3r5w
         OzrPv+RSytZ5Zn3OnPnyH5LAqAEY/Hc1xyDu0T23JCXnAd5XnLWMdgUsIbkxSoU4T0en
         S5B47OYw3BMuzvcl/H9o9AYK+MA/BFHqmrKRHwuT5QKR6okHp/rvpyOLU0KFpGma05zq
         qUeTLiuJEBAAlJwKu22byWJYUbKBp0E1DnrKcvs6zOcKyC64jAiKBd1mUMRGeXb+kqMj
         OnAQ==
X-Gm-Message-State: AOUpUlHWKKcNcYx5TVSyMNbNugtkmWHgrMac3QKD2Y1T+SGvXy7h216C
        xT0NUJ47UIDGvOxmjyL4maM=
X-Google-Smtp-Source: AA+uWPxgEB7lQkAdQPFUL4lOWLipwXmHIhotLU/4iIUfhAI/5/0VZXPsCkSd6al7jtzGaCkAgNcFVQ==
X-Received: by 2002:aed:25a2:: with SMTP id x31-v6mr35564181qtc.228.1534550995844;
        Fri, 17 Aug 2018 17:09:55 -0700 (PDT)
Received: from eeboy (pool-108-26-184-53.bstnma.fios.verizon.net. [108.26.184.53])
        by smtp.gmail.com with ESMTPSA id z3-v6sm1837063qkc.55.2018.08.17.17.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 17:09:55 -0700 (PDT)
Date:   Fri, 17 Aug 2018 20:09:53 -0400
From:   Richard Cochran <richardcochran@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bryan.Whitehead@microchip.com,
        UNGLinuxDriver@microchiptechnology.mail.onmicrosoft.com,
        David Miller <davem@davemloft.net>,
        YueHaibing <yuehaibing@huawei.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: lan743x_ptp: convert to ktime_get_clocktai_ts64
Message-ID: <20180818000953.GB13653@eeboy>
References: <20180815175040.3736548-1-arnd@arndb.de>
 <90A7E81AE28BAE4CBDDB3B35F187D2644073E9C4@CHN-SV-EXMX02.mchp-main.com>
 <CAK8P3a0f38ev5E4Zvg_3BS+1UN2NzYSw+dyRHXDwLCWgREXJ6g@mail.gmail.com>
 <90A7E81AE28BAE4CBDDB3B35F187D2644073EA26@CHN-SV-EXMX02.mchp-main.com>
 <CAK8P3a3guebtDLNhbQwNmA2nq=raKiP8ztGRpb03r0XD8h+ZNA@mail.gmail.com>
 <90A7E81AE28BAE4CBDDB3B35F187D2644073EA3B@CHN-SV-EXMX02.mchp-main.com>
 <20180817162558.GB22210@eeboy>
 <CAK8P3a1XEDzGtxyZ3Q6=jZe+w67r_ZakksAEQVDC8pYSCne55A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1XEDzGtxyZ3Q6=jZe+w67r_ZakksAEQVDC8pYSCne55A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 09:29:56PM +0200, Arnd Bergmann wrote:
> This certainly seems to be an "interesting" problem, given that the Linux
> implementations (other than the new lan743x) then start out with UTC,
> while the PTP spec mandates TAI. So even if the system clock is
> perfectly synchronized to UTC at boot,

When the system boots, it is not synchronized.  Only after ntpd or
ptp4l start their work can we say that.

> we set the PTP hardware 37 
> seconds slow.

s/slow/behind/
 
> It would not be hard to change all PTP drivers to explicitly initialize to
> TAI, but that might create its own set of problems if random code
> depends on the current behavior.

Right. (But there was never any guarantee.)

Also, devices that don't have an RTC (like many embedded) start with
1970 anyhow.  So you really can't have "correct" time at boot.  The
question is, which incorrect time would you prefer?

IHMO a clearly wrong value is more useful than one that might be
mistaken as correct by a casual glance from the sysadmin.

> I also see that "phc_ctl /dev/ptp0 set" defaults to CLOCK_REALTIME
> and has no option to use CLOCK_TAI instead. How is this meant to
> work? I see a lot of other code that tries to deal with leap seconds and
> the tai offset, so I hope I was just misreading that code.

You *can* set UTC and then jump the clock by 37 in two steps.

But I don't see an simple solution for setting the TAI-UTC offset at
boot without actually consulting an outside source.  Even if you have
the NTP leap seconds file, how does the system know the file is up to
date?

For PTP and PHC devices, there are two use cases.

1. The device is a slave.  In this case, applications need to wait
   until the PTP status bits say that the time is valid.  The invalid
   time before shouldn't be trusted at all.

2. The device is a grand master.  In this case, the PTP stack has to
   wait until its global time source (like GPS) is ready.  Then it
   will synchronize the local PHC to the global source, and only then
   should it advertise the valid bits.

So I don't think the particular kind of wrong start-up value makes
much difference in practice.

You could argue that if

  a) the system has an RTC, and
  b) the battery isn't dead, and
  c) there is a leap seconds file that isn't out of date,

then the initial PHC time will be less wrong (for some definition of
wrong) using TAI than if the driver had used UTC or 1970.

I myself can't get too excited about having "less wrong" time, but I
wouldn't mind trying to set TAI in the PHC layer if people feel
strongly about it.

Thanks,
Richard
