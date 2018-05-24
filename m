Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AB8JxZpezEbkaJZY0I9M/WAq1dSDCHr2im3d19lDYlZC/ewthNNOhzVusfBoMlJLWL+LnJ48iauv
ARC-Seal: i=1; a=rsa-sha256; t=1527149911; cv=none;
        d=google.com; s=arc-20160816;
        b=PRLWdAJnIhAB5sHXJtAsPvT7zWE4KQTNO6eolRqNgP2xmA0MBOxdQgkkspdKBf/kES
         PaMTFeRWgFDt/poEXZhEw9WJLM2uYa36msGEBKNGyBNHZOtp2PjW893fCU9C5EYUg+qG
         6iL+xUAQrO4xuFOnioHvBXy/lI9S51fQq4XBn7UM7Djw8WtUH7FLwNJzCSbc09N4zj0N
         WvzbWSW9L+oQNBcf16Aw8FjLHm2dxB7/fcpCZ72e6zlTqjd+lXWaLgtsS8+5Vw63rLgB
         tBUIni8Lnqfz2KXbYc0pTy9hTphqdA2kUFqYV8rPm1RdT0sttK1CIZJMpL+T25kYE8hn
         qvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=FfVyDwYyfKmLw3cWopF8Kyq/fnzqbjBJA1BVWIvPhnc=;
        b=VqYgbW6XIZcAklam13YvL6BZChMkt7R9uruU+BGt8MXhUbruI0aQKRqLVBSnq3DNTQ
         F8UDuE+oC7QLce1j38Hr2dC4ctgK6emnUaNgUVSLPl+V4P80zjiGj2vDZfFTe6uc+wZu
         /y397ZnchJuFS4SkDrFnxIn2epUwqRPKee4SIAXW59zQEAzm3guSdWLB9x2vp9IRIN2Y
         hjpXkobyuoZz2j2R47Uhq8voTcTMp7Vw8xw7dJJo/cPFuAWafxpDjpnRu8994zwnhy+w
         WcO3HHhIPzANKLKqcmepCRmXhUYHp01RigRuTkNbJB6C9ibfzEJo8KQB4UzV1d2XU6h4
         U3xA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="58073593"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v3 0/4] usb: typec: fixes for Cherry Trails
Date: Thu, 24 May 2018 11:18:23 +0300
Message-Id: <20180524081827.37861-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601332745340171401?=
X-GMAIL-MSGID: =?utf-8?q?1601332745340171401?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This is third version of patches that fix various problems I
encountered while testing my USB Type-C Alternate Mode
patches with GPD Win board (Intel Cherry Trail based).

I added one more patch to this series. Sathyanarayanan
reported an issue where the mux does not get configured when
xHCI is suspended. To fix that we need to enable runtime PM
in the mux driver.

Other changes since v2: constifying struct
usb_role_switch_desc sw_desc, and improvements to the commit
messages.

Link to the original patches:
https://lkml.org/lkml/2018/4/30/350


Heikki Krogerus (4):
  usb: roles: intel_xhci: Always allow user control
  platform: x86: intel_cht_int33fe: Fix dependencies
  usb: typec: fusb302: Fix debugfs issue
  usb: roles: intel_xhci: Enable runtime PM

 drivers/i2c/busses/Kconfig                    |  3 +-
 drivers/platform/x86/Kconfig                  |  4 +-
 .../usb/roles/intel-xhci-usb-role-switch.c    | 37 ++++++++-----------
 drivers/usb/typec/fusb302/fusb302.c           |  1 +
 4 files changed, 19 insertions(+), 26 deletions(-)

-- 
2.17.0
