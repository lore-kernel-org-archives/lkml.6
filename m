Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7DFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309EC21533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwD/jTRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309EC21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeI0PsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:48:06 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36821 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeI0PsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:48:05 -0400
Received: by mail-ua1-f67.google.com with SMTP id m26-v6so697126uaq.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 02:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RCkGCpvs/pIJfzl1hqgJyV8S7mNiaxU/q1QUTQktp3M=;
        b=rwD/jTRM/42bN9D+lUv/A7OSoDpTtTsdBNBp7rEbNver0LeTHq9E/7Rahv16iRUNzg
         c4oJ9VI5hJ79k9R7cqiLFhMnPmD/YLu8kOeku1a0KvUMpeVj6KXsFm2UW4Y3ehw6ndoh
         STvNMDOX/ocswmDDVxjDAdZz1gZrSroz3C0tDDK3LaRLkDwbV36yC0D6Vo8GWr4eeIPg
         OAvO9UHWDDyfvpmmqlop6/YieJKfUtd9vK7oFsMqu/1vFzpfUbP2s4SyBFlGOzu5uCBn
         Snyt/z33FN+tK+iORzEuPYpO0AZnjYJDSPhExhTZ4LNFGitmux9fwKLISetunJ/BYsEp
         78bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RCkGCpvs/pIJfzl1hqgJyV8S7mNiaxU/q1QUTQktp3M=;
        b=j5opcm43eQ1K9oBekFItSX16ZWeBu8jexud4n5eJeDKbVc5ZprI8O+PXSwKU6D9Ydw
         8fOy0cSSGeLfJ4RGiFZ/+gG931L80zy8fCXY65hEWjnER97ZuAQGIN75/PyU+rW98jra
         VGXGOZQ1FdONQxiGqKPENltmNiTtl4qD9duPPk82yz+sfDPNZXIkmiSIyOyXEHecSaUF
         dTDKIcmwEdLVIknzMvEmERfTAZN9G0qe4TBiMNuWW2V5HSV4WAdCopx5TMoguQhmFQKD
         wr32O7ie0pDD5d28yc++ogjwAhaMKshWmUnIpAN4Cs8mD8sL5k2CFUfocJn+OSKGi90Y
         uvbw==
X-Gm-Message-State: ABuFfoiVmjmnF9VfKz2tsDUjQ5S134mIulAI3PzdtD5rWl5JvEpAqDtf
        OgbOBWvH0lu1FlytpsQA1zNRK6SW6JmGPpNRJA==
X-Google-Smtp-Source: ACcGV62r+4e0/qi0im3VuaTDnVogEcs+bgiavif0cAi/sjWV+te8Eq8BLNoV/H/clJjTDCZggrLwq9PhCRTbvWoRYTY=
X-Received: by 2002:ab0:3194:: with SMTP id d20-v6mr3525836uan.122.1538040643352;
 Thu, 27 Sep 2018 02:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180927092427.507-1-jekarlson@gmail.com>
In-Reply-To: <20180927092427.507-1-jekarlson@gmail.com>
From:   Emil Karlson <jekarlson@gmail.com>
Date:   Thu, 27 Sep 2018 12:30:31 +0300
Message-ID: <CAELSAVZSJzAY8T+gi31REVM1Hby8tcY5HL5uLrYR3t1nkeWFAw@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros-ec: copy the whole event when msg->version is 0
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stefan Adolfsson <sadolfsson@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To note I have almost no idea what I am doing and ended up wondering,
whether the messages are always truncated and it only shows on version
0, because the messages are not padded to longer lenght. Alternatively
the ret could possibly be used as copy length without the -1, right
now I am unable to test with version 1, possibly it requires update of
cros-ec firmware.

Best regards
-Emil
On Thu, Sep 27, 2018 at 12:24 PM Emil Karlson <jekarlson@gmail.com> wrote:
>
> Commit 57e94c8b974db2d83c60e1139c89a70806abbea0 caused cros-ec keyboard events
> be truncated on many chromebooks so that Left and Right keys on Column 12 were
> always 0. This commit fixes the issue by restoring the old semantics when the
> protocol version is 0.
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 398393ab5df8..457e4940dba4 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -519,8 +519,14 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
>
>         ret = cros_ec_cmd_xfer(ec_dev, msg);
>         if (ret > 0) {
> +               unsigned int copy_size;
> +
>                 ec_dev->event_size = ret - 1;
> -               memcpy(&ec_dev->event_data, msg->data, ec_dev->event_size);
> +               if (!version)
> +                       copy_size = sizeof(struct ec_response_get_next_event);
> +               else
> +                       copy_size = ec_dev->event_size;
> +               memcpy(&ec_dev->event_data, msg->data, copy_size);
>         }
>
>         return ret;
> --
> 2.19.0
>
