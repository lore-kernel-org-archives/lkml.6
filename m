Return-Path: <jdelvare@suse.de>
X-Google-Smtp-Source: AIpwx48gXPOVdQ2wrcFytMLdb6yl8OgEuLT/u6wE9ZacwVt+RdM1B6LJbvSCKUURICl/1FZ661rd
ARC-Seal: i=1; a=rsa-sha256; t=1524740475; cv=none;
        d=google.com; s=arc-20160816;
        b=kolsBAPEYyalQy7wQH0CCz/kivaswXY4U6Y65S9regfbPWn+NQtdSst4kYWlOJoKlV
         pFhx1mx7DuwZJA96UVu90BOA+JR/UVnWp09S680Cva0JBSSquChKcFANAdbEmIwMRGS7
         Wkf/B74XuDnEKY5oWKUzgjKxdp9nkSWTpzan/Y/97+Qg/iW6wCUA6uprxpuOIsHAGRfU
         p3W3uYYBr5b2Icf4hK3hQzQvHO5T4kYlkXRvSAeDxjydE48EVfsaBupd+JXztIIVkSeC
         MKUyXOhCQmUEXd5ZsYOyiMxH/08JXR0Rc9FefkeTMagfXT5nPAFWVyNYLC4vZpeEy+fv
         d7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=mPquu67GgQ+RuWe1yMSA18tNgSdiUXfakgumo3OMvzA=;
        b=J6lHaZVLG2U3bFSS6sQefso7qxz8knqP8fV0ZIPHQpnHbVk2ksthIb4UmIfkStuIln
         k2gA5LqL/73+p9Ge/lxz3P9mNUdyOkdJvhUkTE95z1k79XTEfNUJ0nGeCwZl+hzHi6JI
         Es3alMwTa+ucto2Y+NKjxtha43Opuj5ZUgjajbTTxYc3yZSZ9jyMXIKBYoSPJDfr4pom
         jsmp7Mers4k35v0BksSyLF8PYTHamNfva+ipRYBb+vxSowqV/T+y+p6fvXaYZuEexmWK
         dqv7/neuSSuBEU0IUXMNc0R/LOuViE8EuHOlw/8wrrgED76v/TKkzMIA3shuLAYghyQo
         AaHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jdelvare@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jdelvare@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jdelvare@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jdelvare@suse.de
Message-ID: <1524740470.5117.3.camel@suse.de>
Subject: Re: [PATCH] firmware: dmi: Add access to the SKU ID string
From: Jean Delvare <jdelvare@suse.de>
To: Vinod Koul <vinod.koul@intel.com>, Simon Glass <sjg@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, C Shapiro <shapiroc@chromium.org>,
 Aaron Durbin <adurbin@chromium.org>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Philippe Ombredanne <pombredanne@nexb.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Alex Hung <alex.hung@canonical.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, sayli karnik <karniksayli1995@gmail.com>,
 Sagar Dharia <sdharia@codeaurora.org>
Date: Thu, 26 Apr 2018 13:01:10 +0200
In-Reply-To: <20180426093324.GV6014@localhost>
References: <20180424211111.140374-1-sjg@chromium.org>
	 <20180425025125.GH6014@localhost>
	 <CAPnjgZ1ExEQHL8W2+k=+wS98O3CCX25dKngv_PFNvgAKVBD4Hw@mail.gmail.com>
	 <20180426093324.GV6014@localhost>
Organization: Suse Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598663453447525196?=
X-GMAIL-MSGID: =?utf-8?q?1598806268937663466?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On jeu., 2018-04-26 at 15:03 +0530, Vinod Koul wrote:
> On Wed, Apr 25, 2018 at 03:17:37PM -0600, Simon Glass wrote:
> > 
> > Hi Vinod,
> > 
> > On 24 April 2018 at 20:51, Vinod Koul <vinod.koul@intel.com> wrote:
> > > 
> > > On Tue, Apr 24, 2018 at 03:11:11PM -0600, Simon Glass wrote:
> > > > 
> > > > This is used in some systems from user space for determining the identity
> > > > of the device.
> > > > 
> > > > Expose this as a file so that that user-space tools don't need to read
> > > > from /sys/firmware/dmi/tables/DMI
> > > 
> > > sysfs is an ABI and needs to be documented, I don't see that in this patch,
> > > pls add.
> > 
> > Thanks for taking a look. The only mention of the dmi/id I can find is
> > in Kconfig:
> 
> Sorry I should have been explicit. All sysfs entries are ABI to userspace.
> So they are documented in kernel and the meaning of files should not
> typically get modfied over time.
> Please read Documentation/ABI/README
> 
> For DMI, quick grep told me you should add to
> Documentation/ABI/testing/sysfs-firmware-dmi-tables

No. This is a different interface to user-space (binary tables, instead
of already decoded, selected attributes.)

There is currently no formal documentation of the
/sys/devices/virtual/dmi/id contents, so there's no file Simon can
modify to mention product_sku. Instead, documentation of the whole
directory should be added in a separate patch.

-- 
Jean Delvare
SUSE L3 Support
