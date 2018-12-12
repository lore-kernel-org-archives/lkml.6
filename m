Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F17C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A2820870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544610347;
	bh=vOhkXpgNf7dj0Qdk2kx4FyIKsFY92XZnzok0bgXjA+4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jBR0uXbEkVMAUniirPMtrB8HMVzBCof8AHzIkqhhccqnFhzMgXGUVS4OzgLgWgotU
	 mvyKTDNIt/QGzHnyT/A79kZRU3UIAVb72QHg9iM3X4lZcMGgXPhWP2GkKGE0XjNaw0
	 QkqjocNfedMftuOwH3jbu13Ny9AZ2hOYrolseCGU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A2820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbeLLKZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:25:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbeLLKZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:25:45 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A913385A04;
        Wed, 12 Dec 2018 10:25:44 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2BAA5D9C8;
        Wed, 12 Dec 2018 10:25:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Len Brown <len.brown@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Renninger <trenn@suse.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: [PATCHv2 0/6] tools: Various build flags fixes
Date:   Wed, 12 Dec 2018 11:25:31 +0100
Message-Id: <20181212102537.25902-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 12 Dec 2018 10:25:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
while hardening some of the tools rpm, we noticed we
can't pass build flags to some of them. 

Sending separate tools fixes for what we found. It's
mostly override for CFLAGS and adding LDFLAGS to the
build commands.

v2 changes:
  - 4 patches already accepted, still 6 to go ;-)
  - adding more people to cc

Also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  tools/flags

thanks,
jirka


Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Len Brown <len.brown@intel.com>
Cc: Markus Mayer <mmayer@broadcom.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Thomas Renninger <trenn@suse.com>
Cc: Zhang Rui <rui.zhang@intel.com>
---
Jiri Olsa (6):
      tools power x86_energy_perf_policy: Override CFLAGS assignments and add LDFLAGS to build command
      tools thermal tmon: Override CFLAGS assignments
      tools thermal tmon: Use -O3 instead of -O1 if available
      tools power turbostat: Override CFLAGS assignments and add LDFLAGS to build command
      tools iio: Override CFLAGS assignments
      tools gpio: Override CFLAGS assignments

 tools/gpio/Makefile                             | 2 +-
 tools/iio/Makefile                              | 2 +-
 tools/power/x86/turbostat/Makefile              | 8 ++++----
 tools/power/x86/x86_energy_perf_policy/Makefile | 6 +++---
 tools/thermal/tmon/Makefile                     | 8 ++++----
 5 files changed, 13 insertions(+), 13 deletions(-)
