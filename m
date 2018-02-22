Return-Path: <BATV+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AH8x226t4kzZ0iXQZHo6kj8o7dkoqb7IL8Bc2a4Yksc0z33GChSUHliLUPVA8W82VCh3Ip36mAvy
ARC-Seal: i=1; a=rsa-sha256; t=1519324445; cv=none;
        d=google.com; s=arc-20160816;
        b=FAPas/0SeTQZlVKcOSF3/NSgjAks4AkPDrm0wtornrqNTxMpoX8jLrf7c30Cq7Zy4F
         nUxSsodwZ/loG1hqt+s9eTFHpgy7wIClKz59YajeTpucQVTA1+XIn9F/D3TjzAE4CK3u
         SYzke4MLym9P32ZqoWft8/LzWxky2ZrjGfd8IMJsAI4E0LRZIgEosV2kXvXDuKns0OBq
         EMV/JwUvNo5DQxXuEFzE8i64l/gqp3tn8tAoK5ZRe2CxpQqi56N0MVro8unrICs2H+68
         XW2kJY2d9pETbOQXfV4fFKCqrwNRTaEkGDMGw+wL+/7pcweO7Qmi6hFzPVoXaStltEie
         WWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=9KgjqA0d7uVApPhoxvxcoxjPLxi45K2mIYv0yP85QDc=;
        b=YUg41r4bLdugt63M+XKUdUsV/Sk0ze3SKDxAyXeOjRMGyetTkqUobRF8YlzoyXHIrW
         q9SJfDteLKwPK39XKhEuMjxQLR6XOhY7T64xhFWWtWWuh3jx9t5wdMQmV6/WPFfBkYly
         zTbWPXUtPtMWhfZFCT15zaHtAy3V5TCSqSZOI4piGN3oV+mRlrwXZBQtN2wVlev9R6MD
         bD/Z4DvhG3McPOcsyz86V8kdN/wnNGA41aX627K3Z+4lOngCoM22nf2kN90v8zODis/l
         62lIxGWPWgUiHoJU3PIc2+UofeMB3T03XNVu3Fhf0PiKUuzP2wqH0w/mLusPjUCpa4pz
         M6jQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=miLVIRQQ;
       spf=pass (google.com: best guess record for domain of batv+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=miLVIRQQ;
       spf=pass (google.com: best guess record for domain of batv+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org
Date: Thu, 22 Feb 2018 10:34:03 -0800
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
Subject: Re: [PATCH v10 1/7] PCI/AER: Rename error recovery to generic pci
 naming
Message-ID: <20180222183403.GA6267@infradead.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
 <1519315332-26852-2-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519315332-26852-2-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086403303503248?=
X-GMAIL-MSGID: =?utf-8?q?1593127149525231679?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 09:32:06PM +0530, Oza Pawandeep wrote:
> This patch renames error recovery to generic name with pci prefix
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index a4bfea5..306bf2f 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -478,7 +478,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
>  }
>  
>  /**
> - * do_recovery - handle nonfatal/fatal error recovery process
> + * pci_do_recovery - handle nonfatal/fatal error recovery process
>   * @dev: pointer to a pci_dev data structure of agent detecting an error
>   * @severity: error severity type
>   *
> @@ -486,7 +486,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
>   * error detected message to all downstream drivers within a hierarchy in
>   * question and return the returned code.
>   */
> -static void do_recovery(struct pci_dev *dev, int severity)
> +static void pci_do_recovery(struct pci_dev *dev, int severity)

Maybe pcie_do_recovery?

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
