Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B70FC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6712255D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QR6A6ScV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6712255D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933353AbeFUXsh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:48:37 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:42448 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932734AbeFUXse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:48:34 -0400
Received: by mail-oi0-f74.google.com with SMTP id q129-v6so2772522oic.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=y1udrjP1twkh5X8TRWSu0vDRks7gYPJTY6Qaf3t3Lqw=;
        b=QR6A6ScV+coQOPPsWkWM2/a5m2IFe/UVe0en/irSHJT/2nkKzCfLanPmfLr+B2JgB6
         nslrYb4G7lC1zGWbumkcAi2FBpfR7J2BcZz6ploXmYm+8d3EAQ5AzgJR0swPsK6EqQUN
         zht5VKXV1S3eqmdpLnFUo9uH0mei7VjtS+I1rb+UpoAezdVKI7wX8AmQfcohNbLaSbsY
         yXR73PQcZii1KwZgUgEBYByZ/Y+n/T69SVasIWKbvrshar1zJcJJ3n7rpbiM+IcWsPFO
         cb9GMpU1WYUJduY1vCELgFNHcIems4HbNYarMS5GRRudjAcgLgKPwLgUVW9STmHmXKFE
         NzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=y1udrjP1twkh5X8TRWSu0vDRks7gYPJTY6Qaf3t3Lqw=;
        b=cyhfRnNGKad3zjGb+kf60zhnAYFpheLcyfZFuP58om7etvFQpTtRA1hdqkC+vbvjjU
         QuxTsAWZ2GiGYy2+mnfektZJ3B464JYTMjV3GJq5E5om5mledA4rP8TiuMUBA5FmNsyD
         71AyOT0VpxFDBE4kv7rw+v+XXazGvmYdlsRgeg8g0jXDQr8Y8MW314R3Se+p1nyefPyM
         Cs0khsQuu3ngcJWDKCQ2dUZQ/s8hYV3t8e2YZb22mydtfVVpB+mBB8Ar5p/0mh2aCs37
         9t8fT+tDu4Ki7WxUkMmRnagZj1uFE+sE4bGCT79IiziZB8VOXZ12tGVy4uyXitd2uv/u
         CURw==
X-Gm-Message-State: APt69E2eS4GRHX9rQCI9p6PO9xDp1FMQy2lWZE5W9QKzZUwg7Ap+++CR
        DNkQ9IJcVv91M8X2Y45pqbu4d6YkN9h4
X-Google-Smtp-Source: ADUXVKK+HL44wPWhOl3Q9jEVMTYR7K3JNxFZ5dVXLQ4FBSWKh1vGaX9BNfGvtcka9j6ajsgOmXpZ6TgTCr7L
MIME-Version: 1.0
X-Received: by 2002:a9d:57c1:: with SMTP id q1-v6mr12237109oti.38.1529624913894;
 Thu, 21 Jun 2018 16:48:33 -0700 (PDT)
Date:   Thu, 21 Jun 2018 16:48:25 -0700
Message-Id: <20180621234829.224566-1-rajatja@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH 0/4] Expose PCIe AER stats via sysfs
From:   Rajat Jain <rajatja@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com,
        helgaas@kernel.org
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up to:
https://lkml.org/lkml/2018/5/22/1057

Respinning as a new patchset because the old one has been refactored
to include new patches (that were not part of original), and dropping
some patches. The major changes are:

* Provide breakdown of Fatal / non fatal errors separately
* Include the "total" in the same file
* do some PCI cleanup before the actual aer_stats stuff
* Include documentation in the main patch
* Rename variables / attributes to better match the newer reality.

Rajat Jain (4):
  PCI: Move pci_aer_init() and pci_no_aer() declarations to
    drivers/pci/pci.h
  PCI/AER: Define and allocate aer_stats structure for AER capable
    devices
  PCI/AER: Add sysfs attributes to provide AER stats and breakdown
  PCI/AER: Add sysfs attributes for rootport cumulative stats

 .../testing/sysfs-bus-pci-devices-aer_stats   | 122 +++++++++++
 Documentation/PCI/pcieaer-howto.txt           |   5 +
 drivers/pci/pci-sysfs.c                       |   3 +
 drivers/pci/pci.h                             |  11 +
 drivers/pci/pcie/aer.c                        | 198 +++++++++++++++++-
 drivers/pci/probe.c                           |   1 +
 include/linux/pci.h                           |   5 +-
 7 files changed, 337 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats

-- 
2.18.0.rc2.346.g013aa6912e-goog

