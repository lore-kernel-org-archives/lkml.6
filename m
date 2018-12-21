Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1E5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106BC218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V31N9hUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbeLUJKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:10:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51843 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeLUJKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:10:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so4574441wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HW/016T6/QYKCWOqXW+nYWGLg/GQFDX+vetcGJRNlJE=;
        b=V31N9hUDIVe7360BC6V0FcmUoN97iquhOi6QP0/IViwInRu4dcOvn8wz3DVM8DfDXu
         ZKtS+JQuPofj80/21Golb3ogE6T2lffIruZB+PV3YqqdwAyzx2UAY6+/1vijqDE3vRDM
         AAj2qbUT/vav85mTZgpSHLYx34zaNDbddM0hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HW/016T6/QYKCWOqXW+nYWGLg/GQFDX+vetcGJRNlJE=;
        b=FzDZuDCKVafM83BSNwWiotm4jVKJn+co9CcVMKTmqhg9+tOq4H+afHf5+CO9XqjCp3
         dQfkjJWwoieF6Udwo4tFDNrjncgvdPLWlv6lwfb6Gy6hXyLaW+lr6v4IgBsr7QPeJIuH
         AT0OUWaqK0OzjJ/hI35SEmkKIlkOw0+auMXz6vYKEwN5ttuhab/lBIKYqDCLFMsD9axF
         8AtTsgW3JJrsh+YeLZTAng9zQUzwZuaeawMV324B2VgMj6o2Akunvl7mXpM/Q5OuSwr1
         h4SHv4ZF7qixcjUdoaYWjHNQQO3WUqxdAw0l5vSjNBjnTCC8WJ3EPievwtCUsy78xq/p
         07mw==
X-Gm-Message-State: AJcUukdL2sTQqqAsSaeJ3dUY208dljcJ+FybijfMvdRsji5pQSEyYT/P
        Y08gxhbyzDEoAOoX9uEwGoqomg==
X-Google-Smtp-Source: ALg8bN5aKMiy9kSk0s92m4URvE6NTsn2AJ01j++3+nbWcEanq+9fyYia5Bs2pN7r72AeC0EKd2HHTw==
X-Received: by 2002:a1c:8d49:: with SMTP id p70mr2097512wmd.68.1545383403560;
        Fri, 21 Dec 2018 01:10:03 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id f15sm9053700wrt.10.2018.12.21.01.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 01:10:02 -0800 (PST)
Date:   Fri, 21 Dec 2018 09:10:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org
Subject: Re: [PATCH v5 0/7] mfd / platform: cros_ec: move cros_ec sysfs
 attributes to its own drivers.
Message-ID: <20181221091001.GA13248@dell>
References: <20181212173402.27086-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181212173402.27086-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018, Enric Balletbo i Serra wrote:

> Hi,
> 
> This is another patchset to try to cleanup a bit more the crossed
> references for cros-ec driver between the MFD and the platform/chrome
> subsystems.
> 
> The purpose of these patches is get rid of the different cros-ec attributes
> from mfd/cros_ec_dev to its own sub-driver in platform/chrome. cros_ec_dev
> continues instantiating the sub-devices but the sysfs attributes are owned
> by the platform driver.E.g. The lightbar driver should own his sysfs
> attributes and be instantiated only if the Embedded Controller has a
> lightbar.
> 
> The patchset also adds the documentation of the sysfs attributes.
> 
> Most of the patches touches mfd subsystem and platform/chrome so I'd
> suggest go all using and inmutable branch.

That's fine.

What else needs to happen with this set?

Any more Acks required?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
