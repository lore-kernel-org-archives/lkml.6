Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E37ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9922150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jr+Y4Xx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9922150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390848AbeIUWsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:48:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40222 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390759AbeIUWsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:48:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id l63-v6so6317788pga.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tMagjXsT0NMZM/Y5uTZe0e3rFZqI9NBIP+UyUpnGQo=;
        b=Jr+Y4Xx8dsLSuhLooKrvnhTm07nktLYP1qRRlKtn0ah8TJqe7AxSgCMlmLM8m7wgZr
         qhEBleXlAzopodvdx5ZTmTVXygVuRBv0WjT1pZGA7vCAuM27KIhU2JceAxG4bqLWiaCZ
         i8GdbmjBuxtWmBCMsLp4MkawVnFzoErkFE1UBPMuenf/O52m3DWajYIucYpXqCuboxMp
         SsHYNOwpE7oWto3EhmEMibVNt0Dm/zxjp+OLClVNL036UxFAkjGFnIMANdJe+dyJQtln
         DgiRjgH75c3EtqCP4HHncIhbsdTv2zejjDqBiApy7Smoux51gFCzFH08FTIYzQqVCZP+
         CS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tMagjXsT0NMZM/Y5uTZe0e3rFZqI9NBIP+UyUpnGQo=;
        b=q+eNBHoOX/A242AXDcJClBHlyQPqBt4TlmGTUNOluicAJnhVej5hWIu7R3U7/zctrG
         E53k3iuK5FTYG3Qm1VDLAcWPu+OQo/FNeaKVYmSWS4FFD3wGaKZNwDpDZm5frKqU6pkq
         8RxzW3Cat117VDW6j5ByrT1HCePBDzDScrnfnieiYTwxVwmUTGXhwVkPCzgkNP1YB1nK
         63LdYnyMAiqzxil6Kz17e2RHGGgvUmCMADERu8I4lhaVuFZdXx4LordlXm9JMfx/9/1R
         KngUA/ht/+T7MA0+n+eCUd5XrvCjx2/40vaCLK9g1UXzm+gAGP47U+yJMmQYsGbnTFgh
         7wZw==
X-Gm-Message-State: APzg51ALddAJByyocw6e61TeqvhQATvey8VrYegNMlbTuZ/7PMBCCrAV
        uyyUdegosw5IGh7rhPxxZ0BHHVALrSpnLkRFFWvavw==
X-Google-Smtp-Source: ANB0VdZEAW/uxSaa2rPHrRP+rKOj+8JarvEoJSLmTJNu4ELvKaArbsxn1SDv354Yg4bGDDzbQ5BYvXRF0IpbQmbAP6E=
X-Received: by 2002:a63:6243:: with SMTP id w64-v6mr42913280pgb.145.1537549132242;
 Fri, 21 Sep 2018 09:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180921100045.20181-1-natechancellor@gmail.com>
In-Reply-To: <20180921100045.20181-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Sep 2018 09:58:41 -0700
Message-ID: <CAKwvOdk+u1EeREHkhtOGg9Didg6ibppz5Od8Txp7EnMw05gtFA@mail.gmail.com>
Subject: Re: [PATCH] media: pxa_camera: Fix check for pdev->dev.of_node
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 3:00 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns that the address of a pointer will always evaluated as true
> in a boolean context.
>
> drivers/media/platform/pxa_camera.c:2400:17: warning: address of
> 'pdev->dev.of_node' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (&pdev->dev.of_node && !pcdev->pdata) {
>              ~~~~~~~~~~^~~~~~~ ~~
> 1 warning generated.
>
> Judging from the rest of the kernel, it seems like this was an error and
> just the value of of_node should be checked rather than the address.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/media/platform/pxa_camera.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/pxa_camera.c
> index 3288d22de2a0..6717834e8041 100644
> --- a/drivers/media/platform/pxa_camera.c
> +++ b/drivers/media/platform/pxa_camera.c
> @@ -2397,7 +2397,7 @@ static int pxa_camera_probe(struct platform_device *pdev)
>         pcdev->res = res;
>
>         pcdev->pdata = pdev->dev.platform_data;
> -       if (&pdev->dev.of_node && !pcdev->pdata) {
> +       if (pdev->dev.of_node && !pcdev->pdata) {

pdev->dev.of_node is a `struct device_node *`, so this is the correct
way to check that it's not NULL.  It's use in
pxa_camera_pdata_from_dt() is necessitated on the caller checking that
it's not NULL.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>                 err = pxa_camera_pdata_from_dt(&pdev->dev, pcdev, &pcdev->asd);
>         } else {
>                 pcdev->platform_flags = pcdev->pdata->flags;
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
