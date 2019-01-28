Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C063C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7C32087E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0vM4iPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfA1J67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:58:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38300 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfA1J67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:58:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so7524935plb.5;
        Mon, 28 Jan 2019 01:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJZh3L8iCg2l35Z7983fkXv2DOyMrKd8FNc4DrKdHO4=;
        b=W0vM4iPq9S7ZaLoZA2fnzTJ/P0LyW517dsPf32SFFLqeYNADr6gGOx/pIOCJ/Q3THo
         Ot6xWuHj5WhRRcNiW75aQZDRaoqeOVYZzv7CW3z6Rc8XS1ffxpRb7ibZFWdPSyAEG7dl
         9yuMyNumqEbOWcZJFTiJvk/O69BU+2UI6arXDN+NrRC5vOGw7n2FVrz00sGe8dEKSYMS
         4DQm40A+z9gjNkjRHCq7/0w4vaj/B6YxZGKWtxZhEfQ8ZWqz/ppPPQMtJWKsCc0bzVJO
         6Q3QDEYDDtsOEJfJux5a13JBRPgkO+lZx7n8ik6G7BqplCudR20Pe4rQR4iWAENuE+lo
         3a/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJZh3L8iCg2l35Z7983fkXv2DOyMrKd8FNc4DrKdHO4=;
        b=JFYlNUc1C3t2fEr0gA4b8imFWyJz/EytVd1TNq2gjCc6EPHTRv274uI5sNkMtckmK6
         fAk0QNa0tEaSp17PemIiyN4xi1akpi4wEAi4JHvak7ZdOanodolZ0GARyMlQn6KVY5aw
         AziTzZu12qV+epDyNpzsBYsm9EdxBad+SGy4ee075yAAhyojogSKIPjs+2mTSDnl2Z73
         TY1eXZHT3RsgdFt+IWLir1I+NxLf8gH82U0XtupignJu2X4o5OVy3sjnpHumA6Ow9QoN
         BfyOtVcBKs663pvF+NivpMKlSPPrlOADrOaMGxRGAbwa6Jo3/Dj31j0VP0TPiVCyorFr
         5gVQ==
X-Gm-Message-State: AJcUuke21WvvwzoNpFuPF8o5DZzeCnQx0gy2yEU9k97yEiC65xpyEZQ+
        XrcjLpHAC9mEHpEY7+wnPHX8yoX12ULKPRW+Ufo=
X-Google-Smtp-Source: ALg8bN4uNwWGC6JI+mSZd+WevKQvYbFh/01iZN3LNZVfJ27VxzKjbexVJt7WHIEMey8xT3dQL3CF2Ood1HXtOv+Mujs=
X-Received: by 2002:a17:902:4081:: with SMTP id c1mr21478375pld.87.1548669538396;
 Mon, 28 Jan 2019 01:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20190125131519.88416-1-heikki.krogerus@linux.intel.com> <20190125131519.88416-9-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190125131519.88416-9-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Jan 2019 11:58:47 +0200
Message-ID: <CAHp75VfQGQh4i4d42ijH2vTzrM63-Ev-BomgKP=dBSDM3vnq+w@mail.gmail.com>
Subject: Re: [PATCH 8/8] device connection: Find device connections also from
 device graphs
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 3:17 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> If connections between devices are described in OF graph or
> ACPI device graph, we can find them by using the
> fwnode_graph_*() functions.

> +typedef void *(*devcon_match_t)(struct device_connection *con, int ep,
> +                               void *data);

devcon_match_fn ?
_t sounds to me more like a struct or a redefined POD.

-- 
With Best Regards,
Andy Shevchenko
