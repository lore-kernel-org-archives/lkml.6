Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB9BC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CF8214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBYGwup4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CF8214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeJQJy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:54:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42667 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeJQJy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:54:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id c8-v6so11867195plo.9;
        Tue, 16 Oct 2018 19:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q7+PbnMvoyetgGp3wV/YhTZ/rXs3vFfSTLZJ4DH4+VY=;
        b=XBYGwup4Ii4uF4Mr2fN/f+EieUw1EwPQnStEUvd8PXxJP8nIj54YzPDjQJJ5ImtgLE
         bnlYWiRa4okqNWE/iytaNCktXyKPRg0zYRzT9mUf+pQDlYWO92RQYI3KBJtsT+JY+q0V
         R3Cms+xlsfe7uYHV6X8z9+UIozYuHB/Jk8SwWLyhbRg5pAHCsvH69f7KW6UfVNJdchBI
         t2vxL8njU11+zs6sGKKw/lDXsjDHTuPGZZJKyGTuCGrynSUilu9hECE0ktkeeNx/FGiu
         sYYolv0Wcsda91dq7zUHREWwO/fa+/Iuzw8SOxoHEZS0BkDpqFYBX5R7IKQq7iBxFDds
         takQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q7+PbnMvoyetgGp3wV/YhTZ/rXs3vFfSTLZJ4DH4+VY=;
        b=skandd8vqdmig6uX2OzlaExs2Ybr48XwTFllKVOu0O/L8y3bj5Z5V4Yt1ZBiZOSb4d
         /cQx/esYhCEfxbSwE/V//rwxXrpj+26MwSr8oJzqcPVGqfAHIQHoXxVKwAEbaYnZf/TW
         6Eat4JChWE3ISov345WHu7tM6uSOaInt+xKNn0WV+9QWv7y7eVPxvakgHOlpOUv3TEE5
         ni6dzEp9Lq8R9+QoGgve5lY8lgTf9+K4FvUozB4u1JCanZkY3cUZe2i3ZuH18ZMjk0+c
         pNqwkWWucljcktLZcob9lLHIbKmExNH38kFB4ZNK/cpeLnAXDstwN1yd0UU/GYa9AJ/8
         J8MA==
X-Gm-Message-State: ABuFfohkaHGvC3er2hILEF1tGZHR+JWvvKVtadJLQ91fOL77LFC1CF0n
        BcHpPsNNZxe5hQjY3w22Edw=
X-Google-Smtp-Source: ACcGV60NIXvldayeAu8WoEXCaCeqic4ICWyVSIWEeVYQWlmyB4yvjyr4dkKX/FnHGyWa023AKGP7gg==
X-Received: by 2002:a17:902:9a45:: with SMTP id x5-v6mr23792979plv.213.1539741669626;
        Tue, 16 Oct 2018 19:01:09 -0700 (PDT)
Received: from icarus ([2001:268:c0a4:1899:c8a2:53ea:c386:fc53])
        by smtp.gmail.com with ESMTPSA id p1-v6sm18095772pff.128.2018.10.16.19.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 19:01:09 -0700 (PDT)
