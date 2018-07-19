Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3BEECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5BC2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFEFmUeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5BC2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbeGSDsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:48:03 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:40108 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbeGSDsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:48:03 -0400
Received: by mail-yw0-f196.google.com with SMTP id p129-v6so2539599ywg.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 20:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sUKGQen9X2qDCQqurey0k78Kg1mcYXEerBozxdRO284=;
        b=FFEFmUeQjSpptUKPXsZqZSqmg1bPs5N5m+4AIK723czF9lozH5GBTa8ZjOpzzJcFbB
         rUrY0qH50VSF6tHr7fbe6dq4c/zpeRrZ0b9L9B2jbXXVj/XRGAP53/cYPepLnU48w5Vw
         PtQd//ZH7yOcJFAV11bqLWeIgm/jVOWKiqFL1BKfP4YWG0y5E6posQDXza7kf4QZ5Sxh
         704b2+yWJ0Dmw2rVJOUfJRdS1CXep+VwPLPR5iQqy/pVFkhf/3MHoqnTTLsI4KabsILc
         7N0UNrup4+YYW1nEapriPOlJ9BbLAouvSd2QisEJst0xubBLjXoFkUEHkKKkG/r3Sj9q
         4X2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sUKGQen9X2qDCQqurey0k78Kg1mcYXEerBozxdRO284=;
        b=uf6ubXoT7H6luoNc5xrxfRROfM4m4bCh9A7y+FIuPjyWzz9iZIhh7frtROI1p3drIo
         mLGwH5xRJfbCij1FtvkCLKd05RNwp3fLQUD69FGpTueX9f1KiYCxeavEPXYtgqCeZphG
         0tIY0mj1iCvo4LMKPRQU9/4D392a6eJFqDH83DvMJCgaF0avefdjHlNlylXpfD8m4vhQ
         1t+yuaYRWF82Si/hkB1egDQBqoBf/aKXbJN/8Tf121HBSm91AwZkImPouDs+Zidocp8x
         HBR8qjTx3GuxR4FoX/bUWxgjE1xHEJ3b7jDC6HBgh1b5VGbgphiVm/JocYP75hxha8hV
         lSSw==
X-Gm-Message-State: AOUpUlH98Oq7BN3VZQOiZKwlyHQJVKcpQdOurlPlPJS0e4ZV2kkCcj/i
        Ho1cnwhSZjOvsLmygHvIoevohJFQPBIiHqSa30k=
X-Google-Smtp-Source: AAOMgpcTKbZ3m9dhp7wH8ruWwKlitBXJHxOGaI0KQ+/lckXheKaHAVe3bLmy/5SVBqurTZHji/DnwrySSuMvSygh5Yc=
X-Received: by 2002:a81:b662:: with SMTP id h34-v6mr4249727ywk.262.1531969629309;
 Wed, 18 Jul 2018 20:07:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 20:07:08
 -0700 (PDT)
In-Reply-To: <201807190922.hZdtQ9mP%fengguang.wu@intel.com>
References: <20180715182545.187942-1-toddpoynor@gmail.com> <201807190922.hZdtQ9mP%fengguang.wu@intel.com>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Wed, 18 Jul 2018 20:07:08 -0700
Message-ID: <CAO3upoZZmgxjwuz3bDg-TBVvoZPn9ws6gDuJjCjuyOCY8AF-OQ@mail.gmail.com>
Subject: Re: [PATCH resend] staging: gasket: remove X86 Kconfig restriction
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhongze Hu <frankhu@chromium.org>,
        Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        Todd Poynor <toddpoynor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 6:18 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Todd,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on staging/staging-testing]
