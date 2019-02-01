Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04048C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C995C2184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qumk52IC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfBAITL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:19:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39985 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfBAITK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:19:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so6042666wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 00:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Xxx3SJUj8WuBKt/vTDDpw7v5T8KacH3WTFfYyIpiM6Y=;
        b=Qumk52ICGPx/vGLQypWFGQCzvGMRcMbvDSdeIwls1huRsvQZOHZVWr7b3+nQgqKXmz
         EN7eTUgJ8kkc78YUKXLAw7Rt7Ec9VmHQzBFQWiEK4TXEGBMzIvxZodTsMstPoGNdbGPZ
         xG1trHO01QIF/xEhg+0yzmyW4vbSmA02RQSsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Xxx3SJUj8WuBKt/vTDDpw7v5T8KacH3WTFfYyIpiM6Y=;
        b=TO9Dm9aplCINLK6xta+kXW0V6eiFqtCGdsNYfoCa7MRdyobzoQHE5hhWNOZCBf+fIJ
         ULnYdrDOqlsLh4zp6eEbO+nOGf717RuEUTc5JsjTaigZ2FO691raNUCq2DD3rE2I/FL2
         jiKLax9MuRj0jHHMwcJg/pwCAUhysNTlDIoLJZkVM8/new4zYyppP6BU+GuKytLsOgJw
         XFzw0upqb1tzPIl0cN5vv1iXSnENRGekKIcWxKVKo2n90LZb8vXTEvNlm25KuHmQGnQv
         9uLdUu+lBAWcwtwAi9InI558B/Xh9d5nCt5dDx5v6amRKzqOrnbhPqW+cp8EM/SUXnua
         mTeg==
X-Gm-Message-State: AJcUukdXMpuUgM7H8C9184+B7D8g2QVSP+z3Q7eFMUTFz6aRIW/IBpT7
        4/ui4o41omJtSiS1sdQpHbNUHQ==
X-Google-Smtp-Source: ALg8bN7qr58kbDKKyXQox8xCJGJSwsxavhaQEpf3Dts4ZBjp8XKatdT783lajCFp9+O2kHMCOrPDPQ==
X-Received: by 2002:adf:8544:: with SMTP id 62mr39213379wrh.1.1549009148688;
        Fri, 01 Feb 2019 00:19:08 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id h184sm2922624wmf.0.2019.02.01.00.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 00:19:08 -0800 (PST)
Date:   Fri, 1 Feb 2019 08:19:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v5 0/7] mfd / platform: cros_ec: move cros_ec sysfs
 attributes to its own drivers.
Message-ID: <20190201081906.GB783@dell>
References: <20181212173402.27086-1-enric.balletbo@collabora.com>
 <20190116085124.GC23399@dell>
 <CAFqH_51Mk7_bK8vw8yuUPpvEouAwQjXEGW9JFqH1S4U9Ndr3+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_51Mk7_bK8vw8yuUPpvEouAwQjXEGW9JFqH1S4U9Ndr3+Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019, Enric Balletbo Serra wrote:
> Missatge de Lee Jones <lee.jones@linaro.org> del dia dc., 16 de gen.
> 2019 a les 19:31:
> > On Wed, 12 Dec 2018, Enric Balletbo i Serra wrote:
> > > This is another patchset to try to cleanup a bit more the crossed
> > > references for cros-ec driver between the MFD and the platform/chrome
> > > subsystems.
> > >
> > > The purpose of these patches is get rid of the different cros-ec attributes
> > > from mfd/cros_ec_dev to its own sub-driver in platform/chrome. cros_ec_dev
> > > continues instantiating the sub-devices but the sysfs attributes are owned
> > > by the platform driver.E.g. The lightbar driver should own his sysfs
> > > attributes and be instantiated only if the Embedded Controller has a
> > > lightbar.
> > >
> > > The patchset also adds the documentation of the sysfs attributes.
> > >
> > > Most of the patches touches mfd subsystem and platform/chrome so I'd
> > > suggest go all using and inmutable branch.
> > >
> > > Best regards,
> > >  Enric
> >
> > [...]
> >
> > > Enric Balletbo i Serra (7):
> > >   mfd / platform: cros_ec: use devm_mfd_add_devices
> > >   mfd / platform: cros_ec: move lightbar attributes to its own driver
> > >   mfd / platform: cros_ec: move vbc attributes to its own driver
> > >   mfd / platform: cros_ec: move debugfs attributes to its own driver
> > >   mfd / platform: cros_ec: move device sysfs attributes to its own
> > >     driver
> > >   mfd / platform: cros_ec_vbc: instantiate only if the EC has a VBC
> > >     NVRAM
> > >   platform/chrome: cros_ec_lightbar: instantiate only if the EC has a
> > >     lightbar
> >
> > These patches have been applied to my local MFD tree.  It will be
> > pushed when 5.0-rc3 has been released.  The MFD tree needs rebasing
> > onto it since it contains all of the MFD patches due for v5.0.
> 
> Do you mind to push the patches in your tree, I've some patches that
> depend on these to apply cleanly and I'd like to base my branch on top
> of yours.

Thanks for the reminder.  Will send it 1 min.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
