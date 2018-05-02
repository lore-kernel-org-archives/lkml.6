Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqvF65jjJAbPcR6/AM88LZ8uP6etcFB9hafAZOHyc+iGt1jfaMgGR6wEjmiijC2oF1w0mKA
ARC-Seal: i=1; a=rsa-sha256; t=1525283972; cv=none;
        d=google.com; s=arc-20160816;
        b=NhAK0ySLJ4CGg5ILgL6E0eQ6kwt441p/XuY9HDvuhOymQc3+/EoIAMlcriPISJcrrE
         Attq+OQQoKY+KVanipTV0Q/dMIR1x+z19kBnIlVJrTiqcp2yJ0bfXYKfaomtSFdlgbkN
         i2sECuxltjUDQ/XQTNHSpfGj3HiqmhrBdgHtSXe6n95Ezi0KC2QdqAX4NGTI2EwWK5gc
         e3m0pUSmdxB0nlX8WOOAtnHNuV4pbV0gKI+Mr6GH8nV9R7E+2xPJ9edOvZMdUCYh7/9N
         PhNddyUbWNgRf9Gbr3OgZf7MwI7uzv1bRkX6EPtGc3V+leDiQ131B8bFmofRj+PuCUpA
         /iRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=6GzsXFsH49sgzhVinsVYFq4IWn5HuZsvtPPGJTpy7DE=;
        b=MXfkveZsN3KoTSC3o0gVFgnflg6psY+EOm7cMxstbFc1dq9ipR0X6JPRjkHHaBzSWN
         ChLTuk4HY47xvKlM3FeScAISkR+OqNsaSCcbi5ALfPZy6ePALEWyInlCTvk/H2BcZTjE
         WSTu4Y3BBk4O2Ehuka2wPoiaoEEWZkLBfpq1UQJYVklHq/MtNldaniwHWZ8SWDTLLinm
         lqe9dAVjvbHDulGspoEQm8DrWTSgg1NDVBca+23Vczqc1QXSjxltd5lVPDQXnXk9JLTl
         UU3fhlwTtFDRm0HTNQA+3aRz0ddaZNmk3JYEP7mRzszXWH7KCJobGlaJ/oNEGqxu4Hwm
         mCng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,354,1520924400";
   d="scan'208";a="38755377"
Message-ID: <1525283968.21176.633.camel@linux.intel.com>
Subject: Re: [PATCH] NFC: fdp: Remove __func__ parameter from dev_dbg() call
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Amit Pundir <amit.pundir@linaro.org>, lkml
 <linux-kernel@vger.kernel.org>,  linux-wireless@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, Christophe Ricard
	 <christophe.ricard@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, John
	Stultz <john.stultz@linaro.org>
Date: Wed, 02 May 2018 20:59:28 +0300
In-Reply-To: <1525283379-7141-1-git-send-email-amit.pundir@linaro.org>
References: <1525283379-7141-1-git-send-email-amit.pundir@linaro.org>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599375551043714716?=
X-GMAIL-MSGID: =?utf-8?q?1599376166408822072?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-05-02 at 23:19 +0530, Amit Pundir wrote:

> -	dev_dbg(dev, "%s\n", __func__);
> +	dev_dbg(dev, "\n");

If one enables function tracer this will be redundant completely. 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
