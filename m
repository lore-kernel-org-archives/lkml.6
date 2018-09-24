Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113B4C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6322145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzdFXJb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6322145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeIYCuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:50:51 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:43293 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbeIYCuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:50:51 -0400
Received: by mail-qt1-f171.google.com with SMTP id l16-v6so10538311qtq.10;
        Mon, 24 Sep 2018 13:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqUSBfBbNXQyfBaJnvEWX+6Pj0FydWV2lfL/v33zm9Y=;
        b=mzdFXJb0rw4OO30G2obWqUpdQCtcOgn0ZOW07v2pG6uksoQcsbGVOR6kbQmNTNEFkK
         avDRgGCKYutGjfXv7r5TdRadzM2YiP2tU31Ytl3eMGmPFpwVLevdltGHxSwHHbMQmvg9
         f2D8MF8P9mYcLe+C6+k++0cGT6s9+pwuigc2WRK36pBAW6YmmDcWKAI/Uxpc/GQZK5NB
         k7ugdVun+H6T5awshfp4rXRMh4HXU2ttJnsaq+vRHHYonbilZTgn9/SvdZjjdqeF4BoS
         SMiGiK6jlqShx0J1YmB0dgIvMJd+SlmbFBvJM19Ohl4nm1/ZkxmXqttnB73nBljZD3ub
         NQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqUSBfBbNXQyfBaJnvEWX+6Pj0FydWV2lfL/v33zm9Y=;
        b=I9/9slLFWcAD4Gi6VEphATBLACAFdxP1WRNi2uE5gUY8R+zytKym1ZL0h3FCVM1qFz
         SH1XJ75Vt8HbHu+EGdmHVI9MZptUMQLKiJHJ0fHz7N2mHGahUCk9PEcDdc/Ms6ouYkw8
         bvnk7JcWMY02eKBnlJdLfNQDl2v/Zp+v/DNtThibdwMrlwjbr4ErMIMYOxifcKJL2N9K
         Dxey/4VX7V21QjslrUzJaR+wfUAmkqeKjEwr7qftpC4bDW1lSnIdDtm2meeOffieMiXO
         5XlYaJf9v5PoQR4Usxac6U2IPljtOXm4uC+18tMmhW+s2LMQ5dSGDyY59OMqdVV8jKu3
         kcLQ==
X-Gm-Message-State: ABuFfogtoGmLImS5tX4bJTJJ8no3klaeUAtPurFNQ1CXbi9je7xuyxqR
        ms8o7uMbA02IT/FSF4fFZuQbHBD6qJHnTgsq2K4=
X-Google-Smtp-Source: ACcGV61QoQ7SLvy9UngxjJjG6j4gr/gC7W3RARRZmccA/dIv5GlpN/Dr7t2bP898UvWM0v4bYQjttQhZyo6ls6XNR+A=
X-Received: by 2002:a0c:93c1:: with SMTP id g1-v6mr508247qvg.136.1537822009215;
 Mon, 24 Sep 2018 13:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180924193352.96335-1-mka@chromium.org> <20180924193352.96335-2-mka@chromium.org>
In-Reply-To: <20180924193352.96335-2-mka@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 24 Sep 2018 23:46:37 +0300
Message-ID: <CAHp75VdJfDnBqgn3DSKZe-pFg4eh2tjomRoz0gyQd-O3Aqi5kA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] device property: Add device_get_bd_address() and fwnode_get_bd_address()
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, bgodavar@codeaurora.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 10:36 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Provide an API for Bluetooth drivers to retrieve the Bluetooth Device
> address (BD_ADDR) for a device. If the device node has a property
> 'local-bd-address' the BD address is read from this property.

> diff --git a/include/linux/property.h b/include/linux/property.h
> index ac8a1ebc4c1b..8926cf95d27e 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -15,6 +15,7 @@
>
>  #include <linux/fwnode.h>
>  #include <linux/types.h>

> +#include <net/bluetooth/bluetooth.h>

Hmm... I don't understand why we need this complete header here.
If you are retrieving bdaddr_t type from it, so, better to move it to
types.h first.

Sorry I didn't notice this before.

>  struct device;

> +int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr);

> +int fwnode_get_bd_address(struct fwnode_handle *fwnode, bdaddr_t *bd_addr);

I don't remember if we discussed below...
Since you put implementations under #ifdef, I'm not sure we can leave
header w/o stubs for !CONFIG_BT case.
I can imagine the case where some driver might use BT functionality
optionally in which case this enforces ugly #ifdef in the driver.

-- 
With Best Regards,
Andy Shevchenko
