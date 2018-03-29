Return-Path: <alexander.shishkin@intel.com>
X-Cyrus-Session-Id: sloti22d1t05-670130-1522322092-5-4892175340636248815
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='134.134.136.20', Host='mga02.intel.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alexander.shishkin@intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522322092; b=txaZyw2T3s6+QBQkq5bqickpyE+5PjeWb+P8o84Bhmei3t9XS1
    QVpgTom3adaF5cAtY6o7WhABFP8h9x9WqRw3HhphJeMYPe22bhQwDxl1IrIs5uGe
    D/SroLunQPdZj9heg8Lw61E9QxzTqGjpZJXHh64QhSpX6vNqohfyzCdWzmfimaUn
    /Mb+1+CrkXJaX1brQwnoObAqGXn7x1bDh51ZbeXHQHB1M3yRwV2o3Ae5AAZUCnm3
    2zqTvAKbiYHtEpmUdEPdirFdnyVNlVdZRKWcUyBLFY+qGmiirEXJrp4YWGbntJun
    UWU9DchaS2JRZQE2ZFzqczhsSAV4wkC06JmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id; s=
    fm2; t=1522322092; bh=rmsFzRRoUjUhVvi50rQqTSSlR4xCYJFEFroVkanfDW
    E=; b=lyb/EjJdaZqPLEL/gXV+e/zwFjy3wmf/sz0b8nCprb0Ux8VHSymlDa+Xb8
    yPwvXrxhGfR+T2qmhxy7PBXqV8vMoS0nzY0AD14/K3/WgtjFTaooiFHLC1ZK8VLt
    AKHyTrnANKZS331YWndSJys6O407BrtnaAcOcX6lv6DeCPPjO8VYV31ChTCNwbH+
    1pezlu/IBEiAGL4XMLOKerNhkh3pd7BxCgYBM4i7Q38QHQA6cYRzGN5ERObcXhIx
    VaalIzIZ7wGF0Yw+YYIgSJLJOWCnl5YtpAaB6fYI5VRKhihEIwhCgHRQ8lkxGXAW
    StEbGHYdJZPOWYlpz8SyYiJwBsJg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=134.134.136.20 (mga02.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga02.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga02.intel.com x-ptr-lookup=mga02.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=134.134.136.20 (mga02.intel.com);
    spf=pass smtp.mailfrom=alexander.shishkin@intel.com smtp.helo=mga02.intel.com;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga02.intel.com x-ptr-lookup=mga02.intel.com;
    x-return-mx=pass smtp.domain=intel.com smtp.result=pass smtp_is_org_domain=yes header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNW5RcrM56Qp7md1zrJ2cGq1dRxzWsCxLrxEkwTgmz+QZlRRurCav6LJBP6Dfrv4JlulRfYl4vqePDrmMfyvkqMpY8PRrQbuWURFvH7FM20/flUoI420
    mJRYnXXFw3zwU8ExFKobnIytXTxyJN506HrwDBH0QGEB8OWtea7vRTNWE7FavwDHKRnThQETByecP7R3m+Jpg2S38oYqevbJt/4=
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=h8G49c9N0KxIvQoKHXEdPQ==:117
    a=h8G49c9N0KxIvQoKHXEdPQ==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=0R8L_OTCIOTgpgYoRlwA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="29444540"
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 00/10] stm class/intel_th: Updates for v4.17
Date: Thu, 29 Mar 2018 14:14:08 +0300
Message-Id: <20180329111418.9416-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.16.1
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

Here are the patches I have for the next merge window. As usual, these
are aiaiai-clean (cppcheck/sparse/smatch/coccinelle). Individual patches
follow, for your convenience. Apologies for the late request.

One big thing is the addition of an ACPI device support to the Trace Hub
driver. Other than that, these are small fixes and SPDX stuff.

Please consider pulling or applying. Thanks!

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/stm-intel_th-for-greg-20180329

for you to fetch changes up to 72ef0f24d587d38f235334aef69afe611bba0d16:

  hwtracing: Add HW tracing support menu (2018-03-29 13:38:10 +0300)

----------------------------------------------------------------
stm class/intel_th: Updates for 4.17

These are:
  * Mass conversion to GPL-2 SPDX header
  * Moved "hwtracing" to now its own submenu, to uncrowd the parent menu a bit
  * Added MAINTAINERS entry for drivers/hwtracing
  * Somewhat small Trace Hub fixes
  * Added ACPI glue layer for the Trace Hub
  * Added more module parameters to dummy_stm for better test coverage

----------------------------------------------------------------
Alexander Shishkin (9):
      MAINTAINERS: Bestow upon myself the care for drivers/hwtracing
      stm class: Add SPDX GPL-2.0 header to replace GPLv2 boilerplate
      stm class: Make dummy's master/channel ranges configurable
      intel_th: Add SPDX GPL-2.0 header to replace GPLv2 boilerplate
      intel_th: Use correct method of finding hub
      intel_th: Don't touch switch routing in host mode
      intel_th: Pick up irq number from resources
      intel_th: Allow forcing host mode through drvdata
      intel_th: Add ACPI glue layer

Randy Dunlap (1):
      hwtracing: Add HW tracing support menu

 MAINTAINERS                           |  5 +++
 drivers/Kconfig                       |  4 +-
 drivers/hwtracing/Kconfig             |  7 ++++
 drivers/hwtracing/intel_th/Kconfig    | 12 ++++++
 drivers/hwtracing/intel_th/Makefile   |  3 ++
 drivers/hwtracing/intel_th/acpi.c     | 79 +++++++++++++++++++++++++++++++++++
 drivers/hwtracing/intel_th/core.c     | 31 ++++++++------
 drivers/hwtracing/intel_th/debug.c    | 10 +----
 drivers/hwtracing/intel_th/debug.h    | 10 +----
 drivers/hwtracing/intel_th/gth.c      | 10 +----
 drivers/hwtracing/intel_th/gth.h      | 10 +----
 drivers/hwtracing/intel_th/intel_th.h | 14 ++-----
 drivers/hwtracing/intel_th/msu.c      | 10 +----
 drivers/hwtracing/intel_th/msu.h      | 10 +----
 drivers/hwtracing/intel_th/pci.c      | 10 +----
 drivers/hwtracing/intel_th/pti.c      | 10 +----
 drivers/hwtracing/intel_th/pti.h      | 10 +----
 drivers/hwtracing/intel_th/sth.c      | 10 +----
 drivers/hwtracing/intel_th/sth.h      | 10 +----
 drivers/hwtracing/stm/console.c       | 10 +----
 drivers/hwtracing/stm/core.c          | 10 +----
 drivers/hwtracing/stm/dummy_stm.c     | 34 +++++++++------
 drivers/hwtracing/stm/heartbeat.c     | 10 +----
 drivers/hwtracing/stm/policy.c        | 10 +----
 drivers/hwtracing/stm/stm.h           | 10 +----
 include/linux/stm.h                   | 10 +----
 include/uapi/linux/stm.h              | 13 ++----
 27 files changed, 172 insertions(+), 200 deletions(-)
 create mode 100644 drivers/hwtracing/Kconfig
 create mode 100644 drivers/hwtracing/intel_th/acpi.c

-- 
2.16.2
