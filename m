Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1097286-1521676544-2-7028645698661859639
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521676544; b=hbjEGoof4Qvu8o7AxbqN6kl6mI3GpuZ7NAMqsBCmY+1UwYi
    o/MoUzEr5Xg/k1Qyq7aZbbhxEYeyYavp62pfG7lYMWpstUJg/a7RhbKsMshWGzF5
    3A2lwQEA/Y6UtXKp+8VLb5hvV+H4B3tgGsWFKcvnHWRVWk8MYmHez4IOcS7Dw2S7
    HR4kqvi0LXANTQi6m23cqjcGMtDNhdHlkWfJjV877xLyz+b5OZOwbClISNgz4rRd
    b1bmao5BuM0bICvQkPPdBgw4hbBPWDzXQzWLXWf2WfLBEptyb6fF4nk/79cGdsMN
    BP4WPy1nUi56SlFPNRXNrsNynYbmLlHXb2X9LEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521676544; bh=Q5IYsg41EkyZvZJ/kZuFSTi9seW4TGhiYro4gV
    Kn580=; b=mWxdM6WRnEp/RI6LhxtYpM76mUONXkXFgFgDfhxgZEdbNZUqfj40WB
    ZmQjg69wxC9kyNGTUdM18snm9sWPJ9GTbWU7CoTMCxSlTHkVwHPmZdAq2X99ijKy
    gKQCcPqbJ5jCzSprJGrnakJz393nhk3L5VJHEZ8ZkK9GC/iM1ojFFqUprz8LV9ar
    AHzBRqOLkIsANdqY+hnaUL2cyqQyZ0tPl5jxhjAagPg2KqxIgd5ZDrEQMZW5hhsc
    rtrUT8f1ftvt8lYBTxTdcgSedo4j2fGOpYC3UHpf0d57G+ajXY+0FSh9gSBOmZgx
    e6nDI5e6NTRSpc0fF7wZFUPXziT4fGpA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbeCUXzl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 19:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753793AbeCUXzk (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 21 Mar 2018 19:55:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0371217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AG47ELurqlD4oipoHZTFTIuZrzeu173SSmwvpOE1ctHfEwIxZqSOx5yDrifl2mAnKvAnzs7saTxpcXJuij4ZrrkLI7Q=
MIME-Version: 1.0
In-Reply-To: <1518513893-4719-5-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com> <1518513893-4719-5-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 21 Mar 2018 18:54:58 -0500
X-Gmail-Original-Message-ID: <CANk1AXT0dBT9qejdbSyi75e956OHA0-y0V7de7H=XkOZzVhRqQ@mail.gmail.com>
Message-ID: <CANk1AXT0dBT9qejdbSyi75e956OHA0-y0V7de7H=XkOZzVhRqQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/24] fpga: add device feature list support
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

> +static int
> +build_info_create_dev(struct build_feature_devs_info *binfo,
> +                     enum fpga_id_type type, const char *name,
> +                     void __iomem *ioaddr)
> +{
> +       struct platform_device *fdev;
> +       int ret;
> +
> +       /* we will create a new device, commit current device first */
> +       ret = build_info_commit_dev(binfo);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * we use -ENODEV as the initialization indicator which indicates
> +        * whether the id need to be reclaimed
> +        */
> +       fdev = platform_device_alloc(name, -ENODEV);
> +       if (!fdev)
> +               return -ENOMEM;
> +
> +       binfo->feature_dev = fdev;
> +       binfo->feature_num = 0;
> +       binfo->ioaddr = ioaddr;
> +       INIT_LIST_HEAD(&binfo->sub_features);
> +
> +       fdev->id = alloc_fpga_id(type, &fdev->dev);
> +       if (fdev->id < 0)
> +               return fdev->id;

Do we need platform_device_put if returning here?

Alan

> +
> +       fdev->dev.parent = &binfo->cdev->region.dev;
> +
> +       return 0;
> +}
> +
