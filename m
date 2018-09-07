Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58810C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDE4206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDE4206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeIGOUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:20:54 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44169 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbeIGOUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:20:54 -0400
Received: by mail-oi0-f65.google.com with SMTP id l82-v6so26094825oih.11;
        Fri, 07 Sep 2018 02:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUT91gUdnUU/vmVFkJ7HopNsEkK0ZqbikeJAd4ViIjw=;
        b=JNGAYrNZT+3ZRd1mH465dwPT57Tbgo/nfWqZjaOTNu9Wj+h5L/5lq1aRsiIsxNXIy2
         8+33MEOFGvY9fKfW4KZpuMM/uyJZDhMliLmypcmPmNlC9gzm69b/k/SHTsx1O/l2mISU
         VMIxLIonkZDYQB0fguTpOzkdYFo/YCpa9T8fcsJdHFyztKEMG0rv1FpAv8egwyE7iAvG
         5+MfYvJqrDHbmiymGpdHvvDRjfK+fBnh4cCTYnapFHzuoU6+XP8F8f+VEcjNPCpWcNAw
         1m5ZrVZwZjDW4l7wz6+FLRCzXQFhpAl7RhGqec/3CtEhOHWf90O60AznzKFVe7v+HcdI
         qKYQ==
X-Gm-Message-State: APzg51De1KTXVzyfWEoGE/9DZRTncwDoFdaNKT4XrguBRVW3odFMLhPo
        FOIWN0rLNesU6r4n7n0CNo9Mubx+S+fOynaAWMloJuSK
X-Google-Smtp-Source: ANB0VdYPfR0Pu3NWH2UiL9YlwAmyXV13jLu5SPZ9TNzJF0+iXQOBWG8tS2/HH9kKdqVx39Kcdd34hzzpn6zjW7bs4n8=
X-Received: by 2002:aca:aa06:: with SMTP id t6-v6mr7557786oie.152.1536313247046;
 Fri, 07 Sep 2018 02:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0jWX3mBgeQdhGJr8_Okt_bouG+azeFORh=XiMTLvyimPw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jWX3mBgeQdhGJr8_Okt_bouG+azeFORh=XiMTLvyimPw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 7 Sep 2018 11:40:35 +0200
Message-ID: <CAJZ5v0gwBEWeQ6ONkRh84UEO8yBtW6m_ttSzR61YUfUR0Qs6Ug@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v4.19-rc3
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 11:37 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> two ACPI fixes for 4.19-rc3.
>
> These fix a regression from the 4.18 cycle in the ACPI driver
> for Intel SoCs (LPSS) and prevent dmi_check_system() from being
> called on non-x86 systems in the ACPI core.
>
> Specifics:
>
>  - Fix a power management regression in the ACPI driver for Intel
>    SoCs (LPSS) introduced by a system-wide suspend/resume fix during
>    the 4.18 cycle (Zhang Rui).
>
>  - Prevent dmi_check_system() from being called on non-x86 systems in
>    the ACPI core (Jean Delvare).
>
> Thanks!
>
>
> ---------------
>
> Jean Delvare (1):
>       ACPI / bus: Only call dmi_check_system() on X86
>
> Zhang Rui (1):
>       ACPI / LPSS: Force LPSS quirks on boot

Sorry for the incomplete message, I will send the correct one momentarily.

Rafael
