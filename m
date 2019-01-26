Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0DEC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A193B2184B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfAZVOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 16:14:40 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45822 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfAZVOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 16:14:39 -0500
Received: by mail-qk1-f196.google.com with SMTP id y78so7390872qka.12
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 13:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQMGx38XhBGTMF/0CaQDgyTCsEgvPq5pWGrKKNC/swQ=;
        b=mgqKoIkC/J2BhdPIQvWs1KkCEzEE7tno9NyoowhdDJ3or5uYEPRJvLpD3kBTq44jbG
         y118d98Ez2jYNO5oDVJu+DiDN5FzLfRAvckC0KgK839dpkHeYT7E1zGeiQpcd660rMJG
         e5bJxpQg2dJJUvJAQaHA4qm7Os1gO3zpDANQzU7OSRSX3ZaWJLrkbX/Ma0srpFL6XEGE
         a3RIkkzNfGufz/Q+vk8U6/1YFivQvZOcaNX/FP1wtV54Na023n2M7npQkeaHimgf8zep
         M6qqxzZdftQ4cgnk1EHlqmTmmRxJ8xDq6tM6s1Zr/Asjpwbc2OzEsGG8bFDdOd9qFXfX
         Rv2g==
X-Gm-Message-State: AJcUukfjykLk/eZud6IECMZeBtVOSeN2Y5VIPEpqJxIyHiSh0EMmp3mA
        r1CPdjqghFIWHjY62tS80d0mdgT5Y8ce2zJbG2o=
X-Google-Smtp-Source: ALg8bN6tCUbC2AjDyQtyGyMWX03B76YdxtVHUfNul19PPfxGIA7cei8k29CEjNOwkq7fev9KqYuD1hqtQ9+2Qxy6+G0=
X-Received: by 2002:a37:9a89:: with SMTP id c131mr14580394qke.173.1548537279039;
 Sat, 26 Jan 2019 13:14:39 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <20190123000057.31477-2-oded.gabbay@gmail.com>
 <CAK8P3a2NX_SNZPfqE4fnVcnxmSfAEzWMODce3L-g6JJ0NSTuBw@mail.gmail.com> <CAFCwf10jv4aMNefk_1Xj_Tg5Yjg8ekzWtZ94TssfHzaSN5CVAA@mail.gmail.com>
In-Reply-To: <CAFCwf10jv4aMNefk_1Xj_Tg5Yjg8ekzWtZ94TssfHzaSN5CVAA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 26 Jan 2019 22:14:21 +0100
Message-ID: <CAK8P3a3=1Rocb8jcG8XHadgcUCL6xXs8GRxc-Az6oyPqffYTpw@mail.gmail.com>
Subject: Re: [PATCH 01/15] habanalabs: add skeleton driver
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 5:25 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Sat, Jan 26, 2019 at 6:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Jan 23, 2019 at 1:01 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> >
> > > diff --git a/drivers/misc/habanalabs/include/habanalabs_device_if.h b/drivers/misc/habanalabs/include/habanalabs_device_if.h
> > > new file mode 100644
> > > index 000000000000..9dbb7077eabd
> > > --- /dev/null
> > > +++ b/drivers/misc/habanalabs/include/habanalabs_device_if.h
> >
> > Since this is a apparently a user space ABI, the file should be in
> > include/uapi/linux/,
> > not in the driver directory.
>
> This is not a user space ABI. This is the ABI between the driver and the F/W.

Ah, I see. In that case, you should get rid of all the bitfields and make the
struct members all __le32/__le64/... to make it work on big-endian kernels.

> >
> > > +/* must be aligned to 4 bytes */
> > > +struct armcp_info {
> > > +       struct armcp_sensor sensors[ARMCP_MAX_SENSORS];
> > > +       __u8 kernel_version[VERSION_MAX_LEN];
> > > +       __u32 reserved[3];
> > > +       __u32 cpld_version;
> > > +       __u32 infineon_version;
> > > +       __u8 fuse_version[VERSION_MAX_LEN];
> > > +       __u8 thermal_version[VERSION_MAX_LEN];
> > > +       __u8 armcp_version[VERSION_MAX_LEN];
> > > +       __u64 dram_size;
> > > +};
> >
> > The compiler will align this to 8 bytes on most architectures, and
> > add another padding field before dram_size. Better remove the
> > 'reserved' fields, or make them an even number.
> I can't do that, because those fields were once used by the F/W and if
> I will change the order here, or add/remove those fields then it will
> break compatibility with old F/W.

Ok, I see. Then you should add an explicit padding field and fix the
comment to make the structure match the actual interface.

       Arnd
