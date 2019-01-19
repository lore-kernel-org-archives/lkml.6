Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8F5C61CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F902087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NKLxycaf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbfASAOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:14:32 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:32871 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbfASAOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:14:31 -0500
Received: by mail-io1-f68.google.com with SMTP id t24so12276666ioi.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 16:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Jru+CvK4nZ1PHRXbREmCKp8nN4uIdQ3JUzUN/4n7x4=;
        b=NKLxycaf/3OUmON0WpbyjYXBQ1L63JVLuulIq7TRgtDvcybFOmxB4FSHTXHtYk1TFK
         SrBb2SQ0Bq2MbEBEg0LtSmz59V4+CkRlC3hkQfc6oBhhyGsPLHk2ow/6p9/Ha/nXs1ZL
         U66W/hI1EPeQLfq6XC1B27NiC5/R96NtRx8aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Jru+CvK4nZ1PHRXbREmCKp8nN4uIdQ3JUzUN/4n7x4=;
        b=YrRLb5ifVJyktQQjOkIV8fGHyAPv/vccvf6yuRshR21diCwjW4Brv8CQte4SjwOnsT
         ShwKEjSznPc99iFkixeUPoFvi5xW/YvcdM00Gtdx/RT35nGH0JucegZdNZHLTMNYgPoa
         nsJWffOYEXDm40oSlmhkwPVLMwIQXLH5+9EcNLf6wc+bwn75TEvPyMXIpm7GWCDKfAJE
         je/ZpNHlJbRZ89bxoXomoIE6G3F7Aa3KRMmhquAqxcGanpNqG9SxSfnslcSBl4eowNpg
         MDKIdmOdoRaS9AHdTTbjUGT4TJwHMSGy1+QLqhSxacA1l+56FBL2uNBOQvUcBkPhOv3Z
         yzeg==
X-Gm-Message-State: AJcUukdY8wcgwaRfAj8fccUu2j2nDtJljUD+p956fjYlM3n6Rb7s9DVK
        JjrJ636ZbtfinyX6w9LCp+oNmF7K8Q4=
X-Google-Smtp-Source: ALg8bN6ZiFZVUpFfO/GqkhXdN0jtRbmyrfyQUUO0Mi6Qww/IjiI+FY7N29Wo0H45rGXnRVNTbZY1kQ==
X-Received: by 2002:a6b:b490:: with SMTP id d138mr11735311iof.61.1547856869826;
        Fri, 18 Jan 2019 16:14:29 -0800 (PST)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id e22sm2382062iod.47.2019.01.18.16.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 16:14:29 -0800 (PST)
From:   Nick Crews <ncrews@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, sjg@chromium.org, djkurtz@google.com,
        dlaurie@chromium.org, Nick Crews <ncrews@chromium.org>,
        linux-rtc@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Nick Crews <ncrews@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 0/9] platform/chrome: rtc: Add support for Wilco EC
Date:   Fri, 18 Jan 2019 17:14:13 -0700
Message-Id: <20190119001422.48186-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There is a new chromebook that contains a different Embedded Controller
(codename Wilco) than the rest of the chromebook series. Thus the kernel
requires a different driver than the already existing and generalized
cros_ec_* drivers. Specifically, this driver adds support for getting
and setting the RTC on the EC, adding a binary sysfs attribute
that receives ACPI events from the EC, adding a binary sysfs
attribute to request telemetry data from the EC (useful for enterprise
applications), adding a debugfs interface for sending/receiving raw byte
sequesnces to the EC, and adding normal sysfs attributes to get/set various
other properties on the EC. The core of the communication with the EC
is implemented in wilco_ec/mailbox.c, using a simple byte-level protocol
with a checksum, transmitted over an eSPI bus. For debugging purposes,
a raw attribute is also provided which can write/read arbitrary
bytes to/from the eSPI bus.

We attempted to adhere to the sysfs principles of "one piece of data per
attribute" as much as possible, and mostly succeded. However, with the
wilco_ec/adv_power.h attributes, which deal with scheduling power usage,
we found it most elegant to bundle setting event times for an entire day
into a single attribute, so at most you are using attributes formatted
as "%d %d %d %d %d %d". With the telemetry attribute, we had to use a
binary attribute, instead of the preferable human-readable ascii, in
order to keep secure the information which is proprietary to the
enterprise service provider. This opaque binary data will be read and
sent using a proprietary daemon running on the OS.

