Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqnMiapLJvjZQ/xH10+mKiX3kIeCMWQVJLh98U7czM3+rfHC8x7XwRJcZvtUiB5v+RrYXqg
ARC-Seal: i=1; a=rsa-sha256; t=1525707505; cv=none;
        d=google.com; s=arc-20160816;
        b=Sk89wPYug3flnP6f7ywFNdh9t7j/r2H8HmioXwuYQ0RXfHdG4R1omT6ZQvX1ymCBvC
         00jrW/mKzb1z2Oz+bObnb+7vZI6GPowXibeEwjESTJ9kFbXLr6BRBAhYpop/xBbZVNrf
         DbrCw2RUCC+TC1K7V+tXB4cHlPzBkNGvmu1VAMWcpnziZQ/nEcmhhw5pOasxheCDeh4w
         CDckV/0io/Pm6cpiMF6Edd8ghsEJ2l8B+WYNFpzfc5DCoRX4Y/Lha0qo4/Oxs7sEwUuN
         47OAkJWr9k4+IUEV6clCUhLW4Lx5p91+UbcEqadeIYDZX/pfqyYg3alPVit53dcgBMhw
         2AIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=cYjCYT996otod0v7+KxgIvwI9Kql2MBAwAK9qZlgnKk=;
        b=gLisrH0TQjQVXK08KAMEBxo9mcO9Q+9M80JFr+fbOPmejFl7xEaFleeENUU663j6V9
         QUg9Ire8CF6iOSxh0Jp+NplC5SYCwvG+XrQq81cfJZYsiVw7Vq3LnCCWanpGifb4dYR3
         ORTxZpB7tgrweiFsSf+Le9DoiGs74rzenSAGGzakDsSjr8G9TH3QKJhWmDPJvpXwEsyZ
         0lzV9zTTctUosz38WILKvGTYjoOn4jiYkbn7O+4EzapVDmpwocrVWX9UAqFZcRjk5YNQ
         JQmJDKOR0g/GZ5+ZqSmMjNnkxMEqAoQBsVAw46UQL7i5sIOwZBWhpAhVjmsEDBIC0+Ag
         itSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,374,1520924400";
   d="scan'208";a="53867724"
Date: Mon, 7 May 2018 08:41:07 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson
 <alex.williamson@redhat.com>, Jean-Philippe Brucker
 <jean-philippe.brucker@arm.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Rafael Wysocki
 <rafael.j.wysocki@intel.com>, Liu@mail.linuxfoundation.org, Jean Delvare
 <khali@linux-fr.org>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 05/22] iommu: introduce iommu invalidate API function
Message-ID: <20180507084107.2d1a9421@jacob-builder>
In-Reply-To: <20180505221943.iy724cn4ltmycv5i@cantor>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-6-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180505221943.iy724cn4ltmycv5i@cantor>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909254056563?=
X-GMAIL-MSGID: =?utf-8?q?1599820273733151238?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 5 May 2018 15:19:43 -0700
Jerry Snitselaar <jsnitsel@redhat.com> wrote:

> >
> >+static inline int iommu_sva_invalidate(struct iommu_domain *domain,
> >+		struct device *dev, struct tlb_invalidate_info
> >*inv_info) +{
> >+	return -EINVAL;
> >+}
> >+  
> 
> Would -ENODEV make more sense here?
> 
yes, make sense. thanks!
>  [...]  
