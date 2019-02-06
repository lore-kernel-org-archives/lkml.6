Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCA2C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC2320823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zF47n9Cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfBFU6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:58:23 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45450 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfBFU6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:58:22 -0500
Received: by mail-ua1-f67.google.com with SMTP id e16so2736602uam.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 12:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W4ctc2JQ3t3vtf/g9zMb1HzjTFoyLHUHO4M9eqCT3fE=;
        b=zF47n9CsELeXEx7d92ZdJ+DMNPUE0mUD4HfP7Z0qjPcQrBOI+vKJE+GmppaoLEb3qC
         KZIbXwQaR1JXbnVyLCLogOr+qx/oy4ImLew5r8tzryI2S8F18FTc0TJ00Ig4ofj6Jnpg
         Cf+d8nn9Kx5tOC+ZMNrF6q5aHvr3TtaQ+TZamwZM+WWz8tQ9Fgv5P20oUnOOitnanDye
         r6ZVVKBwkVa4Qk4t4rsPBsWo1kHpQDw+6Xy20vYuaKlQk1eU51rpb31k2XW16Q6RnuJU
         stygbpuf0wzaIA6n4c5lNjqm4at1R7a9Qoox48iWOGHXs7eX7LlUFJOuorHRNSozcRGt
         dQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4ctc2JQ3t3vtf/g9zMb1HzjTFoyLHUHO4M9eqCT3fE=;
        b=pfwhHQ/oow815+Ha7YeJOXuOjPXLUloamsY4nVz+75FBYedu4MPDyb1a3anCsL2ua9
         vKdKi56HBng7boUl7i5+31IwwfUXMYnaY1eWfwzM/vXM4AdSi6Mvrsgu9ak3oKhcS2RI
         R2KVvRVJDr/KoDDIQxgTl//GTtaH4z5IblC1MWJ/bCe+z720IoxXT1QL0kHoiac2Mx8e
         vPTyZ7nxjWHMeJIGd2h0V5e4pmbA3fjQmFFteYjnyH7gyNEdx4SyA5RoTiDMosD1nC3P
         nrw0UIS9gPi6eZvc22wfjvESJymDchsN4AzFQk1qvEG82hzh5m871SoojkhWj3ur6U1q
         qkBQ==
X-Gm-Message-State: AHQUAua0kE9dUTWs0AsznA03m7yPs86+WS0CTQN4PaQ+CfFvS4H8X20C
        a7Fw9nMxCb01O1snRav2nXQURDwSSuCny8Vl6rEEvg==
X-Google-Smtp-Source: AHgI3IZyFtdmeX+mhRloXEAd+DCkr+x8TK9qv/hXANRV35OX3ZjeWgXlSyW6eXCehiCZSzf7EWakPIAtCgRVMwRzW/M=
X-Received: by 2002:ab0:7611:: with SMTP id o17mr4607883uap.22.1549486701252;
 Wed, 06 Feb 2019 12:58:21 -0800 (PST)
MIME-Version: 1.0
References: <20190130234051.2294-1-mike.leach@linaro.org>
In-Reply-To: <20190130234051.2294-1-mike.leach@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 6 Feb 2019 13:58:10 -0700
Message-ID: <CANLsYkxrCpbzjjJ6=pDezsdC0eXyJ01NKu5jBU13Y8G0cc8etg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Update AMBA driver for enhanced component ID spec.
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>, arm@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 at 16:40, Mike Leach <mike.leach@linaro.org> wrote:
>
> The latest ARM CoreSight specification updates the component identification
> requirements for all components attached to an AMBA bus. (ARM IHI 0029E)
>
> This specification defines bits 15:12 in the ComponentID (CID) value as the
> device class. Identification requirements now depend on this class.
> Class 0xF: Traditional components identified by Peripheral ID (PID) only.
> Class 0x9: CoreSight components may be identified by a Universal Component
> Identifier (UCI) consisting of the PID plus CoreSight DevType and DevArch
> values.
>
> Current and future ARM CoreSight IP will now use the same PID for
> components on the same function - e.g. the ETM, CTI, PMU and Debug elements
> associated with a core. The first core to use this UCI method is the A35,
> which currently has binding entries in the ETMv4 driver.
>
> This patchset prepares for the addition of the upcoming CTI driver, which
> will need to correctly bind with A35, and reported new devices that share
> PID for multiple components, while overcoming the limitation of binding by
> PID alone, which cannot now work.
>
> Patch 0001: Adds new UCI data structure and uses it with existing drivers
> that use private data field in amba_id. This fixes issue from prior set.
> Patch 0002: Implements the UCI matching code in the AMBA core code.
> Patch 0003: Update ETMv4 driver to use UCI as appropriate.
>
> Thanks
> Mike
>
> Tested on DB410, Juno; kernel 5.0-rc4
>
> Changes since v3:
> Fix UCI structure to allow CoreSight drivers to set private data. This
> fixes bug where none-UCI private data would cause a driver binding
> mismatch. (e.g. STM).
>
> Add CS_AMBA macros to simplify building AMBA ID tables, with and without
> UCI settings.
>
> Changes since v2:
> Simplification of amba_cs_uci_id_match().
> Fix CID class bitfield comments.
> Dropped RFC tag on patchset.
>
> Mike Leach (3):
>   drivers: amba: Updates to component identification for driver
>     matching.
>   drivers: amba: Update component matching to use the CoreSight UCI
>     values.
>   coresight: etmv4: Update ID register table to add UCI support
>
>  drivers/amba/bus.c                            | 45 +++++++++++++++----
>  drivers/hwtracing/coresight/coresight-etm3x.c | 44 ++++++------------
>  drivers/hwtracing/coresight/coresight-etm4x.c | 21 +++++----
>  drivers/hwtracing/coresight/coresight-priv.h  | 40 +++++++++++++++++
>  drivers/hwtracing/coresight/coresight-stm.c   | 14 ++----
>  drivers/hwtracing/coresight/coresight-tmc.c   | 30 ++++---------
>  include/linux/amba/bus.h                      | 39 ++++++++++++++++
>  7 files changed, 153 insertions(+), 80 deletions(-)

Reviewed-and-tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>

I am looking for guidance on how to proceed here.  Russell, can pickup
the AMBA bits in my coresight tree or perharps you'd prefer to see the
whole set added to the patch tracker?  Please let me know.

Thanks,
Mathieu


>
> --
> 2.19.1
>
