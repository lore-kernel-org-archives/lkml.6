Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E404AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9325620821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="PMqHOeRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfAIGXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:23:15 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43434 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbfAIGXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 01:23:15 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so5423824oie.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 22:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ewuUfh3OpPgWumx4SUp4Z5JU9ushcNwkXaQdqrasjIA=;
        b=PMqHOeRSdFReLz6VoQxlCrqO5f6XladkNCrfD6gJHHKHSCsYacnqyTjDMPW46RIWjd
         BBj1YPimD9oNz01du7CL4SbwMSb7yZ6YPQV6bSK512k5Pxw73KFqVanlJOwIBa0EEIZn
         v+QUhuMTCjpEo6JPpZSKnK5aUIUC+BrJePLRz8Nz7qRjkDsK/q/WeUCNglLslboNLsy0
         7BWMYELfa6wbgMX/sHZeWOmx+11aeVPHjgMZdmcYugkVsgA9V93Ho0cJlJEl90AifE0R
         uZnsyXEVqhBKtyUfKFINUYqbRThN9VZ5ht35puZk75G09IHRDM7EOtt6Mx9iTceV1pxo
         fRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ewuUfh3OpPgWumx4SUp4Z5JU9ushcNwkXaQdqrasjIA=;
        b=e6LpLLxUf6Cgqs/XyVcJKDzs6khNqS6FBpgGIOTiebb/e0ooyw1FKt9g5fmaKQUWIa
         acCgijhp89pvu+UKt2boBq6KQYsTy+CkwrGRtfVZGTv5IDoDb7TcSvqeQJE9cqgy9EjO
         B0dr4qmPGeuCPI987ild9fE3lXcg/wsTh0cSFbj3uzHM07kSRmcwhIwgrSABa/obkFAY
         xhxfXxsTGdEbKppPWdfE+y2OL5Pa1Ctz0q52SguOSh1qBldZ+PW+nERnIDmehqhPOy0I
         ZDxqvoxfJaSp5LJQxV5DCER+6xTkOA7fTlauEvGWs1ezGQll8KbFFsbz5d60AVsMlcrt
         xBMw==
X-Gm-Message-State: AJcUukcZx33jx+iGx0L1Z0aKBbR4bcaM/NOMOmAoEo1LqmXNK3vJ9v5u
        RvmAAxTNHwZr6/118+YMl9tcM65OCb7DIZphflBeRA==
X-Google-Smtp-Source: ALg8bN5Yy0TKXSKEo9Meu+AoNq53amEIgO3MYsPuaQUsC6URM3hysWRsLMHQ3gqrI37HHgVwlsT3aJ/xVMThzAzdtA4=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr2936572oig.232.1547014994542;
 Tue, 08 Jan 2019 22:23:14 -0800 (PST)
MIME-Version: 1.0
References: <1546828416-3040-1-git-send-email-lixiaochun.2888@163.com> <1546828416-3040-2-git-send-email-lixiaochun.2888@163.com>
In-Reply-To: <1546828416-3040-2-git-send-email-lixiaochun.2888@163.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jan 2019 22:23:03 -0800
Message-ID: <CAPcyv4gO-N8vJgZjKR3rMLivqOAxHAjCT-KoLEE4U6w3sk==-Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI/nfit: delete the redundant header file
To:     Xiaochun Lee <lixiaochun.2888@163.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xiaochun Lee <lixc17@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 6, 2019 at 6:33 PM Xiaochun Lee <lixiaochun.2888@163.com> wrote:
>
> From: Xiaochun Lee <lixc17@lenovo.com>
>
> The header file "intel.h" is repeated here, So delete one.
>
> Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>

Thanks, applied.

By the way, no need for a cover letter if it's only one patch.
