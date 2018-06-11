Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OJTHDBJxHlsaewAAmS7hNA
	; Mon, 11 Jun 2018 12:54:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1AA2B607BB; Mon, 11 Jun 2018 12:54:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6JcxehU"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 96934601C3;
	Mon, 11 Jun 2018 12:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96934601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933070AbeFKMyj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 08:54:39 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36088 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeFKMyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:54:37 -0400
Received: by mail-vk0-f67.google.com with SMTP id o138-v6so12191279vkd.3;
        Mon, 11 Jun 2018 05:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O9e5n/BDpAy71zRHe5a4d4WeqzHnh6HPwulJQb2JCfA=;
        b=b6JcxehU7YqRXm8zRA+DjjeSbJ3IrXirByGNAWD7dbJG0wVqxq4n6BeeJ0+8Fw5rRd
         FN1Fld1Mf349AA6t2oO+aZYOd/JYXciwG6KEKPmbSqYpymCeIGkSvOy4p2ttsAC0eTRv
         FA/s3Fvzv8GxANEVj6ePOjtGSiWLmd4hn3vBc7ASLNhiVO3mgjQVo7Xkv7BtYwvCeTHQ
         s/xuiGQYHB54Z1Qz+0BaIoKFH/6RW0y2ONPtkVBdZUHI+3iT9FOZETIvEYQDmoFUJaqA
         Wdy29vCYDf/KJDTuPUOzCplOSdPXJDSrUjOx9sETvpxgK5AzvO7t8X6jLqT2RFvTaigc
         3VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O9e5n/BDpAy71zRHe5a4d4WeqzHnh6HPwulJQb2JCfA=;
        b=mp0I/HU0N5/KHWeNfCz6dahU680NRy5V98fXQAzgcQUwoICV6iG/UcocLmWQ6mx8Pa
         shKRNCoC9mT51BOO9WsKtQq78bJKe2k+37EDYWxIeYh3EhtjlIe2xRDErxYxWimeVGBZ
         zyIZQgOogDA8FjQfmpE0Qv2A1Wtkm/qMHBM5FQERaMJVZ8gPHuqWg5ekdlYZ80aaFzVh
         18pURk5v73lUw0l02u4OffTjnGiri0z3YbS26wi5SUSF0Qgz3BJdZiXJeumeSrdFckvI
         gG+mSvvn3ipMwSwPtNmKqnjfeTyAYYKPBEMooaPvWksmckBybB7OHyXTCu9BcreLEebQ
         14WA==
X-Gm-Message-State: APt69E1gBOAI/K5XeFC6scrxGx3Js4fMRwJPr42XHv17cBSR4HHR9ECx
        wo5H4ndAdpnqohNGTfaJg+WdrH1cXcWW1b9EvOE=
X-Google-Smtp-Source: ADUXVKI8t/578zMK5xfc/xST185m/Shwvzk68r7j6puotMtD2vv98i5teDLgY/TzObgqaNGXNjeU7sqHL05CvTwMLOQ=
X-Received: by 2002:a1f:860b:: with SMTP id i11-v6mr10139140vkd.15.1528721677186;
 Mon, 11 Jun 2018 05:54:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 05:54:36
 -0700 (PDT)
In-Reply-To: <20180611115240.32606-22-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com> <20180611115240.32606-22-ricardo.ribalda@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Jun 2018 15:54:36 +0300
Message-ID: <CAHp75VeeF4eNjyhhBxocRXboN3fRY=RjrT6QQ72=QJ-s8gvSfA@mail.gmail.com>
Subject: Re: [PATCH v2 21/24] rave-sp: Support for variants on modalias drivers
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 2:52 PM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Rave-sp behaves differently based on the device variant.


>         sp->variant = of_device_get_match_data(dev);
> +       if (!sp->variant) {
> +               id = serdev_match_id(rave_sp_serdev_id, serdev);

I think you may leave the ID table where it is in the code and use link.

> +               if (id)
> +                       sp->variant = (const struct rave_sp_variant *)
> +                                                       id->driver_data;
> +       }

Perhaps a helper like it's done for ACPI / OF cases?

[device_get_match_data() -> ]
  of_fwnode_device_get_match_data()
  acpi_fwnode_device_get_match_data()

-- 
With Best Regards,
Andy Shevchenko
