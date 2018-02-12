Return-Path: <sergeev917@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518444477; cv=none;
        d=google.com; s=arc-20160816;
        b=bu0uPDSI4cNKt9FlgwTdDxz1vihFAJRTsXa/sG7rt8woB1VTYnEGoySrj4HrKCFSuj
         rwrKbp0FfjD2Fe4rtvRxz07LhN6QD+yWxW9GoYBK/skgUmxGLAA82bXpTWiVb1iVnFuq
         f1qC0KSsCcvsrQbrnME3HlT+osxhxjHw67CqRjiX1S9GEi/Yr+UUmaRE2dZEpZaca5ez
         MQfPJ5SQfPRXRN/zUPjAutVIPLdi36t2w01koPhKRfQUancyeDPVTfeowTOYcfjzRbon
         N8//+ej0OCpxuYKyLPjY7zuRDjSHF6Pad6tHtulqab0f6juRkXJct63WVHe14V9hGDQQ
         k41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=X/VB953xYAd8V07/EazuTey+Rkdi+7E+cHxY0X/FCpY=;
        b=hU5pBxpcDJavxfcHXZ3u2mfLYZUksBfjZsjV5tBnOAKJFcuGPi3Zg8KkNduMz5wxT8
         Awvj9krmWUxlglwupEsMEWSZQRzX7Hk5+8vU0yBVmRPd4QIVfUBMXxOdwCzfkbW+DDf2
         2n7j5/mlU8/dHf8iWS9dzxv3sbcUXEY6DsF1oFbsX2TmrByJY125sp1u2VmN6zlBLIuc
         f6onCYprTXxs/r4GD2UTEr2kidP2lR1VEkJkkk/xSQpGhF5D8NNpVDiVj7XuSlX1jU1j
         ivt+1R9LACVn1VjMgoHCgp18QQjtvjZ9XQBUA6M1WMkiMmeDcnJkbOBoPmkn3cjOGcOH
         xIvg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XRDZQU1K;
       spf=pass (google.com: domain of sergeev917@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=sergeev917@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XRDZQU1K;
       spf=pass (google.com: domain of sergeev917@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=sergeev917@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226Zo/SPMNWGIO2XPSdRg55ItaJqWYFGrzGg/Oa8FUTKaNO4AsI6BDuJDST7nuM2oPKQLXsVog==
Date: Mon, 12 Feb 2018 17:11:47 +0300
From: Alexander Sergeyev <sergeev917@gmail.com>
To: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, Kyle Huey <me@kylehuey.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: update spectre v2 microcodes blacklist
Message-ID: <20180212141147.GA3761@localhost.localdomain>
References: <20180210123123.GA19396@localhost.localdomain>
 <20180210171459.GA12797@localhost.localdomain>
 <1518428086.6606.11.camel@infradead.org>
 <0575AF4FD06DD142AD198903C74E1CC87A61260B@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0575AF4FD06DD142AD198903C74E1CC87A61260B@ORSMSX103.amr.corp.intel.com>
User-Agent: mtt
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592016927852230730?=
X-GMAIL-MSGID: =?utf-8?q?1592204436287476444?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>> +{ INTEL_FAM6_BROADWELL_X,        0x01, 0x0b000023 },
>> That's redundant since blacklisting 0x0b000025 will also stop us from
>> using 0x0b000023 anyway.

>and 23 is the pre security version so known good.

But 0x0b000023 is listed under "stop deploying these MCU revs" (page 4, row 4).
Has something changed?
