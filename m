Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbeEPMOs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:14:48 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43935 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeEPMOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:14:19 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        "Wang, Wendy" <wendy.wang@intel.com>
Subject: [PATCH 0/2] ACPI / PM: Dispatch EC GPE early on s2idle resume if LPS0 _DSM is used
Date: Wed, 16 May 2018 14:10:55 +0200
Message-ID: <2406722.gU2bUHd7bl@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The purpose of this series is to address a power button wakeup issue on
some platforms where EC events aren't looked for early enough after
wakeup from suspend-to-idle.

The first patch modifies acpi_ev_detect_gpe() to compute a gpe_event_info
if NULL is passed as its second argument and adds a wrapper around it that
is used in the second patch.

The second patch checks the EC GPE in-line after detecting an SCI wakeup
to avoid missing the wakeup event.

Thanks,
Rafael
