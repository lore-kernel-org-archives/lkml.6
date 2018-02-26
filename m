Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x224h/hQOAV+oilSHMgmDbqcB3gFXw7OJpAZd3OyskiKfRyekit70XtcleBxNLUUV090NnpBn
ARC-Seal: i=1; a=rsa-sha256; t=1519638832; cv=none;
        d=google.com; s=arc-20160816;
        b=xBH0DnAE3otaPVQeldkAP6qNNZ4DYXkJrweRivpwaS3PlLWtshJgH+J6lmJU9kQcpW
         xI6abobip/zlCAxAO/xJRyiQd/FpNpLqs73o/sI3Ru2bYuB7jTejHRkg17nrvF14jpOT
         L5qJBS55EAUq10Gi1p7gWsQ0KzeldiMGTELphWaWqWti7H9StQjPbm6fbfjgvEg64Ve+
         c90C5yWU7mZ4wGEAT373368CjNJeOwVYMZ/pdb24OKx32VAaleGNjSnyGfbCgLOKAdJh
         J2V5jctFGpSZuG5C56tuVYjFvJzQxoMX/7dBQd8iveRJoNvIDCxsS+dL8foUuk8INDXf
         CWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=29nACbv9g9lxlgljaBkFy5UklXEvgwF9aFXY3qFd66Q=;
        b=JyC/Y9yyVGOh2ZkTQm26ObK5kgKEOq0N6yNwAHTH0WBhOdGyuEqkxgZ6KHEGMWStcj
         6Ihnm54YesFBbCdjgOhN/8MUxo989LhfDCmnOXsew6wFQfwCX/OCvPM1x6D3bNcFstKI
         kvG/fFCrsUIPaa0R9o0QWRn3cYu3O4SPCKiGGHTQ+EvJV0yAt9Ub3jSfzRmpj2nv6Lfh
         9oWQeN3YghP1gO8vqD7UGpCKJNYcmTBnRL+4uPA7HWL/Q9Yf0EVLUiReFUott9qXHXeN
         avv3CEwc7PikJmuGgfDTKDqGIaK7JvYIx5643+tA1sNCgm10DL3dw3wcl3cATB9B50hh
         ilEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="30693684"
Message-ID: <1519638828.10722.153.camel@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>, gregkh@linuxfoundation.org,
 jslaby@suse.com, p.zabel@pengutronix.de, heiko@sntech.de,
 ed.blake@sondrel.com,  jhogan@kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com
Date: Mon, 26 Feb 2018 11:53:48 +0200
In-Reply-To: <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
	 <1519381801.10722.103.camel@linux.intel.com>
	 <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
	 <1519407117.10722.124.camel@linux.intel.com>
	 <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593124380170225242?=
X-GMAIL-MSGID: =?utf-8?q?1593456808196310473?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-02-26 at 09:33 +0000, John Garry wrote:
> On 23/02/2018 17:31, Andy Shevchenko wrote:
> > On Fri, 2018-02-23 at 11:02 +0000, John Garry wrote:
> > > On 23/02/2018 10:30, Andy Shevchenko wrote:
> > > > On Fri, 2018-02-23 at 02:42 +0800, John Garry wrote:

> > > We require it for a development board for our hip06 platform.
> > 
> > Okay, and this particular platform uses Synopsys IP?
> 
> As I see this uart is really a virtual 8250, so HW details like apb 
> clocks and the like are hidden, so may not be relevant.

Good to know.

> However I will check with the BMC team to know the specific details.

> > > > >  for supporting an 8250-compatible UART with
> > > > > the following profile/features:
> > > > > - platform device
> > > > > - polling mode (i.e. no interrupt support)
> > > > > - ACPI FW
> > > > 
> > > > Elaborate this one, please.
> > > 
> > > So we need to define our own HID here, and cannot use PNP
> > > compatible
> > > CID
> > > (like PNP0501) as we cannot use the 8250 PNP driver.
> > 
> > Why not? What are the impediments?
> > 
> 
> To support the host controller for this device, we will create an
> MFD, 
> i.e. platform device, per slave device.

There is no answer here...

> > > This is related to the Hisi LPC ACPI support, where we would
> > > create
> > > an
> > > MFD (i.e. platform device) for the UART.
> > 
> > Why you can't do properly in ACPI?

No answer here either.

Sorry, but with this level of communication it's no go for the series.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
