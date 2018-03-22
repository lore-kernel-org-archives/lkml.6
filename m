Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3048368-1521733944-2-11047332121802809017
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_WORDY 2.499, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='GB'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521733943; b=Yz9WTlrFaeWULQJaZCD6qOLCZocO9nFE1ocTKG9KtEtuLAK
    jB4x6eZB76USCCiFnN1QJAcmvGd372/NgKtZuIULfTsJ9qJtsNXkPBHD3J1ecoVN
    JQqA8fitvUXevJoFdpA2Q2AtmN0SkiwnlSAC6aZcUC5i9wquiBCoxjPXRqPkyV9L
    c2s+ZwmYg+tRQ5rnsdQjWhU4t6+ceJ/ld6avOxZrk06YeijwnPAiJ2JpMNZQl65g
    VbLcUYcOpIEOgXN6s0PXI9H7n5s0UsikevuZiIuHiAdK00EuJr9trGn6VGvUr8qp
    GxnlFOoOEvw5a86vQpt2utqQ0wHyvUcqjteg4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:from:date:subject:to:cc
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521733943; bh=VE2jv0lBw2qFtw3SU8dL/9uAepgZlFe7ThfWyteKL3k=; b=c
    jK8nlpCB9GPVPrgddnKQ2RyaNrtU4aTuhMrDBhokx5Qhlk0sTsXqrhm98B72CPys
    4ohZaoXgtwabj5dBoiI5DAWA4PaDnF+zAVk4FNtsA6fJthUkyhW7iYECkWQ+Z3y8
    OE22VuUsqrrPFtZtEtMtBTay0zfDOJqfTCpdntv0upMtaIcDnpFYhdGqmVgcgKTU
    xxSiXx8wdR4+DZChJ+O8XRgZlrTrhv9lJmd1/VaqjqQZrOfpJw8yDsrAjrBrYes0
    X4C89T5ZHgDTvTV3C3C7N0FIoL8odAwmRmmRjjgvDeYnt51SG032gSNgXB1M0tGp
    9DeZtdI7vUKynKT7fDc8g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeCVPwH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 11:52:07 -0400
Received: from mail1.bemta5.messagelabs.com ([195.245.231.149]:32523 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751604AbeCVPwE (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 11:52:04 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRWlGSWpSXmKPExsUSt3Opsa7Sxc1
  RBlsfSFg0L17PZvHm+HQmi67VO1ksrh3rZbK4vGsOm8Xn3iOMFouWtTJbPFl4hsni9O4SB06P
  Tas62TzmnQz02D93DbvHxnc7mDze77vK5rHzewO7x+dNcgHsUayZeUn5FQmsGRc7zjAVLFOu2
  HZqH1sDY49MFyMnh5DAekaJDetzIOwKiUd/9rCA2LwCbhJLrvxnBLHZBCwkJp94wNbFyMHBIq
  Aqcfd2AEhYWMBJ4tSpp0DlXBwiAu8ZJT49/gDWyyxQJ9H7+y3UHEGJkzOfQMUlJA6+eMEMsct
  A4vSCRrC4hIC9xPT3V5lB5ksI6Es0HouFCBtKfJ/1DarEXOLmoj1sExj5ZyGZOgvJ1AWMTKsY
  NYpTi8pSi3SNDfSSijLTM0pyEzNzdA0NTPVyU4uLE9NTcxKTivWS83M3MQIDvp6BgXEH44RVf
  ocYJTmYlER5P73YFCXEl5SfUpmRWJwRX1Sak1p8iFGGg0NJgtf7wuYoIcGi1PTUirTMHGDswa
  QlOHiURHhTQNK8xQWJucWZ6RCpU4y6HDdevG5jFmLJy89LlRLnDQEpEgApyijNgxsBSwOXGGW
  lhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzxoJM4cnMK4Hb9AroCCagI7JnbgA5oiQRISXVwMiy
  3+E1l4aGfppXVNZlpm/JvOvEhLnCZNV02ldLznPL6Xrw+YIKx7bOzdvie5fdz8x49DUyWzlXi
  v3Tyj8sCZOVi80FV61mfVJvE1Qz3VHy1kwFRZFkuccBbrYc/a7vORaYVhzgXXSpxPfHm8MF3o
  d3Xpdckuz3oEq77K9gudftg4FOrydfUWIpzkg01GIuKk4EAAM64Gn+AgAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-6.tower-179.messagelabs.com!1521733921!96738844!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <cover.1521732966.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Thu, 22 Mar 2018 15:52:01 +0000
Subject: [PATCH v6 0/6] typec: tcpm: Add sink side support for PPS
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
X-KSE-Antivirus-Info: Clean, bases: 22/03/2018 12:24:00
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

Changes in v6:
 - Remove unnecessary use of 'data' variable and associated kzalloc/kfree call
   for extended message handling.
 - Add patch for error checking psy_desc struct in psy register code.
 - Add error checking of usb_type property in psy register code.
 - Cosmetic () and initialisation changes as requested by Guenter.
 - Removed Acked-by and Reviewed-by on patch 04 as there have been changes to
   error handling with regards to usb_type, so didn't feel appropriate to keep
   them.

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

NOTE: Code changes based on usb-next (027bd6cafd9a1e3a109b5e5682c85ac84e804a8d)

Adam Thomson (6):
  typec: tcpm: Add core support for sink side PPS
  Documentation: power: Initial effort to document power_supply ABI
  power: supply: Add error checking of psy desc during registration
  power: supply: Add 'usb_type' property and supporting code
  typec: tcpm: Represent source supply through power_supply
  typec: tcpm: Add support for sink PPS related messages

 Documentation/ABI/testing/sysfs-class-power | 455 ++++++++++++++
 MAINTAINERS                                 |   1 +
 drivers/power/supply/power_supply_core.c    |  11 +-
 drivers/power/supply/power_supply_sysfs.c   |  45 ++
 drivers/usb/typec/Kconfig                   |   1 +
 drivers/usb/typec/fusb302/Kconfig           |   2 +-
 drivers/usb/typec/fusb302/fusb302.c         |  63 +-
 drivers/usb/typec/tcpm.c                    | 907 +++++++++++++++++++++++++++-
 include/linux/power_supply.h                |  16 +
 include/linux/usb/pd.h                      |   4 +-
 include/linux/usb/tcpm.h                    |   2 +-
 11 files changed, 1418 insertions(+), 89 deletions(-)

-- 
1.9.1

