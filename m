Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932613AbeBVNcP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:32:15 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:41054 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932395AbeBVNcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:32:12 -0500
X-Google-Smtp-Source: AH8x224wwWcy4UXztaCbttkElCotw6aApJSfMXWn8lWKPq4RSCA2srLbXdFShAiGOmXfnpVOP+BJ/HOM5ilLSFzDAZQ=
MIME-Version: 1.0
In-Reply-To: <1519299294.7447.4.camel@pengutronix.de>
References: <20180219165837.28913-1-brgl@bgdev.pl> <72cd2af4-ed6b-8c1b-2488-b999976b894a@lechnology.com>
 <1519123185.3470.5.camel@pengutronix.de> <8ef4b901-f38d-d885-e7bc-657202a2e248@lechnology.com>
 <1519299294.7447.4.camel@pengutronix.de>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 22 Feb 2018 14:32:11 +0100
Message-ID: <CAMpxmJU3eA16cihpy4wmYyRvzOBx94Lfk6FsSdgsCuQPmHkM5Q@mail.gmail.com>
Subject: Re: [PATCH v4] reset: add support for non-DT systems
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        LKML <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-22 12:34 GMT+01:00 Philipp Zabel <p.zabel@pengutronix.de>:
> On Tue, 2018-02-20 at 10:40 -0600, David Lechner wrote:
> [...]
>> > In your case the platform code that adds the lookup may be identical to
>> > the code that registers the struct reset_controller_dev, but that
>> > doesn't have to be the case. I'm not sure how that is supposed to work
>> > for the phy framework (I see no platform code adding phy lookups, only
>> > drivers).
>> >
>> In our use case, we would be adding the lookup in the driver rather than
>> in the platform code, which is why I am suggesting doing it like the phy
>> framework.
>
> Shouldn't it be the job of the platform code to describe the connections
> between reset controller and peripheral module reset
> inputs?
>
> regards
> Philipp

Am I right to understand that it's ok for drivers to know about the
available reset lines on the platform, it's just the associated
between these lines and concerned devices that should be done in
platform code?

Bart
