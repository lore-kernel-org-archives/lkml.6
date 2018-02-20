Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519153258; cv=none;
        d=google.com; s=arc-20160816;
        b=NK12MPR9vN4eeVMilP9g2CIj5ssTdsP8odax2JJPOgMDQ44ZWnMl/2Ij+0PF1D5rL9
         97VLogA/SJVXKHc6Q/8FgqE9o06pS3j0TZl/FLeDoyl0bj5pFIun63KgHYVWbNzrjZpw
         G+fcALa5yOfEB4l4jc5fEVe2d3wh081eej9GYXXgGlqUba/5pD5MSc9Uxd2JzM53Apyo
         W7iYibmigKrnFY/6Gk593F+eE65NInPeqEc8yIcLqHLxMzMLfnPqGyv6D631vDa4FOXR
         kzQjBDP176N6/nMZl05qnl0/H4e8RyBdf88pSGZt0je1Nzp6o54LDwyJgEHGiobhDSpO
         JNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=AewpDx5e0uBsUb08oBZhtWYDhcu3lZRijC+r24PILa4=;
        b=hNhyfwE+iQEC1/i7m3vUp6uP0z/QrAiL0GF6HD57tKMPC4G2KMqe2QYi1+kdn3bafI
         st4c5d0a/fZyEwRqgII8OzdxnGFUwHZw135y9XgUsbvi2diiUDecGyAqRE0sr3bBw4af
         EzUyvmyj/T7Yc837rgfSMlO3Nzl7fKo4/iNXIUrdwrR7p1N0O2q9THLS7+BLVSryMPWm
         Zb0TvwzlpVoLVhoTqehxGcVX+f7I1kFHWshEE/J0Jm7UpFTF+4dikCNvjlMhvDtMQdIN
         wxxeaVJR5nx5QuRJMyW1a1ZPo+0Fxgd2jd9HX5un8pZJhLNZ9bb1UxBIIQkjA+dRSfoJ
         hAig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aVN8feW/;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aVN8feW/;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AH8x226Im1Ahdz8AzWx3YvPCP37K9NpYsTjF5QaKLfosfE/gB0zaXf0tfnTBgyWUKvYnvyxRk5P1FzSGsoVYNt4q0Nk=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180220181554.GA32228@bhelgaas-glaptop.roam.corp.google.com>
References: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <151908204614.37696.12828004282495415825.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0irpPi4PXPHWaSpa3=MpUY4Sg3C-iHd0LPQN+FN-VTRpQ@mail.gmail.com> <20180220181554.GA32228@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Feb 2018 20:00:57 +0100
X-Google-Sender-Auth: kaSZx6POIEYtStq-ivlgwpAtDI8
Message-ID: <CAJZ5v0jqe6Jv9_tjUD=9d9VkxgQRLGpzqo2qJkLc2n3g6EsGAg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PCI: Allow user to request power management of
 conventional and hotplug bridges
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
	Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Mathias Nyman <mathias.nyman@intel.com>,
	Linux PM <linux-pm@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Peter Wu <peter@lekensteyn.nl>, Qipeng Zha <qipeng.zha@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andreas Noever <andreas.noever@gmail.com>,
	Dave Airlie <airlied@gmail.com>, Qi Zheng <qi.zheng@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592872976935903628?=
X-GMAIL-MSGID: =?utf-8?q?1592947647145293781?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 7:15 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Feb 20, 2018 at 10:41:33AM +0100, Rafael J. Wysocki wrote:
>> On Tue, Feb 20, 2018 at 12:14 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > From: Bjorn Helgaas <bhelgaas@google.com>
>> >
>> > Previously "pcie_port_pm=force" enabled power management of PCI bridges,
>> > but only for PCIe ports (not conventional PCI bridges) and only for ports
>> > that do not support hotplug.  Those limitations are there because we're not
>> > confident that all those configurations work, not because the spec requires
>> > them.
>> >
>> > Change "pcie_port_pm=force" to enable power management of conventional PCI
>> > bridges and hotplug bridges as well as PCIe ports.  As with the previous
>> > PCIe port-only behavior, this is not expected to work in all systems.
>> >
>> > Add a "pci=bridge_pm" parameter to reflect the increased scope.  For
>> > backward compatibility, retain "pcie_port_pm=force" as an undocumented
>> > equivalent.
>> >
>> > Add "pci=no_bridge_pm" as an equivalent to "pcie_port_pm=off".  This
>> > disables power management for all PCI bridges, which is results in the same
>> > behavior as before, since we always disabled power management of
>> > conventional PCI bridges, and "pcie_port_pm=off" disabled it for PCIe
>> > ports.
>> >
>> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> Honestly, I wouldn't do that, at least not this way.
>>
>> Somebody might be using pcie_port_pm=force already, for example, and
>> it works for them for PCIe, but the PCI-to-PCI part of the same system
>> may not.
>
> Yes, you and Valdis are right, this is over-aggressive and I'll drop
> it.
>
>> IMO the behavior of pcie_port_pm= should be as is and I don't see
>> what's wrong with it being documented.
>>
>> Of course, you can add pci=bridge_pm/no_bridge_pm to extend the scope,
>> but for what reason really?  Just to follow the letter of the spec?
>
> Basically I was hoping to partially rectify what I think was a mistake
> on my part when we merged this.  9d26d3a8f1b0 ("PCI: Put PCIe ports
> into D3 during suspend") is somewhat misleading because it suggests
> that PCI bridge power management can only be supported on non-hotplug
> PCIe ports, when in fact this was mostly a question of testing and "we
> know this works on the systems we care about so we're going to
> minimize our risk by excluding others".  These constraints seem pretty
> Intel-centric and it's not clear how or whether they apply to other
> architectures.
>
> Adding the comments will help with that some, but in general I don't
> like to artificially limit feature support because it reduces testing
> exposure and makes future maintenance more difficult.
>
> For example, we disallow D3 for hotplug bridges.  I don't think the
> spec requires that, so the fact that we put that limitation in
> suggests that there was some issue we didn't fully understand, and now
> it will be hard to go back and figure that out if and when we *do*
> want to support D3 for hotplug bridges.

In this particular case we just wanted to limit the scope of changes
to what we were able to test at that time.

You seem to be arguing that the target coverage for a new feature
should always be maximum, because that makes future maintenance
easier.

While that might be the case, it places a lot of burden on the
developer who introduces the feature to also cover systems they may
not have access to and causes the test matrix to increase
significantly.

I prefer to limit the initial scope of changes to a set of systems
that can be tested and validated in a specific time frame as that is
much more friendly to developers working on the features in question.
It's just a different development strategy and it is generally
applicable regardless of which company the given developers work for
IMO.

> Anyway, I'll drop this one and just go with adding the comments.

Thanks!
