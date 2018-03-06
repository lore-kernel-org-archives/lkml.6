Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AG47ELsK91/lSyH+//i4V7ZbX+Cp9PtcFQMjzYYrvglWWOF6iBD4KLu/iZ2ndT6xieVYQFtOLbBM
ARC-Seal: i=1; a=rsa-sha256; t=1520335169; cv=none;
        d=google.com; s=arc-20160816;
        b=HFmHJhPStVZB6OJS/zfYwXBuNU5FOxzp3SCWCZBfQ1vOUaLLF5FRVOgKshrHFh28yF
         75dzUTO/TM1N/K9pqgYj8MK8AsiX9w7R685uTFvXi/Wdt8oPZU61VFIgoAhGPAnkAJJO
         7nPD6Jp4PgFxOcGdeus+pvKJ5OKPDB46DSN0S6yNINo8JirfpRAEqspfXsu8GJO28Nrl
         GyWVR9x6505m3iaXZ4xg0Tv6Am2jPE5E28TNaRfu8WoF9BasZI1EB31kQCUlRpewUbEc
         7XKI4L9eYE5yETexyVQv+HI8XvmWNsOmn2RQzFpf3CzM0V2egxGG6G209nLo5oOb9Puu
         DBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=Wc2Hpu6tunOeCo/9mNV/HDDdltRvCQlPyLDN6u2kXOU=;
        b=IkwHurPCEiU9BsHx+G606ALpS6grJ/k45f8914nZly1ij0/0svURJdSJ+5D1ZJdqIq
         OYeoMvNrLmS1dVRB+1SvcDNyYTYYzOwomEwo6hYcsFiKAFn2S+2jiBoKGh/7efRWwh4S
         hLYTEGiuUKamp6oZrDbYkCJHWjkGOxXnYL2nnXAJrp7jzFc0xfQZm0QtQe1Noo3n2WYb
         8kDRauEdbApOFPL64kQU09L8gm+lWAzTRA/8wGOxK229+OBx5+2knrRVEyL30TfYBH5N
         duHveh6Gwa+eMUn9ynr6kHBlePcgAul+uT6MK2WA0P1hKFlqwm+q+6qp1OAhJmRPQ5WB
         Oirg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="22166832"
Message-ID: <1520335161.10722.413.camel@linux.intel.com>
Subject: Re: [PATCH v15 8/9] HISI LPC: Add ACPI support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>, mika.westerberg@linux.intel.com,
 rafael@kernel.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net,
 hanjun.guo@linaro.org, robh+dt@kernel.org, bhelgaas@google.com,
 arnd@arndb.de,  mark.rutland@arm.com, olof@lixom.net,
 dann.frazier@canonical.com,  andy.shevchenko@gmail.com, robh@kernel.org
Cc: joe@perches.com, benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linuxarm@huawei.com,  minyard@acm.org, devicetree@vger.kernel.org,
 linux-arch@vger.kernel.org,  rdunlap@infradead.org,
 gregkh@linuxfoundation.org, akpm@linux-foundation.org,
 frowand.list@gmail.com, agraf@suse.de
Date: Tue, 06 Mar 2018 13:19:21 +0200
In-Reply-To: <10d3b5b8-0662-27b1-ff72-5080dd54d78e@huawei.com>
References: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
	 <1519663249-9850-9-git-send-email-john.garry@huawei.com>
	 <1519933855.10722.364.camel@linux.intel.com>
	 <10d3b5b8-0662-27b1-ff72-5080dd54d78e@huawei.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593479230024368492?=
X-GMAIL-MSGID: =?utf-8?q?1594186970667526269?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-02 at 10:19 +0000, John Garry wrote:
> On 01/03/2018 19:50, Andy Shevchenko wrote:
> > On Tue, 2018-02-27 at 00:40 +0800, John Garry wrote:

> > Ok, this needs to be thought about a bit more.
> > 
> > I guess I understand what's is the problem with PNP IDs in the
> > driver.
> > 
> > You probe your LPC device quite late.
> > One option is to move from classical probe to a event-driven model,
> > i.e.
> > via registering a notifier (see acpi_lpss.c), preparing necessary
> > stuff
> > at earlier stages and then register devices by their enumeration and
> > appearance.
> > 
> > Though, if I would be you I would seek a opinion from Rafael and
> > Mika
> > (maybe others as well).
> 
> I would like to give a bit more background on this HW. This HW is now 
> for us a legacy device. It will be used in no more chipsets. It is
> only 
> used in hip06 and hip07 chipsets on our D03 and D05 boards, 
> respectively. On these boards we have the following LPC slave devices
> only:
> D03: UART, IPMI
> D05: IPMI
> 
> Supporting IPMI for D05 is required. Supporting legacy D03 and the
> UART 
> is a "nice-to-have". But it is definitely ok for us to not support
> this 
> device.

I see. But it raises another question to the whole series, why do we
introduce a generic indirect IO for only two devices ever?

Can't it be done in the (MFD) driver itself?

Possible another option, is to introduce a specific regmap for that and
use it in the drivers (though it might be not so trivial with existing
ones).

> Our previous ACPI support solution did use a scan handler for this
> host, 
> but there was some sensible pushback on this - please check this if
> not 
> familiar: https://lkml.org/lkml/2018/2/14/532

> Overall it does not make sense to try to move this back to
> drivers/acpi 
> and receive more pushback from that direction,

Ah, I think the ARM people just worried mostly about arm64 in the
pathnames, though your case is very similar to our LPSS for only few
SoCs.

I would rather think if you move it directly to drivers/acpi it would be
fine.

>  and only delay 
> indefinitely upstreaming this driver (which is now running at ~27
> months 
> since v1) to just support a PNP-compatible device which we don't care 
> too much about.

Ouch!

As I suggested before, you would better to get an input from
maintainers.

My personal opinion that the handler approach is cleaner, though it's
still non-generic stuff. I think that this is what Mika referred to in
his mail.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
