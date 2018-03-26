Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeCZAL2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 20:11:28 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:36981 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeCZAL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 20:11:26 -0400
X-Google-Smtp-Source: AG47ELvyAcjoJm4aR+531CrNxnW67JuomWnR+XoMMVeCMj1vUDrGB7LRnlEe/BFMG6AvlhUzsYUTqWbYl1XpDBQf7LQ=
MIME-Version: 1.0
In-Reply-To: <20180325182803.30036-3-avarab@gmail.com>
References: <20180325182803.30036-1-avarab@gmail.com> <20180325182803.30036-3-avarab@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.us>
Date: Sun, 25 Mar 2018 20:11:24 -0400
X-Google-Sender-Auth: l9iQk9vDwO21Uy8Os4ZJ6lUjogQ
Message-ID: <CAPig+cQ6EK=Q00panZECVvWt3pJyS9acC1n4mgogMmk5J4hO8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] send-email: supply a --send-delay=1 by default
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2Q0BqcM030082

On Sun, Mar 25, 2018 at 2:28 PM, Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> The earlier change to add this option described the problem this
> option is trying to solve.
>
> This turns it on by default with a value of 1 second, which'll
> hopefully solve it, and if not user reports as well as the
> X-Mailer-Send-Delay header should help debug it.
> [...]
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -3070,7 +3070,18 @@ sendemail.smtpReloginDelay::
>  sendemail.smtpSendDelay::
>         Seconds wait in between message sending before sending another
> -       message. Set it to 0 to impose no extra delay, defaults to 0.
> +       message. Set it to 0 to impose no extra delay, defaults to 1
> +       to wait 1 second.
> ++
> +The reason for imposing a default delay is because certain popular
> +E-Mail clients such as Google's GMail completely ignore the "Date"
> +header, which format-patch is careful to set such that the patches
> +will be displayed in order, and instead sort by the time the E-mail
> +was received.

A minor point: Are you sure that it's git-format-patch that's being
careful about arranging Date: to display in the desired order, and not
git-send-email? Looking at old patches I still have hanging around
which were created with git-format-patch, I see the Date: headers are
wildly out of order, presumably because the date is taken from
Author-Date: and the patches were heavily rebased.
