Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AG47ELtXjbD+/mnXFaIS/A1f318ayUKuTEgRx38F3k7GZ6j98RiGORqvEo8alXdRqPeKxGHUwW2v
ARC-Seal: i=1; a=rsa-sha256; t=1520364117; cv=none;
        d=google.com; s=arc-20160816;
        b=DChdBTdzISnX4l+dcnZGOgusDAhDJSPgufDjSSMpBsnHB9eKqOr6daTBaxqQB66pkE
         BkdUqSP2cvH+Nu6bu2xyDxlhaOBQcAkpz5VrPydVacDDhDNqOGW8BZ1QJ3BILP+jLdA8
         JQnz6ErkA1tM4JPzl1M/YQnnULsT8mzglgb2igNnKMnCpp/wpsWTyOLGvyY1SrtGaNXl
         oh8NGZaxw1C7fbphwhIZa09TrPSPZxahUQvqsdaJzc16FCOWqrVBoERtZPpyGvUrtUi1
         3Q/0FdLmJ8jyO7AL7uf4OwNp+YX9hAXJMZomSsHSYXsRm5VM+fSzd747z3CTz6LlyDHi
         8uZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=2MwkUKJrToMQQArufKEVmlGpe1G0DSjxnXb+/g4I4YI=;
        b=rzdOTDoocKqHFSTgTk8ZXC0LxblteYz/PasurQMcmqgLYPs3RfcCmCxSnykPSO95I0
         /sLGDaviHVSkmWXit1hoNGQAool475bYkEPG4cij+UzPoHpC3uNlcnZGL94Cb49lmdBY
         UGojsZwGxFtp69r2WqzuxivmXurGHDRYV8FDKL8MeZ9TUpAtMjYVFbJxIDL98jqbeT5u
         FsB7M1yz9SuUPRPfHnUxwtflDI9CCwTWzMEjnFHlCOdRGd2w/BZYoyUPpSE5MHC4Dvpl
         ZID+DakWfUCbD7bPus5UhsWvSDQnV7HlXzN/Oq0/ooJkjvroPj+PIyQskQbX9EOw+krC
         5w1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,432,1515484800";
   d="scan'208";a="205993741"
Subject: Re: [PATCH v2 0/8] PECI device driver introduction
To: Pavel Machek <pavel@ucw.cz>
Cc: joel@jms.id.au, andrew@aj.id.au, arnd@arndb.de,
 gregkh@linuxfoundation.org, jdelvare@suse.com, linux@roeck-us.net,
 benh@kernel.crashing.org, andrew@lunn.ch, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 openbmc@lists.ozlabs.org
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180306124014.GB13950@amd>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <94a31519-8009-b131-4d9e-95631b789931@linux.intel.com>
Date: Tue, 6 Mar 2018 11:21:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306124014.GB13950@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027880268986254?=
X-GMAIL-MSGID: =?utf-8?q?1594217325214179576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Pavel,

Please see my answer inline.

On 3/6/2018 4:40 AM, Pavel Machek wrote:
> Hi!
> 
>> Introduction of the Platform Environment Control Interface (PECI) bus
>> device driver. PECI is a one-wire bus interface that provides a
>> communication channel between Intel processor and chipset components to
>> external monitoring or control devices. PECI is designed to support the
>> following sideband functions:
>>
>> * Processor and DRAM thermal management
>>    - Processor fan speed control is managed by comparing Digital Thermal
>>      Sensor (DTS) thermal readings acquired via PECI against the
>>      processor-specific fan speed control reference point, or TCONTROL.
>>      Both TCONTROL and DTS thermal readings are accessible via the processor
>>      PECI client. These variables are referenced to a common temperature,
>>      the TCC activation point, and are both defined as negative offsets from
>>      that reference.
>>    - PECI based access to the processor package configuration space provides
>>      a means for Baseboard Management Controllers (BMC) or other platform
>>      management devices to actively manage the processor and memory power
>>      and thermal features.
>>
>> * Platform Manageability
>>    - Platform manageability functions including thermal, power, and error
>>      monitoring. Note that platform 'power' management includes monitoring
>>      and control for both the processor and DRAM subsystem to assist with
>>      data center power limiting.
>>    - PECI allows read access to certain error registers in the processor MSR
>>      space and status monitoring registers in the PCI configuration space
>>      within the processor and downstream devices.
>>    - PECI permits writes to certain registers in the processor PCI
>>      configuration space.
>>
>> * Processor Interface Tuning and Diagnostics
>>    - Processor interface tuning and diagnostics capabilities
>>      (Intel(c) Interconnect BIST). The processors Intel(c) Interconnect
>>      Built In Self Test (Intel(c) IBIST) allows for infield diagnostic
>>      capabilities in the Intel UPI and memory controller interfaces. PECI
>>      provides a port to execute these diagnostics via its PCI Configuration
>>      read and write capabilities.
>>
>> * Failure Analysis
>>    - Output the state of the processor after a failure for analysis via
>>      Crashdump.
>>
>> PECI uses a single wire for self-clocking and data transfer. The bus
>> requires no additional control lines. The physical layer is a self-clocked
>> one-wire bus that begins each bit with a driven, rising edge from an idle
>> level near zero volts. The duration of the signal driven high depends on
>> whether the bit value is a logic '0' or logic '1'. PECI also includes
>> variable data transfer rate established with every message. In this way,
>> it is highly flexible even though underlying logic is simple.
>>
>> The interface design was optimized for interfacing to Intel processor and
>> chipset components in both single processor and multiple processor
>> environments. The single wire interface provides low board routing
>> overhead for the multiple load connections in the congested routing area
>> near the processor and chipset components. Bus speed, error checking, and
>> low protocol overhead provides adequate link bandwidth and reliability to
>> transfer critical device operating conditions and configuration
>> information.
>>
>> This implementation provides the basic framework to add PECI extensions
>> to the Linux bus and device models. A hardware specific 'Adapter' driver
>> can be attached to the PECI bus to provide sideband functions described
>> above. It is also possible to access all devices on an adapter from
>> userspace through the /dev interface. A device specific 'Client' driver
>> also can be attached to the PECI bus so each processor client's features
>> can be supported by the 'Client' driver through an adapter connection in
>> the bus. This patch set includes Aspeed 24xx/25xx PECI driver and a generic
>> PECI hwmon driver as the first implementation for both adapter and client
>> drivers on the PECI bus framework.
> 
> Ok, how does this interact with ACPI/SMM BIOS/Secure mode code? Does
> Linux _need_ to control the fan? Or is SMM BIOS capable of doing all
> the work itself and Linux has just read-only access for monitoring
> purposes?
> 

This driver is not for local CPUs which this driver is running on. 
Instead, this driver will be running on BMC (Baseboard Management 
Controller) kernel which is separated from the server machine. In this 
implementation, it provides just read-only access for monitoring the 
server's CPU and DIMM temperatures remotely through a PECI connection. 
The BMC can control fans according to the monitoring data if the BMC has 
a fan control interface and feature, but it depends on baseboard 
hardware and software designs.

Thanks,
Jae

> Pavel
> 
> -- (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 
