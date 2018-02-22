Return-Path: <BATV+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AH8x2242DI32/Vcto3QCiMWwdL11T2P9/21YupCBYjMX4SU3JyTU1006yaZ0MIMM2RnzuMJPy6vx
ARC-Seal: i=1; a=rsa-sha256; t=1519325029; cv=none;
        d=google.com; s=arc-20160816;
        b=XJph4aA+0HEtHwXWSVbrXe5kAj/D2MI9DuWljbG9UGv4KuFj5mxXkktKBsYl5OeZak
         vaYqQ8AE6FquEOpAs/+BBFqL3/StumRMOeLphNetQJEqlF3c0CeEBMF92zuC+bziPXfn
         FXa7oXvSYe3dxwRke8Go7JwihikExt+npciRP4SapRq1DWhE41iBz+PGlmsqnjfT0drM
         4RDym3PzMS+Adumrrqho9XAlS8tKvUaMM04bZNj3Kd9kXStS+l5H7mfxZd75+0uAyfSw
         NKKTreiB6FhWgNbkpu69vOkJluompvpb7kJHntW3kXORgNjZ0AiA2wvQFST14xMnqlJD
         bmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=+zDccxVWV7M5VoCORzdVDFGDu8PnIzHUAB6Jf3nqSXg=;
        b=py2NcdwTq3KYCw8kGTKIfh+qZdMImNtr2qpK6EeAMJTx8zIaGZutAZxrfcJnHUa+AT
         /o6BzAlqmQonkr5g07mfmfD8ICjnB32dJBHx6dEfspGynA82OiY0uw26Ip7bOGun9c0a
         V5Z/aU4u/sgCf6VuEcFfmRtBg6grL6umJLIwB08DqMSeVEn4aC/nTmBAgcMPIRMsptKT
         5G5qY9oMBYoufJ29XpK+IoSND+nXwmEeq94AFxzBDmceFpwd9E+bRLfv7PdDFaM3ePBS
         Mwa7+wSTvn4v+o574iE109GR50iUBBKAymICMSn01gGMLHQfLNvLS/rW/Oz+0+fwivAa
         oHgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=aK2oZgGV;
       spf=pass (google.com: best guess record for domain of batv+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=aK2oZgGV;
       spf=pass (google.com: best guess record for domain of batv+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org
Date: Thu, 22 Feb 2018 10:43:48 -0800
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
Subject: Re: [PATCH v10 6/7] PCI: Unify wait for link active into generic pci
Message-ID: <20180222184348.GE6267@infradead.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
 <1519315332-26852-7-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519315332-26852-7-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086424372892434?=
X-GMAIL-MSGID: =?utf-8?q?1593127762660774683?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>  
> +/**
> + * pci__wait_for_link - Wait for link till its active/inactive

typo - just wants a single underscore.

> +	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> +	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);

no need for the !! when assigning to a boolean.

> +
> +	while ((ret != active) && (timeout > 0)) {

No need for either pair of inner braces.

> +		msleep(10);
> +		timeout -= 10;
> +		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> +		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);

Same as above.

> +	}
> +
> +	if (ret == active)
> +		return true;

Seems like the structure is a bit odd.  Why not:

	for (;;) {
		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
		if ((lnk_status & PCI_EXP_LNKSTA_DLLLA) == active)
			return true;
		if (timeout <= 0)
			break;
		timeout -= 10;
	}
