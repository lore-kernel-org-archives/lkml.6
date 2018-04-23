Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1269041-1524492891-2-11231131306081404225
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_WORDY 2.5, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
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
    1524492891; b=F5VL+uMEDBE6370INDi4LnNvY1ntmSkgpM3sniJMWdyf1QczE9
    C7xId9cqX7oPsUgJz2lFkznrDdKYtf9Ik/ficj1icfGwLfO3FKvYB/ktu31XP2lI
    Pq3ZWf8p+HlNBWwuwyZqeyfrWRXJaUaZbS08xSyZQn129ql3v1jc9OZpZ1KrrqRO
    cW+SCsjdFBBE/vKX/D3kigQZFERySEQwwilRXq1ix9HpJWSI2UpzFsfD7hRO2K6S
    A3InUE1znyF8wOLrKOtiZnnE46S8AurS05vXMyp/wqZtQ+O0nUnTFEJ90fQXYh4M
    xagCUGC3caPNa+7yZqM2nkGdWWz87YYnCZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:from:date:subject:to:cc
    :mime-version:content-type:sender:list-id; s=fm2; t=1524492891;
    bh=6QDUmX8t9zc2JTpwnMaZlHCT8vU4+lxp01kOSIQVjzw=; b=LlOLP3t90nOJ
    WOvJTd1v7thTNAeuOEIr3E5xHzzNKmyUK4oCtQ3AhwUT3ExCswz7NBKBhL9UQs8h
    6Nod4/hQ2zTr9JpTEcObzmvELex+oomdDCSVqnpnu1WzapzT54oZkGMONkpIPiR0
    gYYSosBDCew+TcmeGoOxTRj4ht7x82TuQsVGGRnwodSlxW8kKYuZWFc1xtukmo5P
    +jCwJ0TVbiIUm46Qm4OwZRrwli1syIJmDPFiqX3SMMDO2bG+YbeCCB/9hdCwTX3X
    PkkvNXwEUzsV6Zci7T0k9GR3OG8Q50sQxj6k6Z3lbAZ9n2/tEa1yHELbuRZAofc9
    LxOiLpjq4g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfItCmNHw2uBa0yF52l9y4JIeeb9FdH5Z1RVwKwbjBRIFcYrtf7dxCML0tox8FBnULsCnl32hzwCYBD9dYvQypUWBnCQ2Kts66/ssBWkgkK2umqhA0h5N
    V6sZcBKG/jJJ2kywmhYePZXd9ftukW1J2iqCu7aRzf2h5Cxax6HcwUvIbhXIS7Nej6YxA2o3DLRsPFWOJuMjEhMqFcz0GJluyldDJEdtBKh/ahK0gCeGZ1EH
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=QRjQRLzp78EA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=OIWaPkl4YeHaS3ULdMUA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755620AbeDWOOR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 10:14:17 -0400
Received: from mail1.bemta5.messagelabs.com ([195.245.231.145]:21844 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755418AbeDWOLA (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 10:11:00 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRWlGSWpSXmKPExsUSt3OpsW7By7t
  RBqvWi1k0L17PZvHm+HQmi67VO1ksrh3rZbK4vGsOm8Xn3iOMFouWtTJbPFl4hsni9O4SB06P
  Tas62TzmnQz02D93DbvHxnc7mDze77vK5rHzewO7x+dNcgHsUayZeUn5FQmsGQuXXmYqmKZZs
  bHjCFMD4yeFLkYuDiGB9YwSB1+/YO9i5ARyKiSmfdvC2sXIwcEr4Caxd4E8SJhNwEJi8okHbC
  A2i4CqxIQFy1lAbGEBJ4lV11exgswREXjPKPHp8QewBLNAnUTv77dgNq+AoMTJmU+g4hISB1+
  8YIbYZSBxekEjWFxCwF5i+vurzCB7JQT0JRqPxUKEDSW+z/oGVWIucf9wF9sERv5ZSKbOQjJ1
  ASPTKkaN4tSistQiXUMjvaSizPSMktzEzBxdQwNTvdzU4uLE9NScxKRiveT83E2MwJBnAIIdj
  H2znA8xSnIwKYnyWp6/GyXEl5SfUpmRWJwRX1Sak1p8iFGGg0NJgrfiBVBOsCg1PbUiLTMHGH
  0waQkOHiUR3jiQNG9xQWJucWY6ROoUo6KUOO9mkIQASCKjNA+uDRbxlxhlpYR5GYEOEeIpSC3
  KzSxBlX/FKM7BqCTMWwIyhSczrwRu+iugxUxAizsk74AsLklESEk1MHqvlyn9se5okX574gTj
  yHuL7yeuff7u2xzzqKoYs4I/e4tFDDvVn+2Yk+n3bHp+6MbE9GU+v549reFV+r7vmhh/WRzz8
  Z4dja8sF0zWD/0bUM+4eGbT4veXGedND+H+/mH+f4XEEOW+tW83xzZpMoisVlmwJ/DFi5fXVv
  ct/XWZjeee+Zw5IZFKLMUZiYZazEXFiQCH0daL8wIAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-8.tower-180.messagelabs.com!1524492655!66629277!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Mon, 23 Apr 2018 15:10:55 +0100
Subject: [PATCH v8 0/6] typec: tcpm: Add sink side support for PPS
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>
CC: <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 23/04/2018 11:44:00
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch set adds sink side support for the PPS feature introduced in the
USB PD 3.0 specification.

The source PPS supply is represented using the Power Supply framework to provide
access and control APIs for dealing with it's operating voltage and current,
and switching between a standard PDO and PPS APDO operation. During standard PDO
operation the voltage and current is read-only, but for APDO PPS these are
writable as well to allow for control.

It should be noted that the keepalive for PPS is not handled within TCPM. The
expectation is that the external user will be required to ensure re-requests
occur regularly to ensure PPS remains and the source does not hard reset.


Changes in v8:
 - Rebase onto latest 'usb-next' commit
   (b462e2e0d62a716f7a1b7a7ecea966edc3de45d7) in Greg's USB repo. This picks
   up Jun Li's changes to how PDOs are chosen.
 - Use of '__maybe_unused' in patch 01 (core support), for new APIs that are not
   used until patch 05 (power_supply interface), to avoid warnings
   (-Wunused-function) when applying that patch in isolation. '__maybe_unused'
   usage is removed in patch 05 as it's no longer necessary.

Changes in v7:
 - Further tidy up with bracket usage and unwanted initialisation.
 - Stop using else if statement after break.
 - Added NULL checking of psy_name after devm_kzalloc().
 - Reinstate PD_ROLE_SWAP_TIMEOUT and revert role swap functions to use this.
 - Add PD_PPS_CTRL_TIMEOUT for PPS related control functions.

Changes in v6:
 - Remove unnecessary use of 'data' variable and associated kzalloc/kfree call
   for extended message handling.
 - Add patch for error checking psy_desc struct in psy register code.
 - Add error checking of usb_type property in psy register code.
 - Cosmetic () and initialisation changes as requested by Guenter.
 - Removed Acked-by and Reviewed-by, from Heikki and Sebastian respectively, on
   patch 04 as there have been changes to error handling with regards to
   usb_type, so didn't feel appropriate to keep them.

Changes in v5:
 - Rebase on branch with 'Revert "typec: tcpm: Only request matching pdos"' and
   header changes already included.
 - Update power_supply registration to make power_supply names unique per port,
   to avoid errors creating duplicate psy instances. New name uses port
   dev name as a suffix.
 - Renamed 'connected_type' psy property to 'usb_type', as requested by
   maintainer.
 - Added initial attempt at generic ABI documentation for common psy class
   properties for Battery and USB type supplies.
 - Small update to PPS APDO selection code to limit maximum current requested
   based on sink maximum allowed current. Have left Heikki's 'Acked-by' tag as
   it's a minor change, but can remove if that's not deemed appropriate.

Changes in v4:
 - For PD 3.0 definitions patch, make it benign with regards to existing TCPM
   code so build isn't broken if this one patch is applied, as suggested by
   kbuild robot. Update for dynamic revision is moved to be part of sink side
   PPS support patch.
 - Use PTR_ERR_OR_ZERO macro to simplify return of devm_tcpm_psy_register()
   function, as suggested by kbuild robot.
 - Make devm_tcpm_psy_register() static as not used outside this file.

Changes in v3:
 - Drop 'RFC' from patch series titles
 - Rename PPS related defines to be PPS specific rather than generic APDO titles
 - Update source caps logging to only print PPS APDOs, and for others report as
   undefined.
 - Add ABI documentation for tcpm-source-psy sysfs properties
 - Rebase PDO selection on top of 'typec: tcpm: Only request matching pdos'
   patch.
 - Update capabilities validation introduced in
   'typec: tcpm: Validate source and sink caps' to support PPS APDOs.
 - Dropped power_supply 'type' property update for PPS addition
 - Added 'connected_type' property to power_supply framework, to support
   supplies which can report multiple connected types (e.g. USB), as discussed
   with Heikki.

Changes in v2:
 - Use USB_PD and usb_pd prefixes for macros and inline functions in headers.
 - Negotiate spec revision of PD headers during initial contract agreement.
 - New headers now use SPDX tags for referencing correct license.

Adam Thomson (6):
  typec: tcpm: Add core support for sink side PPS
  Documentation: power: Initial effort to document power_supply ABI
  power: supply: Add error checking of psy desc during registration
  power: supply: Add 'usb_type' property and supporting code
  typec: tcpm: Represent source supply through power_supply
  typec: tcpm: Add support for sink PPS related messages

 Documentation/ABI/testing/sysfs-class-power | 455 +++++++++++++
 MAINTAINERS                                 |   1 +
 drivers/power/supply/power_supply_core.c    |  11 +-
 drivers/power/supply/power_supply_sysfs.c   |  45 ++
 drivers/usb/typec/Kconfig                   |   1 +
 drivers/usb/typec/fusb302/Kconfig           |   2 +-
 drivers/usb/typec/fusb302/fusb302.c         |  63 +-
 drivers/usb/typec/tcpm.c                    | 955 +++++++++++++++++++++++++++-
 include/linux/power_supply.h                |  16 +
 include/linux/usb/pd.h                      |   4 +-
 include/linux/usb/tcpm.h                    |   1 +
 11 files changed, 1466 insertions(+), 88 deletions(-)

-- 
1.9.1

