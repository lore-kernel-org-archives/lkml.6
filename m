Return-Path: <rafael.j.wysocki@intel.com>
X-Google-Smtp-Source: AH8x224TaSh65Xg5m8IkD8AE/3Db0HDHmKfd7SRTCZKAp2RzPwQtMxDcuM+9FY6C1ldDPKPqNyt9
ARC-Seal: i=1; a=rsa-sha256; t=1519306317; cv=none;
        d=google.com; s=arc-20160816;
        b=ANw/Hgcasxmx77jNyrErDnwQfup/AMk2ZnDXCXi9iUlQ8H6z6PFI/Cctho3VoFX4cK
         y1dILGWiKSem/JqoccLCBfOcljZUpEadPOSdS235BAzIGnyEgbJONC+D8FjqjdjkUG87
         Z1EcAr0o7AtWeNVa4oLciI6+3w/RxZCwgd2IhllNSCLZ9S81Ypr/P3O6XaN+pcTw0xpu
         VD/OoaByWeH3LIxZwmoKLN4nJEJtEQrnKPONml49Atl1opHDwly12VqXpAXTD3orB5BA
         zxNWcnkxL1kLG2hTt7mIH7gkV00f114WGdAFNP3Woaxqp08dJFphLYPpXttRvb3RNsJX
         Js3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=rF5185uwy2ykuYkyjJeNwTqaWdVKxXqn64ifofv8Tio=;
        b=wBtPqxNR0zCOFlDJeKvhUqbJYvlmNOyMB5onqVQijGpD1edUc31BfAqi4moFgeNfLb
         rEMxfy3XSH6+MpoEjvzwNwKsdrYy8i+GFEmTobsOIhQtTe0yEZIyIDghFxPxmxEnKgU6
         tuy9NlYBD4mt42cOCzQ9OLCSwS4nrFvfAC356+ox8UC1eLdjQ0c8Iuz3BU/57iiSLJGt
         dv7UHacieKA0dApGF2MggtrfRAEV7ZItpX5XQNJ7pxsIIHEfryb9C4cw5Fg4uzhUkaQd
         MEwOL+O8jpUX3+DBmtZqDqB/tecJjP95kFYVAyWKwbDg9Ft4tIBrDlRziOCOZkQM2XSr
         lPuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rafael.j.wysocki@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=rafael.j.wysocki@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rafael.j.wysocki@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=rafael.j.wysocki@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="177240041"
Subject: Re: [PATCH v1 2/2] PCI: Allow user to request power management of
 conventional and hotplug bridges
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
 Mathias Nyman <mathias.nyman@intel.com>, Linux PM
 <linux-pm@vger.kernel.org>, Mika Westerberg
 <mika.westerberg@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Peter Wu <peter@lekensteyn.nl>, Qipeng Zha <qipeng.zha@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andreas Noever <andreas.noever@gmail.com>, Dave Airlie <airlied@gmail.com>,
 Qi Zheng <qi.zheng@intel.com>
References: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <151908204614.37696.12828004282495415825.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0irpPi4PXPHWaSpa3=MpUY4Sg3C-iHd0LPQN+FN-VTRpQ@mail.gmail.com>
 <20180220181554.GA32228@bhelgaas-glaptop.roam.corp.google.com>
 <20180222131834.GA5527@wunner.de>
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <93faaf7b-5f9a-72e7-7816-47b83887740d@intel.com>
Date: Thu, 22 Feb 2018 14:31:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222131834.GA5527@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592872976935903628?=
X-GMAIL-MSGID: =?utf-8?q?1593108141855291535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/22/2018 2:18 PM, Lukas Wunner wrote:
> On Tue, Feb 20, 2018 at 12:15:54PM -0600, Bjorn Helgaas wrote:
>> Basically I was hoping to partially rectify what I think was a mistake
>> on my part when we merged this.  9d26d3a8f1b0 ("PCI: Put PCIe ports
>> into D3 during suspend") is somewhat misleading because it suggests
>> that PCI bridge power management can only be supported on non-hotplug
>> PCIe ports, when in fact this was mostly a question of testing and "we
>> know this works on the systems we care about so we're going to
>> minimize our risk by excluding others".  These constraints seem pretty
>> Intel-centric and it's not clear how or whether they apply to other
>> architectures.
>>
>> Adding the comments will help with that some, but in general I don't
>> like to artificially limit feature support because it reduces testing
>> exposure and makes future maintenance more difficult.
>>
>> For example, we disallow D3 for hotplug bridges.  I don't think the
>> spec requires that, so the fact that we put that limitation in
>> suggests that there was some issue we didn't fully understand, and now
>> it will be hard to go back and figure that out if and when we *do*
>> want to support D3 for hotplug bridges.
> Some x86 machines which handle hotplug in firmware, rather than natively
> by the OS, require that the OS doesn't transition them to D3hot behind
> the firmware's back.  That's the reason why Mika excluded them from
> runtime PM:
> https://bugzilla.kernel.org/show_bug.cgi?id=53811
>
> If the OS handles hotplug natively, transitioning the ports to D3hot
> should be fine in theory.  I submitted this series last May to extend
> runtime PM to those:
> https://www.spinics.net/lists/linux-pci/msg60962.html
>
> However Ashok Raj tested them on a Xeon-SP system and got Hardware Errors:
> https://lkml.org/lkml/2017/5/3/480
>
> I'm not sure if I've done anything wrong in that series or if we're
> dealing with an incompatibility of this particular platform with D3hot
> on hotplug ports.

Thanks for mentioning that, and for the pointers!

> We do need runtime PM on hotplug ports to power off Thunderbolt
> controllers when nothing is plugged in.  That saves 1.5 W, so a
> noticeable amount of power.  I was going to respin the series one
> of these days, I think the best I can do is continue to forbid
> runtime PM on hotplug ports by default, but whitelist it for
> Thunderbolt and allow manually enabling it on other platforms via
> the command line.  That way, vendors are put in a position to
> validate their platforms for runtime PM of hotplug ports, and
> perhaps someday we can enable it for all platforms by default,
> but with a BIOS cut-off date.
>
> As for the existing 2015 cut-off for non-hotplug ports, I remember
> Rafael writing that we may try to slowly push the cut-off further
> back into the past and stop as soon as problems are reported.
> That hasn't happened yet because noone had a need for it.

Right.

There's more background related to this particular thing worth 
mentioning IMO.  I'll write about it later today.

Thanks,
Rafael
