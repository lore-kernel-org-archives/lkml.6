Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5DBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE6320675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OaVkI3hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390680AbfAPNlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:41:13 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45140 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729432AbfAPNlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=ay1zuWVZowNuz5no8Sfw2Hi61MMbHvxLui1bD06+qPM=;
        b=OaVkI3hgg4zwnUytPkBfCkLhjhVjPDOcUymr1QhlvQ0dtCu3dU9kJRSGJCgYGXkZJZjz3MAdxk50kiZYMOQDU/jHKMREybJ5SoR1mkqN1O/Z4CmyMTEwaCD0b5TfF8OSgeCIjWjg3S6YBwzYOtv2bC2xD6wIVe2qPPqfW6eN1PA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gjlRC-0006PZ-S8; Wed, 16 Jan 2019 14:40:58 +0100
Date:   Wed, 16 Jan 2019 14:40:58 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     kernel test robot <lkp@intel.com>
Cc:     Camelia Groza <camelia.groza@nxp.com>, f.fainelli@gmail.com,
        hkallweit1@gmail.com, davem@davemloft.net, oss@buserror.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@01.org
Subject: Re: [net]  b8154ef682:
 WARNING:at_drivers/net/phy/phy_device.c:#phy_driver_register
Message-ID: <20190116134058.GA24229@lunn.ch>
References: <1547555719-13541-1-git-send-email-camelia.groza@nxp.com>
 <20190116085858.pfl4vuutel3b5kgb@inn2.lkp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116085858.pfl4vuutel3b5kgb@inn2.lkp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:58:58PM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: b8154ef682a9a745880ecbb2ee26b16297c9bfd0 ("[PATCH net] net: phy: phy driver features are mandatory")
> url: https://github.com/0day-ci/linux/commits/Camelia-Groza/net-phy-phy-driver-features-are-mandatory/20190116-004308
> 
> 
> in testcase: trinity
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 512M
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +--------------------------------------------------------------+------------+------------+
> |                                                              | 2f960bd056 | b8154ef682 |
> +--------------------------------------------------------------+------------+------------+
> | boot_successes                                               | 45         | 0          |
> | boot_failures                                                | 1          | 4          |
> | BUG:kernel_timeout_in_torture_test_stage                     | 1          |            |
> | WARNING:at_drivers/net/phy/phy_device.c:#phy_driver_register | 0          | 4          |
> | EIP:phy_driver_register                                      | 0          | 4          |
> +--------------------------------------------------------------+------------+------------+
> 
> 
> 
> [  458.251512] WARNING: CPU: 0 PID: 1 at drivers/net/phy/phy_device.c:2246 phy_driver_register+0x90/0xe0
> [  458.260864] CPU: 0 PID: 1 Comm: swapper Tainted: G                T 4.20.0-11080-gb8154ef6 #158
> [  458.260864] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [  458.260864] EIP: phy_driver_register+0x90/0xe0
> [  458.260864] Code: 5d 89 7b 08 89 03 89 d8 c7 43 14 02 00 00 00 e8 06 d3 e1 ff 85 c0 89 c6 75 39 83 c4 0c 89 f0 5b 5e 5f 5d c3 8d b6 00 00 00 00 <0f> 0b b8 38 5b 2e 5e c7 04 24 00 00 00 00 31 c9 ba 01 00 00 00 be
> [  458.260864] EAX: 5e2e5b50 EBX: 5e1a8fe0 ECX: 00000000 EDX: 00000001
> [  458.260864] ESI: 00000000 EDI: 00000000 EBP: 4010defc ESP: 4010dee4
> [  458.260864] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00210246
> [  458.260864] CR0: 80050033 CR2: 00000000 CR3: 1e43a000 CR4: 000006b0
> [  458.260864] Call Trace:
> [  458.260864]  ? phy_drivers_register+0x37/0x90
> [  458.260864]  ? phy_module_init+0x1b/0x1b
> [  458.260864]  ? phy_module_init+0x19/0x1b
> [  458.260864]  ? do_one_initcall+0xd9/0x24b

Hi Camelia

I think we need to extend your patch and print the name of the PHY
which is missing the features pointer. I don't see anything here which
allows me to determine which PHY caused the warning.

       Thanks
	Andrew