> [also build test ERROR on next-20180718]
> [cannot apply to v4.18-rc5]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Todd-Poynor/staging-gasket-remove-X86-Kconfig-restriction/20180716-031056
> config: xtensa-allmodconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=xtensa
>
> All errors (new ones prefixed by >>):
>
>    In file included from drivers/staging/gasket/gasket_page_table.h:19,
>                     from drivers/staging/gasket/gasket_page_table.c:34:
>    drivers/staging/gasket/gasket_core.h: In function 'gasket_dev_read_64':
>>> drivers/staging/gasket/gasket_core.h:651:9: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]

Will respin this patch to explicitly list X86_64 and ARM64 as the only
architectures to build for now, and fixup some of these other issues
soon.



>      return readq(&gasket_dev->bar_data[bar].virt_base[location]);
>             ^~~~~
>             readl
>    drivers/staging/gasket/gasket_core.h: In function 'gasket_dev_write_64':
>>> drivers/staging/gasket/gasket_core.h:657:2: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
>      writeq(value, &dev->bar_data[bar].virt_base[location]);
>      ^~~~~~
>      writel
>    drivers/staging/gasket/gasket_page_table.c: In function 'gasket_is_extended_dev_addr_bad':
>    drivers/staging/gasket/gasket_page_table.c:1373:11: warning: right shift count >= width of type [-Wshift-count-overflow]
>      if (addr >> (GASKET_EXTENDED_LVL0_WIDTH + GASKET_EXTENDED_LVL0_SHIFT)) {
>               ^~
>    drivers/staging/gasket/gasket_page_table.c: In function 'gasket_alloc_coherent_memory':
>    drivers/staging/gasket/gasket_page_table.c:1679:4: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>        (u64)mem + j * PAGE_SIZE;
>        ^
>    cc1: some warnings being treated as errors
> --
>    In file included from drivers/staging/gasket/gasket_sysfs.h:21,
>                     from drivers/staging/gasket/gasket_sysfs.c:3:
>    drivers/staging/gasket/gasket_core.h: In function 'gasket_dev_read_64':
>>> drivers/staging/gasket/gasket_core.h:651:9: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
>      return readq(&gasket_dev->bar_data[bar].virt_base[location]);
>             ^~~~~
>             readl
>    drivers/staging/gasket/gasket_core.h: In function 'gasket_dev_write_64':
>>> drivers/staging/gasket/gasket_core.h:657:2: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
>      writeq(value, &dev->bar_data[bar].virt_base[location]);
>      ^~~~~~
>      writel
>    cc1: some warnings being treated as errors
> --
>    In file included from drivers/staging/gasket/gasket_ioctl.h:6,
>                     from drivers/staging/gasket/gasket_ioctl.c:4:
>    drivers/staging/gasket/gasket_core.h: In function 'gasket_dev_read_64':
>>> drivers/staging/gasket/gasket_core.h:651:9: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
>      return readq(&gasket_dev->bar_data[bar].virt_base[location]);
>             ^~~~~
>             readl
>    drivers/staging/gasket/gasket_core.h: In function 'gasket_dev_write_64':
>>> drivers/staging/gasket/gasket_core.h:657:2: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
>      writeq(value, &dev->bar_data[bar].virt_base[location]);
>      ^~~~~~
>      writel
>    drivers/staging/gasket/gasket_ioctl.c: In function 'gasket_config_coherent_allocator':
>>> drivers/staging/gasket/gasket_ioctl.c:434:27: error: passing argument 3 of 'gasket_alloc_coherent_memory' from incompatible pointer type [-Werror=incompatible-pointer-types]
>        gasket_dev, ibuf.size, &ibuf.dma_address,
>                               ^~~~~~~~~~~~~~~~~
>    In file included from drivers/staging/gasket/gasket_ioctl.c:9:
>    drivers/staging/gasket/gasket_page_table.h:227:18: note: expected 'dma_addr_t *' {aka 'unsigned int *'} but argument is of type 'u64 *' {aka 'long long unsigned int *'}
>          dma_addr_t *dma_address, uint64_t index);
>          ~~~~~~~~~~~~^~~~~~~~~~~
>    cc1: some warnings being treated as errors
>
> vim +651 drivers/staging/gasket/gasket_core.h
>
> 9a69f508 Simon Que 2018-06-29  620
> 9a69f508 Simon Que 2018-06-29  621  /*
> 9a69f508 Simon Que 2018-06-29  622   * Memory management functions. These will likely be spun off into their own
> 9a69f508 Simon Que 2018-06-29  623   * file in the future.
> 9a69f508 Simon Que 2018-06-29  624   */
> 9a69f508 Simon Que 2018-06-29  625
> 9a69f508 Simon Que 2018-06-29  626  /* Unmaps the specified mappable region from a VMA. */
> 9a69f508 Simon Que 2018-06-29  627  int gasket_mm_unmap_region(
> 9a69f508 Simon Que 2018-06-29  628      const struct gasket_dev *gasket_dev, struct vm_area_struct *vma,
> 9a69f508 Simon Que 2018-06-29  629      const struct gasket_mappable_region *map_region);
> 9a69f508 Simon Que 2018-06-29  630
> 9a69f508 Simon Que 2018-06-29  631  /*
> 9a69f508 Simon Que 2018-06-29  632   * Get the ioctl permissions callback.
> 9a69f508 Simon Que 2018-06-29  633   * @gasket_dev: Gasket device structure.
> 9a69f508 Simon Que 2018-06-29  634   */
> 9a69f508 Simon Que 2018-06-29  635  gasket_ioctl_permissions_cb_t gasket_get_ioctl_permissions_cb(
> 9a69f508 Simon Que 2018-06-29  636      struct gasket_dev *gasket_dev);
> 9a69f508 Simon Que 2018-06-29  637
> 9a69f508 Simon Que 2018-06-29  638  /**
> 9a69f508 Simon Que 2018-06-29  639   * Lookup a name by number in a num_name table.
> 9a69f508 Simon Que 2018-06-29  640   * @num: Number to lookup.
> 9a69f508 Simon Que 2018-06-29  641   * @table: Array of num_name structures, the table for the lookup.
> 9a69f508 Simon Que 2018-06-29  642   *
> 9a69f508 Simon Que 2018-06-29  643   */
> 9a69f508 Simon Que 2018-06-29  644  const char *gasket_num_name_lookup(
> 9a69f508 Simon Que 2018-06-29  645      uint num, const struct gasket_num_name *table);
> 9a69f508 Simon Que 2018-06-29  646
> 9a69f508 Simon Que 2018-06-29  647  /* Handy inlines */
> 9a69f508 Simon Que 2018-06-29  648  static inline ulong gasket_dev_read_64(
> 9a69f508 Simon Que 2018-06-29  649      struct gasket_dev *gasket_dev, int bar, ulong location)
> 9a69f508 Simon Que 2018-06-29  650  {
> 9a69f508 Simon Que 2018-06-29 @651      return readq(&gasket_dev->bar_data[bar].virt_base[location]);
> 9a69f508 Simon Que 2018-06-29  652  }
> 9a69f508 Simon Que 2018-06-29  653
> 9a69f508 Simon Que 2018-06-29  654  static inline void gasket_dev_write_64(
> 9a69f508 Simon Que 2018-06-29  655      struct gasket_dev *dev, u64 value, int bar, ulong location)
> 9a69f508 Simon Que 2018-06-29  656  {
> 9a69f508 Simon Que 2018-06-29 @657      writeq(value, &dev->bar_data[bar].virt_base[location]);
> 9a69f508 Simon Que 2018-06-29  658  }
> 9a69f508 Simon Que 2018-06-29  659
>
> :::::: The code at line 651 was first introduced by commit
> :::::: 9a69f5087ccc20bb411025decab455836df04168 drivers/staging: Gasket driver framework + Apex driver
>
> :::::: TO: Simon Que <sque@chromium.org>
> :::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Todd
