Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CE3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577FD2086B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577FD2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbeIFSwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:52:34 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44264 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbeIFSwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:52:34 -0400
Received: by mail-qt0-f196.google.com with SMTP id k38-v6so12370100qtk.11;
        Thu, 06 Sep 2018 07:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gStD7gng+LQGi3GcB0ZkoptvESlejc3poKJrQW8iS94=;
        b=dqMq698ENstbANNxCOVW5G9i0dX7RF/Ta/LSLob/M2nilcU01/D8Zyw0rkw6ufCcVZ
         Jy7lwsHI2zs9NVFku7Txt/INrs4/eFW42uuws1gGRctBRqA+kTE1bWuMZL5D2ArV79Wf
         p+2ifJDgCq3oJhshk0Ed+W/oWNRyLxMhQmN0rWV+Hqg6qlgqDQJDZmk5qVFPE7c4UCqQ
         Yu/VQ1C4J6VTopWNtCE6+O4MJYPXKSAbQe6W3GYWafFeww4gepZKVyS2DigOvcHG2cII
         qvzsFY/2s5usidKlr6phJNVAE5AcrQb2x09SccxCvbFRxd1pRDwM6ZVSOjJmBEURLlE7
         POdw==
X-Gm-Message-State: APzg51DWYFfQ1zZX6I71C4exIAM1OfXUSv8pUgyNCSJ1Mlmb0CArLkKU
        jOq6BaH502p2SHeKlrx+Yx4dndSL0u9+xzAEGSzMNg==
X-Google-Smtp-Source: ANB0VdaQx6qazDqP23yKqZAlM6+w2JeZ522Ic8sMPb3uLhALOJ3EnFBZEpCL2PqPb6dAijbgRlid9po3pxYyHcX4D2s=
X-Received: by 2002:a0c:fb08:: with SMTP id c8-v6mr2169704qvp.149.1536243407082;
 Thu, 06 Sep 2018 07:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <66335e5f59c186b291f8c3c98c9dadbd61d0cd3e.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <66335e5f59c186b291f8c3c98c9dadbd61d0cd3e.1536138304.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 16:16:30 +0200
Message-ID: <CAK8P3a2pOYNB6LtFB6hJ3WMXzJsj5wwNKvBK4_dP-4uPKas-Pw@mail.gmail.com>
Subject: Re: [PATCH V3 17/26] csky: Misc headers
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:

> diff --git a/arch/csky/boot/dts/qemu.dts b/arch/csky/boot/dts/qemu.dts
> new file mode 100644
> index 0000000..d36e4cd
> --- /dev/null
> +++ b/arch/csky/boot/dts/qemu.dts
> @@ -0,0 +1,77 @@
> +/dts-v1/;
> +/ {
> +       compatible = "csky,qemu";
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       interrupt-parent = <&intc>;

Ideally, qemu would supply a dtb file that matches the current configuration,
as we do for instance on the ARM 'virt' machine. This allows you
much more flexibility in running all kinds of options, as well as extending
qemu later with new features.


> +
> +               timer0: timer@0xffffd000 {
> +                       compatible = "snps,dw-apb-timer";
> +                       reg = <0xffffd000 0x1000>;
> +                       clocks = <&dummy_apb>;
> +                       clock-names = "timer";
> +                       interrupts = <1>;
> +               };
> +
> +               timer1: timer@0xffffd014 {

Drop the leading '0x' in the unit-address here (in all devices)

      Arnd
