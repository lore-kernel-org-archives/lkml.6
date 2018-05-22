Return-Path: <BATV+a8c6d037863aa87ae187+5385+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AB8JxZr5vHMHVXpb1uNN5HpvX6PMVlWw7RATa9rv36XTE4krVTqwrXxtXR7jjRc9Wkeltn/DsVzm
ARC-Seal: i=1; a=rsa-sha256; t=1526982037; cv=none;
        d=google.com; s=arc-20160816;
        b=I8PrGU08R+6Hq62zzc0BwdCqTCSUdaL24Eu5aTcYH8GY3bFYYufghIVVi+aN8uLF5k
         GaNKg4hUi94X/CuZsdjKdjgBFYK0sMPBI+sd++yD/DL3q4PHSJuSX821QbLF6BX/xwPM
         L4UPU/TQg19v3seyhbwcdRsxEkeJ7Q23ry3Ucg7iCzmFKoiH4VQf3L67vMPI+f3eoQU1
         XllPdyw4WrXNqCVBlgi8fx5I0zTQdjmc+zb4tuyaVq9F1UaoY4TxuLXKKsF0dzWmUV39
         Txb4NYwhsPJ0hmvspIEwQxozLqSYtUepyljDGSu/WZqR1uumKGdsq5qPgpkDao3gywu+
         LI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=/bz6sIJku1vmAOrptWqDL9sfc8GL1nJ1xcf4Clhd3LM=;
        b=UYx9+LhftfxvxILBAtPXGwCyE9B1OsJ5DDypRf+1jJpX2jpOqAhntl3hlhkp2hjsSW
         ekEXOXCywp5vKADjGWNXsQ138mzWo+fWysPTzR+gj1aaHg7rqfuFP9zYRAvZZBSxbyQW
         J5LoilDy9dB5jx8iF1LSCWsGcg5agOWS0a0K3plX8JiOAmAmx2gUVeT4ggEq8ArT0ifO
         +MwAJvUlowOPLN2K904y+3eh4IWVjUuS7lV2y9tZ8Vw1WngroKoLXqwp/bFwGQ+tiN1y
         E2YTyGaOtKkT9jlLBvpG7BXGAQxT307CvYxWaI2TxfOgcgpaPHcgA7uBjJyoyra7OiFd
         u5cA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Z7MY2+z1;
       spf=pass (google.com: best guess record for domain of batv+a8c6d037863aa87ae187+5385+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+a8c6d037863aa87ae187+5385+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Z7MY2+z1;
       spf=pass (google.com: best guess record for domain of batv+a8c6d037863aa87ae187+5385+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+a8c6d037863aa87ae187+5385+infradead.org+hch@bombadil.srs.infradead.org
Date: Tue, 22 May 2018 02:40:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Huaisheng Ye <yehs2007@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, mhocko@suse.com,
	willy@infradead.org, vbabka@suse.cz, mgorman@techsingularity.net,
	kstewart@linuxfoundation.org, alexander.levin@verizon.com,
	gregkh@linuxfoundation.org, colyli@suse.de, chengnt@lenovo.com,
	hehy1@lenovo.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
	linux-btrfs@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [RFC PATCH v2 00/12] get rid of GFP_ZONE_TABLE/BAD
Message-ID: <20180522094035.GB25671@infradead.org>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087516393165793?=
X-GMAIL-MSGID: =?utf-8?q?1601156716595890886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This seems to be missing patch 1 and generally be in somewhat odd format.
Can you try to resend it with git-send-email and against current Linus'
tree?

Also I'd suggest you do cleanups like adding and using __GFP_ZONE_MASK
at the beginning of the series before doing any real changes.
