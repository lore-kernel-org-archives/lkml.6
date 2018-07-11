Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8542CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E687208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E687208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbeGKC5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:57:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43967 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732425AbeGKC5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:57:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id u11-v6so17987741eds.10;
        Tue, 10 Jul 2018 19:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YRapvYT33hxn/tCMAtcka8iiAgx/ZUvZYFF3RLeTaEI=;
        b=a0M+XHWW5nJ31evuVXXqWCRybdwuKHzADzYGFILywveKyh2N3UlfET7i/gXDgrMVxl
         HoEAtLfdnxUF3Xi41pL/eT6ZVmrFn+13i/iELeoHUyu0slcQXn8m4Vy8eFCtlq1aQL8B
         h6pffO7PXge9eCQhIBQqHv4j5tvdJ5mdU1AsKVZQkruaFWjbsoVJso+mXED7tDaeWg/P
         NEmnGce8k2CnaIKqNO9L5gAVWE6MXbf7pSBVvIHfFwozbRYBWq+xK4LADaFoyOh+dqAb
         ATbqSsuCkTqDei10eHo3M8lQpaYae7HJvaw35/drmT1OU5PIW5gD1T707kbBvDeb+Ca3
         ylYA==
X-Gm-Message-State: APt69E0z76wGt27N02tG3KsmOfI1TUnF94jvptIebgz3OFgpFdt+Wye7
        d1n8xpp8pdpfn1NKXqs/zl6dfX+g
X-Google-Smtp-Source: AAOMgpcA+ySHW22z+MBcu2fZdASElfJ9EV2uO9OZwSwYx3PdeS032C6SxXOrd1wKRsrMq0I6v3dk8g==
X-Received: by 2002:a50:89aa:: with SMTP id g39-v6mr27666889edg.25.1531277707894;
        Tue, 10 Jul 2018 19:55:07 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id j7-v6sm9250206edh.76.2018.07.10.19.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 19:55:07 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id q10-v6so16524806wrd.4;
        Tue, 10 Jul 2018 19:55:07 -0700 (PDT)
X-Received: by 2002:adf:b202:: with SMTP id u2-v6mr18814001wra.19.1531277707041;
 Tue, 10 Jul 2018 19:55:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 19:54:46
 -0700 (PDT)
In-Reply-To: <201807110632.6k3QA7Vs%fengguang.wu@intel.com>
References: <20180710203511.18454-5-jernej.skrabec@siol.net> <201807110632.6k3QA7Vs%fengguang.wu@intel.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 11 Jul 2018 10:54:46 +0800
X-Gmail-Original-Message-ID: <CAGb2v64h4PvgGkn_q7WW5k0mEjv9_bQ40zOK6KK+S3xdpJCzgg@mail.gmail.com>
Message-ID: <CAGb2v64h4PvgGkn_q7WW5k0mEjv9_bQ40zOK6KK+S3xdpJCzgg@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] drm/sun4i: tcon-top: Cleanup clock handling
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     kbuild-all@01.org, Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 7:20 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Jernej,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on next-20180710]
> [cannot apply to sunxi/sunxi/for-next drm/drm-next robh/for-next v4.18-rc4 v4.18-rc3 v4.18-rc2 v4.18-rc4]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Jernej-Skrabec/Allwinner-R40-HDMI-refactoring/20180711-043932
> config: arm64-allyesconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm64
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/kernel.h:10:0,
>                     from include/linux/list.h:9,
>                     from include/linux/agp_backend.h:33,
>                     from include/drm/drmP.h:35,
>                     from drivers/gpu//drm/sun4i/sun8i_tcon_top.c:4:
>    drivers/gpu//drm/sun4i/sun8i_tcon_top.c: In function 'sun8i_tcon_top_register_gate':
>    include/linux/err.h:22:49: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
>                                                     ^
>    include/linux/compiler.h:77:42: note: in definition of macro 'unlikely'
>     # define unlikely(x) __builtin_expect(!!(x), 0)
>                                              ^
>>> drivers/gpu//drm/sun4i/sun8i_tcon_top.c:56:6: note: in expansion of macro 'IS_ERR_VALUE'
>      if (IS_ERR_VALUE(index))
>          ^~~~~~~~~~~~
>
> vim +/IS_ERR_VALUE +56 drivers/gpu//drm/sun4i/sun8i_tcon_top.c
>
>      3
>    > 4  #include <drm/drmP.h>
>      5
>      6  #include <dt-bindings/clock/sun8i-tcon-top.h>
>      7
>      8  #include <linux/bitfield.h>
>      9  #include <linux/component.h>
>     10  #include <linux/device.h>
>     11  #include <linux/module.h>
>     12  #include <linux/of_graph.h>
>     13  #include <linux/platform_device.h>
>     14
>     15  #include "sun8i_tcon_top.h"
>     16
>     17  static int sun8i_tcon_top_get_connected_ep_id(struct device_node *node,
>     18                                                int port_id)
>     19  {
>     20          struct device_node *ep, *remote, *port;
>     21          struct of_endpoint endpoint;
>     22
>     23          port = of_graph_get_port_by_id(node, port_id);
>     24          if (!port)
>     25                  return -ENOENT;
>     26
>     27          for_each_available_child_of_node(port, ep) {
>     28                  remote = of_graph_get_remote_port_parent(ep);
>     29                  if (!remote)
>     30                          continue;
>     31
>     32                  if (of_device_is_available(remote)) {
>     33                          of_graph_parse_endpoint(ep, &endpoint);
>     34
>     35                          of_node_put(remote);
>     36
>     37                          return endpoint.id;
>     38                  }
>     39
>     40                  of_node_put(remote);
>     41          }
>     42
>     43          return -ENOENT;
>     44  }
>     45
>     46  static struct clk_hw *sun8i_tcon_top_register_gate(struct device *dev,
>     47                                                     const char *parent,
>     48                                                     void __iomem *regs,
>     49                                                     spinlock_t *lock,
>     50                                                     u8 bit, int name_index)
>     51  {
>     52          const char *clk_name, *parent_name;
>     53          int ret, index;
>     54
>     55          index = of_property_match_string(dev->of_node, "clock-names", parent);
>   > 56          if (IS_ERR_VALUE(index))

Yeah. This is incorrect usage. IS_ERR_VALUE should be used on pointers.
Checking for a negative value here should suffice.

ChenYu

>     57                  return ERR_PTR(index);
>     58
>     59          parent_name = of_clk_get_parent_name(dev->of_node, index);
>     60
>     61          ret = of_property_read_string_index(dev->of_node,
>     62                                              "clock-output-names", name_index,
>     63                                              &clk_name);
>     64          if (ret)
>     65                  return ERR_PTR(ret);
>     66
>     67          return clk_hw_register_gate(dev, clk_name, parent_name,
>     68                                      CLK_SET_RATE_PARENT,
>     69                                      regs + TCON_TOP_GATE_SRC_REG,
>     70                                      bit, 0, lock);
>     71  };
>     72
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
