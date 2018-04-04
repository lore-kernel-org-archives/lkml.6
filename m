Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeDDHWe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:22:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:52301 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbeDDHWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:22:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,405,1517904000";
   d="scan'208";a="39239951"
To: Mike Looijmans <mike.looijmans@topic.nl>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Build failure due commit 9217e566bdee
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Message-ID: <76f98816-9f0a-3eb7-e00e-82cf5935afd6@linux.intel.com>
Date: Wed, 4 Apr 2018 10:22:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Today's head and linux-next doesn't compile due commit 9217e566bdee 
("of_net: Implement of_get_nvmem_mac_address helper"):

drivers/of/of_net.o: In function `of_get_nvmem_mac_address':
.../drivers/of/of_net.c:100: undefined reference to `of_nvmem_cell_get'
.../drivers/of/of_net.c:104: undefined reference to `nvmem_cell_read'
.../drivers/of/of_net.c:106: undefined reference to `nvmem_cell_put'
Makefile:1033: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Builds if I set CONFIG_NVMEM=y from CONFIG_NVMEM=m or revert above commit.

-- 
Jarkko
