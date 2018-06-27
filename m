Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E05C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 02:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1532E2671D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 02:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDek5oO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1532E2671D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeF0CfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 22:35:07 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54499 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbeF0CfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 22:35:06 -0400
Received: by mail-it0-f65.google.com with SMTP id 76-v6so5291033itx.4;
        Tue, 26 Jun 2018 19:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3uKliBHErrsBG5Cv2cUOdXMk5CrlyTJvDzd/UekbiCQ=;
        b=LDek5oO4/AXKSH80rw6GG46WMxxscPVZe0RXTiqE43Ea01BG4Z36ARzw4WCGgBjKr3
         7oEB05YuyoTPCGPx2Z4NDQjR6q1PhSTm35WDzDoDp/65dJoqTZn7rgCjQUNWJDDO+ddH
         U2pghoeHo9F0I2rTFjPSRSLDjqY1MApsgI0vpJCkcQnGIZaEa4jwwzz+u4JKsK5kDytf
         8Y3YoYQsnHT6BEsGjoJygTSQwsZWu7Wzm5iq3kXO5GWvbEVemf1NenwUiW1vDg5U04Nh
         RoR9ndCC+3ifVK/ddpY2uC5GsvKzrpJXlF1XujsxZkwZdjwVtRiL77Mr2haOfmvtD3j0
         nyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3uKliBHErrsBG5Cv2cUOdXMk5CrlyTJvDzd/UekbiCQ=;
        b=unlzGjStm3qgi92sMfHUhaCKz5RjCm4COldiFg3jAmGBY649BnBz2rT56PTeWiMzoD
         XYplm0b3Ega0Z+SmmVwc/1+J2W/QYL9n1lrPSlkWQUdYH4pmwlJxTYqR99/essd5o0JJ
         OkZH83QCdxdxdoJeTMANb1ZPvH3M8j6yiu4aXMTyNfW81EpWi6Afp36UaTxskeTLLAq4
         /8h2SbkOaEGlfylp2x6swF5mr+1x/O2FnnuhOZeRmrgLAwciRYZKcSaZad3Ikw8uROEv
         UKNWXlsleXw7bmL3vucx7LzksJJxv4aliMaaqCIaYrzVAimigXTXyTvCvRV+3LwuUcOC
         sxKg==
X-Gm-Message-State: APt69E18VNwKempWELeCgqMW+j/dpwESAyuOeTYwzKDUi+r4R5KG3xe4
        Hqlv+zTbYfbhPQQwZ7Ws5N+7aTYvXxXvFHIDlQ==
X-Google-Smtp-Source: AAOMgpfPNr0UTINWs8Wy/A7SqUMlGS99Zlj4l45QpeaA153aOJmXe0tIm6tRHIgfwlPScxWU189pBtSd7y5XU9Sg9pg=
X-Received: by 2002:a24:de84:: with SMTP id d126-v6mr3462037itg.18.1530066905457;
 Tue, 26 Jun 2018 19:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <1529904187-18673-3-git-send-email-kernelfans@gmail.com> <20180626074426.hzunfbvwbubt3t3p@mwanda>
In-Reply-To: <20180626074426.hzunfbvwbubt3t3p@mwanda>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 27 Jun 2018 10:34:54 +0800
Message-ID: <CAFgQCTsCFP_6znUaFKnczuUJjMMA1Hq_Qrk6CUVs+EFEBZgTMQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drivers/base: reorder consumer and its children
 behind suppliers
To:     dan.carpenter@oracle.com
Cc:     kbuild@01.org, kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks for your hints, see the comment in lines.

