Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9CEE2C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B02208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1hnH3SC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B02208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754569AbeFMINf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:13:35 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:42281 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754479AbeFMINa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:13:30 -0400
Received: by mail-vk0-f45.google.com with SMTP id s187-v6so985655vke.9;
        Wed, 13 Jun 2018 01:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2H4YwMKEDRVbgnq2YT+Ve6QkezSPYXmZ4W8Ct2Cw2As=;
        b=U1hnH3SCyWxJIIG4+MTgUOWPMqumoR8k4XpZa++RSGsGO2LF+o4amWL5qRPOg2pLqo
         qLHDYnKlOu70fv843SE2YOSqk3NvnKBB2H9snd2J4wxB0qyYk1CwaH1opFJDdX+wuFMg
         D3A8GlIA1JmQLGcZ/JirKr6tag/sKOWQiW6azHgSxyPb70gW1ahRIPbheG+ryfagSd6p
         kQaBO8Kupa0hIV+zBZsqLNga4dtDa7FHme5izDIoQQZLBG012mle4aSFySJwgwOT6fNw
         1VMTRlSs3y1ChAJZ/3LlUNGYtNO0InQ/mSqEH0F9goMzdifUEPHUk5XybFH6IY/2hJ+K
         clDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2H4YwMKEDRVbgnq2YT+Ve6QkezSPYXmZ4W8Ct2Cw2As=;
        b=E65TYG9jwU+jb9Aw0o//79hC3I9LDfENXatcosr1vF0iYeImhn3OZN0/T6+QXqf74x
         3dJvHeWkiUaB8nQVGxlFZlnhWmqkMr/1BDpPKb95zhYg5ujFH5bx+yhvCfzukmYW0hmj
         2JXiQiBpPRltlkptWX5IdDOqNKjPZ0kIuqEUAjjWwohiBfiyYQNatseJgIyG49LXtW+m
         RhGRr4WUnFbJX6eI+n3XmYEgFtkZaUnQZ9QwW9bTdoMcnW3Fz5wEC7f/7epu3gUAwJ9x
         /XgAod4gqclvCk2aRASjsRQc6hh8kkKtwUID2d7DfvnMT016/mIDsWg8VfQ5bHoR18l7
         ErLg==
X-Gm-Message-State: APt69E0Ch2apQ1c17BgYhOSsAmJ4Z0XcNAs7qehS+Mt4PLjrDh2juRDW
        8GQWKYun1AwkuDon274ZASlTS6Ft+jBHJTZfojY=
X-Google-Smtp-Source: ADUXVKJwmRkRJ6lc6uYuAdpsubDOcMjCArLAFAwDm2bz7CO3jfvAeOmtbPMjWT+zv3g8XaEUzHZbzlueMzyfrCMSmIk=
X-Received: by 2002:a1f:8e0f:: with SMTP id q15-v6mr2496323vkd.161.1528877609049;
 Wed, 13 Jun 2018 01:13:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 01:13:28
 -0700 (PDT)
In-Reply-To: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
References: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jun 2018 11:13:28 +0300
Message-ID: <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
Subject: Re: ACPI support in common clock framework
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Rafael, ACPI ML

On Wed, Jun 13, 2018 at 7:14 AM, Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
> Hi Michael, Stephen,
>
> We are adding ACPI support in our Linux based platform.
> At present our clock hierarchy using common clock framework through DTS.
> Now we required ACPI support in common clock framework to upgrade our platform.
>
> For example, clk_get API called in many drivers to get clock device is
> tightly coupled with DT framework.
>
> Please let us know, if anybody in Open Source community have plans to
> add ACPI support for common clock framework.
> If not please suggest us alternative method to use common clock
> framework in ACPI use case.
>
> Thanks in advance.
>
> Regards,
> Srinath.



-- 
With Best Regards,
Andy Shevchenko
