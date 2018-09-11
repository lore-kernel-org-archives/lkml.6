Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239C3C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92F620866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Za3hF/Nt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92F620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeILDzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:55:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43765 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeILDzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:55:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id v66-v6so12959288pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 15:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFgUVH3F8T3JjFWUP1NLsmrvcMsZDEQTEOvmoo1k26c=;
        b=Za3hF/Nt6YirbON2weOaRCpMHlhfE9nzhXdYxcfbJppct4bul1PqhLu2NYC5eLAu90
         Jg36HTqVE9xSM9mn/f8V9LJ1SplsW8HiCqCvt5L2jd1BjNP7vyPn+e/X2unSJL2Hrk6N
         NcJPSPFO7Bbw80un0rsanCVxFJxsIqnMhXxdWi2kUX5tXiVxtsczLDuBD5dOyU7YagZR
         Ug06TicDs/2NbGK8298d1Z3k8LPqbrhwjlhE8MGUk960tolEGbdIuNIsdnCiYfZLoKbG
         SZueGTgZBPRNJXDt3QhqtmoKJiKqTxIwYF1CwlZDhgRpfsBrjUuItAMX5hfYAraGPrzv
         cHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFgUVH3F8T3JjFWUP1NLsmrvcMsZDEQTEOvmoo1k26c=;
        b=Yma6EdKefQQy5IQTn+CXz64tQh0Eqv4hUXTTfk8JeDyc5sZcm09hnoQuoncg26yalu
         3MTgk05V0b1+vESx2B1X6eBk3VyYDy4LefYFhoSxhqs1J0ZwxQb3zvFe134qIBngFGi2
         RQl35YeJ28njf9ZSsF8olOLNV0I+5yruYAaxDz6oCyOhd6kmIx44r+oYLtgbig91NmqO
         HNBcHzuYnk44rd/SoRWJP8k9/LVIlE/o6LHKuTs+0kcm8bmEygUsU1ad4/tzWUTQMQ7w
         lldWWuMEtPNP4e581kiKFSTDCxn6jDGPXz60y5YQ9S31QlhSLdLApZLLDSnEhPje/uBJ
         S+AQ==
X-Gm-Message-State: APzg51Dj3Yuz9OJ8upY7n7nlrG/5KZSWSpUTy230YwCx8rQvkg9QdZvP
        Iu/A5XzjQdhtpjYY2XPXOyt64ZzlbN7XOhd4IPDsUj3tf8o=
X-Google-Smtp-Source: ANB0VdYNXbY+kBzjHePUktU0/tvAZPVV+A0q0JrtbBRVENh0sw9kGkfWHFSjNzt+ORfxRvBn3jurMv5d8g6u8Olv0yQ=
X-Received: by 2002:a62:d44a:: with SMTP id u10-v6mr31816615pfl.144.1536706448759;
 Tue, 11 Sep 2018 15:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180911225221.54513-1-venture@google.com>
In-Reply-To: <20180911225221.54513-1-venture@google.com>
From:   Patrick Venture <venture@google.com>
Date:   Tue, 11 Sep 2018 15:53:57 -0700
Message-ID: <CAO=notyaxeCuAxHTBYw=J6ZzJoObd_EPdnDVh+4OYqhDsJvjyA@mail.gmail.com>
Subject: Re: [PATCH] ipmi: looped device detection
To:     Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 3:52 PM Patrick Venture <venture@google.com> wrote:
>
> Try to get the device ID repeatedly during initialization before giving up.
> The BMC isn't always responsive, and this allows it to be slightly flaky
> during early boot.
>
> Tested: Installed on a system with the BMC software disabled
> such that it was non-responsive.  The driver correctly detected this
> and gave up as expected.  Then I re-enabled the BMC software unloaded
> and reloaded the driver and it was detected properly.
>
> Signed-off-by: Patrick Venture <venture@google.com>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 90ec010bffbd..a1ca34af7698 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -1918,11 +1918,14 @@ int ipmi_si_add_smi(struct si_sm_io *io)
>   * held, primarily to keep smi_num consistent, we only one to do these
>   * one at a time.
>   */
> +#define GET_DEVICE_ID_ATTEMPTS 5
>  static int try_smi_init(struct smi_info *new_smi)
>  {
>         int rv = 0;
>         int i;
>         char *init_name = NULL;
> +       bool platform_device_registered = false;

platform_device_registered -- looks like I accidentally included a
variable from my branch.

> +       unsigned long sleep_rm;
>
>         pr_info(PFX "Trying %s-specified %s state machine at %s address 0x%lx, slave address 0x%x, irq %d\n",
>                 ipmi_addr_src_to_str(new_smi->io.addr_source),
> @@ -2003,7 +2006,26 @@ static int try_smi_init(struct smi_info *new_smi)
>          * Attempt a get device id command.  If it fails, we probably
>          * don't have a BMC here.
>          */
> -       rv = try_get_dev_id(new_smi);
> +       for (i = 0; i < GET_DEVICE_ID_ATTEMPTS; i++) {
> +               pr_info(PFX "Attempting to read BMC device ID\n");
> +               rv = try_get_dev_id(new_smi);
> +               /* If it succeeded, stop trying */
> +               if (!rv)
> +                       break;
> +
> +               /* Sleep for ~0.25s before trying again instead of hammering
> +                * the BMC.
> +                */
> +               sleep_rm = msleep_interruptible(250);
> +               if (sleep_rm != 0) {
> +                       pr_info(PFX "Find BMC interrupted\n");
> +                       rv = -EINTR;
> +                       goto out_err;
> +               }
> +       }
> +
> +       /* If we exited the loop above and rv is non-zero we ran out of tries.
> +        */
>         if (rv) {
>                 if (new_smi->io.addr_source)
>                         dev_err(new_smi->io.dev,
> --
> 2.19.0.rc2.392.g5ba43deb5a-goog
>
