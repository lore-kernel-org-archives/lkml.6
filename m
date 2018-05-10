Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZpzEBtuq556GqwnuvKmlyZog33Ah7dFDTELfnyhbK8Ou/pxhASlQRetNMa0rwfj7lWFv5Hd
ARC-Seal: i=1; a=rsa-sha256; t=1525958288; cv=none;
        d=google.com; s=arc-20160816;
        b=Xcql54zIIwzsIMf0Z/jxnhGjk+9KssYH5oJGXc/utTNrwY9YJ8fjpEU6g4093a82oO
         Us1r9Zub+HdKhXwilDNAHYkW9enDXiXqH2vfl86cVqCFkKzoURRL9+9G7HpnrbAR63Gx
         J4sbJmUIqeZ5nKCWFcmQp/foULeotuXo/aXScFXGFFHc5ulm632u8vR7dSu7uOxCsMIL
         InIJp+I0oU+pDTs0oqUo0GRUdncwUQSA2riVwuEyqgVCdtQ6jmfhlRuTme/BSTXweXge
         sETMAXROFqJUbUDjTJ3CbQBtNXMP2FtQuE75dWijL/FgIbAkbs8OIA81VhfReZb3dfgz
         2RyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=MoEtQi+JZCjbwP2EsrScRpseWYJh4DJdoVT6cDP9p/w=;
        b=h1HuedmtC0vrgEQIGtbFHAuA/JMadkW0uXjUvF6xdmV+ZNaRUNsd0Wi5qKSwUxMXUg
         1zmAnlxEVixlY7ME42K151852qSC6lsSD4iaUjDD+gF2OehdMu58l5s/1CsuU77fPBpZ
         VdoHa70fwRWarqUncm/WbiXq4cq0l9+kr4Sy+Rv17fSrGGst6f9NAHftZC/EGviiN9i4
         bDYwoy0vHn6UhkQvicwOiAi5Qt+6c+A/H8KtJGCdDaSe5pLVqwSwYNVlNLLxHE2rvMRU
         4GDuuOByiGIcP8wQKZVsA4wZEefMoASosY3GaW+9G9urkxt0XZ2tL7mQsLyTbmYDeabO
         Ik3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Eechcm0I;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Eechcm0I;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 10 May 2018 08:18:06 -0500
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
Subject: Re: [PATCH v15 1/9] PCI: Unify wait for link active into generic PCI
Message-ID: <20180510131806.GD173327@bhelgaas-glaptop.roam.corp.google.com>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
 <1525323838-1735-2-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525323838-1735-2-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599417975971430440?=
X-GMAIL-MSGID: =?utf-8?q?1600083238646891647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 01:03:50AM -0400, Oza Pawandeep wrote:
> + * pcie_wait_for_link - Wait for link till it's active/inactive
> + * @pdev: Bridge device
> + * @active: waiting for active or inactive ?

s/inactive ?/inactive?/
