Return-Path: <ard.biesheuvel@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520524770; cv=none;
        d=google.com; s=arc-20160816;
        b=pVm7CfIeBcSpbFJ9b/YNQJSEki6PCrmeT9tXxR0PIwmYMPB9MGOEMomBNHkjRJakJ2
         G9gG5ThUHp2F7U/LKm6nwwyHnPa2oc4ULEcvis9oPpOrKPXaOqrOZKR53cmJ1/cZy/Qy
         bfLIsw8MBGarup2ZpQgarUJ2j1hqUty+Kdvaz52ki/RN54du8dTbhzxzZWYR74GV3HOc
         ZP6R6Mz6EHbW6aEv0eVQ3CjS4tVyvZFGMc4eCv6PsYr3uOTwB6UqTffjNW2wv9hxkjAG
         EOZCx1YHu8amTB8+SlPA9Mur0XW6xki8q2vYGvwYmDy6ObuVBBPilpKMr3UCv78lfjt3
         21NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=zI6PkDVz2dTOAz5wgCxUktpEbijfb6zZ0lqgRyad0aU=;
        b=EUnGaJa46o+5PN6KcEkOwG6SUZwcIoqkTKKg5zQwAabqRjV0I6zfrsOGRQ45zCEQGZ
         YpBferZWUcSkb1/bs8E6+mMvoyAIk3Y2kxtuzeyEYIyPHfncTko5E5FhrqCbHalOuKNe
         JRjbzao/wXSH27WfvbxsYb3upIfhFCsu9ECUTSdCGg352utlV7PPOycwAtOInHr97sNr
         9plvYp4+TEhcMfZfrnOW+3Fr3GhSn94ciLlQs7H5ZSn0V5cAVcxK67/fKxQhKbfa7zDl
         TvsuWnY6o+Fl9dRoEYYVCzWi6b5vmVZdel6x1MllGMynZbz772UbQyAt/UKkTvEk6fUF
         hdWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=g+EY78UC;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=g+EY78UC;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELuCODLidWsBeG2V656rVoyxXkDT4hbSsaPs7Hui2pzUndt6riPawnyGe9h4GnnphYZ3tVi62a8xM8Z9W6u0peM=
MIME-Version: 1.0
In-Reply-To: <1890b2e2-375e-f44f-c224-8cfa23a0add3@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com> <8b5bfd7e-57ea-bb34-85f8-69007a3847e6@arm.com>
 <1890b2e2-375e-f44f-c224-8cfa23a0add3@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 8 Mar 2018 15:59:29 +0000
Message-ID: <CAKv+Gu__yYX-fFqxyxNk3M=Byvw5798po0Jr=qr3anEWKJ+SMA@mail.gmail.com>
Subject: Re: [PATCH v7 00/13] Support PPTT for ARM64
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>, vkilari@codeaurora.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, dietmar.eggemann@arm.com,
	Will Deacon <will.deacon@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, morten.rasmussen@arm.com,
	Al Stone <ahs3@redhat.com>, palmer@sifive.com, Hanjun Guo <hanjun.guo@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, linux-riscv@lists.infradead.org,
	John Garry <john.garry@huawei.com>, wangxiongfeng2@huawei.com,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684134324692162?=
X-GMAIL-MSGID: =?utf-8?q?1594385781483015561?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 27 February 2018 at 18:49, Jeremy Linton <jeremy.linton@arm.com> wrote:
> On 03/01/2018 06:06 AM, Sudeep Holla wrote:
>>
>> Hi Jeremy,
>>
>> On 28/02/18 22:06, Jeremy Linton wrote:
>>>
>>> ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
>>> used to describe the processor and cache topology. Ideally it is
>>> used to extend/override information provided by the hardware, but
>>> right now ARM64 is entirely dependent on firmware provided tables.
>>>
>>> This patch parses the table for the cache topology and CPU topology.
>>> When we enable ACPI/PPTT for arm64 we map the physical_id to the
>>> PPTT node flagged as the physical package by the firmware.
>>> This results in topologies that match what the remainder of the
>>> system expects. To avoid inverted scheduler domains we then
>>> set the MC domain equal to the largest cache within the socket
>>> below the NUMA domain.
>>>
>> I remember reviewing and acknowledging most of the cacheinfo stuff with
>> couple of minor suggestions for v6. I don't see any Acked-by tags in
>> this series and don't know if I need to review/ack any more cacheinfo
>> related patches.
>
>
> Hi,
>
> Yes, I didn't put them in because I changed the functionality in 2/13 and
> there is a bug fix in 5/13. I thought you might want to do a quick diff of
> the git v6->v7 tree.
>
> Although given that most of the changes were in response to your comments in
> v6 I probably should have just put the tags in.
>

