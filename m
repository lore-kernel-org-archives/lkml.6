Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeBRU7a (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 15:59:30 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:52120 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbeBRU73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 15:59:29 -0500
X-Google-Smtp-Source: AH8x227uaEWGMTqMMVXON9wKo5+EcsZgKE9GrE+V/lohPiObiHK3APniAVTNlFvbCYWaAgOM8YLpKvY3TeZWnGDFeNk=
MIME-Version: 1.0
In-Reply-To: <20180212145846.19380-18-jbrunet@baylibre.com>
References: <20180212145846.19380-1-jbrunet@baylibre.com> <20180212145846.19380-18-jbrunet@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 18 Feb 2018 21:59:07 +0100
Message-ID: <CAFBinCBrSKi=mmLuZuwqXJdfZu+RQsCDgDABPHOWAbvm7piS=w@mail.gmail.com>
Subject: Re: [PATCH v2 17/19] clk: meson: rework meson8b cpu clock
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 3:58 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> Instead of migrating meson cpu_clk to clk_regmap, like the other meson
> clock drivers, we take advantage of the massive rework to get rid of it
> completely, and solve (the first part) of the related FIXME notice.
>
> As pointed out in the code comments, the cpu_clk should be modeled with
> dividers and muxes it is made of, instead of one big composite clock.
>
> The cpu_clk was not working correctly to enable dvfs on meson8b. It hangs
> quite often when changing the cpu clock rate. This new implementation,
> based on simple elements improves the situation but the platform will
> still hang from time to time. This is not acceptable so, until we can
> make the mechanism around the cpu clock stable, the cpu clock subtree
> has been put in read-only mode, preventing any change of the cpu clock
>
> The notifier and read-write operation will be added back when we have a
> solution to the problem.
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you Jerome!
