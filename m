Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C267ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203C220858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IumnIef4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203C220858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeGUTRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:17:02 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:41486 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeGUTRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:17:02 -0400
Received: by mail-yb0-f196.google.com with SMTP id s8-v6so5840680ybe.8;
        Sat, 21 Jul 2018 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RMO/Ldkiln+6L5LfNkSoKkhokRJumbCHnWrzlXB91no=;
        b=IumnIef4DB4+aFPVEy3A4kiC19XM0zAkhqmbocl1NgUgLGq6z+suRxofg7HgkCwzGb
         yiF0e7MyUhqkLTGzrcRT9C3SrAiOhxXpRwSfJuR0BWOgwS6Yh3Kszz453VfbKDCLOlvJ
         ywFZ+jBjndC25FluufMwTpPyy5cj9K/KZsxkshrgHCGfHck2oVxAUbdzGhAKZgcktw/n
         WMEPWqnzOWG2EZ4cA0D9moI4nWoKvOsrTuP8mkxpe7OLX1lnRjh2wqtkkB77695fD3Dx
         /UXE3mTKOutAsqpRbxAkbIAnZRAO0QMxZtm6BPKjjJknceDSSjNM3VJz87q0sbmtatNg
         u0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RMO/Ldkiln+6L5LfNkSoKkhokRJumbCHnWrzlXB91no=;
        b=SzlYbgxY870UvwnZoOjhqsdwt4UEiXtZlLUqW2NjiIU4JVpMAreP3NS+R0GQoHFVgn
         4HR0pCKVnC+yGN6ijeg0KcFBJcwDDJ7mJvelj5hUNBiUk2ze5KgDUpJwpbDVDldTbdEq
         FsF9JFD5rnVQy54ir575o5nJIzxC+hderUOezzOB/7YcjzkGsXq7BYlk+ceioK8NHbEZ
         +DMAv9ItbSeLUxAGo+w9B4v/Yy8e5ihDTmkvhKtVYgnPo7jrvo9jwIXBMA/B+yTZpW1v
         NgU8EI/ZNKH9T5jBxuDZdql1wmah4MuOZRSu6h55V+XsPCCTm1M+VlbDTi/8FpQXCGc9
         eUOg==
X-Gm-Message-State: AOUpUlHFzjPsS7QKAaw/6foVzxPjF90+DpBrLt8oZ5lNvid32kEEbp2j
        1SE7XBwBI9VVfczd5h/qoOA=
X-Google-Smtp-Source: AAOMgpf+TCSKylegBiPJSVRd+lVxLSR+Yvy4dq8hmGhWk3Twgzl9aTakHgMEbq1fBRo9vThMf9PeqQ==
X-Received: by 2002:a25:13c2:: with SMTP id 185-v6mr2467408ybt.331.1532197403605;
        Sat, 21 Jul 2018 11:23:23 -0700 (PDT)
Received: from sophia ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id b135-v6sm4766275ywh.24.2018.07.21.11.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 11:23:22 -0700 (PDT)
Date:   Sat, 21 Jul 2018 14:23:09 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org
Subject: Re: [PATCH v8 00/11] Introduce the Counter subsystem
Message-ID: <20180721182202.GA17344@sophia>
References: <cover.1531685024.git.vilhelm.gray@gmail.com>
 <20180721190134.166e50ab@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180721190134.166e50ab@archlinux>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 07:01:34PM +0100, Jonathan Cameron wrote:
>On Sun, 15 Jul 2018 16:44:24 -0400
>William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>
>> Changes in v8:
>>  - Add counter_enum.h file
>>  - Simplify COUNTER Kconfig option help text
>>  - Rename generic-counter.c to the more straightforward counter.c
>>  - Update copyright and license boilerplate (use recommended SPDX line)
>>  - Replace EXPORT_SYMBOL lines with respective EXPORT_SYMBOL_GPL lines
>>  - Replace scnprintf lines with sprintf since we're dealing with sysfs files
>>  - Add struct counter_attr_parm to simplify counter_attribute_create parameters
>>  - Rename *_comp_t suffixes to *_unit in order to avoid *_t suffix implications
>>  - List sysfs attribute values verbatim in sysfs documentation files
>>  - Reorganize 104-QUAD-8 driver license boilerplate update to dedicated patch
>> 
>> This revision is functionally identical to the last; changes in this version
>> were made to improve clarity, formatting and whitespace, and organization. I
>> also took this opportunity to record some of the new ACKs from the last
>> submission.
>> 
>> The counter_enum.h file was created to hold the Generic Counter enum helper
>> functions required by the Generic Counter enum macros (i.e. COUNTER_SIGNAL_ENUM,
>> COUNTER_COUNT_ENUM, etc.). These helper functions are not intended to be used
>> directly by driver authors, so I thought it best to keep them separated. Now the
>> counter.h file contains only macro, functions, and data structures that are
>> expected to possibly appear in a counter device driver.
>> 
>> The counter_attribute_create function parameter list was large so I reorganized
>> the parameters into the counter_attr_parm structure, which may be set and passed
>> by reference to the counter_attribute_create function. Since the show and store
>> function pointers match with the struct device_attribute show and store function
>> pointers, I decided to keep them declared as there are here without a typedef --
>> however, I can typedef them in a future revision if it will improve clarity to
>> do so.
>> 
>> Heads-up for Jonathan Cameron: you may pick-up the "iio: 104-quad-8: Update
>> license boilerplate" patch independent of this series; it's the SPDX license
>> boilerplate update for the 104-QUAD-8 IIO driver.
>> 
>> Sincerely,
>> 
>> William Breathitt Gray
>> 
>This crossed with Andrew Morton's good points on this occupying
>namespace that is rather too generically named.  Hence I'll assume
>we'll see a v9 with a solution to that (and personally ignore v8
>to save time ;)
>
>Ah I see you just replied to Andrew. Great!
>
>
>Jonathan

