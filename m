Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AG47ELuz8TJ/mNor5kmeiphcxZ7l06Ll8M5K+NEfwSpdFAI2Dy3cr0r1KDRSgsVEuEM9WkyxQPYT
ARC-Seal: i=1; a=rsa-sha256; t=1521807221; cv=none;
        d=google.com; s=arc-20160816;
        b=bryl22gnkEBhXVP6bQ3P3kEua74c6ocaTmYoRSCeH4h1F1faruXklynQnRtjef/FsT
         /RKWj9roYEGNw8i2z/HeACpMfpaFYcbtjQQkaZRrwX3+z/UFRP3yqHIas4EXhiswZL3W
         JRXpHV7SRfOk2unAsf5cLNYvfhnzALAaqJR0h7OYSuUg6ll/CTkA+D70/AlceLP4uhZt
         zciRPqqVJhmYPCVqI2CAZB/7LwOe9K+hvGLNHim1EFR5AdE5QZMvim7JpP2oYhGfGRzb
         lJxn8ypj/a9HWjt8JvuuSUwJMmPBcViOhvB2arClOGRoZsOYTKJksXOuHBzxcVKkNkn/
         ms1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=1lar9LjCAg7+LBo1plcFjFINJMO9rxPdGxR3zDrXYX0=;
        b=YM4R9wUSDns7l/yjYMKVy62PZePRgHji9zCoQ607mIt/KrU26CUMNPFU5mc98ZI9+3
         sRLsRM2JDZsl4x7InYzuQbB+mFZGfTbpTSK3qCk1AjSdFaDGqoC9ZkA7Q/SeNEmHsnbl
         bBybtyUtycjAyNmq6E813dooIL8RFGJsuFzqEN7ocWou0OmkzBp2ojAh70wr87eyVpF/
         XQFQC427Zzs74byEpOFbDgUcMPr9a6aRvoLQ80k2hG/Duzh7JuN6cjL42QZfrIsLuc8t
         12sK5AVF1I2I10P69T3QSf7A8OyjPWIS/ZYT7Q+XOIiQwa5rx0A7GsxYTNwfDXuo782g
         //bg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,349,1517904000";
   d="scan'208";a="214218852"
Date: Fri, 23 Mar 2018 20:13:01 +0800
From: kbuild test robot <lkp@intel.com>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: kbuild-all@01.org, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Mark Rutland <mark.rutland@arm.com>, Nandor Han <nandor.han@ge.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@collabora.com,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 1/2] misc: ezport-firmware: new driver
Message-ID: <201803232023.qttpOUFw%fengguang.wu@intel.com>
References: <20180320172201.2065-2-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320172201.2065-2-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595478143332183310?=
X-GMAIL-MSGID: =?utf-8?q?1595730529702232269?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Sebastian,

I love your patch! Perhaps something to improve:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on v4.16-rc6 next-20180322]
[cannot apply to char-misc/char-misc-testing]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sebastian-Reichel/GE-Healthcare-PPD-firmware-upgrade-driver-for-ACHC/20180323-144836
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/misc/ezport-firmware.c:296:33: sparse: incompatible types in comparison expression (different type sizes)
   drivers/misc/ezport-firmware.c:329:33: sparse: incompatible types in comparison expression (different type sizes)
   In file included from include/linux/delay.h:22:0,
                    from drivers/misc/ezport-firmware.c:12:
   drivers/misc/ezport-firmware.c: In function 'ezport_firmware_flash_data':
   include/linux/kernel.h:792:16: warning: comparison of distinct pointer types lacks a cast
     (void) (&min1 == &min2);   8-                ^
   include/linux/kernel.h:801:2: note: in expansion of macro '__min'
     __min(typeof(x), typeof(y),   11-  ^~~~~
   drivers/misc/ezport-firmware.c:296:19: note: in expansion of macro 'min'
      transfer_size = min((u32) EZPORT_TRANSFER_SIZE, size - address);
                      ^~~
   drivers/misc/ezport-firmware.c: In function 'ezport_firmware_verify_data':
   include/linux/kernel.h:792:16: warning: comparison of distinct pointer types lacks a cast
     (void) (&min1 == &min2);   18-                ^
   include/linux/kernel.h:801:2: note: in expansion of macro '__min'
     __min(typeof(x), typeof(y),   21-  ^~~~~
   drivers/misc/ezport-firmware.c:329:19: note: in expansion of macro 'min'
      transfer_size = min((u32) EZPORT_TRANSFER_SIZE, size - address);
                      ^~~

vim +296 drivers/misc/ezport-firmware.c

   259	
   260	static int ezport_firmware_flash_data(struct spi_device *spi,
   261					      const u8 *data, size_t size)
   262	{
   263		int ret;
   264		u32 address = 0;
   265		u32 transfer_size;
   266	
   267		ret = ezport_get_status_register(spi);
   268		if (ret < 0)
   269			return ret;
   270	
   271		if (ret & EZPORT_STATUS_FS) {
   272			dev_dbg(&spi->dev, "bulk erase");
   273			ret = ezport_bulk_erase(spi);
   274			if (!ezport_ready(ret, false))
   275				return ret;
   276		}
   277	
   278		ret = ezport_get_status_register(spi);
   279		if (!ezport_ready(ret, false)) {
   280			dev_err(&spi->dev, "flash memory is not ready!");
   281			return ret;
   282		}
   283	
   284		while (address < size) {
   285			if (!(address & EZPORT_SECTOR_MASK)) {
   286				dev_dbg(&spi->dev, "section erase: %x", address);
   287				ret = ezport_section_erase(spi, address);
   288				if (!ezport_ready(ret, false))
   289					return ret;
   290			}
   291	
   292			ret = ezport_write_enable(spi);
   293			if (!ezport_ready(ret, true))
   294				return ret;
   295	
 > 296			transfer_size = min((u32) EZPORT_TRANSFER_SIZE, size - address);
   297	
   298			dev_dbg(&spi->dev, "transfer: %x", address);
   299			ret = ezport_flash_transfer(spi, address,
   300						    data+address, transfer_size);
   301			if (!ezport_ready(ret, false))
   302				return ret;
   303	
   304			address += transfer_size;
   305		}
   306	
   307		return 0;
   308	}
   309	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
