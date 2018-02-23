Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x226HJaWbu6DGleoCgznF9IoGvYh2FpuIZ5gaEmMKIEBb1TJkTtOk8kMPEGnarFDH/uqHrS8o
ARC-Seal: i=1; a=rsa-sha256; t=1519381806; cv=none;
        d=google.com; s=arc-20160816;
        b=dhSl2iVS3yOyPkyVxAfwggyxuqpLwsEjWxv9tgIvdI5qOtDRgWhuQSs8aQiKACuf14
         4uN1+LRIVa0UaezJzcu92IU7yA2FRffeqhUxk1+SO6uFWKTJQ2n6fuCDaDQBq8ZKpIPh
         Z67BtB8rZzwaRAXT7iHACPP6cVj55q8B3DVthtXlKte1tULGTO7oyINd+1FgXxfkJ6sL
         ZcTUqDqN1A3iBCBImzpsBlXm7rKQRbo2q1qlAAB5vL9T/ngmimlOLMbhE4e4My/uYx+c
         ff1LnJbmXrdhE4wFi2rz1mvnVbKOecUCjD5BSXa9q5JaJqBngybRueaN+uqBZSscC2kW
         B6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=/or1aB/Uo1GXosHttkSMaAFjNyFj89JiYdmLqNu/Zbc=;
        b=Co4ISODkss/9CyL/0NcHw06Tjz1NlT/0Z8df44WvszXf6vGGEXNdR/8AjB+05G/1Lx
         n6M1gxhicu8lq63IprdYiX2unvMedX6igjE8Kp19VSJj5dLrRKuFyVoiQ9TixTUNfgBo
         kemfu9NvuoPBEw1bHXMCSGEtZQRKuzJjmwUfwDEzGdH1sQgVcXMt7IooqNM4eO9vVXyV
         5izZrhjQcsvVV2RKYXCx3RdibMkLEyjQK3JnQlWb6ruAcAE/bLk0SgcRJTuuduPUWjVZ
         F8pltW2GglwJ18turnlMswAZgEZaKaSbjEeecMVpZf3ySV6XU3gpOiA0nMWwIKjS7T05
         Ne0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,382,1515484800";
   d="scan'208";a="36877685"
Message-ID: <1519381801.10722.103.camel@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>, gregkh@linuxfoundation.org,
 slaby@suse.com, p.zabel@pengutronix.de, heiko@sntech.de,
 ed.blake@sondrel.com,  jhogan@kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com
Date: Fri, 23 Feb 2018 12:30:01 +0200
In-Reply-To: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593124380170225242?=
X-GMAIL-MSGID: =?utf-8?q?1593187297046214852?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-23 at 02:42 +0800, John Garry wrote:
> There is a requirement

Where?

>  for supporting an 8250-compatible UART with
> the following profile/features:
> - platform device
> - polling mode (i.e. no interrupt support)

> - ACPI FW

Elaborate this one, please.

> - IO port iotype
> - 16550-compatible
> 
> For OF, we have 8250_of.c, and for PNP device we have 8250_pnp.c
> drivers. However there does not seem to any driver satisfying
> the above requirements. So this RFC is to find opinion on
> modifying the Synopsys DW 8250_dw.c driver to support these
> generic features.

Synopsys 8250 is a particular case of platform drivers. It doesn't
satisfy "8250-compatible UART" requirement.

> With patch 2/2, we're relaxing the interrupt support requirement.
> As I mentioned in the commit log, the 8250_of.c driver seems to
> ignore the dt bindings, and I do the same.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