The RTC driver is exposed as a standard RTC driver with
read/write functionality.

For event notification, the Wilco EC can return extended events that
are not handled by standard ACPI objects. These events can
include hotkeys which map to standard functions like brightness
controls, or information about EC controlled features like the
charger or battery. These events are triggered with an
ACPI Notify(0x90) and the event data buffer is read through an ACPI
method provided by the BIOS which reads the event buffer from EC RAM.
These events are then processed, with hotkey events being sent
to the input subsystem and other events put into a queue which
can be read by a userspace daemon via a sysfs attribute.

The rest of the attributes are categorized as either "properties" or
"legacy". "legacy" implies that the attribute existed on the EC before it
was modified for ChromeOS, and "properties" implies that the attribute
exposes functionality that was added to the EC specifically for
ChromeOS. They are mostly boolean flags or percentages.

A full thread of the development of these patches can be found at
https://chromium-review.googlesource.com/c/1371034. This thread contains
comments and revisions that could be helpful in understanding how the
driver arrived at the state it is in now. The thread also contains some
ChromeOS specific patches that actually enable the driver. If you want
to test the patch yourself, you would have to install the ChromeOS SDK
and cherry pick in these patches.

I also wrote some integration tests using the Tast testing framework that
ChromeOS uses. It would require a full ChromeOS SDK to actually run the
tests, but the source of the tests, written in Go, are useful for
understanding what the desired behavior is. You can view the tests here:
https://chromium-review.googlesource.com/c/1372575

Thank you for your comments!

Changes in v3:
- Change <= to >= in mec_in_range()
- Add " - EC_HOST_CMD_REGION0" to offset arg for io_bytes_mec()
- remove unused ret in probe()
- Add newline spacer in probe()
- rm unnecessary res in get_resource()
- s/8bit/8-bit
- rm first sleep when sending command to EC
- Move the attribute to the debugfs system
- Move the implementation to debugfs.c
- Improve the raw hex parsing
- Encapsulate global variables in one object
- Add safety check when passing less than 3 bytes
- Move documentation to debugfs-wilco-ec
- explicitly define toplevel_groups from the start,
so adding telem later makes sense
- Break version attribute into individual attributes
- rm unused WILCO_EC_ATTR_RW macro
- Moved some #defines from legacy.h to legacy.c
- rm #define for driver name
- Don't compute weekday when reading from RTC.
  Still set weekday when writing, as RTC needs this
  to control advanced power scheduling
- rm check for invalid month data
- Set range_min and range_max on rtc_device
- change err check from "if (ret < 0)" to "if (ret)"
- Now bubble up error codes from within sysfs_init()
- Add comment that PID means Property ID
- rm some useless references to internal docs from documentation
- add err check on returned data size
- add check on read request offset and size

Changes in v2:
- Fixed kernel-doc comments
- Fixed include of linux/mfd/cros_ec_lpc_mec.h
- cros_ec_lpc_mec_in_range() returns -EINVAL on error
- Added parens around macro variables
- Remove COMPILE_TEST from Kconfig because inb()/outb()
won't work on anything but X86
- Add myself as module author
- Tweak mailbox()
- Add sysfs documentation
- rm duplicate EC_MAILBOX_DATA_SIZE defs
- Make docstrings follow kernel style
- Fix tags in commit msg
- Move Kconfig to subdirectory
- Reading raw now includes ASCII translation
- Remove license boiler plate
- Remove "wilco_ec_sysfs -" docstring prefix
- Fix accidental Makefile deletion
- Add documentation for sysfs entries
- Change "enable ? 0 : 1" to "!enable"
- No longer override error code from sysfs_init()
- Put attributes in the legacy file to begin with, don't move later
- Remove duplicate error messages when init()ing sysfs
- rm license boiler plate
- rm "wilco_ec_rtc -" prefix in docstring
- Make rtc driver its own module within the drivers/rtc/ directory
- Register a rtc device from core.c that is picked up by this driver
- rm "wilco_ec_event -" prefix from docstring
- rm license boiler plate
- Add sysfs directory documentation
- Fix cosmetics
- events are init()ed before subdrivers now
- rm license boiler plate
- rm "wilco_ec_properties -" prefix from docstring
- Add documentation
- rm license boiler plate
- rm "wilco_ec_adv_power - " prefix from docstring
- Add documentation
- make format strings in read() and store() functions static

