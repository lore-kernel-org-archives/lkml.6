Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3258100-1518625534-2-9250985356673170841
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518625533; b=hZCHvn7uQPb1oBMDSx//P3jiADBPXBrsVuNeN8NkoaZ87Dt
    sPM6zUNxUa3zLPGpRsESqa4Kz/xOzIP2hWjzm+lUIYhoEAB83NmFcMd1zGZ7dTMQ
    OsARPKouaq1tOFDrZ5mBRzdHFwj32pflYqF4R1hmvUerLpaytkDtGri/VyCiKY1f
    Y09g3jxaFFny+zqobTxp5+IskXi4hWHOWZuQC7ioIYAskWKA4ggkYt07hR2Z52Cp
    dBsmLwz3v6Wh0PNPSEWusS3LZeJE/Kzzit2qKi/G9E7zR6RKcjFTxsyosyCIJj1V
    7PZrIJN3OgtHxibXoJT7+a0eteyl4ffO2ObLvAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518625533; bh=sgOA5e8c2GU5xitG8Xp/di5beQQu2zR9XhVMYh
    YQo3U=; b=Qk0XLkJtxGVj0M3HPgMMR8rY2ZW/1skVP0jijY47q7Mgwfyj/gx/H0
    +cns57xd6jAQ1BFhIHpKpaOU93d8XkHJCT2pf5B0TdA4zqPJCh4aVqUkEAqmB1+X
    PJii+3rWD9hy0ujGyGorsGIojoqZI/tTU5QzpDUs4jlpS2Xt4gPCWi5IvRcPLX/q
    XgRvUIbq1he8C45QRAze5edfYA0utWStlPzQ2lAEMueu2C6tP0Ip08ANyDtY1Vy5
    4c9igrbNyD0ht8arQzSwvCEi7M/1kSByLxPkVivbBlcmqgeHTyW4SNrleOlrIh8p
    9Iiiz6D+1kfKqOSUZVmsXYzMGLTr9s2g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032411AbeBNQZb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 11:25:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:41210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032204AbeBNQZ3 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 14 Feb 2018 11:25:29 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1983D217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AH8x224l5cGp2G11FdaPj/nJ4Kj2wFe5VqyT4HuKq1TtYJYjH+PuEL6uAP9uuB+ou+SD59l004Et2g4eQPryHKeLHTk=
MIME-Version: 1.0
In-Reply-To: <1518513893-4719-7-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com> <1518513893-4719-7-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 14 Feb 2018 10:24:47 -0600
X-Gmail-Original-Message-ID: <CANk1AXQgeeQm_ncn+17nrjr+YTCKvpc=PVZEsaZVOjRb3aHTQQ@mail.gmail.com>
Message-ID: <CANk1AXQgeeQm_ncn+17nrjr+YTCKvpc=PVZEsaZVOjRb3aHTQQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/24] fpga: dfl: adds fpga_cdev_find_port
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

> For feature devices, we need a method to find the port dedicated
> to the device. This patch adds a function fpga_cdev_find_port
> for this purpose. e.g FPGA Management Engine (FME) Partial
> Reconfiguration sub feature, it uses this function to find
> dedicated port on the device for PR function implementation.

OK, that is very clear now, thanks!  Ack with the minor doc changes below.

>
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>

> ---
> v3: s/fpga_for_each_port/fpga_cdev_find_port/
>     move fpga_cdev_find_port to fpga-dfl module.
> v4: improve description in commit message.
>     add comments to remind user to put_device after use this function.
> ---
>  drivers/fpga/dfl.c | 34 ++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl.h | 20 ++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index dcfe5ab..38dc819 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -783,6 +783,40 @@ void fpga_remove_feature_devs(struct fpga_cdev *cdev)
>  }
>  EXPORT_SYMBOL_GPL(fpga_remove_feature_devs);
>
> +/**
> + * __fpga_cdev_find_port - find a port under given container device
> + *
> + * @cdev: container device
> + * @data: data passed to match function
> + * @match: match function used to find specific port from the port device list
> + *
> + * Find a port device under container device. This function needs to be
> + * invoked with lock held.
> + *
> + * This function returns NULL if the device doesn't match and non-zero if it
> + * does.

Good but this would be more brief and more specific and more in line
with recommended format in Documentation/kernel-doc-nano-HOWTO.txt:

 * Return: pointer to port's platform device if successful, NULL otherwise.

> If this function returns non-zero and a reference to the platform
> + * device of port can be obtained.

This if..then type sentence is not complete (missing the 'then' part).
I see where you might have gotten inspiration for it from core.c.
Probably you could just delete the sentence and all would be clear.

> + *
> + * NOTE: you will need to drop the device reference with put_device() after use.
> + */

Good

Thanks,
Alan

> +struct platform_device *
> +__fpga_cdev_find_port(struct fpga_cdev *cdev, void *data,
> +                     int (*match)(struct platform_device *, void *))
> +{
> +       struct feature_platform_data *pdata;
> +       struct platform_device *port_dev;
> +
> +       list_for_each_entry(pdata, &cdev->port_dev_list, node) {
> +               port_dev = pdata->dev;
> +
> +               if (match(port_dev, data) && get_device(&port_dev->dev))
> +                       return port_dev;
> +       }
> +
> +       return NULL;
> +}
> +EXPORT_SYMBOL_GPL(__fpga_cdev_find_port);
> +
>  int fpga_port_id(struct platform_device *pdev)
>  {
>         void __iomem *base = get_feature_ioaddr_by_id(&pdev->dev,
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 9b19399..d6ecda1 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -356,4 +356,24 @@ struct fpga_cdev {
>  struct fpga_cdev *fpga_enumerate_feature_devs(struct fpga_enum_info *info);
>  void fpga_remove_feature_devs(struct fpga_cdev *cdev);
>
> +/*
> + * need to drop the device reference with put_device() after use port platform
> + * device returned by __fpga_cdev_find_port and fpga_cdev_find_port functions.
> + */
> +struct platform_device *
> +__fpga_cdev_find_port(struct fpga_cdev *cdev, void *data,
> +                     int (*match)(struct platform_device *, void *));
> +
> +static inline struct platform_device *
> +fpga_cdev_find_port(struct fpga_cdev *cdev, void *data,
> +                   int (*match)(struct platform_device *, void *))
> +{
> +       struct platform_device *pdev;
> +
> +       mutex_lock(&cdev->lock);
> +       pdev = __fpga_cdev_find_port(cdev, data, match);
> +       mutex_unlock(&cdev->lock);
> +
> +       return pdev;
> +}
>  #endif /* __FPGA_DFL_H */
> --
> 2.7.4
>
