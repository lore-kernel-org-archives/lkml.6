Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756283AbeEATK0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 15:10:26 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.101]:18252 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755443AbeEATKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 15:10:24 -0400
X-Authority-Reason: nr=8
From: Matheus Castello <matheus@castello.eng.br>
To: linus.walleij@linaro.org
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: Re: [PATCH v2 0/2] pinctrl: generic: improve apply_setting error verbosity
Date: Tue,  1 May 2018 15:09:59 -0400
Message-Id: <1525201801-25682-1-git-send-email-matheus@castello.eng.br>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <201805011855.LvT1SKBS%fengguang.wu@intel.com>
References: <201805011855.LvT1SKBS%fengguang.wu@intel.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.21.134
X-Source-L: No
X-Exim-ID: 1fDafO-0042Wq-VV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.21.134]:17937
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 1
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is for improve verbosity in debug for error cases using pinconf 
generic API. Legacy pinctrl-vendor drivers prints error messages with more 
verbosity when parse invalid or not supported sub-nodes properties. In this 
series we try to show messages with more information about the pinctrl-vendor 
driver and sub-nodes that returned error when applied.

Let me know your opinion about this.

Tested Kbuild for arch/x86_64 arch/arm

Changes since v1:
(Suggested by Linus Walleij)
- Fix errors in Kbuild
- Use CONFIG_OF instead CONFIG_GENERIC_PINCONF for use it only in flatned 
device tree enable configurations

Matheus Castello (2):
  pinctrl: generic: add API to solve generic sub-node property name
  pinctrl: generic: improve apply_setting error verbosity

 drivers/pinctrl/pinconf-generic.c       | 61 +++++++++++++++++----------------
 drivers/pinctrl/pinconf.c               | 15 +++++++-
 include/linux/pinctrl/pinconf-generic.h | 32 +++++++++++++++++
 3 files changed, 77 insertions(+), 31 deletions(-)

-- 
2.7.4
