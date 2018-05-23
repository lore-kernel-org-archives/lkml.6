Return-Path: <sakari.ailus@linux.intel.com>
X-Google-Smtp-Source: AB8JxZpWbcFhVro4TpJ9thItQzncyPwWMS6AH7+uTMp0sDPuZ78gorQuZ0K6JiCADjjsffpaHpTQ
ARC-Seal: i=1; a=rsa-sha256; t=1527067654; cv=none;
        d=google.com; s=arc-20160816;
        b=g/xCtWdGWLr0cZgtE/floIQYjX+1EuQ+hybgjtJ3QLElW+ql5O2Z+5s0eYS5XWRCJl
         WMidTosHJxCy5zH7Eoi/sbwv/wKaw66aAEfGTigcqfcb0/A0N9fgI93PBeUOHacTKmkM
         ZROwMuHLnxEFT9n3BA2KWv0A+86dXgkpJiebCU4QXXjXaJy41ClpAlvWyl98PngFeQTX
         ZsO0OyZSUIW+hKsA/3BiQaNZB6gEX0G45Or1YG1bZn9pzT4vfS/yoz4DQGDvtLaxrj7y
         vjp2VioEHtFiY4Md+Rz1/a64NvddG0AdNdnNCsgwrjnlvkfylC5x4teUOLbnZ5ZY60fJ
         HeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=U1BR2bqS3ggZfr1fuJ0pgiRrOVxo3ugQfQVzJKxFEYE=;
        b=CVM3BgzOF6XT/ot14PGoIW1lLW4yNx7l7LukbqM4TsJmEek+8QqMMg3Q8uNTj5bgyC
         ncAVIyhwqMuGIVtzWFwC1dz+1uu6CHI30veJmlroJJ0UqwaAFUmd2R0agWg3ojfamLXg
         8vN30xme/QHFOCEj/eROOvsnxII+A+wGSRvV32daVARqPamrsqBoNnr81rowTBQ56LrB
         d/0j8qHTRBKyZmo4O9sXcdXQyg1mOc296p0WDG14rIEFGsYAywYSKV3+gEzu0uHvdF8D
         6oc5gH4/JaBK+P/zM4gQNbJCRtYjTa1U8if7HaiOD3RO6y9aFhWi6LbyqS2FQo4Fu3va
         ONwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of sakari.ailus@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=sakari.ailus@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of sakari.ailus@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=sakari.ailus@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,432,1520924400";
   d="scan'208";a="57740904"
Date: Wed, 23 May 2018 12:27:30 +0300
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Cc: alan@linux.intel.com, mchehab@kernel.org, gregkh@linuxfoundation.org,
	linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Fix issues reported by static analysis tool.
Message-ID: <20180523092730.va7ds7t6h3zhyz7r@paasikivi.fi.intel.com>
References: <1527052896-30777-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527052896-30777-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601231384615667446?=
X-GMAIL-MSGID: =?utf-8?q?1601246492970638976?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Pankaj,

On Wed, May 23, 2018 at 10:51:30AM +0530, Pankaj Bharadiya wrote:
> This patch series fixes some of the issues reported by static analysis
> tool.
> 
> Pankaj Bharadiya (6):
>   media: staging: atomisp: remove redundent check
>   media: staging: atomisp: Remove useless if statement
>   media: staging: atomisp: Remove useless "ifndef ISP2401"
>   media: staging: atomisp: Fix potential NULL pointer dereference
>   media: staging: atomisp: Fix potential NULL pointer dereference
>   media: staging: atomisp: Fix potential NULL pointer dereference
> 
>  drivers/staging/media/atomisp/pci/atomisp2/atomisp_cmd.c   | 14 --------------
>  .../media/atomisp/pci/atomisp2/atomisp_compat_css20.c      |  2 --
>  drivers/staging/media/atomisp/pci/atomisp2/atomisp_csi2.c  |  8 --------
>  .../pci/atomisp2/css2400/camera/pipe/src/pipe_binarydesc.c |  3 ++-
>  .../staging/media/atomisp/pci/atomisp2/css2400/sh_css.c    |  7 +++++--
>  5 files changed, 7 insertions(+), 27 deletions(-)
> 

I'm sorry to tell you that the atomisp driver was removed from the staging
tree some time ago.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
