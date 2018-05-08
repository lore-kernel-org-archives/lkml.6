Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754976AbeEHNQ5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:16:57 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52383 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754201AbeEHNQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:16:56 -0400
Date: Tue, 8 May 2018 15:16:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org, andrew.smirnov@gmail.com
Subject: Re: [PATCH RFC] drivers: nvmem: Export nvmem_add_cells()
Message-ID: <20180508131654.GD2888@lunn.ch>
References: <1525547507-1428-1-git-send-email-andrew@lunn.ch>
 <e36b58db-d8e3-cd89-e7d3-adca01991732@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e36b58db-d8e3-cd89-e7d3-adca01991732@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 09:35:55AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 05/05/18 20:11, Andrew Lunn wrote:
> >Not all platforms use device tree. It is useful to be able to add
> >cells to a NVMEM device from code. Export nvmem_add_cells() so making
> >this possible.
> >
> >This required changing the parameters a bit, so that just the cells
> >and the number of cells are passed, not the whole nvmem config
> >structure.
> >
> >Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> >---
> >
> >This is an RFC.
> >
> >I have an intel platform with an AT24 EEPROM. I want to make use of
> >nvmem, but don't have device tree to be able to specify cells. I have
> >an x86 platform driver which does:
> >
> >struct nvmem_cell_info nameplate_cells[] = {
> >        {
> >                .name = "checksum",
> >                .offset = 2,
> >                .bytes = 1,
> >        },
> >        {
> >                .name = "part_number",
> >                .offset = 11,
> >                .bytes = 11,
> >        },
> >};
> >
> >        err = nvmem_add_cells(nvmem, nameplate_cells,
> >                              ARRAY_SIZE(nameplate_cells));
> >        if (err) {
> >                dev_err(dev, "Error adding cells to nameplate nvmem device\n");
> >                return;
> >        }
> >
> >        cell = nvmem_cell_get(NULL, "checksum");
> >
> >
> >drivers/nvmem/core.c           | 15 ++++++++-------
> >  include/linux/nvmem-provider.h | 11 +++++++++++
> >  2 files changed, 19 insertions(+), 7 deletions(-)
> >
> 
> 
> Thanks Andrew for the patch,
> 
> Overall the patch looks good to me,
> I would like to see some kernel doc for this new exported function

Hi Srini

O.K. I can do that.

Will you accept the patch without a user of this API? The driver which
needs it is not yet up to mainline quality. I doubt it will be ready
for this merge window. But having this patch applied soon will remove
a dependency when i do submit it.

Thanks
	Andrew
