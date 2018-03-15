Return-Path: <mathias.nyman@linux.intel.com>
X-Google-Smtp-Source: AG47ELu+ixZjgxL3aRQ8a4dDVhUsEnMFKpWl4wYmLSQPV8l85zgOyCsI0BCQWyKELRmsBVZtQ9/H
ARC-Seal: i=1; a=rsa-sha256; t=1521130620; cv=none;
        d=google.com; s=arc-20160816;
        b=QJEbYWfvFXjH8d07Ew27o9saXjDDhUMPyj9/XnuzJPcbcilf79TdPWKOkd6YAFfTEx
         C+rS0O/idp2fi8exiUgYgs7noHalaK0GZSPfLgTwyjyySnd0BrzdbSkR/z43EIZm+Xul
         IW0fnJ3rM+7CWFJ5mfGlJ57sTcSdQEIIvu0JA+wzJhU7JOtF+iFwuw0rVtcp8YeFEI+e
         OZN2V5CpiNS41iJkxrIhIkQ/4zUsNDABTjiEwnaIBnHzHdSVHodUIvPan2qlQddRfJ6F
         S46dVHLYGhRwRXOKOxiWn54HI3HJWPLzo9L77OsckjDWex1JojOOYv2jCDmSYE8qaY2c
         Wzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=AayaDRye5WbzQWAMu5W531LNHfSOJfW0G6kuMVSiW3A=;
        b=eaYPTrFa/clPg/bid8bnP9dOhU98hUlPYJrXpV7UK1s0QAvyvUejr9dFAuHavIfypC
         t/cRZZ585SRtX1UFrONm3bOUkTdu+ulga6h71cMebQFnkru7Qvz4Gp93U3hp+ZEv8jPU
         z+1f3Cv7hch7WoqQ2A1NfEymtWv+EA/6DPQ4HdfHgK8kAj/XoetjkeRHmbfjU0EQa6gF
         I1SURq7nPUcc0wFevD6QK/NJl6kcQLpMMlZSXLHrtQoCdBmwDN5HQDtISOQ/OFPl4oNT
         booTUo1MfnGxupJdOUdmu+9NTV6GCkFiV90fYSBdbUYrNPxgd8yuzxVGOv6QHjlTB0uh
         C9QA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mathias.nyman@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=mathias.nyman@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mathias.nyman@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=mathias.nyman@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,311,1517904000";
   d="scan'208";a="38273808"
Subject: Re: Intel GemniLake xHCI connected devices can never wake up the
 system from suspend
To: Chris Chiu <chiu@endlessm.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
 Linux Upstreaming Team <linux@endlessm.com>
References: <CAB4CAwf_k-WsF3zL4epm9TKAOu0h=Bv1XhXV_gY3bziOo_NPKA@mail.gmail.com>
 <6c8df688-b456-6f07-9325-6f4dfd8f0883@linux.intel.com>
 <CAB4CAwf39wW2LmuY-TZNdfgL=SBiDZuXvRNu7MD7j5Nc8O-bkg@mail.gmail.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <278fe5fa-7b33-02e5-12e3-b7760952b297@linux.intel.com>
Date: Thu, 15 Mar 2018 18:11:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAB4CAwf39wW2LmuY-TZNdfgL=SBiDZuXvRNu7MD7j5Nc8O-bkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594977262317953417?=
X-GMAIL-MSGID: =?utf-8?q?1595021062141410787?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15.03.2018 15:28, Chris Chiu wrote:
> On Thu, Mar 15, 2018 at 7:46 PM, Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
>> On 15.03.2018 06:40, Chris Chiu wrote:
>>>
>>> Hi,
>>>       I  have a ASUS AIO V222GA and another Acer Desktop XC-830 both
>>> have Intel CPU J5005 and they both hit the same problem. The XHCI
>>> connected USB keyboard/mouse can never wakeup the system from suspend.
>>> It reminds me that similiar thing happens on ApolloLake too which
>>> needs the XHCI_PME_STUCK_QUIRK to get it work. It's also mentioned in
>>>
>>> https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/pentium-celeron-n-series-spec-update.pdf
>>> page #14 for N-seris intel CPU. And I also find the same problem
>>> description in
>>> https://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/silver-celeron-spec-update.pdf
>>> page #16 for J-series Intel CPU. Seems that they have different
>>> workaround so I can not simply apply XHCI_PME_STUCK_QUIRK to make it
>>> work.
>>>
>>>       Anyone can help here?
>>>
>>
>> N-Series
>> CHP8: USB xHCI Controller May Not Re-Enter D3 State After a USB Wake Event
>> - needs XHCI_PME_STUCK_QUIRK in driver (sets bit 28 at offset 80a4)
>>
>> Intel® Pentium® Silver N5000
>> Intel® Pentium® Silver J5005
>> Intel® Celeron® N4000 and N4100
>> Intel® Celeron® J4105 and J4005
>>
>> USB xHCI Controller May Not Re-enter a D3 State After a USB Wake Even
>> Need to clear PME_EN bit of of the standard PCI PM_CSR register.
>> I think Linux does this anyway (clears enabling PME when reaching D0)
>> So if I remember correct there was no specific workaround needed for this.
>>
>> what is the PCI ID of your xhci controller? (lspci -nn)
> 
> They're both 8086:31a8. So you mean from the workaround description, it should
> work w/o any extra code? "Software should clear bit 8 (PME_EN) of PM_CSR" has
> been handled somewhere else?
> 
>>
>> One other possible cause is that xHCI never reaches PCI device D3 suspend
>> state during system suspend.
>> xHC can't generate PME# wake event from normal running PCI device D0 state.
>>
>> PCI code in Linux will check with ACPI about the lowest possible D state
>> when suspending,
>> If there is something missing from the xHCI entry in ACPI DSDT table it
>> might select D0.
>> as the suspend state, causing wake failure.
>>
> 
> Here's the DSDT ASL of the ASUS machine.
> https://gist.github.com/mschiu77/8e9c8a0e5a98b70a6dfff45620340bf1

Scope (_SB.PCI0.XHC) has _PS0 method, so Linux will look for a _S3W to get the
lowest possible D state in S3, but_S3W is missing, so Linux pci-acpi code will
probably default to D0

> 
> 
> ASUS said the BIOS has no problem on USB wakeup under Windows so I don't think
> there's any update. Anything else could be cause for this?

Linux and Windows probably check different DSDT values

You can try to force your xHC to D3 during suspend with a hack:

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 7815768..da46c52 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -488,6 +488,10 @@ static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
         else
                 d_max = ACPI_STATE_D3_COLD;
         acpi_state = acpi_pm_device_sleep_state(&pdev->dev, NULL, d_max);
+
+       if (pdev->device == 0x31a8)
+               acpi_state = ACPI_STATE_D3_HOT;
+
         if (acpi_state < 0)
                 return PCI_POWER_ERROR;
  
and see if usb wake starts to work

-Mathias
