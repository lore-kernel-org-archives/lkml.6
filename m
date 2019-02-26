Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4176BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B90520652
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+bUhDYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfBZQFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:05:03 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39279 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbfBZQFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:05:02 -0500
Received: by mail-ed1-f65.google.com with SMTP id p27so11186247edc.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 08:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5zHsaI3XiPwXpZVEWtyJ9od4TDwMvh1jABeSaD5X5g=;
        b=I+bUhDYiFQgfoXJTB1+2tH6vA8aDk4UzCu476z5rN43iLSFMw3DmIJ4Q4rI1vBIUSr
         Nmjhy7o2xMcJYlJ5KChvkJjXsj8nddcQK7VKaK2Mdl+sUx29TnEkKFdlpzc7bsjo1N1B
         yymvGqFGZmRlVtJhD34R6GQIICBzV41hejeQtgq677jbKbbh4EvrBIUvdwbC42UE8FpC
         7Y5rRU3bui1hIZ3YkfRwUiprGO4/rv65F9CwwkjfTzRXIrtJ0BiVOV/j2tfq868BO6JX
         afIgm/xSCRrtI4GSrKa2DcLUJn70f9qZBbaDP4D5ynUawzNnfglZAr1iwLa6d77H1bVG
         b0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5zHsaI3XiPwXpZVEWtyJ9od4TDwMvh1jABeSaD5X5g=;
        b=cbd7WPW43vt3fnnOlfIPi8rt+DVlFaV03Qeaw4DOv3PVvU55jqOzmO1fpVDsaCjWbW
         evfQS9ePY+NyAEM4Tr+QffHwkdCLVeXIyqqCaqCv1s7UDaBgt9exAbqvk1MRyPRPT5ZM
         oNArCjzhXQiGaPz6T7GO6S9tbdJRV5ub5sC3UJjL/cXu1pIhwXYRoAFhztSh0ZKBuwUm
         w2yBLfW40vg8DMBJcW9o5+8Pv6V3g9y0FiAkS5QYmixrvkBgVE9ghpznJJGEYILQTBG7
         B4sgm61aSymO/y94bwA2a8KNdccyswKYCyfWGxA0SbVrlEYo//zSzPjARqy7/2udxjzw
         vjsQ==
X-Gm-Message-State: AHQUAuaSP7qihd05sed8PaTxO1IlfY29Wv8kGbEXQU6pAA8Iu6LlRWOL
        16/WLO6wu6nk+gQwnNqT/JQroPTYchzYOR2qE9HejQ==
X-Google-Smtp-Source: AHgI3IaHlKoVg2GGequEsSiJiTMIW1DGYJYHTmTUehVQaSJSDdo3ozv6wvkx89vuJ5wB6LD97z7zMcQfN4tPOL/W3ww=
X-Received: by 2002:a50:be42:: with SMTP id b2mr6653277edi.78.1551197101238;
 Tue, 26 Feb 2019 08:05:01 -0800 (PST)
MIME-Version: 1.0
References: <333cc78c-7537-7898-d753-17352df893aa@gmail.com>
In-Reply-To: <333cc78c-7537-7898-d753-17352df893aa@gmail.com>
From:   Jouke Witteveen <j.witteveen@gmail.com>
Date:   Tue, 26 Feb 2019 17:04:50 +0100
Message-ID: <CAJ2ouawAZPNRE+DYPmD42UWZPCXba5BH-NtfZ_-RzLNa6F5OBQ@mail.gmail.com>
Subject: Re: thinkpad_acpi: Battery quirk for Thinkpad 11e (4th gen)
To:     Ken Milmore <ken.milmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 3:58 PM Ken Milmore <ken.milmore@gmail.com> wrote:
> Setting charge thresholds seems to basically work, but one thing worth
> mentioning is that charge_start_threshold and charge_stop_threshold
> appear to be tied together; AFAICT setting one also sets the other to
> the same value. The battery does seem to start charging whenever it
> falls below the common threshold, I have it set at 80% and it has kept
> the battery floating around 79%.

I observe the same behavior on my Thinkpad 13. Maybe there is a bug in
the driver, but it could also be a bug in the firmware.

> diff -uprN linux-source-4.19~/drivers/platform/x86/thinkpad_acpi.c linux-source-4.19/drivers/platform/x86/thinkpad_acpi.c
> --- linux-source-4.19~/drivers/platform/x86/thinkpad_acpi.c     2019-02-24 13:27:29.341331227 +0000
> +++ linux-source-4.19/drivers/platform/x86/thinkpad_acpi.c      2019-02-24 13:09:28.710982438 +0000
> @@ -9619,6 +9619,7 @@ static const struct tpacpi_quirk battery
>         TPACPI_Q_LNV3('R', '0', 'B', true), /* Thinkpad 11e gen 3 */
>         TPACPI_Q_LNV3('R', '0', 'C', true), /* Thinkpad 13 */
>         TPACPI_Q_LNV3('R', '0', 'J', true), /* Thinkpad 13 gen 2 */
> +       TPACPI_Q_LNV3('R', '0', 'K', true), /* Thinkpad 11e gen 4 */

Personally, I would add the line below the 11e gen 3.

>  };
>
>  static int __init tpacpi_battery_init(struct ibm_init_struct *ibm)
