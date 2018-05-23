Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932289AbeEWJs0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:48:26 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34723 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932155AbeEWJsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:48:24 -0400
X-Google-Smtp-Source: AB8JxZqPUUGYCxMCPbcthppG/H5yZt9hNgOF9GmaH+Ew+kQQTvk9xHUwsmzExDpw80couG2AyrsIcwrFsI5GGsb0Z/0=
MIME-Version: 1.0
In-Reply-To: <no_message-id@ru>
References: <no_message-id@ru>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 May 2018 11:48:23 +0200
Message-ID: <CACRpkdZtE6tD2aM49DNovfEz5DYEjfmh0_=WxaAUY6jLz_tigg@mail.gmail.com>
Subject: Re: [PATCH] gpio: pca953x: Clear irq trigger type on irq shutdown
To: Grigoryev Denis <grigoryev@fastwel.ru>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 4, 2018 at 6:53 PM, Grigoryev Denis <grigoryev@fastwel.ru> wrote:

> The driver stores the result of irq_set_type() in the internal variables
> irq_trig_raise and irq_trig_fall, which later are used to determine
> the GPIOs that must be re-configured as input. These variables retain their
> value between gpiolib's  export / unexport, resulting in an incorrect
> state in some cases. The corresponding bits in the variables
> irq_trig_raise and irq_trig_fall should be cleared in irq_shutdown().
>
> Signed-off-by: Denis Grigoryev <grigoryev@fastwel.ru>

Patch applied with Andy's ACK.

If there are issues we can just revert it.

Yours,
Linus Walleij
