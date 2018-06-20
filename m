Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4F4C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A7A208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0fJb85ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A7A208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbeFTAgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:36:21 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46988 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbeFTAgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:36:18 -0400
Received: by mail-pl0-f66.google.com with SMTP id 30-v6so731910pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 17:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=I28aluI7jokKZRqQOKdYQoSTFkJEfDaRhB1BY3EJB3E=;
        b=0fJb85jajNbCKFkAPFe2+vGwLnwRmGSbArTDHEwvr1BEdD//wFELOkC0PZlafZLMlj
         n+OTnwZdyMroSYlhaftHlAQkQFcXyxV6ATaQrX23OWVg91O2g6DvIHJprp6WKSQnjpdQ
         7Eq4tEpl1lD/Sook0ykRjgNzd7EpOG/qpVUDGZGtHdcUchUHfUbLlYZlsAvmJ9mZb+/R
         RdL6vFuSB+BwLQ5YA3xsjNX9Ccp9U2lVXyASKppW3/iZIQV8SBygY8OSw8DmlIzfqf24
         SWJDNDiEUYJWpdEcskhLSBNcD3DRYHPvpX8J7/fqvV5G8hN1slZ0pO3up+8q0Igm1Y2x
         8xNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=I28aluI7jokKZRqQOKdYQoSTFkJEfDaRhB1BY3EJB3E=;
        b=QP9f2sTF/PEOQkxMhjOlwk62kWCOXbmGrOBhTQMtUpXkiwwc6pu08Dry6z/IiUAamH
         56ogKOjC6qcaUOkdZW2N3uaxy/DbbcbPG4vZq02AcSe2iXS1K6/DdWHICVKoiyGKqD4o
         Glz6hbtBsVaH2u7WS7hhYrEiYQ3VV6Gb+tWcbsrS7KltLBE6KkSghockJARan7X3KG+z
         a9R8MJSvkZS78LHzeZ2kfVQS9pd3Gt0KV+/u9Xods5rsT9GCMOYepAZOfklvphv+VXM3
         ofwoa+WKCk+quZxxbsNpeCJakOjZFc70s/v5RO7VKwlRwduqV1ryVMy2X/a6mX7/Znwq
         Uj1g==
X-Gm-Message-State: APt69E1cfUxomEtmtcsnDBxWMicrTdRL32C5lFYgHIdP59H+aGaPfkM/
        Ts4c8fM0wIilNT5ykP0GSxfVfQ==
X-Google-Smtp-Source: ADUXVKI4v5nolSbAK1wUBpVMJqORnPeXEUDrpmgcuHHlvyLWXgNTIxosjjvr4TOpyYRmFt9FYSg/1Q==
X-Received: by 2002:a17:902:294a:: with SMTP id g68-v6mr21675128plb.58.1529454977360;
        Tue, 19 Jun 2018 17:36:17 -0700 (PDT)
Received: from localhost (s169.156.222.122.fls.vectant.ne.jp. [122.222.156.169])
        by smtp.googlemail.com with ESMTPSA id s28-v6sm1147520pfg.89.2018.06.19.17.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 17:36:16 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/21] 3.18.113-stable review
Organization: BayLibre
References: <20180612164825.401145490@linuxfoundation.org>
        <5b20444c.1c69fb81.cb5e6.5a8d@mx.google.com>
        <20180613044055.GA32451@kroah.com> <7hfu1qw7o8.fsf@baylibre.com>
        <20180614155127.GA9178@roeck-us.net>
Date:   Tue, 19 Jun 2018 17:36:13 -0700
In-Reply-To: <20180614155127.GA9178@roeck-us.net> (Guenter Roeck's message of
        "Thu, 14 Jun 2018 08:51:27 -0700")
Message-ID: <7hbmc6nvk2.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:

> On Wed, Jun 13, 2018 at 05:09:11PM -0700, Kevin Hilman wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> > On Tue, Jun 12, 2018 at 03:08:12PM -0700, kernelci.org bot wrote:
>> >> stable-rc/linux-3.18.y boot: 52 boots: 28 failed, 18 passed with 1 offline, 5 conflicts (v3.18.112-22-gb0582263e3c9)
>> >> 
>> >> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-3.18.y/kernel/v3.18.112-22-gb0582263e3c9/
>> >> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.y/kernel/v3.18.112-22-gb0582263e3c9/
>> >> 
>> >> Tree: stable-rc
>> >> Branch: linux-3.18.y
>> >> Git Describe: v3.18.112-22-gb0582263e3c9
>> >> Git Commit: b0582263e3c9810fd887ca92d19cb9ff30a4d9f6
>> >> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>> >> Tested: 24 unique boards, 12 SoC families, 13 builds out of 183
>> 
>> [...]
>> 
>> >
>> > That is a lot of new failures, did the whole lab fail, or is this really
>> > a problem in v3.18.112 here?
>> 
>> Whole lab failure (more precisely, lab operator failure)  ;)
>> 
>> gak, I updated the rootfs images to the latest buildroot, which forced
>> me to upgrade the kernel headers used to build the rootfs from v3.10 to
>> v4.4.  So I guess it's no surprise that every single board panic'd as
>> soon as it hit userspace.
>> 
> I build my root file systems with buildroot, and had a similar problem. My fix
> was to patch buildroot to let me use older linux headers.

Could you share the patch?

I was lazy and just rolled back the buildroot release.

Thanks,

Kevin