I get sane output from lstopo when applying these patches and booting
my Socionext SynQuacer in ACPI mode:

$ lstopo-no-graphics
Machine (31GB)
  Package L#0 + L3 L#0 (4096KB)
    L2 L#0 (256KB)
      L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU L#0 (P#0)
      L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1 + PU L#1 (P#1)
    L2 L#1 (256KB)
      L1d L#2 (32KB) + L1i L#2 (32KB) + Core L#2 + PU L#2 (P#2)
      L1d L#3 (32KB) + L1i L#3 (32KB) + Core L#3 + PU L#3 (P#3)
    L2 L#2 (256KB)
      L1d L#4 (32KB) + L1i L#4 (32KB) + Core L#4 + PU L#4 (P#4)
      L1d L#5 (32KB) + L1i L#5 (32KB) + Core L#5 + PU L#5 (P#5)
    L2 L#3 (256KB)
      L1d L#6 (32KB) + L1i L#6 (32KB) + Core L#6 + PU L#6 (P#6)
      L1d L#7 (32KB) + L1i L#7 (32KB) + Core L#7 + PU L#7 (P#7)
    L2 L#4 (256KB)
      L1d L#8 (32KB) + L1i L#8 (32KB) + Core L#8 + PU L#8 (P#8)
      L1d L#9 (32KB) + L1i L#9 (32KB) + Core L#9 + PU L#9 (P#9)
    L2 L#5 (256KB)
      L1d L#10 (32KB) + L1i L#10 (32KB) + Core L#10 + PU L#10 (P#10)
      L1d L#11 (32KB) + L1i L#11 (32KB) + Core L#11 + PU L#11 (P#11)
    L2 L#6 (256KB)
      L1d L#12 (32KB) + L1i L#12 (32KB) + Core L#12 + PU L#12 (P#12)
      L1d L#13 (32KB) + L1i L#13 (32KB) + Core L#13 + PU L#13 (P#13)
    L2 L#7 (256KB)
      L1d L#14 (32KB) + L1i L#14 (32KB) + Core L#14 + PU L#14 (P#14)
      L1d L#15 (32KB) + L1i L#15 (32KB) + Core L#15 + PU L#15 (P#15)
    L2 L#8 (256KB)
      L1d L#16 (32KB) + L1i L#16 (32KB) + Core L#16 + PU L#16 (P#16)
      L1d L#17 (32KB) + L1i L#17 (32KB) + Core L#17 + PU L#17 (P#17)
    L2 L#9 (256KB)
      L1d L#18 (32KB) + L1i L#18 (32KB) + Core L#18 + PU L#18 (P#18)
      L1d L#19 (32KB) + L1i L#19 (32KB) + Core L#19 + PU L#19 (P#19)
    L2 L#10 (256KB)
      L1d L#20 (32KB) + L1i L#20 (32KB) + Core L#20 + PU L#20 (P#20)
      L1d L#21 (32KB) + L1i L#21 (32KB) + Core L#21 + PU L#21 (P#21)
    L2 L#11 (256KB)
      L1d L#22 (32KB) + L1i L#22 (32KB) + Core L#22 + PU L#22 (P#22)
      L1d L#23 (32KB) + L1i L#23 (32KB) + Core L#23 + PU L#23 (P#23)
  HostBridge L#0
    PCIBridge
      PCIBridge
        PCI 1b21:0612
          Block(Disk) L#0 "sda"
  HostBridge L#3
    PCI 10de:128b
      GPU L#1 "renderD128"
      GPU L#2 "card0"
      GPU L#3 "controlD64"

So

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

*However*, while hacking on the firmware that exposes the table, I
noticed that a malformed structure (incorrect size) can get the parser
in an infinite loop, hanging the boot after

[    8.244281] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    8.251780] Serial: AMBA driver
[    8.255042] msm_serial: driver initialized
[    8.259752] ACPI PPTT: Cache Setup ACPI cpu 0
[    8.264121] ACPI PPTT: Looking for data cache
[    8.268484] ACPI PPTT: Looking for CPU 0's level 1 cache type 0

so I guess the parsing code could be made a bit more robust?
