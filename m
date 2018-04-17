Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AIpwx49cnjTM0dbkKxaC7UoaV9fbl6V2Bl3zSO+sE+XwT+bOSfnK7X2eyF7S48y/aGQazDReLiYH
ARC-Seal: i=1; a=rsa-sha256; t=1523939492; cv=none;
        d=google.com; s=arc-20160816;
        b=abwsvMt+B1pM0bQKuumwtbELEQ2ZSOy28jPsJuyAqus+vmi11L9X/6OoxaNFFzXcgX
         X5EcLTwPrS90eOkOo0Tlz0vtCTJdQecMbz/+cNr8TMdrUwuNQxwdVSd++FCArExD2XN1
         wYZ2oejYmARnyYPqG3UPW2QylPG09gGhgHLRtft98AbdDk/Cv3wxvoClErsF6cQ4UPOQ
         EmPI4ELFwQCBmaWtpyG7LOuF2cErkkCFWRJ06F6d5eGSWtMSZwFpPkodiyAP5I71eak2
         7FlDjIw2Gjs7jETM2cdLo5iEUtAKbBjs2oG77a4tYGdgA6DeuLYp5ecsj9Ikf63MhVA2
         XO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=jJQF5wO1x2B4wYtptnj4yqvQ6HzXTId8wG80SSTHZOY=;
        b=z7WPxIgYZxkJ0eMWX1Pu/3TptSkc8hYCvSNE7nDQEQVar40ck/Z6T+hS4Xf0pj8PX0
         rThWjWnQk7zDq2KRdwcZOcW8QNLdo7aGPirDefxZF9DfXafMPRnOgyMFyMRTOTrU5eOj
         QnePAX+NR6G96zkbrR1KkqMMHaSPsGdaCNecULK28UJ/dvHdLIEB20MxfRTh5S8zWzm6
         cfBdEX9U/o5kXapondk1eqGNaOKgBipegqh1JNzRuIlnIFqov6cXxZmT3W2kZJqUO3tL
         jzNu3CmD5+akA6qCVBz+p6e+RxYTYCjh0EjAwotkwK5ArXvrFrImuv2j/4vQJ9kSo7LW
         Zmow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,462,1517904000";
   d="gz'50?scan'50,208,50";a="34806662"
Date: Tue, 17 Apr 2018 12:30:50 +0800
From: kbuild test robot <lkp@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: kbuild-all@01.org, linux-parisc@linux-mips.org, arnd@arndb.de,
	timur@codeaurora.org, sulrich@codeaurora.org,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sinan Kaya <okaya@codeaurora.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] parisc: use the asm-generic version for writeX()
Message-ID: <201804171208.1138HEgL%fengguang.wu@intel.com>
References: <1523916078-23049-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <1523916078-23049-1-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597941834039295294?=
X-GMAIL-MSGID: =?utf-8?q?1597966378144445653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sinan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hp-parisc/for-next]
[also build test ERROR on v4.17-rc1 next-20180416]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sinan-Kaya/parisc-use-the-asm-generic-version-for-writeX/20180417-103119
base:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git for-next
config: parisc-c3000_defconfig (attached as .config)
compiler: hppa-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=parisc 

All errors (new ones prefixed by >>):

   In file included from arch/parisc/include/asm/hardirq.h:13:0,
                    from include/linux/hardirq.h:9,
                    from arch/parisc/kernel/asm-offsets.c:34:
   include/linux/irq.h: In function 'irq_reg_writel':
>> include/linux/irq.h:1126:3: error: implicit declaration of function 'writel'; did you mean 'iowrite8'? [-Werror=implicit-function-declaration]
      writel(val, gc->reg_base + reg_offset);
      ^~~~~~
      iowrite8
   cc1: some warnings being treated as errors
   make[2]: *** [arch/parisc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +1126 include/linux/irq.h

7d828062 Thomas Gleixner 2011-04-03  1109  
ebf9ff75 Boris Brezillon 2016-09-13  1110  /*
ebf9ff75 Boris Brezillon 2016-09-13  1111   * The irqsave variants are for usage in non interrupt code. Do not use
ebf9ff75 Boris Brezillon 2016-09-13  1112   * them in irq_chip callbacks. Use irq_gc_lock() instead.
ebf9ff75 Boris Brezillon 2016-09-13  1113   */
ebf9ff75 Boris Brezillon 2016-09-13  1114  #define irq_gc_lock_irqsave(gc, flags)	\
ebf9ff75 Boris Brezillon 2016-09-13  1115  	raw_spin_lock_irqsave(&(gc)->lock, flags)
ebf9ff75 Boris Brezillon 2016-09-13  1116  
ebf9ff75 Boris Brezillon 2016-09-13  1117  #define irq_gc_unlock_irqrestore(gc, flags)	\
ebf9ff75 Boris Brezillon 2016-09-13  1118  	raw_spin_unlock_irqrestore(&(gc)->lock, flags)
ebf9ff75 Boris Brezillon 2016-09-13  1119  
332fd7c4 Kevin Cernekee  2014-11-06  1120  static inline void irq_reg_writel(struct irq_chip_generic *gc,
332fd7c4 Kevin Cernekee  2014-11-06  1121  				  u32 val, int reg_offset)
332fd7c4 Kevin Cernekee  2014-11-06  1122  {
2b280376 Kevin Cernekee  2014-11-06  1123  	if (gc->reg_writel)
2b280376 Kevin Cernekee  2014-11-06  1124  		gc->reg_writel(val, gc->reg_base + reg_offset);
2b280376 Kevin Cernekee  2014-11-06  1125  	else
332fd7c4 Kevin Cernekee  2014-11-06 @1126  		writel(val, gc->reg_base + reg_offset);
332fd7c4 Kevin Cernekee  2014-11-06  1127  }
332fd7c4 Kevin Cernekee  2014-11-06  1128  

:::::: The code at line 1126 was first introduced by commit
:::::: 332fd7c4fef5f3b166e93decb07fd69eb24f7998 genirq: Generic chip: Change irq_reg_{readl,writel} arguments

:::::: TO: Kevin Cernekee <cernekee@gmail.com>
:::::: CC: Jason Cooper <jason@lakedaemon.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--wRRV7LY7NUeQGEoC
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--wRRV7LY7NUeQGEoC--
