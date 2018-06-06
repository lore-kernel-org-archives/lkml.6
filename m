Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xnRVCXpsGFuMDgAAmS7hNA
	; Wed, 06 Jun 2018 23:21:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0BB81608B8; Wed,  6 Jun 2018 23:21:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snCV8FM0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8887B601A8;
	Wed,  6 Jun 2018 23:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8887B601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932108AbeFFXV1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 19:21:27 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35905 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeFFXVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 19:21:25 -0400
Received: by mail-oi0-f65.google.com with SMTP id 14-v6so6896765oie.3;
        Wed, 06 Jun 2018 16:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/LzBnBAXe/GfxGAa/uuLZw/1mYi8DAarnzBGpKsdmHU=;
        b=snCV8FM0EUh4XAYPCLMdH2wng7p3EaeltdOLWoTif1WnqbogCgWcSVrJbpByvCZ0BN
         9uH3VoPhws/X4Z0bqwwFMxDY0WV5kLcS1mezPFw/Y2hMqvo5K2nLMXOzxognKMIb0k8F
         kpC1zmd1svU8EYB+RF2127kz2yDcs7MvHY4n93szxjsFtgaDLmtXq7YOI0ysQg3OJwCP
         Wo7rQLJUlox0I1tCqS+yEKLhkKINTNAbuNDVgLVs/WFn0Ejsav8DiU7Z884mSaE6cen2
         QYjkPPaJWMRBAZpehm87YPZdf/2fJ7pqMTivUYHpEUpOIIVc9nB/wMuu+ZxuhxogxFYu
         8YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/LzBnBAXe/GfxGAa/uuLZw/1mYi8DAarnzBGpKsdmHU=;
        b=e1Kl9hUgaSGv/Lzpv/y2e5O3ECp68LVKVExinKxvdlCcsE4sJHJxuhLgY2WVq6A32x
         daNqW9fdjvfi6EdVXyoO1pfePSag8rTFBQFVJaCd3/ogTKl1Gu0sTS8gj/BLhNyhXLNC
         6bNjqeSZSzKI3JWsaDW151JveX9GM2wOytjL5Fo5przgr/oPc4xZZDkTVoPHcQiUDq2K
         aHYDZlE+4wbZTmmhCPw98so5AIdHek8++B7MQFMkVB+pkqbEID9lhGZvBexTfR57Jfh7
         jC4Lk65PoaKNFvSWgd2xf684UMv9i+PGN/qF7suO+3LA4YD7J34osP/ANYPWu6GGRgAM
         xG8g==
X-Gm-Message-State: APt69E23nEbLz0PSA7h/h3e4cBQsCX9aALO4vYMJOYslCMEYl5C74kN9
        7niA8Z6m6NGEOOrFsyCJi7cqAUtS67sllzx5Il0=
X-Google-Smtp-Source: ADUXVKK+PX2TEzeggPOcX80VS9Op+wiFcs+3ZfsYBGl6GS2I9mBnoqAFBarL6oKcbW5DdAODtQCGRZZy5i+Yu25cPAM=
X-Received: by 2002:aca:e143:: with SMTP id y64-v6mr2691127oig.282.1528327284820;
 Wed, 06 Jun 2018 16:21:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1468:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 16:21:24 -0700 (PDT)
In-Reply-To: <20180606231130.GA57957@decatoncale.mtv.corp.google.com>
References: <20180604182612.72699-1-ravisadineni@chromium.org>
 <CAJZ5v0jBTpUzqEj1CeQ0CKH7zVRkgj1qJffoSujEZWi0HXABXw@mail.gmail.com> <20180606231130.GA57957@decatoncale.mtv.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 7 Jun 2018 01:21:24 +0200
X-Google-Sender-Auth: 81OAjQyJTPqQXntbHVHJllYmoDs
Message-ID: <CAJZ5v0gXqyKQ5yTtqFYzv=KW2o+b4vGiUYiWWn+iT=zY-mU9xw@mail.gmail.com>
Subject: Re: [PATCH] ACPI LID: increment wakeup count only when notified.
To: Benson Leung <bleung@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Todd Broch <tbroch@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 1:11 AM, Benson Leung <bleung@google.com> wrote:
> Hi Rafael,
>
> On Wed, Jun 06, 2018 at 09:00:43AM +0200, Rafael J. Wysocki wrote:
>> > @@ -417,6 +414,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>> >                 /* fall through */
>> >         case ACPI_BUTTON_NOTIFY_STATUS:
>> >                 input = button->input;
>> > +               acpi_pm_wakeup_event(&device->dev);
>>
>> Not really.
>>
>> There already is an acpi_pm_wakeup_event() call in the else branch below.
>>
>
> Ravi removes that other call below.

OK, I missed that, not sure why, sorry.

> The intent for this is to call
> acpi_pm_wakeup_event() regardless if the button->type is ACPI_BUTTON_TYPE_LID,
> in case that event is ACPI_BUTTON_NOTIFY_STATUS.

Well, the patch really drops the acpi_pm_wakeup_event() call from
acpi_lid_notify_state() and so it has to ensure that this function
will be called here for ACPI_BUTTON_NOTIFY_STATUS regardless of the
button->type value.

That's fine, but still the changelog doesn't make it clear why the
acpi_pm_wakeup_event() call in acpi_lid_notify_state() is not
necessary in general.

Thanks,
Rafael
