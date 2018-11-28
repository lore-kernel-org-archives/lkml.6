Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104DBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C800D206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwRaZBIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C800D206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbeK2Dcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:32:47 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50365 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbeK2Dcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:32:47 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so5334241iti.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 08:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jEHFc25zIkLHPxuplM7xnuSZQ305HY/ijfHf0SseaxU=;
        b=AwRaZBIacb3ezaKR8EnoK2BqiI4MmPw/Lieq+mRmDZs0Q86VPypZw4zQ3uj6fgXdLl
         ORljT0Em4OC9wxMK/Ib3lrZqmqGn8Q/cXKeCKw10qw0r/aAGobWJhrF+s5vZpsANbb5V
         8VkE1OAv3MWMOsg0NVinxw7D9B/nd7dpY/qpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jEHFc25zIkLHPxuplM7xnuSZQ305HY/ijfHf0SseaxU=;
        b=eHcZjl/XOQAp06BX9qqa7YhvtIYT2aqANDGpFm7C51jupwoG/PzOWo9Dw+KefTzMxK
         ZxWpH5O1ofmni4thU0m6HOB0VzMRoW20YYmW9Sv6cwwbMsykmi3VAlpNh9dWtuToXsvt
         K5svYSSHMB0TS6arl1u7lbBywTP3zUTlX99gcjMc/rY45lcyYvPY+tjgm7EExQ3trOW3
         b5l9BT34AL2aU8sULWwvJ+lqRHZdGVCMVB5cfVe1DpzAzjZFaThbRx31hRCdcSuZOSOE
         LbvbWBpY7wHlFeUnqZorKwgC9WYHXCjHhqPIxv0kbM0wtazZHE3ND5cQfI2+XmquXcVb
         8iGQ==
X-Gm-Message-State: AA+aEWY12RIFOzg7F3d1pd2wnvcF0bMRnpxT81Ep+cAntgya6mfZxkBD
        FYR/UHdceT79M2Yd0kPmnc3NBdPsiqRVjHnivDdQvA==
X-Google-Smtp-Source: AFSGD/UuLq56B2PqWexXqeUOp8SnO8IL/y66EAJasNU6A99Qf2qz8w8j6t99UT4YYuVt7ESKhSORdTW9l22GMXnd9Rs=
X-Received: by 2002:a05:660c:34f:: with SMTP id b15mr3651968itl.146.1543422633581;
 Wed, 28 Nov 2018 08:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20181127140356.26626-1-colin.king@canonical.com>
In-Reply-To: <20181127140356.26626-1-colin.king@canonical.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 28 Nov 2018 09:30:22 -0700
Message-ID: <CANLsYkzyHiD0NXn6jOpJg7Ho3G83dqTX9N-8BsNUtxNRiXS3Fw@mail.gmail.com>
Subject: Re: [PATCH] coresight: fix spelling mistake "deffered" -> "deferred"
To:     colin.king@canonical.com
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018 at 07:03, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in the dev_info error message, fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/hwtracing/coresight/coresight-stm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 35d6f9709274..ef339ff22090 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -856,7 +856,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>
>         if (stm_register_device(dev, &drvdata->stm, THIS_MODULE)) {
>                 dev_info(dev,
> -                        "stm_register_device failed, probing deffered\n");
> +                        "stm_register_device failed, probing deferred\n");
>                 return -EPROBE_DEFER;
>         }
>

Applied - thanks,
Mathieu

> --
> 2.19.1
>
