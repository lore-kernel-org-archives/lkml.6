Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeC2W5t (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:57:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:17179 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbeC2W5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:57:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000";
   d="scan'208";a="30064043"
Reply-To: thor.thayer@linux.intel.com
From: Thor Thayer <thor.thayer@linux.intel.com>
Subject: RFC: Using regmap in ARM64 for EL3 register access
To: Mark Brown <broonie@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <0cf26fec-a702-9d57-c7e0-85064690133c@linux.intel.com>
Date: Thu, 29 Mar 2018 18:00:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working on an ARM64 architecture that needs to manipulate some 
protected registers that are only accessible in EL3. Linux is running at 
EL1 which doesn't have the proper permissions for these registers.

Since U-Boot is running at the higher EL3, we communicate to the U-Boot 
functions through a SMC mechanism.

The regmap framework seems like a good match for accessing these 
registers. We need the same functionality as I2C and SPI regmaps - read, 
write, and update registers.

Any comments or suggestions about using regmap for this purpose? Is 
there a better method?

Thanks,

Thor
