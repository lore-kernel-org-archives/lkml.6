Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE975C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB772150B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGaQ2JN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB772150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeIZX0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:26:19 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:34772 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeIZX0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:26:19 -0400
Received: by mail-qt1-f170.google.com with SMTP id x23-v6so18094516qtr.1;
        Wed, 26 Sep 2018 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zH6lQjG/WJ/egxo/nrCXAQNiFiBIKND/Jz0Pqc8eVXs=;
        b=IGaQ2JN+y6XHUoFnwcwbSvIdtaaa+FcbWalbKTNJposkkNtDfPjFNuB0l2t1T0eMe8
         js5ih9dmTgHFjeNOVzEP8JBSp0HJFWTk3uB4cjdR3Zj96mhk7+rX4HzBmQCW5ax2BtXl
         fbAUDvZm+eXKa3sd6JUOp6aHg2qXkp4zRqkAqxYsFKJuPE3eCwMl+B09Mibp/OUDHV+c
         SSi1sscJctM4Qx1oHOmMC0eQqsHghoTo2AZ5sPUx+WOtNc7nCUd4CRfQ/AnQl6TJN2Ns
         ivpnZbqhpCqQZ6Epp1d4njZVbTykS2G693h50Rg9touZIAsAKUUNV+WW+cPvT+MHB03t
         KLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zH6lQjG/WJ/egxo/nrCXAQNiFiBIKND/Jz0Pqc8eVXs=;
        b=UykQZS1v33ekUVuORbLz3mfEfOX82tSv8W1ruBdIUZhbP9f33K/tIMkNeqCBa08mXr
         lXmr+Q1N12GODmOaTlg9MBZ9U2D+lv77XN0ovqMrd/TE+s/Cx86/rrE7/JMUdMCg6qqA
         zWGSWtl0JRSbmWQgA+KOKi64/MylRarDedq2iOJ17AzMuC3EoFy70xTlEo1/lFOBRntz
         zYI8x+jYR6RVZhVHhW6WsZhv71FEjinV7d1H+H1jO1tSIIzhgudntiLxRz6FtNL5LoxB
         rewVUAmJdA06KchiPTFMQyN7aSaesWr10CnOtX6k21ZPA9TwJcP7QI95WGZFUq/mJ8M7
         Z+lw==
X-Gm-Message-State: ABuFfogtJnldUwG2e995SX2mieDQ66jA5OM6XRZlhKzsPdRU05W/kTMM
        PE0d3IKlPZfcBBqBrioxS7ueJ/vXsoSr6c4OcTQ=
X-Google-Smtp-Source: ACcGV61mG0BoHU8a0vabxLGPKgKVXKNn4eXSefPYUdO9aQrJkbg/gHkd1N7wui7fm/pepo49UEw4k4/yw2UlGQhgF/0=
X-Received: by 2002:a0c:9557:: with SMTP id m23-v6mr5060613qvm.138.1537981943591;
 Wed, 26 Sep 2018 10:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180925191014.85573-1-mka@chromium.org> <20180925191014.85573-2-mka@chromium.org>
 <20180926113625.GM11965@kuha.fi.intel.com>
In-Reply-To: <20180926113625.GM11965@kuha.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 20:12:12 +0300
Message-ID: <CAHp75Vdwkovc+Myd9HSMUYxPdB_8TxqEY1JrCNSOhUwbTTpPEw@mail.gmail.com>
Subject: Re: [PATCH v3.1 1/2] device property: Add device_get_bd_address() and fwnode_get_bd_address()
To:     "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, bgodavar@codeaurora.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 2:37 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Sep 25, 2018 at 12:10:13PM -0700, Matthias Kaehlcke wrote:

> Let's not fill property.c with framework specific helper functions any
> more!
>
> Those functions are completely bluetooth specific, so they do not
> belong here. The fact that some other framework already managed to
> slip their helpers in does not justify others to do the same.

Actually good point.

-- 
With Best Regards,
Andy Shevchenko
