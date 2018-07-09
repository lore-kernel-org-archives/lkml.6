Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D213EC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B07208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZf+aRC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B07208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932501AbeGIGPJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:15:09 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:43297 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932173AbeGIGPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:15:07 -0400
Received: by mail-vk0-f66.google.com with SMTP id d74-v6so9804010vke.10;
        Sun, 08 Jul 2018 23:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4LvWj1jXxce2xfiflfQmMmA0LApICtibPf1/Grcvq2g=;
        b=KZf+aRC+8aJdHPW6HPGU/bmeXLan6wvb044FpHHVNnpVPaT8AI+LtHRUMNBzhWwQr1
         FhVGSr+7CishWZe8ln/i2gC0tSMcUt2wHDoh03DdLQJfIO0M2ZDFGnYu7NtiR1rfMPWt
         KJseE+NE304ynjMgANQbjM/DbF65VbaU24lKwFVUA/Xo/B3pZHSHclXOTSXtZ5z2caao
         ENkOFHXKN1S5yPjl8CkslFbqKuETdtW5Mg2ivCirix7Ue4VBJeuUEiKO2u7l0+VJcTwW
         FdSt/ANd07E0KIziEk9gVgKeccvyHquNxkY5dburfPhCzqhs9WvwXpCfFj68439pXsgo
         Tkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4LvWj1jXxce2xfiflfQmMmA0LApICtibPf1/Grcvq2g=;
        b=ZEuhnHdymMGQhq5orcEKKlPOtDzqTc2i+JZh5FJyOhYV73/u46rNoalS1e8WlsTpO/
         ENKu3rLAFUo6hbhsH08yznEp0jrCE10sQYl7PxU65n1W7ZcenKX+iA52VgP+JsixQWhW
         brGP3boT5raRWtw87P/w2rOv1p/GZ56kUyd7SEwsCf6Z1l+696Jhnsqtu18v1qt4cjyL
         M5UGm5zCR07O+pn7ko5R8CLlGueGKBmDcNf3gb6FHwTYGTk0054VBSum8UFSI5kBv1t+
         zVO8wOZ4E6hMY5wpbHp0YHPfkgu7pFePZFPjBoejPuD8su4QX94LXPN2g7kEZ9RLhqtZ
         2eXw==
X-Gm-Message-State: APt69E0Gxrctl+dduuc79mUBPKpjNWyepK2+gbbTbZDgkfqM7HsqQ+J7
        1WnMc/bkxFEi2Kyn2OfqVd+vtZzDS3aUchcFCpc=
X-Google-Smtp-Source: AAOMgpeSZ2GodUqQ3d1VbxoCMB7qUAlX5mPUQ9FCKaqiHZEfiVhvawPI6PweAsekDZen8VrzQb4otEOLtOULJZRJg8s=
X-Received: by 2002:a1f:6dc4:: with SMTP id i187-v6mr11012296vkc.131.1531116906935;
 Sun, 08 Jul 2018 23:15:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Sun, 8 Jul 2018 23:15:06 -0700 (PDT)
In-Reply-To: <20180709140435.3996588b@xhacker.debian>
References: <20180704165908.4bb8b090@xhacker.debian> <20180704170310.56772d77@xhacker.debian>
 <f2733332a58e7f2d92948e2ff252581f93e5073a.camel@linux.intel.com>
 <20180705143921.6a8aeb50@xhacker.debian> <66eff871bc97f24e7fbcc2494df1bb6fdd98d8da.camel@linux.intel.com>
 <20180709140435.3996588b@xhacker.debian>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 9 Jul 2018 09:15:06 +0300
Message-ID: <CAHp75VcyzV8KmPx=NXe=4s2eOTRups=XU8L4UHP3eWr=1TH7Fg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] serial: 8250_dw: add fractional divisor support
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 9:04 AM, Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
> On Fri, 6 Jul 2018 20:37:09 +0300 Andy Shevchenko wrote:

> yes, makes sense. Will send a new version soon.
Please, be sure you base it on top of tty-next and there is no
warnings added (makes sense to run make W=1 as well),

-- 
With Best Regards,
Andy Shevchenko
