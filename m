Return-Path: <vinod.koul@intel.com>
X-Google-Smtp-Source: AIpwx48XQtkl0/B+FTcFQreQ9yGmO/0b8SyLRqzt4myA3FieHlaMQ7yam2wL4d4LlX1Kx9Zq1kmP
ARC-Seal: i=1; a=rsa-sha256; t=1524734925; cv=none;
        d=google.com; s=arc-20160816;
        b=RkGuSFSpMf6Zuq1HB6A2V/AD6psNVqYFZeLXOFqOEoKTmdO8pZ40aW038WY0e5KD/j
         AKMzkNBNAFbit6Rg4P2FNj1H98NpFTJRSlxQSOgR6zIIyFWaCYCiW4XQHymPMDJdo0CX
         1dEx8259IMc31mzRM5gMZij8n6tEK/lOeiXwSrcY28jmuiHfRjwE0Xl+3qHXIS0OvFvV
         PF9QutkWcsrgOFJhdW8zAok1K601rK6Gmghskgtg2cdSkdcPwSFk6AFbrNudtPnzx+7o
         23lGvSQ/uGWhSMD28kW+Jp124vG47Ki19F5C9/j+/tz3OHI4ilRKXVQFK17zYTjqxwDt
         1rHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=/GHcc6hussvERZW7n1y+fhIgMz7/Ya+EhyyEW7yuPgU=;
        b=PtrB8a+3NbwY+TAg/zRrLtW7WaMIVsOWKoDDkq6CMJ7jypu9Z/P4I18GI34eogU+li
         rYWSKDhffqNXmT5V4MTOadonc+ODmo5pN2IPX1KzcE/fZai6HtnzVicpK2wDyQg9HivG
         TXENi8ux1XriVpvUqgfhEdPkFHqNh84b9TdwxuEP16G89ug4lGEXiSlXCsJcRt/bvkpT
         PYRx3f/9rey3oIXqxtlxQSwXo5aBP0xMEzwWw+0tdMtpfoz5VxCTJwSEAZXpr11zCufZ
         gSmZhTbBWVSV1835sZ4WFNGgezzil9S+K4s63ZDLNHsM6O/QNGxgIa3NwrvKklB/XQX6
         yYaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vinod.koul@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=vinod.koul@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vinod.koul@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=vinod.koul@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,330,1520924400";
   d="scan'208";a="223501331"
Date: Thu, 26 Apr 2018 15:03:24 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, C Shapiro <shapiroc@chromium.org>,
	Aaron Durbin <adurbin@chromium.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alex Hung <alex.hung@canonical.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	sayli karnik <karniksayli1995@gmail.com>,
	Sagar Dharia <sdharia@codeaurora.org>
Subject: Re: [PATCH] firmware: dmi: Add access to the SKU ID string
Message-ID: <20180426093324.GV6014@localhost>
References: <20180424211111.140374-1-sjg@chromium.org>
 <20180425025125.GH6014@localhost>
 <CAPnjgZ1ExEQHL8W2+k=+wS98O3CCX25dKngv_PFNvgAKVBD4Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1ExEQHL8W2+k=+wS98O3CCX25dKngv_PFNvgAKVBD4Hw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598663453447525196?=
X-GMAIL-MSGID: =?utf-8?q?1598800449942471625?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 03:17:37PM -0600, Simon Glass wrote:
> Hi Vinod,
> 
> On 24 April 2018 at 20:51, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Tue, Apr 24, 2018 at 03:11:11PM -0600, Simon Glass wrote:
> >> This is used in some systems from user space for determining the identity
> >> of the device.
> >>
> >> Expose this as a file so that that user-space tools don't need to read
> >> from /sys/firmware/dmi/tables/DMI
> >
> > sysfs is an ABI and needs to be documented, I don't see that in this patch,
> > pls add.
> 
> Thanks for taking a look. The only mention of the dmi/id I can find is
> in Kconfig:

Sorry I should have been explicit. All sysfs entries are ABI to userspace.
So they are documented in kernel and the meaning of files should not
typically get modfied over time.
Please read Documentation/ABI/README

For DMI, quick grep told me you should add to
Documentation/ABI/testing/sysfs-firmware-dmi-tables

HTH
-- 
~Vinod
