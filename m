Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751181AbeEUJSx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:18:53 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41910 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeEUJSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:18:49 -0400
X-Google-Smtp-Source: AB8JxZpjX3Y2S+R1Prz5rEiC5U75sVnf5v3mGl+yhyalfOeDEJUN5Eh319eFCa1nI9qQFzLVzAY+Pf8yzv27/wyn/cM=
MIME-Version: 1.0
In-Reply-To: <20180515163652.19980-2-jbrunet@baylibre.com>
References: <20180515163652.19980-1-jbrunet@baylibre.com> <20180515163652.19980-2-jbrunet@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 21 May 2018 11:18:28 +0200
Message-ID: <CAFBinCCdKgFOod=JimSnBVRvQ8Xmggpa0Uok3rgr3ixB7o+fnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: meson: mpll: add round closest support
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 6:36 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> Allow the mpll driver to round the requested rate up if
> CLK_MESON_MPLL_ROUND_CLOSEST is set and it provides a rate closer to the
> requested rate.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>


I gave it a quick spin on Odroid-C1 (which uses an RGMII Ethernet PHY
and the RGMII TX clock is supplied by MPLL2). the clock tree looks
fine and Ethernet is still working:
          mpll2_div                   1        1        0   249999701
        0 0
            mpll2                    1        1        0   249999701
       0 0
               c9410000.ethernet#m250_sel       1        1        0
249999701          0 0
                  c9410000.ethernet#m250_div       1        1        0
  249999701          0 0
                     c9410000.ethernet#fixed_div2       1        1
   0   124999850          0 0
                        c9410000.ethernet#rgmii_tx_en       1        1
       0   124999850          0 0
