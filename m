Return-Path: <robdclark@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518624744; cv=none;
        d=google.com; s=arc-20160816;
        b=0pQ7NoDtYF8YwHK3mw6NZOj2WlYAAOWvNZnX8B/bdCG2XrBLxR9b8ZQrvQWNTeL9mq
         2pypKRe1TwkwTDdZa1fgZ6SB4nNDNy0SPP5EWjUQw0So2qoyNyiHjQgoA+B5zOIGdC+8
         AlXoFyMCGyC1YRBH/VLXdyE8MTyPlFo0DJ0A320CACJU9Hx/VIcYlkDJeM/bg5/yFBi+
         F6qhn+gdUAc38tZEl9IuPBvHmE7WxKAhZ20inoO1Dkvv5avMaFlkiiNv4pmX3gnF98fW
         3pGBukuoTLrDPdYlwo/Zci45AbDFxaVDtIeZ8bhSpTR7NtsEJfjFatKkZwp0RyUNz9Cd
         0o0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:subject:message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature:arc-authentication-results;
        bh=r7AdxZjo0Zuf+gTcQCkBX5IQfkwgpGxy1JA1DWUmqKo=;
        b=qONfPZ4uL09u/13pn9fJ6QE4WqHgUrmFPjX6t3tok8hmxX/1evepUyfvPv3ZAmiiUY
         oaV9kO3n4GHsaC5I/2zQJ5DIMPVyu8E7ZmNuZ5lMcqArUfIXHdZwNo54qYNERRtTIndX
         8k7u5Zi/nH+4Y6H7LBx/IFBSMBImmqLCIcP9ohzt6z1m0vYfz4nolI7XvOZkgL7b1Lzx
         uEgrEx24IAuM8CB1LH9cgufMNmBWqIMfU0TpKr+NsMjiBH7cALRrC7F0qb1VD0IiQFs+
         HAyWjFgM7FG9m4hlq/czAc6LKS0ArQ3tcMXOjIyt/Wkh9rmGCZnwKwuzKhNqujaNNu9q
         nWUg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=A3GNlMIh;
       spf=pass (google.com: domain of robdclark@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robdclark@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=A3GNlMIh;
       spf=pass (google.com: domain of robdclark@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robdclark@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227V4vc7KcQT5NS+fJHbZLCeTag5vN9B3yr92jPRh6RRWGHIBteMZ05dsdl3LMFsToEp4/KTO2GjtAdg7qkG+Wo=
MIME-Version: 1.0
In-Reply-To: <20180214154850.GA25422@jcrouse-lnx.qualcomm.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-7-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com>
 <20180213164205.GA7599@jcrouse-lnx.qualcomm.com> <CAAFQd5CjQRFATfh-mRQv5J=WefYuxBVTkk=Ju09FoqA-Or5Cvg@mail.gmail.com>
 <20180214154850.GA25422@jcrouse-lnx.qualcomm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 14 Feb 2018 11:12:23 -0500
Message-ID: <CAF6AEGtFOwBtXw7HvDSpEj+w78dsg9+p2SVk9e-uDuCE23Fpbw@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls
 with runtime suppliers
To: Tomasz Figa <tfiga@chromium.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	David Airlie <airlied@linux.ie>, Will Deacon <will.deacon@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, freedreno <freedreno@lists.freedesktop.org>,
	Robin Murphy <robin.murphy@arm.com>, Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737886832187485?=
X-GMAIL-MSGID: =?utf-8?q?1592393460568959375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 10:48 AM, Jordan Crouse <jcrouse@codeaurora.org> wrote:
> On Wed, Feb 14, 2018 at 12:31:29PM +0900, Tomasz Figa wrote:
>>
>> - When submitting commands to the GPU, the GPU driver will
>> pm_runtime_get_sync() on the GPU device, which will automatically do
>> the same on all the linked suppliers, which would also include the
>> SMMU itself. The role of device links here is exactly that the GPU
>> driver doesn't have to care which other devices need to be brought up.
>
> This is true.  Assuming that the device link works correctly we would not need
> to explicitly power the SMMU which makes my point entirely moot.

Just to point out what motivated this patchset, the biggest problem is
iommu_unmap() because that can happen when GPU is not powered on (or
in the v4l2 case, because some other device dropped it's reference to
the dma-buf allowing it to be free'd).  Currently we pm get/put the
GPU device around unmap, but it is kinda silly to boot up the GPU just
to unmap a buffer.

(Semi-related, I would also like to batch map/unmap's, I just haven't
gotten around to implementing it yet.. but that would be another case
where a single get_supplier()/put_supplier() outside of the iommu
would make sense instead of pm_get/put() inside the iommu driver's
->unmap().)

If you really dislike the get/put_supplier() approach, then perhaps we
need iommu_pm_get()/iommu_pm_put() operations that the iommu user
could use to accomplish the same thing?

BR,
-R
