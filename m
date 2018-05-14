Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753869AbeENOUH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:20:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:58852 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752171AbeENOUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:20:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,400,1520924400";
   d="scan'208";a="58476244"
Subject: Re: [BUG] i2c-hid: ELAN Touchpad does not work on ASUS X580GD
To: Chris Chiu <chiu@endlessm.com>, Daniel Drake <drake@endlessm.com>
Cc: Jian-Hong Pan <jian-hong@endlessm.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Adrian Salido <salidoa@google.com>,
        Jason Gerecke <killertofu@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
References: <CAPpJ_ed-JPOzQPtyCdH4_C7dzEeM3fznus8XDuaojaiM_4nFpw@mail.gmail.com>
 <CAB4CAwcKu88xP0R9P-3csd6SE2fZ-Vb6OrQD9AmBDh6p77VFDQ@mail.gmail.com>
 <a9e1f1cb-b823-8690-930f-f7346798341a@linux.intel.com>
 <CAD8Lp46b+-B=xqSAqB+zV4xF6SRUGs46FkydS37UEuqav_jNog@mail.gmail.com>
 <CAB4CAwd0tN7CaS7YZCo3TZH-DPxt0x6wxyO23v7aBW9MOCtHCw@mail.gmail.com>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <c1343704-6b1a-14b5-3942-a8a33f73feee@linux.intel.com>
Date: Mon, 14 May 2018 17:20:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAB4CAwd0tN7CaS7YZCo3TZH-DPxt0x6wxyO23v7aBW9MOCtHCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2018 03:03 PM, Chris Chiu wrote:
> Report from guys who can access scope. If i2c-sda-falling-time-ns=400ns
> , HCNT increase to 117, the SCL high duration is 576ns as follows
> https://pasteboard.co/HkwERvP.png
> 
> The original SCL high duration (HCNT = 105, 120MHz) is as follows
> https://pasteboard.co/HkwFxgY.png
> 
> So the HCNT does affect but per this HCNT/LCNT value, just not 400kHz
> as expected. Any suggestion?
> 
Thanks for measurements. I was sidetracked last week so I don't have yet 
explanation why signals run faster than expected :-(

Using 120 MHz SPT I2C clocks in commit b418bbff36dd ("mfd: intel-lpss: 
Add Intel Cannonlake PCI IDs") is clearly wrong but before going to 133 
MHz (which work for you but still runs too fast) I would like to find 
explanation why it appears to be much higher.

-- 
Jarkko
