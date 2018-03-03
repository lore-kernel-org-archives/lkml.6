Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520093079; cv=none;
        d=google.com; s=arc-20160816;
        b=y6VganeYli8v4kuuEQRCCjH4r9o2DGUmwFUmj8Mgsa0Pnt4QgWbmg1CeJFMwFbR6qc
         qdYwT2ire7fa6hAgFTFmamZX/rru9oYMpXRH+ku7KmROiq3wnqn/Z0cfgyDUclEhNNrB
         velozvR7P/vJwVhbq3g3OmJYB3Mv2XdSLnQClW5WVrb81XT8UO9ppgESmN8S0ib/IDET
         y3Scrbr7xld+Xy3QXEkxe30Pqvlsb/PU78/fcWk+5/7XiJu+t16vklhUS7fcK5k4qe3s
         mGVTOAozjfHXiGivOYJGWcjzbKGHEBQZtQ4NcaSqxt0+GZ6ZZoRK9vwt1HSnjDqoouac
         KuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=o9vr2ArGlTSxtD8wZExO1CdVqYBmEWLetG7QMiqyJxw=;
        b=H3RVLycwbZ7HtnDG5EL6z9f6AHcDWaxzO5me0M9squKu/5k2eH6UrDZA47ZGsKi/qz
         OozGPgR8UwKE1QWRvaohHYjFJ6vzYXz0ZQbjhLIUVcq+UkNfaWAxJkI7EBwpiIDUmQ97
         DfFArOD03/33FYwOr9NbyRMFJKY7uopZbrCgi58WQL5Gpm1EiEmIvImyfA3rF2QHToL4
         HP7iWYO75JZap7TZDOMkMxZcGgxlgni7TSH7Lq+ybaXn+OKXq9xdh4nJLHw3vAjjyGl5
         hjtfzMWltMDbXO0EWKkaFLZXP07lLQEgkFhgIxVXU968I8LCiDl3g6zSvIin13F5HjOE
         mCMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PYx0UPMp;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PYx0UPMp;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvOEWH0Z6D78hvc0h2rjZS855JZ6NcqDXImaI0m2Rhwsfuq4RUNQD+gyC6A0a7dCYY7R7sreJnJpeVKqGg6I9s=
MIME-Version: 1.0
In-Reply-To: <201803031205.5PsqVoxS%fengguang.wu@intel.com>
References: <20180228082726.21535-1-mmoese@suse.de> <201803031205.5PsqVoxS%fengguang.wu@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 3 Mar 2018 18:04:38 +0200
Message-ID: <CAHp75VfbxKOD=J2Q4ZDt=yeHSN0fUCMc3FbeTN_zK_vhb4muiQ@mail.gmail.com>
Subject: Re: [PATCH v2] 8250-men-mcb: add support for 16z025 and 16z057
To: kbuild test robot <lkp@intel.com>
Cc: Michael Moese <mmoese@suse.de>, kbuild-all@01.org, Greg KH <gregkh@linuxfoundation.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, Johannes Thumshirn <jthumshirn@suse.de>,
	Andreas Geissler <andreas.geissler@men.de>, Ben Turner <ben.turner@21net.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593568644699224821?=
X-GMAIL-MSGID: =?utf-8?q?1593933120965417444?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 3, 2018 at 6:51 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Michael,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on tty/tty-testing]
> [also build test ERROR on v4.16-rc3 next-20180302]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Michael-Moese/8250-men-mcb-add-support-for-16z025-and-16z057/20180303-104548
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> config: sparc64-allyesconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc64
>
> All errors (new ones prefixed by >>):
>
>    drivers/tty/serial/8250/8250_men_mcb.c: In function 'get_num_ports':
>>> drivers/tty/serial/8250/8250_men_mcb.c:59:10: error: implicit declaration of function 'readb' [-Werror=implicit-function-declaration]
>       return readb(membase) >> 4;
>              ^~~~~
>    cc1: some warnings being treated as errors


I suppose kbuildbot can generate patches in similar cases, i.e. adding
"#include <linux/io.h>" has to cure this.

>
> vim +/readb +59 drivers/tty/serial/8250/8250_men_mcb.c
>
>     51
>     52  static unsigned int get_num_ports(struct mcb_device *mdev,
>     53                                    void __iomem *membase)
>     54  {
>     55          switch (mdev->id) {
>     56          case MEN_UART_ID_Z125:
>     57                  return 1U;
>     58          case MEN_UART_ID_Z025:
>   > 59                  return readb(membase) >> 4;
>     60          case MEN_UART_ID_Z057:
>     61                  return 4U;
>     62          default:
>     63                  dev_err(&mdev->dev, "no supported device!\n");
>     64                  return -ENODEV;
>     65          }
>     66  }
>     67
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
With Best Regards,
Andy Shevchenko
