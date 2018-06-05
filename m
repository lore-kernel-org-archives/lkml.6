Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeFEVZJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751619AbeFEVZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:25:08 -0400
X-Google-Smtp-Source: ADUXVKLSOJAEahUiMhp7w2r/o/siGwFuHNh/G4kbj4uTL4obtMXIMHsqAe0XqWEIRl+ycQxeJVWTonV1EmLRL5zQR7I=
MIME-Version: 1.0
In-Reply-To: <1525229431-3087-11-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com> <1525229431-3087-11-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 5 Jun 2018 16:24:26 -0500
X-Gmail-Original-Message-ID: <CANk1AXTezwLOZOy3E=herSatYRm9mATdqO8WFcbEbRGpfK5mRQ@mail.gmail.com>
Message-ID: <CANk1AXTezwLOZOy3E=herSatYRm9mATdqO8WFcbEbRGpfK5mRQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/28] fpga: dfl: add dfl_fpga_port_ops support.
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 9:50 PM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

> In some cases, other DFL driver modules may need to access some port
> operations, e.g disable / enable port for partial reconfiguration in
> FME module. In order to avoid dependency between port and FME modules,
> this patch introduces the dfl_fpga_port_ops support in DFL framework.
> A global dfl_fpga_port_ops list is added in the DFL framework, and
> it allows other DFL modules to use these port operations registered
> to this list, even in virtualization case, the port platform device
> is turned into VF / guest VM and hidden in host, the registered
> port_ops is still usable. It resolves the dependency issues between
> modules, but once get port ops API returns a valid port ops, that
> means related port driver module has been module_get to prevent from
> unexpected unload, and put port ops API must be invoked after use.
>
> These APIs introduced by this patch is listed below:
>  * dfl_fpga_add_port_ops
>    add one port ops to the global list.
>
>  * dfl_fpga_del_port_ops
>    del one port ops from the global list.
>
>  * dfl_fpga_get_port_ops / dfl_fpga_put_port_ops
>    get/put the port ops before/after use.
>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
> ---
>  drivers/fpga/dfl.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl.h | 21 +++++++++++++++++
>  2 files changed, 88 insertions(+)
>