That's right: please ignore this v8 release; Andrew Morton's suggestions
on the v7 thread are quick enough that I should have a v9 tested and
submitted by tomorrow, so keep an eye out for that one instead.

Thanks,

William Breathitt Gray

>
>> Benjamin Gaignard (2):
>>   counter: Add STM32 Timer quadrature encoder
>>   dt-bindings: counter: Document stm32 quadrature encoder
>> 
>> Fabrice Gasnier (2):
>>   counter: stm32-lptimer: add counter device
>>   dt-bindings: counter: Adjust dt-bindings for STM32 lptimer move
>> 
>> William Breathitt Gray (7):
>>   counter: Introduce the Generic Counter interface
>>   counter: Documentation: Add Generic Counter sysfs documentation
>>   docs: Add Generic Counter interface documentation
>>   iio: 104-quad-8: Update license boilerplate
>>   counter: 104-quad-8: Add Generic Counter interface support
>>   counter: 104-quad-8: Documentation: Add Generic Counter sysfs
>>     documentation
>>   iio: counter: Add deprecation markings for IIO Counter attributes
>> 
>>  Documentation/ABI/testing/sysfs-bus-counter   |  230 +++
>>  .../ABI/testing/sysfs-bus-counter-104-quad-8  |   36 +
>>  Documentation/ABI/testing/sysfs-bus-iio       |    8 +
>>  .../testing/sysfs-bus-iio-counter-104-quad-8  |   16 +
>>  .../{iio => }/counter/stm32-lptimer-cnt.txt   |    0
>>  .../bindings/counter/stm32-timer-cnt.txt      |   31 +
>>  .../devicetree/bindings/mfd/stm32-lptimer.txt |    2 +-
>>  .../devicetree/bindings/mfd/stm32-timers.txt  |    7 +
>>  Documentation/driver-api/generic-counter.rst  |  342 ++++
>>  Documentation/driver-api/index.rst            |    1 +
>>  MAINTAINERS                                   |   15 +-
>>  drivers/Kconfig                               |    2 +
>>  drivers/Makefile                              |    1 +
>>  drivers/{iio => }/counter/104-quad-8.c        |  782 ++++++++-
>>  drivers/counter/Kconfig                       |   51 +
>>  drivers/{iio => }/counter/Makefile            |    5 +-
>>  drivers/counter/counter.c                     | 1561 +++++++++++++++++
>>  drivers/{iio => }/counter/stm32-lptimer-cnt.c |  361 +++-
>>  drivers/counter/stm32-timer-cnt.c             |  390 ++++
>>  drivers/iio/Kconfig                           |    1 -
>>  drivers/iio/Makefile                          |    1 -
>>  drivers/iio/counter/Kconfig                   |   34 -
>>  include/linux/counter.h                       |  505 ++++++
>>  include/linux/counter_enum.h                  |   45 +
>>  24 files changed, 4341 insertions(+), 86 deletions(-)
>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter
>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
>>  rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)
>>  create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
>>  create mode 100644 Documentation/driver-api/generic-counter.rst
>>  rename drivers/{iio => }/counter/104-quad-8.c (44%)
>>  create mode 100644 drivers/counter/Kconfig
>>  rename drivers/{iio => }/counter/Makefile (46%)
>>  create mode 100644 drivers/counter/counter.c
>>  rename drivers/{iio => }/counter/stm32-lptimer-cnt.c (48%)
>>  create mode 100644 drivers/counter/stm32-timer-cnt.c
>>  delete mode 100644 drivers/iio/counter/Kconfig
>>  create mode 100644 include/linux/counter.h
>>  create mode 100644 include/linux/counter_enum.h
>> 
>
