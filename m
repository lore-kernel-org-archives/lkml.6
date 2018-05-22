Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2671386-1527002223-2-2446802747377992846
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_WORDY 2.046, HEADER_FROM_DIFFERENT_DOMAINS 0.248,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='GB'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527002222; b=d3q8LEuCJfSvh2lYEmKEzlf4ZG1WJqfdqpp3ypvEUhavSdsGMO
    Ey8oeSsSMd3HKL/ud+38DXanbmJYqveIDca3ocwbj4W2PpVq0niCFpCpcAVImCL0
    i4y3Qc2oKYCDpGsYxrr58uP1DIY5UVPruXzY8cWnXqZ1tZfOPKFZHAUZpX/ykWKA
    mD0vU5iWMwWbuXOFwG81UtkS7XFoGgZ8pYJDcM4pBpBhRnDGGU6eoDgGKxLb8PBY
    3XvS41Ww2Tkbi8+3aBif35+lVpIp0xwCHrPUPhblZA7i0JbhJTmnBjySaBw5xaQ7
    LTHZbRX9En4mT2wjuDUHoNZtqahTOxNP3GCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:from:date:subject:to:cc
    :mime-version:content-type:sender:list-id; s=fm2; t=1527002222;
    bh=xRnnr/Tq1kp+5ST5lHyS+X0WP6IL8ZkaFzEXRuTPYXs=; b=a8uDx31iekwY
    FCVPjKsJN0zYUO6HTmT5obvdtgfUbu9EnhBL2DNJnsINmwWQoBiylG9lVEy3rn4s
    mseFNEYEmHSWbDNAW++1iwUVQJ+V1Q7y2zq0ANbz35sIva6BI5OrMCeEJ3jGTDN+
    Bh6kpsx2lSafRvdQY2XKI9X9ps697bZkHB0MOPKZ77tbbPS9hIzkRx8gL0X3ZKQc
    x2XBSJEJhjtJAqIb/D2ja60P6dLta2xowSE+tSEz87txjrtkTf2gbSILUzLeUWFi
    Dgc7qA+xz6/DH01vPnUkkaKEsERMkV5vP8wR3Hhsk6RPeLC3YBY0hl+65eSQ0haV
    SOcFhNNlaw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAl+wSOBFQqoM/P5c4gV5IzShcJwCnbvrLMgPaZmC3UzhLxM28MyeZjb4XIbPo8xjYMVYwy6QKAzbL0Coy5FrqZ0TMPHDvJHrYSbvaLy68S6wn/viQsJ
    ZPBoQQCOT/0HUjOQQSErqic5T6jG/gxGJY69+1CqARjqo2XQUx/U9Rxmp2I9tP1V30BXi23mYbQpjUitp57Jx2Hu8x8sgp9m4rr4pHkQieWIlT/A2Qs660do
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=QRjQRLzp78EA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=FLLQ4yAgDYodH0EX7PkA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbeEVPQa (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 11:16:30 -0400
Received: from mail1.bemta5.messagelabs.com ([195.245.231.140]:37677 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751339AbeEVPQ0 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 22 May 2018 11:16:26 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRWlGSWpSXmKPExsUSt3Opsa67CUu
  0wbo9whbNi9ezWXSt3slicXnXHDaLz71HGC0WLWtltniy8AyTxendJQ7sHptWdbJ5zDsZ6LF/
  7hp2j53fG9g9Pm+SC2CNYs3MS8qvSGDN+PV4C1tBP1vFuavPGBsYX7F0MXJxCAmsZ5To7fjO2
  sXICeRUSPxbfYIRxOYVcJO4MHEaWJxNwEJi8okHbCA2i4CqxJJ7a8FqhAX8JM68/wwWFxHYwC
  ixfUUoiM0sUCfR+/stC8QcQYmTM5+wQMQlJA6+eMEMsctA4vSCRrC4hIC9xPT3V4HiHEC2vkT
  jsViIsKHE91nfoErMJZq2zmScwMg/C8nUWUimLmBkWsWoUZxaVJZapGtoppdUlJmeUZKbmJmj
  a2hgqpebWlycmJ6ak5hUrJecn7uJERjKDECwg3Hq+7hDjJIcTEqivGFPmaOF+JLyUyozEosz4
  otKc1KLDzHKcHAoSfB+MmKJFhIsSk1PrUjLzAFGFUxagoNHSYR3Okiat7ggMbc4Mx0idYpRUU
  qc9yBIQgAkkVGaB9cGi+RLjLJSwryMQIcI8RSkFuVmlqDKv2IU52BUEuYVMQaawpOZVwI3/RX
  QYiagxReXM4MsLklESEk1MGYf+XpBuTTONyJvoQ3LsvIqnt9i7yRFpvnw9ZWyTwiytau3eNvD
  2ODiIa9c8dFn14/Ptx6U/TRoDC38can93Qu3tq3f5fdUvNhR+02iKXWzF8vKZZLc85e6GZ6/E
  bmopdmUTTvDsmVv7kLvJW5ikit8tfJNTQ/b7dhxPV76mJT90WYJrorPSizFGYmGWsxFxYkAGu
  b+7t8CAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-5.tower-180.messagelabs.com!1527002183!97455828!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <cover.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 22 May 2018 16:16:22 +0100
Subject: [PATCH 0/2] typec: tcpm: Populate fwnode for use in power_supply core
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 22/05/2018 13:35:00
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch set adds support for passing a fwnode pointer as part of the psy
config structure, when intialising the psy core, so that calling code can be
written to be agnostic of the HW description required for the platform. The TCPM
code is updated subsequently to make use of this new field.

For now the main FW support in the psy core is still just DT based but in the
future ACPI will likely be added and can use this field.

Adam Thomson (2):
  power: supply: Add fwnode pointer to power_supply_config struct
  typec: tcpm: Provide fwnode pointer as part of psy_cfg

 drivers/power/supply/power_supply_core.c | 4 +++-
 drivers/usb/typec/tcpm.c                 | 2 ++
 include/linux/power_supply.h             | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
1.9.1

