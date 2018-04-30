Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754721AbeD3SXI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 14:23:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754614AbeD3SXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 14:23:07 -0400
Subject: Re: drivers/gpu/drm/bridge/sil-sii8620.c:2405: undefined reference to
 `extcon_unregister_notifier'
To: kbuild test robot <lkp@intel.com>,
        Maciej Purski <m.purski@samsung.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
References: <201804291100.alIrExlq%fengguang.wu@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0f8f6643-9c8a-6427-4b8f-e2d1a3a09531@infradead.org>
Date: Mon, 30 Apr 2018 11:23:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <201804291100.alIrExlq%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28/2018 08:15 PM, kbuild test robot wrote:
> Hi Maciej,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   19b9ad67310ed2f685062a00aec602bec33835f0
> commit: 688838442147d9dd94c2ef7c2c31a35cf150c5fa drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL
> date:   7 weeks ago
> config: x86_64-randconfig-s4-04290805 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         git checkout 688838442147d9dd94c2ef7c2c31a35cf150c5fa
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/gpu/drm/bridge/sil-sii8620.o: In function `sii8620_remove':
>>> drivers/gpu/drm/bridge/sil-sii8620.c:2405: undefined reference to `extcon_unregister_notifier'
>    drivers/gpu/drm/bridge/sil-sii8620.o: In function `sii8620_extcon_init':
>>> drivers/gpu/drm/bridge/sil-sii8620.c:2229: undefined reference to `extcon_find_edev_by_node'
>>> drivers/gpu/drm/bridge/sil-sii8620.c:2241: undefined reference to `extcon_register_notifier'
>    drivers/gpu/drm/bridge/sil-sii8620.o: In function `sii8620_extcon_work':
>>> drivers/gpu/drm/bridge/sil-sii8620.c:2189: undefined reference to `extcon_get_state'

The correct fix for this IMO is:
config DRM_SIL_SII8620
...
	depends on EXTCON || !EXTCON

but doing that causes kconfig-recursive-dependency-hell-messy-spaghetti.
OTOH, doing:
	select EXTCON
does not cause any kconfig recursive dependency issues and solves the build
errors.


-- 
~Randy
