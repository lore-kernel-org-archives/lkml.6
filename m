Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A9BC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 12:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4675E22516
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 12:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4675E22516
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbeGAMI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 08:08:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37097 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbeGAMI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 08:08:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id n17-v6so6076460wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 05:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xQMOTcJmEYaCMQWqm7vvIfPMZUTHX4rIq6Eg8fIL0EI=;
        b=e0Zq3Mm9BpRBgjRnk6A2bzs3Dvy1mkeIxkEUonPEcS+hINc0Q1wY5+OuqeDZgQ8HLg
         ECrhFLWBX7jR62q2kOpygSD2Wog0F9Thu/QchFk+r4IDcs3X5E0uZXIKBTH4Ku7cJkZX
         5xUqlQp1ikQSTpWIUmoJrqXAW1rj9j3wHvNu8mplELi6jw0lqgcq7JPJyDAORKvvnqEx
         SvgevKuwZDvzMGqwOZGsa1MTTfTlOuzLLVOdtpmSMcDhLi/oNBQ5ujGQ/Zlh9B+0kO5P
         t5MLudtd7pH6OcKmCtinyvhu6uqxYRV9NdSL+cYlPbPzeGb/6UjY/loHmTmfXVujmR7j
         eFig==
X-Gm-Message-State: APt69E2psZea8VK6pH41XFGgg7XAlNVlEsmiP/Z+VjWNdrbMNN+9sbG3
        JqmIV/BJDK4Grbp5gUuuyKU4YLNOh68=
X-Google-Smtp-Source: AAOMgpd5maLdXrTVI2dNavLUR846QTYXa8RIX28Du75PZYnSzLISIc7tyuRYtOMW+EBDQuh7ydq7BA==
X-Received: by 2002:a1c:9042:: with SMTP id s63-v6mr4247240wmd.91.1530446935342;
        Sun, 01 Jul 2018 05:08:55 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 74-v6sm10474549wmt.31.2018.07.01.05.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 05:08:54 -0700 (PDT)
Subject: Re: [PATCH 0/8] usb: typec: Support for Alternate Modes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3941ff88-b929-4aa6-f40a-7c1b511afdd3@redhat.com>
Date:   Sun, 1 Jul 2018 14:08:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27-06-18 17:19, Heikki Krogerus wrote:
> Hi,
> 
> Since we now have an implementation for an actual alternate mode (DisplayPort),
> I guess there is no reason to send another RFC. This series is the same as the
> last RFC proposal [1] with only minor changes. There were only a few comments.
> 
> [1] https://lkml.org/lkml/2018/6/8/225
> 
> I've tested these with a platform that has fusb302, and also with UCSI
> platforms. The UCSI driver will need separate support for alternate modes that
> I'm not including to this series. I'm still working on it. I've used various
> DisplayPort to Type-C adapters for testing, both DisplayPort receptacles and
> connectors.

I've tested that this series does not cause any regression wrt
PD or susperspeed host and gadget mode on a device with a fusb302 controller:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> 
> 
> Heikki Krogerus (8):
>    usb: pd: include kernel.h
>    usb: typec: function for checking cable plug orientation
>    usb: typec: mux: Get the mux identifier from function parameter
>    usb: typec: Register a device for every mode
>    usb: typec: Bus type for alternate modes
>    usb: typec: Add driver for DisplayPort alternate mode
>    usb: typec: pi3usb30532: Start using generic state values
>    usb: typec: tcpm: Support for Alternate Modes
> 
>   Documentation/ABI/obsolete/sysfs-class-typec  |  48 ++
>   Documentation/ABI/testing/sysfs-bus-typec     |  51 ++
>   Documentation/ABI/testing/sysfs-class-typec   |  62 +-
>   .../testing/sysfs-driver-typec-displayport    |  49 ++
>   Documentation/driver-api/usb/typec_bus.rst    | 136 +++++
>   MAINTAINERS                                   |  11 +-
>   drivers/usb/typec/Kconfig                     |   2 +
>   drivers/usb/typec/Makefile                    |   3 +-
>   drivers/usb/typec/altmodes/Kconfig            |  14 +
>   drivers/usb/typec/altmodes/Makefile           |   2 +
>   drivers/usb/typec/altmodes/displayport.c      | 578 ++++++++++++++++++
>   drivers/usb/typec/bus.c                       | 401 ++++++++++++
>   drivers/usb/typec/bus.h                       |  38 ++
>   drivers/usb/typec/class.c                     | 486 ++++++++++-----
>   drivers/usb/typec/mux.c                       |   6 +-
>   drivers/usb/typec/mux/pi3usb30532.c           |  13 +-
>   drivers/usb/typec/tcpm.c                      | 188 ++++--
>   include/linux/mod_devicetable.h               |  15 +
>   include/linux/usb/pd.h                        |   1 +
>   include/linux/usb/tcpm.h                      |   9 -
>   include/linux/usb/typec.h                     |  52 +-
>   include/linux/usb/typec_altmode.h             | 160 +++++
>   include/linux/usb/typec_dp.h                  |  95 +++
>   include/linux/usb/typec_mux.h                 |   2 +-
>   scripts/mod/devicetable-offsets.c             |   4 +
>   scripts/mod/file2alias.c                      |  13 +
>   26 files changed, 2116 insertions(+), 323 deletions(-)
>   create mode 100644 Documentation/ABI/obsolete/sysfs-class-typec
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-typec
>   create mode 100644 Documentation/ABI/testing/sysfs-driver-typec-displayport
>   create mode 100644 Documentation/driver-api/usb/typec_bus.rst
>   create mode 100644 drivers/usb/typec/altmodes/Kconfig
>   create mode 100644 drivers/usb/typec/altmodes/Makefile
>   create mode 100644 drivers/usb/typec/altmodes/displayport.c
>   create mode 100644 drivers/usb/typec/bus.c
>   create mode 100644 drivers/usb/typec/bus.h
>   create mode 100644 include/linux/usb/typec_altmode.h
>   create mode 100644 include/linux/usb/typec_dp.h
> 
