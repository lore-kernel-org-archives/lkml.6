Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AG47ELtMPbVoW5VnXZ2S47IUA3wAVTycQ+n12Eeaeccbi73u44Omk2MvmEIddbKcjtIas5MNQ22P
ARC-Seal: i=1; a=rsa-sha256; t=1520978113; cv=none;
        d=google.com; s=arc-20160816;
        b=MDe30GfuYiC6ZR5G7zwPhJ/hBSOAvK+zHUfW3B9tIYF/ivSbf2/TDHNkLV48W0zTkJ
         xD8AAEbkYe52Ug80oe4f9Y0iLpPG9a37x55Lt/3qzbcZucFGno+hOhidK14VWgfPqTQc
         qVjBlBFKyq3YkjqI5ZrplqSJaiT6Q5TUGsxdRkevV7ZVf3AVaO/q5vVe9+Ja8xoULzru
         fJkc0OOjC5OFoinz57YjDTotMbStQf2+N/4hSp7NOZ00h72GMdO0WFVblIB4g0EWOwy/
         gore1EB2mgaPTmiAEYqDQQAYQQc1Th7qWTc/CutXwGCQKeHaW+aO1gulOydSlKfpWusQ
         1EZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Vw2rSCajHk1OFJEmIerKdv8/tIiVNeSHpusVp7vje84=;
        b=GQ9qIxyZN+Qf7AEk0ZZKzfTDt7Ay8j8+BBhNoTv5f9cpkTcR0ODxylA2Pfky/7uNhs
         hZsx7y1hczS+YO5ZupIGAQu/8VQPxt4hKKNn1WiNgvWZUeakmsMBcSueYtxr/WgasNRP
         b2JKRwnLvo+8T0z/p8yi24Ljf8O/ME5t4XYaVRWoxkz3I+5SFPVH0tRum1SaYr49l+WF
         PMWACW7U5PLP26dgGJCcPhIkaDdCbK7r2gmabBLLEhaQgdhMBmz0tLRWboLAE/nzQR5J
         aWSrO7bU+to154XX8Iw0HUyADwz2K2Vl/7ZqHM9w9tnqKpMIGDgnDCpsvdXEB5K1FJoa
         9FMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,466,1515484800";
   d="scan'208";a="37084793"
Date: Wed, 14 Mar 2018 05:53:57 +0800
From: kbuild test robot <lkp@intel.com>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: kbuild-all@01.org, hch@lst.de, robin.murphy@arm.com,
	linux@armlinux.org.uk, gregkh@linuxfoundation.org,
	m.szyprowski@samsung.com, bhelgaas@google.com,
	dmitry.torokhov@gmail.com, rafael.j.wysocki@intel.com,
	jarkko.sakkinen@linux.intel.com, linus.walleij@linaro.org,
	johan@kernel.org, msuchanek@suse.de, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	Nipun Gupta <nipun.gupta@nxp.com>
Subject: Re: [PATCH] dma-mapping: move dma configuration to bus infrastructure
Message-ID: <201803140513.ga74hWw2%fengguang.wu@intel.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1594861145341698623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Nipun,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc5 next-20180313]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nipun-Gupta/dma-mapping-move-dma-configuration-to-bus-infrastructure/20180313-225250
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/base/platform.c:1133:5: sparse: symbol 'platform_dma_configure' was not declared. Should it be static?
>> drivers/base/platform.c:1149:6: sparse: symbol 'platform_dma_deconfigure' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
