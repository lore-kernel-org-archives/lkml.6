Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqAY0KAXYySMgvGZ9hqRnQLHj3j0cPVsnxn6Kd+oD6Yzo2Rvn411dm0jcepNqzyxS8I7pMB
ARC-Seal: i=1; a=rsa-sha256; t=1526323777; cv=none;
        d=google.com; s=arc-20160816;
        b=CU/hLFU+8neloRjBcbQTouu+eot/dS7LEF01HPZy4XLACFkcP7Av8nHLEX9GyhQdI9
         REc+MUWT/4Ez4gHNZmi4E6edE2I+M+xXlZFI0eej52IvkGTNX8FyupraolI4ryavsCfd
         s6IROIEj+IgkxAOlE8DY4c+DtPGKJ4kIforiV1kTlo9CnumBtrI8LOK3eSwWibPsTFAf
         oib6nA/b7LNv4Gjzu134A06Iul0UJ22xry33eefNhkamFh08ikpLljXtyGBCfLTUX7Iz
         ONkK5i65pAjJeQ6Wqth40I7EiFXZ3xNcxKOaPls115VvbqxbAlqI1qNitvOzSJYBf/9J
         ZsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=2r86naj8aLtTyRFKWQOWupOAP2sANZIixa7WvHyi5ls=;
        b=y81zQO5TtSfB3/3C1czNh+o1SUs4/aeOeJU8U8FCdV1zZBMd9HEvP5OmkwFtOv2vKy
         2UqQXY2tBE0JNbr3K4H92zAwq48Z8uVNELfI/LyFL11BELohSyNlyt8Izz4HRZRXsN/g
         2PZaLPU9x0QT9l7snhamF1pEne4+tGFxTVdp0mHnTi8XqY6SDmqVj/2/fyLmZeQHA5TU
         tiCg2uwgXR6ldJzUBLpxUlqKVGJja087Tq4QFDIa9i/ZB833kzKoDXa9ERFcjTMp6dPh
         l7uCWKApEuWJwkeaZsQ8+Lk7q4mHFBXsuGfM2nEvZfRyNu1nwbrtPy/aRGQXpVEFOStn
         MjAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="49168786"
Date: Mon, 14 May 2018 11:52:22 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson
 <alex.williamson@redhat.com>, Jean-Philippe Brucker
 <jean-philippe.brucker@arm.com>, Rafael Wysocki
 <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean
 Delvare <khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 03/23] iommu/vt-d: add a flag for pasid table bound
 status
Message-ID: <20180514115222.0389285a@jacob-builder>
In-Reply-To: <5AF7F0EE.902@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<5AF7F0EE.902@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202361739379214?=
X-GMAIL-MSGID: =?utf-8?q?1600466481217596278?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 13 May 2018 16:01:50 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> > +	u8 pasid_table_bound:1;  
> 
> Can you please add some comments here? So that, people can
> understand the purpose for this bit exactly.
will do. I will add:
u8 pasid_table_bound:1;	/* PASID table is bound to a guest */
