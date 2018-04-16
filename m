Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523917057; cv=none;
        d=google.com; s=arc-20160816;
        b=MUrX7uXIulKOhHEKi7BubAfNipNCDfHh/7yWpmeYswcSkMvGFP6U9ltVkQqJM1/BeG
         C78FUSkCIKf2xRdOHZm2AYUQpUb+7MlAlZ6m8TW9woiTM/ZoJtzwGEL9tkacQCUHLEPd
         qoZGjTGY8MglguQlRPoL2YU0GxLfx6cTTXdvd8FB3Ah3w7+Sg1QT18lVqIJMwm2I8Z29
         VQbfKM0PmrQP9NCc937ULmf0ID6KykbCzDQVMHRjs1DXv6jblmWw1lV4cdZwWSngloKq
         2QqZBxmGDx04NwcEaxLmG7BkatC1yV1WJyeCQs/YmTFJWz9MLucNfNb7SU2oAJqBNtZu
         GGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=6Isc1M2FZFjA9knTtR4nxK4FluLLK3BmGjWUWiTwv/M=;
        b=rygVOXYV6x7rHQKuyt92VBh/qbaSklx03VpUqaI1vLGWrwq5RKYRwcOYBD7dSeQctn
         btCCNn8AVxqMx9f0zTUcoAQ2+8n5QDOJwS8dvNza5O/gFvgkmU4+koXNayEdNvKBZyAr
         fyNeCxRC53tHR3dBmmAUM920fWV8Q9rtTqCpzw7j2NpRRJyNwDBq3hPqVB6e2oaaRnrt
         gocyhvysVeJEyXlnf/QrGKhnIhZEqWMwKkon/9lpkey9wQpr81j+bxAiPOK/T00bUWIV
         NmGGJR+ASz+fyGkCkXvaRRlldtf6b4gvIIyalLrfoHFYRsDi4JgvJVlP3FJDfMeZfGW0
         YGkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=irjBW05T;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=irjBW05T;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/1dZxKa6CGRruoa8hTYSr449jRmwA7ZEXyNhnY+4RFR/9NzdoNmPuAq27o7+vvJj7OktOHFg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org
Cc: Doug Berger <opendmb@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Brian Norris <computersforpeace@gmail.com>,
	Gregory Fong <gregory.0xf0@gmail.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] ARM: brcmstb: Add support for the V7 memory map
Date: Mon, 16 Apr 2018 15:17:34 -0700
Message-Id: <20180416221734.31965-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223210923.544-5-f.fainelli@gmail.com>
References: <20180223210923.544-1-f.fainelli@gmail.com> <20180223210923.544-5-f.fainelli@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593227538446054373?=
X-GMAIL-MSGID: =?utf-8?q?1597942852437587012?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Feb 2018 13:09:23 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> The 7278 device is the first device that includes support for the V7
> memory map developed for use in 64-bit architecture brcmstb devices.
> This map relocates the register physical offset from 0xF0000000 to
> 0x0000000008000000.
> 
> Since the ARM PERIPHBASE value is also relocated in the V7 memory map
> we can use its value to determine whether this device uses the new
> V7 memory map and therefore where to look for the SUN_TOP_CTRL
> register used to identify the chip family.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to soc/next, thanks!
--
Florian
