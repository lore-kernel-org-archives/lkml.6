Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BD3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D6E20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGXO2esY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D6E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932844AbeGIMOj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:14:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43888 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932597AbeGIMOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:14:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id r13-v6so13904558ljg.10;
        Mon, 09 Jul 2018 05:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4rkhol9MWzyKE1r5wfsYdekvm7nzB0IJa9NIog9W614=;
        b=QGXO2esYBVfbJYtnaMflMqIApnoi8VET4xyWb74JX9xYPpa8dzlWP1AwkqDthXFfxE
         VMgTaxyz1Tek3JMRYYMXcQB/a8G+0wkSNDTwMawVbrg9C3JDhz0wWy8Vv7dRVoNtmN/+
         jdtgzMWytNRN6OpxC8vWRbV7/WVM7/4tMpn5JZsG6bzLRNmyQpprxrlI6hEjVQ8SfV4p
         OLZdzu6y8888/UWIe77Q8dhBgYQMm+opQBrV5rVcQISNYwVtVh6WZCQFwYIp17QQyzAx
         gsPA/4a02IJeYScpqSd08Ljp2vrERPFrT1ZId16oDSBeBz3y4A7EBKs3Hl9XgSyqAbHI
         YTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4rkhol9MWzyKE1r5wfsYdekvm7nzB0IJa9NIog9W614=;
        b=bcI1xdCW8hVGZwCDdsLIUWKP0+6piAa3HPzYkZ8rOxHi2rNxI+t/F0IAu8SFnHhlmZ
         ckQT09vXteeF5Y5jgAyVIYyLm2qV0pvI+FEdvik2vNhfWRjeICdY6iujpjPqqT+pz+bv
         VRs2BsHvqTNgHttFx0/qLuho12pG9dDLmNKtWo/fYRHt/OupdgXg5vvebtOWCVCl1foG
         jcs+uZZCRkTB5be1oxzfEdqWbrCmg71z1BiaEE4ZzZKtFERn6HHBkTYV0YaOIrRpFGcD
         cgVfJYmR3tGsKwRsYTfpz6r0FwBN/ERNK+YoQ/w5iF/Zofqo91Y+mqJEZlNbzhsBbig+
         MZQQ==
X-Gm-Message-State: APt69E3bGu+3e8jc8k/aWukz+d2AqQES1PQP/uiLVZt54X5W/W4OXmjw
        RxMIMfd6gZ6Z0KS4HJzuYpoN6HhvCJnJgjOXKygtNQ==
X-Google-Smtp-Source: AAOMgpf0H6tOtC6aZKOkfMT8myKf6FqyYa9WSFoMSGNPpJz3A3NYZpdf8QdekFEtHXgnBAqlJ4/5M1J7Vi7fGd/xQyc=
X-Received: by 2002:a2e:6a04:: with SMTP id f4-v6mr13126473ljc.109.1531138475326;
 Mon, 09 Jul 2018 05:14:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:309:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 05:14:34 -0700 (PDT)
In-Reply-To: <20180622162549.9563-1-jandryuk@gmail.com>
References: <20180622162549.9563-1-jandryuk@gmail.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Mon, 9 Jul 2018 08:14:34 -0400
Message-ID: <CAKf6xptPoBJ1T=FSSkyqXf9yLdjzvGW73GL-tNLx34zA0jr78g@mail.gmail.com>
Subject: Re: [PATCH] i2c-hid: Fix "incomplete report" noise
To:     open list <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     john-s-84@gmx.net, Jason Andryuk <jandryuk@gmail.com>,
        stable@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

The logging here is very excessive.  If not this change, then some
other change is needed to cut down on the sheer quantity of messages.

Thanks,
Jason


On Fri, Jun 22, 2018 at 12:25 PM, Jason Andryuk <jandryuk@gmail.com> wrote:
> Commit ac75a041048b ("HID: i2c-hid: fix size check and type usage")
> started writing messages when the ret_size is <= 2 from i2c_master_recv.
> However, my device i2c-DLL07D1 returns 2 for a short period of time
> (~0.5s) after I stop moving the pointing stick or touchpad.  It varies,
> but you get ~50 messages each time which spams the log hard.
> [  95.925055] i2c_hid i2c-DLL07D1:01: i2c_hid_get_input: incomplete report (83/2)
>
> This has also been observed with a i2c-ALP0017.
> [ 1781.266353] i2c_hid i2c-ALP0017:00: i2c_hid_get_input: incomplete report (30/2)
>
> Only print the message when ret_size is totally invalid and less than 2
> to cut down on the log spam.
>
> Reported-by: John Smith <john-s-84@gmx.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> ---
> John Smith originally reported this, but his post did not include a git
> formatted patch nor a Signed-off-by.
> https://www.spinics.net/lists/linux-input/msg56171.html
> https://patchwork.kernel.org/patch/10374383/
>
> When ret_size is 2, hid_input_report is passed 0 and returns early.  ret_size
> == 2 seems to be a header size saying there is no content.  Should
> i2c_hid_get_input just return early in that case?
>
> Also, should this condition be noted to stop an interrupt from firing to
> avoid the ~50 bogus messages?
>
>  drivers/hid/i2c-hid/i2c-hid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index c1652bb7bd15..eae0cb3ddec6 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -484,7 +484,7 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
>                 return;
>         }
>
> -       if ((ret_size > size) || (ret_size <= 2)) {
> +       if ((ret_size > size) || (ret_size < 2)) {
>                 dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
>                         __func__, size, ret_size);
>                 return;
> --
> 2.17.1
>
