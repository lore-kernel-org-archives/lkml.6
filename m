Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeDCQMC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 12:12:02 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:45941 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbeDCQMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 12:12:01 -0400
X-Google-Smtp-Source: AIpwx49USgphGJe0tmAoMKyngNuG2K3tmV2EzvKBR+1fMxRq2jzan8W1DwP4h6WueTri4HFIVzidtgQeICDr0uaO0B8=
MIME-Version: 1.0
References: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
 <20180323073814.5802-12-jeffy.chen@rock-chips.com> <CAGS+omDUve9DTMJY8FdWBBxQgCOACLYLsRuzmQzd3Fh7TeekDw@mail.gmail.com>
 <5AB8A7F0.1090305@rock-chips.com>
In-Reply-To: <5AB8A7F0.1090305@rock-chips.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Tue, 03 Apr 2018 16:11:49 +0000
Message-ID: <CAGS+omCN7cXY0APvFuL_wmZeXihivu4hF0+ZfLFffvdZyK9f6A@mail.gmail.com>
Subject: Re: [PATCH v8 11/14] iommu/rockchip: Use OF_IOMMU to attach devices automatically
To: Jeffy <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, Ricky Liang <jcliang@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>, xxm <xxm@rock-chips.com>,
        Tomasz Figa <tfiga@chromium.org>, Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        open@263.net, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffy,

Sorry for delayed response.

On Mon, Mar 26, 2018 at 1:58 AM JeffyChen <jeffy.chen@rock-chips.com> wrote:

> Hi Daniel,

> Thanks for your reply.

> On 03/26/2018 02:31 PM, Daniel Kurtz wrote:
> >> >+struct rk_iommudata {
> >> >+       struct rk_iommu *iommu;
> >> >+};
> > Why do we need this struct?  Can't we just assign a pointer to struct
> > rk_iommu directly to dev->archdata.iommu?
> >
> hmmm, i was trying to add more device related data in patch[13]:

>    struct rk_iommudata {
> +       struct device_link *link; /* runtime PM link from IOMMU to master
*/
>          struct rk_iommu *iommu;
>    };
> >

Can't you just add link to rk_iommu directly?
