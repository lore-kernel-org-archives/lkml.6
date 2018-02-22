Return-Path: <BATV+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AH8x226Y4xNfpNQ72QLOR5G2DvFj4XrLyGt8eLo7l57H20Bi96hrKPbPdiR5il9PyQHMLmm7xJ/7
ARC-Seal: i=1; a=rsa-sha256; t=1519324491; cv=none;
        d=google.com; s=arc-20160816;
        b=rJNyal8kWuZOCOMUovQGYH9IpuK0oeh2OAJbUokLCBOffezbbeaVtRG6sUXOwzRtGG
         rq7NkZ4cQu1/NowUZeoUEV3ma3932/kJlLeVfeBZhF/rgUdkbS5PHtm49gVBZLgTi7S/
         V/RpTD+PBW9f9ChvdQ2XKLDr9c9zsAE22Abzc1NvBF0SCx75i6dfNMVC/ORrR3RiWonX
         ak/aqmHwxrPnv4mICd1jdUuLpQt30rjL5RBBq5HtEny+8WSeoITh+BB1am5++E3OrBgF
         8Jf3ru9hBRDI1fxhQiO0Q3thu+JjAwv3GYiQXE859Q0PciNmwWuKYEelKXP0pPah8Kdq
         He2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=w4zsWXmhdgARw/oYUN+S6BcL7ghImyMouKRB//+l01E=;
        b=aK4/1VUxz9Tq2zpRe4ZkrJqHQQsiV5NNRjlk1KMA4w2L4BmJjRpT1Oe+h8FJ2kc5YW
         HVCFpRZp6mwMO7Ge/r5RoqFCwfp11hWvWh07Q2FGeaaYVldt3/EqZ7wWwboKCqCvs+bn
         uAj2WUpn1VrRjfOrYqLm6J2bk65pIPHGoQtSyLBbMr7W60ITqHEEu7JUKjwpR63yI41w
         XsJS8PK0MmCzuqzWjg0/V8Ih87CoIBnxIC8gZ/AoKXkjvT1KqaCAsdkEoUITjQsoMHjj
         mn5NBEYGnjgb6zi4k4bt7dQVCMH2/F+5q0EcvVq+OT6lDd1Edfnfpev7jyKxE3ohMz/V
         3u1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=QWQ2Lp8+;
       spf=pass (google.com: best guess record for domain of batv+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=QWQ2Lp8+;
       spf=pass (google.com: best guess record for domain of batv+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org
Date: Thu, 22 Feb 2018 10:34:48 -0800
From: Christoph Hellwig <hch@infradead.org>
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
Subject: Re: [PATCH v10 2/7] PCI/AER: factor out error reporting from AER
Message-ID: <20180222183448.GB6267@infradead.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
 <1519315332-26852-3-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519315332-26852-3-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086410511514158?=
X-GMAIL-MSGID: =?utf-8?q?1593127197260045392?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
> -	/* TODO: Should kernel panic here? */
> -	pci_info(dev, "AER: Device recovery failed\n");
> -}
> +EXPORT_SYMBOL(pci_find_aer_service);

EXPORT_SYMBPOL_GPL please.
