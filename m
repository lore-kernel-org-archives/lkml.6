Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519829016; cv=none;
        d=google.com; s=arc-20160816;
        b=ud9Z/EWWWw4KLciVuSQ3AQGKtrwQPs+k/5vw5JYd8yx9v1cGvopF/WL1HANHQ1L2Sq
         p0PTpk5JxpwmprB8HSqb8HMQdhQ7xIMddulx4gZGHw/D8UIXl8YdOvW1HZ8Gcc3q15Vh
         7WxrPErmpN5ZNMU3TdUSG/+rhu2M97oXnNb3Khg8n5Ee2sIb9HM+yAKdjU5iIKd9sbNX
         CcLcpWpJ7OINsquWQXbKFRIm9VkVSOpEeRrk5y0DbIRqyjEyJhtiF3CeZMtLPLflwear
         xg5nKqHBs3Jq4fNcKppsKj6ao/RBE669gHee7t5ySM+9kUMIL/f6vBhjzqGHLvO9bDHy
         g6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=23tUOrsWbGan0/LnHA1O+GjGE3rIl6LWnc4zeve57XY=;
        b=rcdS7UICnl3D+ZyHBI0bhqHcu3D3YOJsnWCdpNLsRlw/kUgknmd/jlmivdwwqdHfsJ
         n/uSu5tkCg8y0hnrrQgHvB8YNHpjiUfBmS5teLUoOatPROPC7TuaUefKA8UbdDhIWmJi
         SuyW/D/cUvOsLiyE5O6ZHHd/5wSmHSJNzQ9Rzui5NHuU65IOnlmE2EPiTI108DlEk7T7
         Q3fZYrILEuepV7grh+BP/99HfGNLspAaaXnzeSSq0wGIH5gtlH8fFF6OuQYMsJuDTxdy
         B59PJsHAKWJ3SzgZ2c3FzPv6ixn+pVebsOZV6W5SSY2YIX24s8ymCcK3wIPTbrdsWGw0
         FLKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oBeLhbhq;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oBeLhbhq;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELs2vI3xzFa9Cf2vfePHDIwIb7SS8VAdaRmqdb+e3foEqzdaTUPYQhJpDXl0DHNYL2SNTunSiNkR5vrlmvr82a0=
MIME-Version: 1.0
In-Reply-To: <20180228084418.7566-1-jthumshirn@suse.de>
References: <20180228084418.7566-1-jthumshirn@suse.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2018 16:43:35 +0200
Message-ID: <CAHp75VfbZCitjh2spwCqFCa5ckLp2rTqqgT17NWiuSgwrL_=vQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] MCB Update for v4.17
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, Michael Moese <mmoese@suse.de>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593633633623715262?=
X-GMAIL-MSGID: =?utf-8?q?1593656230666428282?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:44 AM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> Hi Greg or Bjorn,
>
> here's a small mcb update for the 4.17 window. The first patch makes
> the PCI Vendor ID of Altera generally available in pci_ids.h and
> removes it from the two private implementations before I would have to
> add a 3rd one.
>
> The 2nd patch adds the Altera's PCI vendor ID to the mcb pci driver
> which enables at least one carrier board. This was reported and tested
> by Ben Turner.
>
> Bjorn asked me to Cc linux-pci@ in his response, so I'm not sure if he want's
> to merge these two patches. I'm fine either way.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Thanks,
>         Johannes
>
> Changes to v1:
> * Removed redundant pci_ids.h include
>
> Johannes Thumshirn (2):
>   PCI: add vendor id for Altera
>   mcb: add Altera PCI ID to mcb-pci
>
>  drivers/char/xillybus/xillybus_pcie.c | 1 -
>  drivers/fpga/altera-cvp.c             | 2 --
>  drivers/mcb/mcb-pci.c                 | 1 +
>  include/linux/pci_ids.h               | 2 ++
>  4 files changed, 3 insertions(+), 3 deletions(-)
>
> --
> 2.13.6
>



-- 
With Best Regards,
Andy Shevchenko
