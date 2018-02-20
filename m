Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519120628; cv=none;
        d=google.com; s=arc-20160816;
        b=OJ1wxMyqUNj0hnZDr4NScmH3VXf8y7e8wFncd6c7QJzXysweuqEz5VXYtotL3xpXY7
         B+YjtE4g1KbSTQ8STqCeKQy8bQXWcb4BtYA8/jU6o7JJQ+dx/SD/tTA34dHvwWyiR7DZ
         wywBsp/HYpG2foS1JCfFkQqh/5kBMYlZQBwQO6/IvuWlTCeYDuVg1fkWhn0RLttsBblN
         pAVRIO8cDnBYiMen+mPYjQ/CbT/eQB9zKSTKt6PjQb1k+CRZ1JRJZVe7T/2I6ynBaJH6
         3XZNtzjhlcjDOFApe0wvu2Lo7AbrcKtX1DnmUyn/oSQeRHzbA001f/fyJmHBm55AI69n
         xYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=AJ1isu7Dhg7VTybvrfS6VLDa6Vy4KFB2TmS61XOrsqo=;
        b=op+Km3cKVRcsafX2UcOzPwFwkLQ2lnXGtFhTyy/2Lx8IL0Bw3CFRvXu9WXrWYfVon1
         F3lPnXYF7CYd9Rw6NLprtyx8m69J2uL+YkrK7aeH21bzOcq5i34La3P9tvJ1N+BIy7QM
         gbzcpjzRMkSAfnAzRqPmH3DHafcfULZjbas9YMQqpUHDMv04JEXJVEDL4wRwkUOdy2zy
         cP5Fk69OkV+ezdBrLMSLLpk4YB2U7S4nvSwJcxBi3hSdiLk9YRbPuUW8c431V0HvDQ88
         tcuLeBfx6CEDiEHRj694wUx8SpVnOqdextB3Er0S9lueMKX+VLLmtuEBGnpIJGHsng2G
         ZvLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gFiRZtJg;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gFiRZtJg;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AH8x225sJnTWK+5b6z7r0lht8yrL0t9YejyZWty1hG3fvuw6oK1JOP4364cizP6wX2zZ+ToeLuT+62aed7XPeohnFJo=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <CAJZ5v0irpPi4PXPHWaSpa3=MpUY4Sg3C-iHd0LPQN+FN-VTRpQ@mail.gmail.com>
References: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <151908204614.37696.12828004282495415825.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0irpPi4PXPHWaSpa3=MpUY4Sg3C-iHd0LPQN+FN-VTRpQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Feb 2018 10:57:07 +0100
X-Google-Sender-Auth: Xkn_xF595vSKc4L1nqa3ANyrv6A
Message-ID: <CAJZ5v0goX+Op9WwyPn1eNNreatA0WFsqpEYontmEL7etNDudpQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PCI: Allow user to request power management of
 conventional and hotplug bridges
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	Mathias Nyman <mathias.nyman@intel.com>, Linux PM <linux-pm@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Peter Wu <peter@lekensteyn.nl>, Qipeng Zha <qipeng.zha@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andreas Noever <andreas.noever@gmail.com>,
	Dave Airlie <airlied@gmail.com>, Qi Zheng <qi.zheng@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592872976935903628?=
X-GMAIL-MSGID: =?utf-8?q?1592913431607134594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 10:41 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Feb 20, 2018 at 12:14 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> From: Bjorn Helgaas <bhelgaas@google.com>
>>
>> Previously "pcie_port_pm=force" enabled power management of PCI bridges,
>> but only for PCIe ports (not conventional PCI bridges) and only for ports
>> that do not support hotplug.  Those limitations are there because we're not
>> confident that all those configurations work, not because the spec requires
>> them.
>>
>> Change "pcie_port_pm=force" to enable power management of conventional PCI
>> bridges and hotplug bridges as well as PCIe ports.  As with the previous
>> PCIe port-only behavior, this is not expected to work in all systems.
>>
>> Add a "pci=bridge_pm" parameter to reflect the increased scope.  For
>> backward compatibility, retain "pcie_port_pm=force" as an undocumented
>> equivalent.
>>
>> Add "pci=no_bridge_pm" as an equivalent to "pcie_port_pm=off".  This
>> disables power management for all PCI bridges, which is results in the same
>> behavior as before, since we always disabled power management of
>> conventional PCI bridges, and "pcie_port_pm=off" disabled it for PCIe
>> ports.
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Honestly, I wouldn't do that, at least not this way.
>
> Somebody might be using pcie_port_pm=force already, for example, and
> it works for them for PCIe, but the PCI-to-PCI part of the same system
> may not.
>
> IMO the behavior of pcie_port_pm= should be as is and I don't see
> what's wrong with it being documented.

That said it may be useful to add something like this to the
documentation of it in kernel-parameters.txt:

[PCIe port power management is needed to enable SoC-wide power
management on some SoCs shipping since 2015, so it is enabled by
default on systems from 2015 and newer.  Some older systems may still
benefit from it and it may not work on some newer systems due to
hardware problems.  Use this parameter in those cases.]