Date:   Wed, 17 Oct 2018 11:01:17 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org
Subject: Re: [PATCH v9 00/11] Introduce the Counter subsystem
Message-ID: <20181017020117.GB3307@icarus>
References: <cover.1532298882.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1532298882.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 06:49:49PM -0400, William Breathitt Gray wrote:
> Changes in v9:
>  - Prefix exported symbols with "counter_" to make counter namespace
>    explicit and clear
>  - Replace scnprintf and snprintf lines with sprintf in 104-quad-8.c
>    since we're dealing with sysfs files
> 
> This revision is functionally identical to the last; changes in this
> version were made to improve code clarity. Andrew Morton suggested
> improving the names of the exported symbols to clean up the Counter
> subsytem namespace. This revision adds a "counter_" prefix to the
> exported symbols to keep the namespace tidy and these symbols as
> clearly part of the Counter subsystem.
> 
> Andrew Morton also brought up a good point that the Generic Counter
> "signal" terminology could conflict with the existing established use of
> the term in other areas of the Linux kernel. I've changed the major
> exported symbols in counter.h that used the "signal_" naming covention
> to now use a "counter_signal_" naming convention in order to help
> prevent this confusion; I've made similar changes to symbols in
> counter.c as well. If this naming still causes trouble, we can consider
> alternative names for this component.
> 
> William Breathitt Gray
> 
> Benjamin Gaignard (2):
>   counter: Add STM32 Timer quadrature encoder
>   dt-bindings: counter: Document stm32 quadrature encoder
> 
> Fabrice Gasnier (2):
>   counter: stm32-lptimer: add counter device
>   dt-bindings: counter: Adjust dt-bindings for STM32 lptimer move
> 
> William Breathitt Gray (7):
>   counter: Introduce the Generic Counter interface
>   counter: Documentation: Add Generic Counter sysfs documentation
>   docs: Add Generic Counter interface documentation
>   iio: 104-quad-8: Update license boilerplate
>   counter: 104-quad-8: Add Generic Counter interface support
>   counter: 104-quad-8: Documentation: Add Generic Counter sysfs
>     documentation
>   iio: counter: Add deprecation markings for IIO Counter attributes
> 
>  Documentation/ABI/testing/sysfs-bus-counter   |  230 +++
>  .../ABI/testing/sysfs-bus-counter-104-quad-8  |   36 +
>  Documentation/ABI/testing/sysfs-bus-iio       |    8 +
>  .../testing/sysfs-bus-iio-counter-104-quad-8  |   16 +
>  .../{iio => }/counter/stm32-lptimer-cnt.txt   |    0
>  .../bindings/counter/stm32-timer-cnt.txt      |   31 +
>  .../devicetree/bindings/mfd/stm32-lptimer.txt |    2 +-
>  .../devicetree/bindings/mfd/stm32-timers.txt  |    7 +
>  Documentation/driver-api/generic-counter.rst  |  342 ++++
>  Documentation/driver-api/index.rst            |    1 +
>  MAINTAINERS                                   |   15 +-
>  drivers/Kconfig                               |    2 +
>  drivers/Makefile                              |    1 +
>  drivers/{iio => }/counter/104-quad-8.c        |  782 +++++++-
>  drivers/counter/Kconfig                       |   51 +
>  drivers/{iio => }/counter/Makefile            |    5 +-
>  drivers/counter/counter.c                     | 1567 +++++++++++++++++
>  drivers/{iio => }/counter/stm32-lptimer-cnt.c |  361 +++-
>  drivers/counter/stm32-timer-cnt.c             |  390 ++++
>  drivers/iio/Kconfig                           |    1 -
>  drivers/iio/Makefile                          |    1 -
>  drivers/iio/counter/Kconfig                   |   34 -
>  include/linux/counter.h                       |  510 ++++++
>  include/linux/counter_enum.h                  |   45 +
>  24 files changed, 4352 insertions(+), 86 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
>  rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)
>  create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
>  create mode 100644 Documentation/driver-api/generic-counter.rst
>  rename drivers/{iio => }/counter/104-quad-8.c (44%)
>  create mode 100644 drivers/counter/Kconfig
>  rename drivers/{iio => }/counter/Makefile (46%)
>  create mode 100644 drivers/counter/counter.c
>  rename drivers/{iio => }/counter/stm32-lptimer-cnt.c (48%)
>  create mode 100644 drivers/counter/stm32-timer-cnt.c
>  delete mode 100644 drivers/iio/counter/Kconfig
>  create mode 100644 include/linux/counter.h
>  create mode 100644 include/linux/counter_enum.h
> 
> -- 
> 2.18.0

Hi Greg,

It's been some time now since this patchset was submitted so I want to
check up and see if I should try to merge it in through IIO or some
other subsystem, or wait for now for additional reviews.

Sincerely,

William Breathitt Gray
