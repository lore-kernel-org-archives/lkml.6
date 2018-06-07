Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CXyQKHZzGVundwAAmS7hNA
	; Thu, 07 Jun 2018 18:04:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 620DF6089E; Thu,  7 Jun 2018 18:04:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mdhqq6//"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EA69F601C3;
	Thu,  7 Jun 2018 18:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA69F601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935025AbeFGSEC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932520AbeFGSEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:04:00 -0400
Received: from mail-yw0-f171.google.com (mail-yw0-f171.google.com [209.85.161.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A47482089C;
        Thu,  7 Jun 2018 18:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528394639;
        bh=VpMHQlB3BjdQaoTgPeHsNVrv9C+7Dd5WvXEQhXbZc7I=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Mdhqq6//clAlBOGbh/SF86jQENjDOLHq3pG7ep8SKGSYz1KU1MZZicFmh57JPyHdE
         1pzDos6+IdHdVTvcLGwdSaICABVKYytcQFS+IFluhZqtBcp2D3VXs8nAefmfv280MK
         oMo4UP+nejbpPs3j9PKlgSsxTq10xL8N0N1lIUoE=
Received: by mail-yw0-f171.google.com with SMTP id v190-v6so3286657ywa.12;
        Thu, 07 Jun 2018 11:03:59 -0700 (PDT)
X-Gm-Message-State: APt69E2+ZXTutlpv4rL/K4P0d09ElbqCFTK2eVGHYZPe5K0N5HUdE+Em
        HXaWnre50Le+fixfrchWhzaG694kv/dcJ5DHi2I=
X-Google-Smtp-Source: ADUXVKJpVnmnvECCqSXd//3d7pmv69p43pIOopubDe8G1jcCKPsm3A5eswkxzALgAgh7O58x9P8AkM1oW5cabGgoRUg=
X-Received: by 2002:a81:a0d0:: with SMTP id x199-v6mr1709923ywg.483.1528394638880;
 Thu, 07 Jun 2018 11:03:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:b87:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 11:03:18 -0700 (PDT)
In-Reply-To: <20180606122457.GB7681@hao-dev>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
 <1525229431-3087-8-git-send-email-hao.wu@intel.com> <CANk1AXRQx=QtwmSKuWiGprMcfjNnUWcBHNy-hTfP+JaQZsJLLA@mail.gmail.com>
 <20180606122457.GB7681@hao-dev>
From: Alan Tull <atull@kernel.org>
Date: Thu, 7 Jun 2018 13:03:18 -0500
X-Gmail-Original-Message-ID: <CANk1AXTmpa1P55qCwZhyn=CGoa3v_hJ-KFCQsy7kMTBpULc6hQ@mail.gmail.com>
Message-ID: <CANk1AXTmpa1P55qCwZhyn=CGoa3v_hJ-KFCQsy7kMTBpULc6hQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/28] fpga: dfl: add chardev support for feature devices
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 7:24 AM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

One more...

>> > +static dev_t dfl_get_devt(enum dfl_fpga_devt_type type, int id)
>> > +{
>> > +       WARN_ON(type >= DFL_FPGA_DEVT_MAX);
>> > +
>> > +       return MKDEV(MAJOR(dfl_chrdevs[type].devt), id);
>> > +}
>> > +
>> > +/**
>> > + * dfl_fpga_register_dev_ops - register cdev ops for feature dev
>> > + *
>> > + * @pdev: feature dev.
>> > + * @fops: file operations for feature dev's cdev.
>> > + * @owner: owning module/driver.
>> > + *
>> > + * Return: 0 on success, negative error code otherwise.
>> > + */
>> > +int dfl_fpga_register_dev_ops(struct platform_device *pdev,
>> > +                             const struct file_operations *fops,
>> > +                             struct module *owner)
>> > +{
>> > +       struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>> > +
>> > +       cdev_init(&pdata->cdev, fops);
>> > +       pdata->cdev.owner = owner;
>> > +
>> > +       /*
>> > +        * set parent to the feature device so that its refcount is
>> > +        * decreased after the last refcount of cdev is gone, that
>> > +        * makes sure the feature device is valid during device
>> > +        * file's life-cycle.
>> > +        */
>> > +       pdata->cdev.kobj.parent = &pdev->dev.kobj;
>> > +
>> > +       return cdev_add(&pdata->cdev, pdev->dev.devt, 1);
>> > +}
>> > +EXPORT_SYMBOL_GPL(dfl_fpga_register_dev_ops);
>> > +
>> > +/**
>> > + * dfl_fpga_unregister_dev_ops - unregister cdev ops for feature dev
>> > + * @pdev: feature dev.
>> > + */
>> > +void dfl_fpga_unregister_dev_ops(struct platform_device *pdev)
>> > +{
>> > +       struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>> > +
>> > +       cdev_del(&pdata->cdev);
>> > +}
>> > +EXPORT_SYMBOL_GPL(dfl_fpga_unregister_dev_ops);

How about dfl_fpga_dev_ops_register/unregister?

Thanks,
Alan
