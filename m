Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E699ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50BF20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50BF20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbeGQK5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:57:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34755 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729973AbeGQK5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:57:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so716230wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 03:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H6f+QsvmmWI6NPhiCxoM30tzcPxvb5U86xLWBcabTZ0=;
        b=XFCIncA99JZ7HVExU52cJmaHpunA+dpRzGuebsMvt7LNX4opDFZJGf1MsY7VhzOcFS
         SSLChvdQ5tGq6Euz1i/v9tNxXRrQlJ811HypA1sOaZvQ+OIWPh2F2T/xBFnMnFs6f8n7
         joX0BDmjWhF2782cWaePHlZbE7L9X4idJoTAC++XC/N2qRY5uG4eozJyfiBRLSK/wbbr
         V3AZ0nFsm0HeBpmIFfvKe5bom5vds0tN+ccGtfcq/hsFxmRmONhO3p1fVd+FeA4LF025
         30QLIfazEZ5frvqqMlVaWhHP1YbXYLB1ObEbu2PAdBY7F60tWgyalwqpTZY10ec0E4tY
         CAEQ==
X-Gm-Message-State: AOUpUlGXIMDUNX6xRMRKvOYnw7EWLcOuGQOxbi+QY46ozeYKT1m+4oHF
        /Jhj7kfgKme4ouQkc2MZotdpUnW5sMh02sIzBo8+BQ==
X-Google-Smtp-Source: AAOMgpftPmAmjb/B93A2lRGeqxsbG5gU75QCnKF8WFzIw/XRGwhVNW9RLzMQOBxGpdoOen51BAI2ErglmmSXc4qSKkQ=
X-Received: by 2002:adf:dc8e:: with SMTP id r14-v6mr908247wrj.166.1531823121264;
 Tue, 17 Jul 2018 03:25:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c2:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 03:25:20
 -0700 (PDT)
In-Reply-To: <20180717000758.8770-1-lyude@redhat.com>
References: <20180717000758.8770-1-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 17 Jul 2018 12:25:20 +0200
Message-ID: <CACO55tt5e6PrvbfZUzQNb0T1o8twRfaFewt6tnjUW0DQYYXK-Q@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau: Fix bogus indenting in nouveau_hwmon.c
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

isn't there like 1 space missing for each change? Or maybe my client
is messed up, but please align it with the first letter of the
parameters not the "(".

With that fixed: Reviewed-by: Karol Herbst <karolherbst@gmail.com>

On Tue, Jul 17, 2018 at 2:07 AM, Lyude Paul <lyude@redhat.com> wrote:
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_hwmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> index 44178b4c3599..d556f24c6c48 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> @@ -655,7 +655,7 @@ nouveau_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>
>  static int
>  nouveau_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> -                                                       int channel, long *val)
> +            int channel, long *val)
>  {
>         switch (type) {
>         case hwmon_chip:
> @@ -677,7 +677,7 @@ nouveau_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>
>  static int
>  nouveau_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> -                                                       int channel, long val)
> +             int channel, long val)
>  {
>         switch (type) {
>         case hwmon_temp:
> --
> 2.17.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
