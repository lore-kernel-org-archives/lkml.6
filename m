Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AH8x2278NRIJDiQBZzRL39LX1Ayi78bqmniaoQfEyGPnBexP8zyI/X2VZUDjc5zxL2aB4RBrxESn
ARC-Seal: i=1; a=rsa-sha256; t=1519463262; cv=none;
        d=google.com; s=arc-20160816;
        b=d8IvkLqn/r+Zy8Ga1HHPmGm3+YC9Agwb+axJKnfYGai4XfibFWX3MAIyYPXS+VfSC5
         9xrxZdIXc+mUhioirs7CC4CsLPn9ZxbR02nZ1PCPBp0holIxtScxJtzF+vSkPUUXpaR4
         YUjyfqE+BXHnLUjSm1N+Gtgu/7OkpN8Pu8pFw4MHZftkOn+2QQPU9SUYT8JeZWYFwjCL
         Q2hQNqJs+fGBF45kaVU4dLXoS7LVg5flzaPVokLcFtv8jAtCkyVvGYbll7pChKN2bHuz
         Y1omLRoKtitJwIAV+/TmlJEgdcP71WSmhmu9wdh5J6+W7rpcXVg4pE93mHvNNRG/+Y+0
         OD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=2iyNhytxyetP0/Cior45fPtmj5s9qqyTYV6YZuN8PRo=;
        b=TNkFQ+BGAelGIZTgKm7ROJeUVTPzV3SWJz/J/eCXHWn6jeL4t0kDCsGUVZPtG/kKj2
         zlKYyFaGREwoyrTfrR2dREmC3o6u0ui2xLAZh5ETA9gZFIrahdYdTfCtEC8utfp4I+Tm
         D5T6QyEzDKUr4DyP/jMKOFGjrMXaAyey/acfLguqSeIHFSFDbtCkUSnwawzwhRJ/0iMu
         7eDeEU1DHe1TVKVGanH7zpCRk7zJ/gsSW1LtA24t8rPTOyLCqJuFwc8bMVSyAV7GiC9Z
         lC6rxzuG6nqQPL1kN2lP2bSvOL91DwN22BqR+6PXQI1RQ1fA1Et3IHEknJwncpvOl3PI
         sGyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,386,1515484800";
   d="scan'208";a="33793995"
Date: Sat, 24 Feb 2018 17:06:47 +0800
From: kbuild test robot <lkp@intel.com>
To: Or Idgar <idgar@virtualoco.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, arnd@arndb.de, ghammer@redhat.com,
	Or Idgar <oridgar@gmail.com>
Subject: Re: [PATCH] drivers/virt: vm_gen_counter: initial driver
 implementation
Message-ID: <201802241726.nuC5WB8Z%fengguang.wu@intel.com>
References: <20180222162038.28768-1-idgar@virtualoco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222162038.28768-1-idgar@virtualoco.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593118768319025256?=
X-GMAIL-MSGID: =?utf-8?q?1593272709393527862?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Or,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on v4.16-rc2 next-20180223]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Or-Idgar/drivers-virt-vm_gen_counter-initial-driver-implementation/20180224-112017
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/misc/vmgenid.c:35:15: sparse: incorrect type in assignment (different address spaces) @@ expected struct uuid_t @@ got uct uuid_t @@
   drivers/misc/vmgenid.c:35:15: expected struct uuid_t
   drivers/misc/vmgenid.c:35:15: got void
>> drivers/misc/vmgenid.c:40:29: sparse: incorrect type in argument 1 (different address spaces) @@ expected void @@ got strvoid @@
   drivers/misc/vmgenid.c:40:29: expected void
   drivers/misc/vmgenid.c:40:29: got struct uuid_t
   drivers/misc/vmgenid.c:51:15: sparse: incorrect type in assignment (different address spaces) @@ expected struct uuid_t @@ got uct uuid_t @@
   drivers/misc/vmgenid.c:51:15: expected struct uuid_t
   drivers/misc/vmgenid.c:51:15: got void
   drivers/misc/vmgenid.c:55:29: sparse: incorrect type in argument 1 (different address spaces) @@ expected void @@ got strvoid @@
   drivers/misc/vmgenid.c:55:29: expected void
   drivers/misc/vmgenid.c:55:29: got struct uuid_t

vim +35 drivers/misc/vmgenid.c

    28	
    29	static ssize_t generation_id_show(struct device *_d,
    30				      struct device_attribute *attr, char *buf)
    31	{
    32		uuid_t *uuidp;
    33		ssize_t result;
    34	
  > 35		uuidp = acpi_os_map_iomem(phy_addr, sizeof(uuid_t));
    36		if (!uuidp)
    37			return -EFAULT;
    38	
    39		result = sprintf(buf, "%pUl\n", uuidp);
  > 40		acpi_os_unmap_iomem(uuidp, sizeof(uuid_t));
    41		return result;
    42	}
    43	static DEVICE_ATTR_RO(generation_id);
    44	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
