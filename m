Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5BCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600DD214FA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="oJCjEp8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600DD214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeJJKJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 06:09:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34635 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeJJKJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 06:09:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id y10-v6so2824633lfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 19:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rgrUYw0eHjqpzCTuzq4f1UOL6UvVlEvan1YJ2oBFEt8=;
        b=oJCjEp8+zzOuzfvRUtNfsec5d/MLseRmsHEsxq9hdNBLgVb2CFuxolv8mkQ0ipxFBH
         5TyOyG0NxWToHXEPuhZ4wYWc0L4lF8yG9nZCwu9B4ZFQck9ggkbOZE+M5ZyLFjvkCE6e
         Tewbm18bc3n7snhnWI3WPIxrKTIPG6M80I6Xn4n177vKe5ihILQ3+EYv04RUykVPi1Pm
         Mbli/ucb6PbK8gPx36yu3OCqYcJultUKA3C255+p24NVMK8hlXX2LX6KMO/rpH/PBr55
         ALbYCtDxQg29bJfni29wiY7tuo1vxmN+I+Yd+s/Eh5mVYGZ0VpusH02yh3xqad1CRx5Y
         iTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rgrUYw0eHjqpzCTuzq4f1UOL6UvVlEvan1YJ2oBFEt8=;
        b=mW4P/wwvEAPxpsHwFAruosUd+N9gKtNpFUNjt4eTU6PQtmYZ8+Ool429RDaiLPK4A3
         VcSi8jTXl7YzPucGxHOWrkHSErfITVpUX5zgDfl3UyLvU30aQdqnjbIiI1iWLfXCxzFa
         DDwtyPY4IR0Oa5wlZxbKv5CDX+ecNuA8pE+BdD7gXLr8H0L43KGOMWCuCypBWNhBhwEB
         sEb0BmUqNb138Yiqrw5O7YtA2vktHHgE7GMw74Z0nn8Uvh93hwKh/GyHMPhgxbjWCN5t
         p1nQb41x1D5MkmU94MKhk3pV+OQX6m6FdybPriHJQ9Yrdhn4hQ9PAt0wKaaaKpkwXAzF
         8WXA==
X-Gm-Message-State: ABuFfohNAnM4zIObuh+Oqs4lQtjBFFOdcXu5ckLqMZ+pH0y0GwscNWsu
        TB8j490Y7CW7MTB+pFDZ9ebXrpPE6MmQG07gac5BRw==
X-Google-Smtp-Source: ACcGV62VyVY5Ssdfd8wA0PKEu1xZWbGluCgGoLC86vWAHuJ0GlyhVb6pMPPoYBVjrc7P01wKRPRwneEMvYIYYTlsLFk=
X-Received: by 2002:a19:504e:: with SMTP id z14-v6mr8230487lfj.120.1539139758337;
 Tue, 09 Oct 2018 19:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <1539080245-25818-1-git-send-email-svellattu@mvista.com> <20181009110210.i6xphyuy5jkcfaug@katana>
In-Reply-To: <20181009110210.i6xphyuy5jkcfaug@katana>
From:   Silesh C V <svellattu@mvista.com>
Date:   Wed, 10 Oct 2018 08:19:06 +0530
Message-ID: <CALabi0EZPOeyvXdw-JUvtnVz2tQQbmhAKKrUXfuc7yzcudFArw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Driver core: add bus_find_device_by_fwnode
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wolfram,

On Tue, Oct 9, 2018 at 4:32 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Tue, Oct 09, 2018 at 03:47:24PM +0530, Silesh C V wrote:
> > Some drivers need to find the device on a bus having a specific firmware
> > node. Currently, such drivers have their own implementations to do this.
> > Provide a helper similar to bus_find_device_by_name so that each driver
> > does not have to reinvent this.
> >
> > Signed-off-by: Silesh C V <svellattu@mvista.com>
>
> Looks good in general, however:
>
> We recently had this discussion in I2C world about using the parent if
> the (logical) device has a NULL fw_node [1]. I don't know if the other
> subsystems you modify use logical devices as well? If no, it seems we
> need an additional check for the parent in the I2C core only. If yes,
> this might be considered in your patchset?

We can add an additional check for dev_fwnode(dev->parent) if match
for dev_fwnode(dev) fails in match_fwnode callback. Please correct me
if I am wrong. But then, we will be doing these two comparisons for
each device (until a match is found) on a bus for a bus_find_device
iteration(mostly unnecessarily because I could not find any "match
node" callbacks (for bus_find_device) currently doing this). So,
wouldn't it be better to add this check in exceptional cases (like in
the case of I2C) in the respective subsystems itself ?

Thanks,
Silesh
