Return-Path: <ben.hutchings@codethink.co.uk>
X-Google-Smtp-Source: AIpwx48oAItJECYrg+gWifb+OqkgZEwUCd6AG2BfhVKVVg68huAea9vHZc/uFXJt54ASTzrSgq1i
ARC-Seal: i=1; a=rsa-sha256; t=1522337337; cv=none;
        d=google.com; s=arc-20160816;
        b=Hx10BnFNElVkMWtI0OQKUUGKdUkWm1C03cPvj9+76C19/GO3fdIs1oBhQSJmACyxVa
         15cTB5pEdLbAOjicnCcP/9RuvJD9SP02zpOHCbyAQc2OT2EoaPPDhiAeR7Xx4wMYsonR
         /6toKo5/uPz5WH8pVABjtkSLY7nMuZ39/lrI4WPbDMDMv0fKPThGJuDTxq4V5ePu3PEy
         htTEygTu9DxbtH4mBNuz86clg9ycr+g2VrPwd/rLiX+rM8LwMMXfIGHuYbkWR2TAJXKo
         jnXSKI6suwXhYUJPxuerS5PLbsFpSRug6oj3IdHb8j8lnuqThZHgL9+ztup4tCT3eEFy
         gxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=6rCXdko5t3ZURWbi1KHMrobriuPn5Gjf0uYhpl5XrcY=;
        b=e7r8vKtTYevgp2lD50ExKEDMqpeD4+Nqb3W0NDn8gc2pjf8NOBtwvLwicbEFLoyn6t
         UdpbSLpqOOV0tB60hbKAac3rdziU5BGIT4xdYjSjGcKHdupoXTobe2Ad5PSQ7gJ1pX8l
         zEzukkYCnrH+iL1GpqJSd+ki+OTVsEXr4YnR9KHvP59Zn8DEbgWT1fLaxQS1NuQRe8i8
         h7f+X3K2lsAGZjKJPt99OC6+RgbYlQvkssbgPVUWBrT8ySbs9NxMTSJDmcNAnqzHKQ78
         lXwIccLQBkkoCurEFzP1gfktTeVL2SWiSJvFSjuZl2wSqv0QkNdltI61iLaotMdo9dog
         zcmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Message-ID: <1522337334.2654.14.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 009/134] PCI/MSI: Stop disabling MSI/MSI-X in
 pci_device_shutdown()
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Alex Williamson
 <alex.williamson@redhat.com>, David Arcari <darcari@redhat.com>, Myron
 Stowe <mstowe@redhat.com>, Lukas Wunner <lukas@wunner.de>,  Keith Busch
 <keith.busch@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Sasha Levin <alexander.levin@microsoft.com>
Date: Thu, 29 Mar 2018 16:28:54 +0100
In-Reply-To: <20180319171850.444128621@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
	 <20180319171850.444128621@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595390574168988527?=
X-GMAIL-MSGID: =?utf-8?q?1596286395787190534?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-19 at 19:04 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Prarit Bhargava <prarit@redhat.com>
> 
> 
> [ Upstream commit fda78d7a0ead144f4b2cdb582dcba47911f4952c ]
[...]
> The MSI disabling code was added by d52877c7b1af ("pci/irq: let
> pci_device_shutdown to call pci_msi_shutdown v2") because a driver left MSI
> enabled and kdump failed because the kexeced kernel wasn't prepared to
> receive the MSI interrupts.
> 
> Subsequent commits 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even
> if kernel doesn't support MSI")

This went into 4.2 and hasn't been backported.

> and  e80e7edc55ba ("PCI/MSI: Initialize MSI capability for all
> architectures")

This went into 4.5 and hasn't been backported.

> changed the kexeced kernel to disable all MSIs itself so it no longer
> depends on the crashed kernel to clean up after itself.
[...]

So I think 3.18-stable and 4.4-stable will need backports of the later
changes in order for this to work properly.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
