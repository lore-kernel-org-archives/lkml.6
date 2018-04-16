Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4/O7ilMph5gJWIek2RKFFNOEa9pV2xblRrYlIdLMIgT/TJjH5NGa1zjjkaJXnVqrQObtIXE
ARC-Seal: i=1; a=rsa-sha256; t=1523889970; cv=none;
        d=google.com; s=arc-20160816;
        b=N8+FU3ioarSJqmod10nFrgG/KuTiwSkJfNVXdISOVmuB7wp8VHcQJJoqNVloB7XF9/
         1bEiLT6BAqJVFf+hiKis8mxO3mhsLJbsZyFQ0XDULTy+SqLcp8EAnMdwNVXOLo5w5+nu
         3+6GW5M74eMlRY7E0JIHv/zt/NDiWsfTuNz9MQIrEmfD18bJouRmoQAoveyaiCVMy0G4
         ZBxBPZ+xV6j2xGLIjpJiZfafIXgSBXEkUkaV+inlh47MzTRfJYcgWZuOJdn733nUBRtK
         fgvgODADzL/OmJoPixgyjHBPChgO4HasKkcrwQLUI8sdza3vFd2DE70+jA5icZNtp2kp
         2ceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=vGq3Xl49xNHG7T/nuxkuVYk6MWk2SSP8NGWP69p3hD4=;
        b=Rnc+kVw3uGgxrmgrSVzpG2MCZiGReYEA/+FQdtl1MqL5zJMmi59H9W0l5f+KCX1Rrh
         uL4k/g589fadMynlKhUcxGjS6Ea9amXGHV9B3l4IudmTL8Oogr43pMhEFOCutPPtIJ5z
         TwlwRCdpmeXrNmLwNlKM8O7bHKpz/gJAes36UK4rbng05V5MQQ4/BQfF4OBcmGtKE7F3
         /RemYuBt1WRhbm5wYSId3Tlean407v2FglZcDAAcp5s6oSGHjSTy3QIXQ/pidDZDit/B
         Fhtx6ixDySsm9oNQyG6erO4qlZA4NFB99PHEaLHuj8IyiVCEZyIIe9VGawCzYfdE5DTB
         oRxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cRoTCCF1;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QSpI9byu;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cRoTCCF1;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QSpI9byu;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9162A60AE0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>, Oza Pawandeep <poza@codeaurora.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Wei Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
 <13efe2e8-74c8-acb4-ec58-f79b14a1f182@codeaurora.org>
 <20180412140648.GD145698@bhelgaas-glaptop.roam.corp.google.com>
 <ca7e5285-2e88-e130-6402-a271bb92a81e@codeaurora.org>
 <20180412143954.GB4810@localhost.localdomain>
 <20180412150231.GD4810@localhost.localdomain>
 <ea977780-6f90-af5a-442f-575536038307@codeaurora.org>
 <20180412170911.GA6424@localhost.localdomain>
 <fa167b21-f70d-a220-5671-5ad66a0f72c0@codeaurora.org>
 <cced24b5-c0bd-138a-0304-c87cac2ec226@codeaurora.org>
 <20180416031726.GB158153@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <c236b732-ed65-9f94-7ae5-b1203dff2eb0@codeaurora.org>
Date: Mon, 16 Apr 2018 10:46:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416031726.GB158153@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027488013564?=
X-GMAIL-MSGID: =?utf-8?q?1597914450143067267?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/15/2018 11:17 PM, Bjorn Helgaas wrote:
> It doesn't seem right to me that we handle both ERR_NONFATAL and
> ERR_FATAL events differently if we happen to have DPC support in a
> switch.
> 
> Maybe we should consider triggering DPC only on ERR_FATAL?  That would
> keep DPC out of the ERR_NONFATAL cases.
> 
>From reliability perspective, it makes sense. DPC handles NONFATAL errors
by bringing down the link. If error happened behind a switch and root port
is handling DPC, we are impacting a lot of devices operation because of one
faulty device.

Keith, do you have any preference on this direction?

> For ERR_FATAL, maybe we should bite the bullet and use
> remove/re-enumerate for AER as well as for DPC.  That would be painful
> for higher-level software, but if we're willing to accept that pain
> for new systems that support DPC, maybe life would be better overall
> if it worked the same way on systems without DPC?

Sure, we can go to this route as well.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
