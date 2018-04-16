Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AIpwx4+mDCj85T0anzM7RbZSLZfzA4SrSTkN9lalwB1J8dYZtOxofsd/ssAGAAF9vpZhoIKrYbQG
ARC-Seal: i=1; a=rsa-sha256; t=1523848572; cv=none;
        d=google.com; s=arc-20160816;
        b=CFPTWPR9wdD+w/iJRw1kATEWcU5XBNN09Ai/P0tbAqJf5fiU8BekQH7deYMLj/2zGa
         9wyOYj5Bpfqpox6NFmnbItV3dLZNSXdw0RWlcZGVTNJ2nz/N+bbGhf99y6uS6/xCo3gC
         BNRC3sF60Pe1V8qjSQF6I6Oef6bZF2FaW/Ke06fnnzCqKNBJXn943Gpu9sBMsQhdNE6t
         STKum3dyjbP5RQNkGvMiMmnSGUnfvM5LeJOWOtvHKUaNQFZ6qPb8tm5aEtVw7AeS6/r6
         vdDmZjgH6lJ2pKqL2jqza1fFuEebguOAZvEdRmV5evJSocYQZBu+6RbZBHbabOk2wwjS
         pu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=H5keOF6J5agvgpPetPSNvvdVXUID0t0GbUpoyIILPYs=;
        b=LpTZfospkPuc20nJmMecqFLhjAEcseGatSwECVXMEVtoLDbfNYSed5PyHttHZzWsw1
         i3kvoZZcryTpVhgFdHE3GNwseD2egUV0NjXQyDeqx6xLzlcGclZQM+BRk3TKOz6W/51Y
         exHnazWHXSd6aeT0fLovDsDBeVMF/CsvLHyxbnzM5mNgzYNYVGIQYr1J/+dHlfwG5e4j
         Ahi0U26GkcwbRYTjuNLleiFJSKdTyvgUSzCTvQ4bHpofL9A4SWQsNq6W4H0p5rc+UApo
         F6AjGAiw3IArDIl5DVExfavWT54rZnwAYn8Kfm65Xu0fFNgviNGIFUi4vAO3UBybhtno
         IKjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDF821775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Sun, 15 Apr 2018 22:16:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v13 0/6] Address error and recovery for AER and DPC
Message-ID: <20180416031600.GB80087@bhelgaas-glaptop.roam.corp.google.com>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027023020186?=
X-GMAIL-MSGID: =?utf-8?q?1597871041055533029?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:41:48AM -0400, Oza Pawandeep wrote:
> This patch set brings in error handling support for DPC
> 
> The current implementation of AER and error message broadcasting to the
> EP driver is tightly coupled and limited to AER service driver.
> It is important to factor out broadcasting and other link handling
> callbacks. So that not only when AER gets triggered, but also when DPC get
> triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
> 
> DPC should behave identical to AER as far as error handling is concerned.
> DPC should remove the devices and not to do recovery for hotplug enabled system.

Is there a specific bug that's fixed by these patches?  I didn't see
one mentioned in the changelogs.
