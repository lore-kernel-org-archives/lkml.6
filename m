Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8FAC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C6320834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C6320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emutex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeJZAJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:09:26 -0400
Received: from mr40.theemaillaundry.net ([109.169.43.35]:33202 "EHLO
        mr40.theemaillaundry.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbeJZAJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:09:26 -0400
Received: from mr30.theemaillaundry.net (mr30.theemaillaundry.net [78.46.72.43])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mr40.theemaillaundry.net (Postfix) with ESMTPS id BE4ED4034E;
        Thu, 25 Oct 2018 16:36:06 +0100 (IST)
Received: from localhost (localhost [127.0.0.1])
        by mr30.theemaillaundry.net (Postfix) with ESMTP id 60AAC24162D;
        Thu, 25 Oct 2018 16:36:04 +0100 (IST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mr30.theemaillaundry.net
X-Virus-Scanned: amavisd-new at theemaillaundry.net
Received: from mr30.theemaillaundry.net ([127.0.0.1])
        by localhost (mr30.theemaillaundry.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z1voWWzrRrpy; Thu, 25 Oct 2018 16:36:03 +0100 (IST)
Received: from statler.emutex.com (unknown [92.51.199.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mr30.theemaillaundry.net (Postfix) with ESMTPS id 4E329241B1A;
        Thu, 25 Oct 2018 16:36:02 +0100 (IST)
Received: from [10.10.68.81] (helo=dan-Latitude-E5450.emutex.com)
        by statler.emutex.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.84)
        (envelope-from <dan@emutex.com>)
        id 1gFhg1-0008BR-Dr; Thu, 25 Oct 2018 16:36:01 +0100
From:   Dan O'Donovan <dan@emutex.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Dan O'Donovan <dan@emutex.com>
Subject: [PATCH v3 0/3] iio: adc128s052: add matching options
Date:   Thu, 25 Oct 2018 16:35:39 +0100
Message-Id: <1540481742-23596-1-git-send-email-dan@emutex.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180423213805.12591-1-javier@emutex.com>
References: <20180423213805.12591-1-javier@emutex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On some SKUs of AAEON's UP Squared board, there is an ADC124S101
enumerated via ACPI. This is a pin-compatible variant of ADC124S021,
which is already supported by the adc128s052 driver.

This patchset adds missing DT compatible strings for ADC124S021 (and
ADC122S021) variants, adds AAEON's allocated ACPI HID, and adds the
SPDX GPL identifier to the driver.

v2 was posted at:
https://lore.kernel.org/lkml/20180423213805.12591-1-javier@emutex.com/

Changes from v2:
* Added device-tree bindings documentation for new chip variants
* Simplified code to get ACPI match data
* Dropped redundant patch to facilitate OF matching via ACPI _DSD
* Added patch to replace GPL license text with SPDX identifier

Changes from v1:
* Improved patch descriptions and series title
* Added an initial commit introducing new compatible strings
  (as per Jonathan's suggestion)
* Moved of_match_ptr removal last as this patch is less important to us

Dan O'Donovan (1):
  iio: adc128s052: use SPDX-License-Identifier

Javier Arteaga (1):
  iio: adc128s052: Add pin-compatible IDs

Nicola Lunghi (1):
  iio: adc128s052: add ACPI _HID AANT1280

 .../devicetree/bindings/iio/adc/ti-adc128s052.txt  |  9 ++++-
 drivers/iio/adc/ti-adc128s052.c                    | 39 +++++++++++++++++-----
 2 files changed, 38 insertions(+), 10 deletions(-)

-- 
2.7.4


------
This email has been scanned for spam and malware by The Email Laundry.

