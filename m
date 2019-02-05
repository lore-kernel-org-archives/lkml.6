Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C08C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F31217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heMsyozK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfBEPzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:55:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37246 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfBEPzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:55:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so1666625plr.4;
        Tue, 05 Feb 2019 07:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FeIiVekYumUC1Kewaoo/MPQUICR2Dfk4BLZqCT+f1UY=;
        b=heMsyozKKcDwTuBwy2cZwY/aoWm15jAgswt52Brjuxebwt7WAFwu4O1rEQZ0nYffFt
         3HViPuOcChjZkbccB8jnxuj/4wYxu93WhLMqOhoIbuky97JFDln2Jwy6nqDJgoF7U7Oo
         RDxnXKWwz3SirrGsI3kj8lh+PWBALoO/4mGIIWEcSmrDH6g45eGd2uxiaPCnZAb9N1om
         9y2N9TmHNEa4CSFq1tnXcEafABhJb4leDYLrokihP1PaR0AEbqL+tQQWnGYlLdWRVXoR
         WuJ8RArcqQpAHjfLlEElr/3UsKnnPMj+pMp8AQB9g6VU0BJC0/y9G4CwIt6m2HZ3BBsl
         A20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FeIiVekYumUC1Kewaoo/MPQUICR2Dfk4BLZqCT+f1UY=;
        b=io3yly68v0M7CMjbFZm+mtePPo0oIHTdlG85fhJsBH5mevhNRV/eeicRPGk12hC51w
         CEafj2BddbsPl9NZ306jyOZi/is6RekgTtP8RBMEHOD45iDv2onxz0k2sWl+qYY1KZAC
         MgSpICdONP7kh+cMVok8Pr1yX3V449Icy+cobdaV2PeMdUVp/hZUWOw8P4sie7L7/9xR
         4ImPjcAIjbg95zP8ZLsx3j5niPz9iY+m6fIS/ANn+Hlgn893rL/51rW6rWH0hskWyMyc
         Awd/3QLebtg0Jnop7A/zyYQ9gG7+ahWGmMnwZ7lwhVhmBaPF3lCSVKmRZJUK/aU7EZ+l
         80VQ==
X-Gm-Message-State: AHQUAuYSEDo9aINCDIDlSG/LRGN15M1LDbOjnjeitQz95DT7fs68zTRZ
        ewbZ/LN7jzkFuYDSsR1gq9hwBuVn0pdRqkl3bqw=
X-Google-Smtp-Source: AHgI3IZi7/+iK33MTDLMHOwsWTRDoi+fL6lBm+2BXTLv8+xInn4ommRUXiBKPzWZK/aje7btraD/6qR35NuokYStwvw=
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr5617897pla.144.1549382118901;
 Tue, 05 Feb 2019 07:55:18 -0800 (PST)
MIME-Version: 1.0
References: <20181220143451.25962-1-hdegoede@redhat.com>
In-Reply-To: <20181220143451.25962-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Feb 2019 17:55:08 +0200
Message-ID: <CAHp75Vczx8+-Ut0mzB_weT3W6OWYKvd8L2wT+9TXZ-wSxSGToA@mail.gmail.com>
Subject: Re: [PATCH 0/1] ACPI / scan: Create platform device for BSG2150 ACPI nodes
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 4:35 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> This patch adds support for another ACPI HID which describes multiple
> i2c-clients in a single node. As such this applies on top of the recent
> patch from Andy making a similar change for INT3515 nodes:
>
> Commit a3dd034a1707 ("ACPI / scan: Create platform device for INT3515
> ACPI nodes"), which is in the platform-drivers-x86-v4.21-1 tag.
>
> As such I believe it would be best to merge this tree through the
> linux-platform-drivers-x86 tree, as was done for the INT3515 patch.
>
> Rafael, may we have your ack for merging the single line drivers/acpi
> change through the linux-platform-drivers-x86 tree?
>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko
