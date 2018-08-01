Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D205C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFC620844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVPVbOGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFC620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389139AbeHALvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:51:35 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40835 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388896AbeHALvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:51:35 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so33535340oie.7;
        Wed, 01 Aug 2018 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JuY9QN3qr5iO9Mrn06oVTw5HM5/VXEOkuqrC5+UIYow=;
        b=WVPVbOGdxYZ2O8ezpYVZLEloTkmbgrlp7wbB1PW8uksM/iFqsQQRCWCvv/33f/acM/
         IbrH9kBM1ipe/AZzSqS7u4A4dbujmLNy9QQknennbxVeYyYnm8JvQFI+0Pyam6lAJAWq
         4Nz+QT5mqr2UPH2k6mJxhOW/x4W3RZt7t0q+2cdcYRqB66BDr8kroutKIIwrXR9gyus4
         qY30mmG+7GnpRdbQ7L2rrHwX6gfjFczxagpsI10YZLP9CNMKxLX4IC3Z2EhCo0I1OQZd
         JaolpMBqBZ+YmHnYZwXTgEwwrfJvCx7LvatzRfgB20juhWRqhyKm7oZkuEM4IR+xU5C5
         gd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JuY9QN3qr5iO9Mrn06oVTw5HM5/VXEOkuqrC5+UIYow=;
        b=Cf4TikwYqUrIyQRjJKKtJ5m9Am5a79rOueC5NwRjjfeq4O/UvpZAe682cWavFZN+Ga
         3N+x9zl2ygOsZkiawkMeDWAkd4Yo20/VJb/aJYQdQzB2locaIDHLbFYATngPO89HVely
         IFW7+uX6SgRIT2WHx5h+D121nAsf7PpqSr6si/2q9JAXqzVNn9IZ4dBWseMOhp1SePkQ
         vRPAlDsdd/D4xE4BBcKHSHUnKuJGEPH/2UQhmcKNyX/9UID5dzrtvBt/a23IDSG+ssVA
         vmVtNnd1aKagAq11mUf7+wktImY+746z1gtgdX8Ohp7XoGc1y7fB//Utz4ODdnFtASnC
         UopA==
X-Gm-Message-State: AOUpUlFNIkpRSOf5Lpj4/zuidXjgeNlN7yyLOK1dBIPcl472buxIf4gx
        YUMGAgKXG4h39Q4tRwY1odAsNzlNalFej0/AvgvBgw==
X-Google-Smtp-Source: AAOMgpe11M/chpwPrUhRMdi0fxrh+Dvy5nZAy4TK76S4qh6dgYaJxzXv/gLjFKYtRvlfUjTSaEsJVxS1Ulynb37vA2A=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr3032452oib.116.1533117994870;
 Wed, 01 Aug 2018 03:06:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 03:06:34 -0700 (PDT)
In-Reply-To: <CAJZ5v0jHpO3werjy2f1RVuFSNCpJReSi3QzxDT1Vuz5fAGd_Ow@mail.gmail.com>
References: <CAJZ5v0jHpO3werjy2f1RVuFSNCpJReSi3QzxDT1Vuz5fAGd_Ow@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Aug 2018 12:06:34 +0200
X-Google-Sender-Auth: ohX2TzlUWJd0hELUg7wUCgqtwts
Message-ID: <CAJZ5v0iGA=oVV9eaF=JkmK4iY20x44qjkOKDLJa_f6CPUHK=ng@mail.gmail.com>
Subject: Re: [GIT PULL] Urgent power management fixes for v4.18
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 12:03 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> urgent power management fixes for final 4.18.
>
> These fix the scope of a recent intel_pstate driver optimization
> used incorrectly on some systems due to processor identification
> ambiguity and fix a few issues in the turbostat utility, including
> three recent regressions.
>
> Specifics:
>
>  - Use ACPI FADT preferred PM Profile to distinguish Skylake
>    desktop processors from some server ones with the same model
>    number in order to limit the scope of the recent IO-wait boost
>    optimization to servers, as intended (Srinivas Pandruvada).
>
>  - Fix several issues in the turbostat utility:
>    * Fix the -S option on 1-CPU systems (Len Brown).
>    * Fix computations using incorrect processor core counts (Artem
>      Bityutskiy).
>    * Fix the x2apic debug message (Len Brown).
>    * Fix logical node enumeration to allow for non-sequential
>      physical nodes (Prarit Bhargava).
>    * Fix reported family on modern AMD processors (Calvin Walton).
>    * Clarify the RAPL column information in the man page (Len Brown).

Sorry for the broken message, I'll send the correct one shortly.
