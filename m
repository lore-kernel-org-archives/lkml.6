Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4E2C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12D320880
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNPoKeuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfAZQZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:25:18 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36840 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAZQZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:25:18 -0500
Received: by mail-ua1-f66.google.com with SMTP id j3so4259937uap.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 08:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01VttcPRMIwRvqFb83KoJstnAKPFvhzQQR45ZmSzSHA=;
        b=BNPoKeuOD43PSzewt7SYj7VNcYqjhTPBl5eI3o4Jr2KrT6gtt7R3WNhVW3vzduxbN7
         a6+FCzpgFnKMxfUMTQ1EjLuLlWyjcZCXMthSLiFDxLl/pg9k9hVeWxkap/SHfh1xHHJS
         g+OLrZz+3NIlg8QRwogPUcLA+kKqeX3y3bkY21gGx830TyOW7zwoCcBO4mcm0XbL1X2a
         LoW3QKsgewrNow+qt2Ey0YDlSLYIY3jSPRSqo1Qs/dBp0bdf3sPJGNiww9fyPRQR+Avk
         p7RqI4dN6DXVm2OReCZzLH7fYfV240Ge4pGLsrttm5SYMgUp1TODtDp2ea6tbQW2A80S
         ADbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01VttcPRMIwRvqFb83KoJstnAKPFvhzQQR45ZmSzSHA=;
        b=HqYua71bV1ROiukMXt/89Zpp4ourNVFV6H2JfWtKJ/U6ZXvptDHG0ltdtlWuyGGl6k
         vOohWnnMy43L8+aqXw104sLgksQppqQpNKkPI1/QyNNvpcxPgXWKIlAzyyLRNadeEixO
         ZlI3JdJ3DEx2bBsLSbTbmpfoJx+kKcgqRFRLyq9Kd0mc72vvpJLt71ByVJglAVheHZU+
         suUYCrhld9WG2YzPYMq7U4KlWUC3I7/Mjgkx4J+Cnn0xu6RvOcN+yPHARztHRNp7UNVm
         v1kcpq6IQw/ASTrqgVyEJ8Ud3D79kbu6BPGohsC+HMdRw0PD8ASZYfq9aqzS4kGstyYq
         /jyQ==
X-Gm-Message-State: AJcUukecSOwYgOcZgY6oGyvWi54Hhy2t0+Z4dtaStQ2qAWeJRYMSKz+P
        yadkxCdSsAcE9rmpKs3+ogQH1oom4sa8eRIOdPkjoUPa
X-Google-Smtp-Source: ALg8bN435a6+zKA+9t6KN+ujqpAdNHmi+k4lA98Jr9o+mDbgyKGyWxTW8NkTeqIO8BkJeLGk42xOME0ogVzdmtONVc4=
X-Received: by 2002:ab0:6446:: with SMTP id j6mr6343648uap.2.1548519916445;
 Sat, 26 Jan 2019 08:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <20190123000057.31477-2-oded.gabbay@gmail.com>
 <CAK8P3a2NX_SNZPfqE4fnVcnxmSfAEzWMODce3L-g6JJ0NSTuBw@mail.gmail.com>
In-Reply-To: <CAK8P3a2NX_SNZPfqE4fnVcnxmSfAEzWMODce3L-g6JJ0NSTuBw@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 26 Jan 2019 18:24:51 +0200
Message-ID: <CAFCwf10jv4aMNefk_1Xj_Tg5Yjg8ekzWtZ94TssfHzaSN5CVAA@mail.gmail.com>
Subject: Re: [PATCH 01/15] habanalabs: add skeleton driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 6:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jan 23, 2019 at 1:01 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> > diff --git a/drivers/misc/habanalabs/include/habanalabs_device_if.h b/drivers/misc/habanalabs/include/habanalabs_device_if.h
> > new file mode 100644
> > index 000000000000..9dbb7077eabd
> > --- /dev/null
> > +++ b/drivers/misc/habanalabs/include/habanalabs_device_if.h
>
> Since this is a apparently a user space ABI, the file should be in
> include/uapi/linux/,
> not in the driver directory.

This is not a user space ABI. This is the ABI between the driver and the F/W.

>
> > +/* must be aligned to 4 bytes */
> > +struct armcp_info {
> > +       struct armcp_sensor sensors[ARMCP_MAX_SENSORS];
> > +       __u8 kernel_version[VERSION_MAX_LEN];
> > +       __u32 reserved[3];
> > +       __u32 cpld_version;
> > +       __u32 infineon_version;
> > +       __u8 fuse_version[VERSION_MAX_LEN];
> > +       __u8 thermal_version[VERSION_MAX_LEN];
> > +       __u8 armcp_version[VERSION_MAX_LEN];
> > +       __u64 dram_size;
> > +};
>
> The compiler will align this to 8 bytes on most architectures, and
> add another padding field before dram_size. Better remove the
> 'reserved' fields, or make them an even number.
I can't do that, because those fields were once used by the F/W and if
I will change the order here, or add/remove those fields then it will
break compatibility with old F/W.

Thanks,
Oded

>
>        Arnd
