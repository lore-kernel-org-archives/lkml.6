Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932279AbeCLSyx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:54:53 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:45298 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932225AbeCLSyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:54:52 -0400
Date: Mon, 12 Mar 2018 19:53:57 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: dvhart@infradead.org, mario.limonciello@dell.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Dell Inc. XPS 13 9343/0TM99H fails to boot v4.16-rc5
Message-ID: <20180312185357.GA1672@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mario,

unfortunately, my Dell Inc. XPS 13 9343/0TM99H, BIOS A11 12/08/2016 fails to
boot v4.16-rc5. More exactly, I could bisect it down to commit 25d47027e10
("platform/x86: dell-smbios: Link all dell-smbios-* modules together").
Usually, I have enabled

CONFIG_SENSORS_DELL_SMM=y
CONFIG_DELL_SMBIOS=y
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=y
CONFIG_DELL_WMI=y
CONFIG_DELL_WMI_DESCRIPTOR=y
# CONFIG_DELL_WMI_AIO is not set
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
# CONFIG_DELL_RBU is not set

For v4.16-rc5 to work, I need to manually disable DELL_SMBIOS_WMI:

-CONFIG_DELL_SMBIOS_WMI=y
+# CONFIG_DELL_SMBIOS_WMI is not set

Any ideas?

Thanks,
	Dominik