Duncan Laurie (6):
  platform/chrome: Remove cros_ec dependency in lpc_mec
  platform/chrome: Add new driver for Wilco EC
  platform/chrome: Add support for raw commands in debugfs
  platform/chrome: Add sysfs attributes
  platform/chrome: rtc: Add RTC driver
  platform/chrome: Add event handling

Nick Crews (3):
  platform/chrome: Add EC properties
  platform/chrome: Add peakshift and adv_batt_charging
  platform/chrome: Add binary telemetry attributes

 Documentation/ABI/testing/debugfs-wilco-ec    |  23 +
 .../ABI/testing/sysfs-platform-wilco-ec       | 196 +++++++
 drivers/platform/chrome/Kconfig               |   4 +-
 drivers/platform/chrome/Makefile              |   2 +
 drivers/platform/chrome/cros_ec_lpc_mec.c     |  52 +-
 drivers/platform/chrome/cros_ec_lpc_mec.h     |  43 +-
 drivers/platform/chrome/cros_ec_lpc_reg.c     |  47 +-
 drivers/platform/chrome/wilco_ec/Kconfig      |  33 ++
 drivers/platform/chrome/wilco_ec/Makefile     |   6 +
 drivers/platform/chrome/wilco_ec/adv_power.c  | 544 ++++++++++++++++++
 drivers/platform/chrome/wilco_ec/adv_power.h  | 183 ++++++
 drivers/platform/chrome/wilco_ec/core.c       | 154 +++++
 drivers/platform/chrome/wilco_ec/debugfs.c    | 218 +++++++
 drivers/platform/chrome/wilco_ec/event.c      | 347 +++++++++++
 drivers/platform/chrome/wilco_ec/legacy.c     | 103 ++++
 drivers/platform/chrome/wilco_ec/legacy.h     |  79 +++
 drivers/platform/chrome/wilco_ec/mailbox.c    | 236 ++++++++
 drivers/platform/chrome/wilco_ec/properties.c | 344 +++++++++++
 drivers/platform/chrome/wilco_ec/properties.h | 180 ++++++
 drivers/platform/chrome/wilco_ec/sysfs.c      | 245 ++++++++
 drivers/platform/chrome/wilco_ec/telemetry.c  |  73 +++
 drivers/platform/chrome/wilco_ec/telemetry.h  |  41 ++
 drivers/platform/chrome/wilco_ec/util.h       |  38 ++
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-wilco-ec.c                    | 177 ++++++
 include/linux/platform_data/wilco-ec.h        | 189 ++++++
 27 files changed, 3509 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-wilco-ec
 create mode 100644 Documentation/ABI/testing/sysfs-platform-wilco-ec
 create mode 100644 drivers/platform/chrome/wilco_ec/Kconfig
 create mode 100644 drivers/platform/chrome/wilco_ec/Makefile
 create mode 100644 drivers/platform/chrome/wilco_ec/adv_power.c
 create mode 100644 drivers/platform/chrome/wilco_ec/adv_power.h
 create mode 100644 drivers/platform/chrome/wilco_ec/core.c
 create mode 100644 drivers/platform/chrome/wilco_ec/debugfs.c
 create mode 100644 drivers/platform/chrome/wilco_ec/event.c
 create mode 100644 drivers/platform/chrome/wilco_ec/legacy.c
 create mode 100644 drivers/platform/chrome/wilco_ec/legacy.h
 create mode 100644 drivers/platform/chrome/wilco_ec/mailbox.c
 create mode 100644 drivers/platform/chrome/wilco_ec/properties.c
 create mode 100644 drivers/platform/chrome/wilco_ec/properties.h
 create mode 100644 drivers/platform/chrome/wilco_ec/sysfs.c
 create mode 100644 drivers/platform/chrome/wilco_ec/telemetry.c
 create mode 100644 drivers/platform/chrome/wilco_ec/telemetry.h
 create mode 100644 drivers/platform/chrome/wilco_ec/util.h
 create mode 100644 drivers/rtc/rtc-wilco-ec.c
 create mode 100644 include/linux/platform_data/wilco-ec.h

-- 
2.20.1.321.g9e740568ce-goog

