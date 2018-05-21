Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AB8JxZqH5/vWG8KMUsgRr6m+SBQt3Rr13hF5FwKrt4MZ9Da3cysrmfaB052trsnBa5LZu3PBajyb
ARC-Seal: i=1; a=rsa-sha256; t=1526916346; cv=none;
        d=google.com; s=arc-20160816;
        b=g8CSuSBb3ivcYvIgnfcg8WNfAVCIwi0CFx8HK/t9zANkM0+56PA0XckuIk/SmUZSBS
         tpmpQoNcg3wwHVpYtfSHctvmJP+GiCHmv8xgOvg+VfNCeV6nc8+LBTEwt5sU43YV0lcE
         23x8QfDi0YT5F4CCKpEuK/7a8zf8fopeYfnsjAL0Dlv7Dw56I98dPHBoHhIkqWiJCfEw
         MW4l41hiBDYOjLaKQHyYq24WDsGjHqEd8VKcXGZbSUzCWdeJk9sHeAg/XvmAXJrDq56s
         BJrvTu6WSgX3zk/5jWIITTBtisJOg/INQhncxkZFILozJUXrrUz8aVe2dCV9sreTfAgP
         Cs1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=741ePe6e7GY0n1C+uo7NI2ElDh0Et3+bV7FysXiARHg=;
        b=IOPFtZP3JEp16Dq3s3aohk6HFw5wKfl6cLe1HBWpU/XkiXhedVpNze9/UjMsHRJqwC
         1CocMPWSzi3YnnHytPPHhNJ0axJElGsgwiKpnm31cadupEub2BvzwufzCQJDgCfZ2/Kl
         2JlnGYlBZd66d6MbWQiXDat6RClTCAokk7jeQPj3v4/jXum7Xi8uXavA6mZVo7Qhb8Qm
         yjkal8doTdAKI5lVvKPmBwMEfY0ymQF7pesS2CftW+3Ror71lj6WbeG5Z+5RsytBvXxD
         GuEED7fBOPAoLZbFR9nnM+7x4CJVENgrsTFjXSjCpYghgBKpuPo8A0YPQYf+RZGJayBy
         ec4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Mon, 21 May 2018 17:30:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Huaisheng Ye <yehs2007@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, mhocko@suse.com,
	willy@infradead.org, vbabka@suse.cz, mgorman@techsingularity.net,
	kstewart@linuxfoundation.org, alexander.levin@verizon.com,
	gregkh@linuxfoundation.org, colyli@suse.de, chengnt@lenovo.com,
	hehy1@lenovo.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
	linux-btrfs@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH v2 05/12] include/linux/dma-mapping: update usage
	of address zone modifiers
Message-ID: <20180521153055.GA18588@lst.de>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com> <1526916033-4877-6-git-send-email-yehs2007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526916033-4877-6-git-send-email-yehs2007@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087542252628612?=
X-GMAIL-MSGID: =?utf-8?q?1601087834830726130?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 21, 2018 at 11:20:26PM +0800, Huaisheng Ye wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> Use __GFP_ZONE_MASK to replace (__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32).
> 
> ___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP
> bitmasks, the bottom three bits of GFP mask is reserved for storing
> encoded zone number.
> __GFP_DMA, __GFP_HIGHMEM and __GFP_DMA32 should not be operated with
>each others by OR.

You have to include me for the whole series, otherwise I have absolutely
no way to properly review your patch.
