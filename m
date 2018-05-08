Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933246AbeEHXwy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 19:52:54 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:53900 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933022AbeEHXww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 19:52:52 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w48NqOTB009719
X-Nifty-SrcIP: [209.85.217.171]
X-Google-Smtp-Source: AB8JxZrfMZ+3xvYEhiKz+YcKKMwkkVxKYpM8RVdq2sJbrBPUfBKYg1t7sb7SyGDOfAv9CIQ9mhWEnbzy4pIfcPmBpcA=
MIME-Version: 1.0
In-Reply-To: <20180508135150.27762-2-robh@kernel.org>
References: <20180508135150.27762-1-robh@kernel.org> <20180508135150.27762-2-robh@kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 9 May 2018 08:51:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQnFrZNJetQRrB_KuV_=oRneSFXj-KJ=SK6ZTZWjdn1tg@mail.gmail.com>
Message-ID: <CAK7LNAQnFrZNJetQRrB_KuV_=oRneSFXj-KJ=SK6ZTZWjdn1tg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: disable new dtc graph and unit-address warnings
To: Rob Herring <robh@kernel.org>
Cc: DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

2018-05-08 22:51 GMT+09:00 Rob Herring <robh@kernel.org>:
> dtc gained some new warnings for OF graphs and unique unit addresses,
> but they are currently much too noisy. So turn off
> 'graph_child_address', 'graph_port', and 'unique_unit_address' warnings
> by default. They can be enabled by building dtbs with W=1.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> I plan to take this via DT tree as it is dependent on a dtc update in
> patch 1.


Yes, please do so.

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>





>  scripts/Makefile.lib | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 5af34a2b0cd9..1bb594fcfe12 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -251,6 +251,9 @@ DTC_FLAGS += -Wno-unit_address_vs_reg \
>         -Wno-unit_address_format \
>         -Wno-avoid_unnecessary_addr_size \
>         -Wno-alias_paths \
> +       -Wno-graph_child_address \
> +       -Wno-graph_port \
> +       -Wno-unique_unit_address \
>         -Wno-pci_device_reg
>  endif
>
> --
> 2.17.0
>



-- 
Best Regards
Masahiro Yamada
