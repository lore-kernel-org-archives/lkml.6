Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751055AbeBQPC6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 10:02:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:48015 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750977AbeBQPC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 10:02:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,525,1511856000";
   d="scan'208";a="30869392"
Message-ID: <1518879773.22495.378.camel@linux.intel.com>
Subject: Re: i2c-designware: sound and s2ram broken on Broadwell-U system
 since commit ca382f5b38f367b6 (add i2c gpio recovery option)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>, tim@krieglstein.org,
        jarkko.nikula@linux.intel.com, preid@electromag.com.au,
        wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 17 Feb 2018 17:02:53 +0200
In-Reply-To: <20180217132543.GA21571@light.dominikbrodowski.net>
References: <20180217132543.GA21571@light.dominikbrodowski.net>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-02-17 at 14:25 +0100, Dominik Brodowski wrote:

> on v4.16-rc1+, sound does not work any more on my Dell XPS 13;
> suspend-to-RAM hangs as well. I have bisected this problem down to
> commit ca382f5b38f3; reverting this on top of Linus' latest
> (1e3510b2b053)
> fixes these issues.

> And a few snippets from a broken kernel dmesg:
> 
> 	i2c_designware: probe of INT3432:00 failed with error -38
> 	i2c_designware: probe of INT3433:00 failed with error -38

ENOSYS here at probe time, taking into account the commit you think is a
culprit, can be passed from gpiod_get() calls only.

> Ideas on how to fix this properly?

Enable CONFIG_DEBUG_GPIO first and share through some service the dmesg.
(it might be good idea to add 'ignore_loglevel initcall_debug' to the
kernel command line)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