On Tue, Jun 26, 2018 at 3:44 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> [ There is a bug with kbuild where it's not showing the Smatch warnings
>   but I can probably guess...  - dan ]
>
> Hi Pingfan,
>
> Thank you for the patch! Perhaps something to improve:
>
> url:    https://github.com/0day-ci/linux/commits/Pingfan-Liu/drivers-base-bugfix-for-supplier-consumer-ordering-in-device_kset/20180625-132702
>
>
> # https://github.com/0day-ci/linux/commit/1b2a1e63898baf80e8e830991284e1534bc54766
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 1b2a1e63898baf80e8e830991284e1534bc54766
> vim +/ret +245 drivers/base/core.c
>
> 1b2a1e63 Pingfan Liu 2018-06-25  216
> 1b2a1e63 Pingfan Liu 2018-06-25  217  /* When reodering, take care of the range of (old_pos(dev), new_pos(dev)),
> 1b2a1e63 Pingfan Liu 2018-06-25  218   * there may be requirement to recursively move item.
> 1b2a1e63 Pingfan Liu 2018-06-25  219   */
> 1b2a1e63 Pingfan Liu 2018-06-25  220  int device_reorder_consumer(struct device *dev)
> 1b2a1e63 Pingfan Liu 2018-06-25  221  {
> 1b2a1e63 Pingfan Liu 2018-06-25  222    struct list_head *iter, *left, *right;
> 1b2a1e63 Pingfan Liu 2018-06-25  223    struct device *cur_dev;
> 1b2a1e63 Pingfan Liu 2018-06-25  224    struct pos_info info;
> 1b2a1e63 Pingfan Liu 2018-06-25  225    int ret, idx;
> 1b2a1e63 Pingfan Liu 2018-06-25  226
> 1b2a1e63 Pingfan Liu 2018-06-25  227    idx = device_links_read_lock();
> 1b2a1e63 Pingfan Liu 2018-06-25  228    if (list_empty(&dev->links.suppliers)) {
> 1b2a1e63 Pingfan Liu 2018-06-25  229            device_links_read_unlock(idx);
> 1b2a1e63 Pingfan Liu 2018-06-25  230            return 0;
> 1b2a1e63 Pingfan Liu 2018-06-25  231    }
> 1b2a1e63 Pingfan Liu 2018-06-25  232    spin_lock(&devices_kset->list_lock);
> 1b2a1e63 Pingfan Liu 2018-06-25  233    list_for_each_prev(iter, &devices_kset->list) {
> 1b2a1e63 Pingfan Liu 2018-06-25  234            cur_dev = list_entry(iter, struct device, kobj.entry);
> 1b2a1e63 Pingfan Liu 2018-06-25  235            ret = find_last_supplier(dev, cur_dev);
> 1b2a1e63 Pingfan Liu 2018-06-25  236            switch (ret) {
> 1b2a1e63 Pingfan Liu 2018-06-25  237            case -1:
> 1b2a1e63 Pingfan Liu 2018-06-25  238                    goto unlock;
> 1b2a1e63 Pingfan Liu 2018-06-25  239            case 1:
> 1b2a1e63 Pingfan Liu 2018-06-25  240                    break;
> 1b2a1e63 Pingfan Liu 2018-06-25  241            case 0:
> 1b2a1e63 Pingfan Liu 2018-06-25  242                    continue;
>
> The break breaks from the switch and the continue continues the loop so
> they're equivalent.  Perhaps you intended to break from the loop?
>
Yes, you are right.

> 1b2a1e63 Pingfan Liu 2018-06-25  243            }
> 1b2a1e63 Pingfan Liu 2018-06-25  244    }
> 1b2a1e63 Pingfan Liu 2018-06-25 @245    BUG_ON(!ret);
>
> If the list is empty then "ret" can be unitialized.  We test a different
> list "dev->links.suppliers" to see if that's empty.  I wrote a bunch of
> code to make Smatch try to understand about empty lists, but I don't
> think it works...
>
Yes, if list_empty, then the code can not touch ret. But ret is
useless in this scene. Does it matter?

Thanks and regards,
Pingfan

> 1b2a1e63 Pingfan Liu 2018-06-25  246
> 1b2a1e63 Pingfan Liu 2018-06-25  247    /* record the affected open section */
> 1b2a1e63 Pingfan Liu 2018-06-25  248    left = dev->kobj.entry.prev;
> 1b2a1e63 Pingfan Liu 2018-06-25  249    right = iter;
> 1b2a1e63 Pingfan Liu 2018-06-25  250    info.pos = list_entry(iter, struct device, kobj.entry);
> 1b2a1e63 Pingfan Liu 2018-06-25  251    info.tail = NULL;
> 1b2a1e63 Pingfan Liu 2018-06-25  252    /* dry out the consumers in (left,right) */
> 1b2a1e63 Pingfan Liu 2018-06-25  253    __device_reorder_consumer(dev, left, right, &info);
> 1b2a1e63 Pingfan Liu 2018-06-25  254
> 1b2a1e63 Pingfan Liu 2018-06-25  255  unlock:
> 1b2a1e63 Pingfan Liu 2018-06-25  256    spin_unlock(&devices_kset->list_lock);
> 1b2a1e63 Pingfan Liu 2018-06-25  257    device_links_read_unlock(idx);
> 1b2a1e63 Pingfan Liu 2018-06-25  258    return 0;
> 1b2a1e63 Pingfan Liu 2018-06-25  259  }
> 1b2a1e63 Pingfan Liu 2018-06-25  260
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
