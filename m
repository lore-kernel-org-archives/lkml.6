Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931CFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5875D20866
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5875D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389302AbeKPR5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:57:49 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45468 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeKPR5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:57:48 -0500
Received: by mail-qk1-f193.google.com with SMTP id d135so36006291qkc.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 23:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJEr8Jtp8swWj5XEne85o45PByDl88zVt3vzUIE/pbM=;
        b=KmnYgKDbpN3Wy6VV4n7yxE38qCIdSPv6/Qjl9KKbtleReuMqFmIq6OxwolA8okmM0j
         jPYQIBDvi2P1jUXX8vfrkIr0HGOVRGWrWwzyim1Q1XoY2iatQRTI6Cj9xITHsKnHi+oS
         EXmmhDkAwXNGZENb2j5UHm7onTpMzGsKccZJ9AldDCYsfQsfjAEVe/A3iAEyezy2+IZ5
         vABmsxFcpidhBkpQuOzINaN8MDIax3l//RYtoo34nHCSSDPBasf3xQ63xe5rOBa6xXkn
         wfeRIgVNyXMsNhCjgjA2ktDS6pA4zVD4S5Dj0WihL2khcWTLyEws0MiKbou6Uc2znugB
         ENsw==
X-Gm-Message-State: AGRZ1gID2Sf/I0IrUNQvTNh90/pdwy2BQYXBR3jOFGKvDlshH75jJBk3
        WLqP38y0xrW1lot13dlTCofjd5XoQHjNQe3GJ3iBTQ==
X-Google-Smtp-Source: AJdET5e/oXDN3YBeNxLfB4C5bLUVg4eIeG25xWkC59aDYyYGc2P/u4DA+15rUvGBewpP2Q/Q/K3GUg+M4PbQMjbejrA=
X-Received: by 2002:ae9:e102:: with SMTP id g2mr8668982qkm.343.1542354394588;
 Thu, 15 Nov 2018 23:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20181116.130459.1796034910024118091.teika@gmx.com>
In-Reply-To: <20181116.130459.1796034910024118091.teika@gmx.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 16 Nov 2018 08:46:22 +0100
Message-ID: <CAO-hwJJrCvoCxBrS7H4+JRnfpHjfpPobwTzwsy8_aiFX=AD40w@mail.gmail.com>
Subject: Re: [PATCH 1/1] Input: synaptics - enable SMBus for HP 15-ay000 (SYN3221).
To:     Teika Kazura <teika@gmx.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 6:00 AM Teika Kazura <teika@gmx.com> wrote:
>
> SMBus works fine for the touchpad with id SYN3221, used in the HP 15-ay000 series,

Nice.

Thanks for the patch.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>
> This device has been reported in these messages in the "linux-input" mailing list:
> * https://marc.info/?l=linux-input&m=152016683003369&w=2
> * https://www.spinics.net/lists/linux-input/msg52525.html
>
> Reported-by: Nitesh Debnath <niteshkd1999@gmail.com>
> Reported-by: Teika Kazura <teika@gmx.com>
> Signed-off-by: Teika Kazura <teika@gmx.com>
> ---
>  drivers/input/mouse/synaptics.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 55d33500d5..591b776f22 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -179,6 +179,7 @@ static const char * const smbus_pnp_ids[] = {
>         "LEN0096", /* X280 */
>         "LEN0097", /* X280 -> ALPS trackpoint */
>         "LEN200f", /* T450s */
> +       "SYN3221", /* HP 15-ay000 */
>         NULL
>  };
>
> --
> 2.18.1
