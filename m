Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AH8x225yUSr+kyK/HE0NnNWBMmU9mWG5FKIKxJJoswHkSoBZGz4voB2cc4FPM4WCTJg7iAzL86Hi
ARC-Seal: i=1; a=rsa-sha256; t=1519855186; cv=none;
        d=google.com; s=arc-20160816;
        b=gCwL5gdWmkeIW34WaZi8uSVcoDvAYmDRBxiiMdTGWjbLfFlzm4+OWoTwOGD3mjzBTV
         ieoLgSL8/T7FeAlE+S2MEvEsACKQqw4lTQOM6XvMVkH1MGXxYuG07vL7HhYnbUQFkS2J
         OAqzCsUoIxDCuw6AK0jPdrZtv5jxmwEdgbzzrUjHJKQOHJIzUfLvdZbPjQcwCN0jgphR
         /CdEdJ56hQATCm53tAu5iOAvQcPANV7uUX0XCIdgS0npIKKpYnKqv7Mc7ZygwpjKY+Rr
         MGdoUGA02++m98q+feuzXiC7LEBzCW07OlehOtuFKN8tkh9ETy0YB2VbRahPiTOHJOdu
         Qxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=NfdvzMHjbRM8g4uM6c4i4hOY5sinN01gTdZCem9wH1M=;
        b=kw3adOx6mRyz0Vkl/Wd73lGIQ2aMg69J+vZCKAeU0Hw5r6oXS/X6FkvS90tvUZ38kY
         Z+LnAdOrttaLQHM9Hoi5qcxVxLG/C8yvOXQGxqoN1fNtzzLmYA2X/OMP4duJO3QZ5JFN
         IO4/T8YA6HAA3GnHlgwnQG2I2e/5WGJ42jdhHNziPj+a+EuDKLO7l60CxyyYiyjD5Z31
         9UT7qrOYmHJyrMzwKUY4bdLJruJGOwM5tbFDbz0zrCc51/CVD1AbYwizTRdPKb5I82HG
         BKWE+o+iu48p6ikFzEc3BUSU/CJxHnCcqfDDmmLUHQ3cBcaqsdFG60C14epHc9DB9UBK
         TYsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Date: Wed, 28 Feb 2018 13:59:43 -0800
From: Tony Lindgren <tony@atomide.com>
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: linux-omap@vger.kernel.org, Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] usb: musb: call pm_runtime_{get,put}_sync before
 reading vbus registers
Message-ID: <20180228215943.GI5448@atomide.com>
References: <20180227222740.2150-1-merlijn@wizzup.org>
 <20180227222740.2150-2-merlijn@wizzup.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227222740.2150-2-merlijn@wizzup.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593594893909061681?=
X-GMAIL-MSGID: =?utf-8?q?1593683671676275576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Merlijn Wajer <merlijn@wizzup.org> [180227 22:29]:
> Without pm_runtime_{get,put}_sync calls in place, reading
> vbus status via /sys causes the following error:
> 
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab060
> pgd = b333e822
> [fa0ab060] *pgd=48011452(bad)
> 
> [<c05261b0>] (musb_default_readb) from [<c0525bd0>] (musb_vbus_show+0x58/0xe4)
> [<c0525bd0>] (musb_vbus_show) from [<c04c0148>] (dev_attr_show+0x20/0x44)
> [<c04c0148>] (dev_attr_show) from [<c0259f74>] (sysfs_kf_seq_show+0x80/0xdc)
> [<c0259f74>] (sysfs_kf_seq_show) from [<c0210bac>] (seq_read+0x250/0x448)
> [<c0210bac>] (seq_read) from [<c01edb40>] (__vfs_read+0x1c/0x118)
> [<c01edb40>] (__vfs_read) from [<c01edccc>] (vfs_read+0x90/0x144)
> [<c01edccc>] (vfs_read) from [<c01ee1d0>] (SyS_read+0x3c/0x74)
> [<c01ee1d0>] (SyS_read) from [<c0106fe0>] (ret_fast_syscall+0x0/0x54)
> 
> Solution was suggested by Tony Lindgren <tony@atomide.com>.
> 
> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>

Thanks for fixing this. Assuming it passes Bin's tests:

Acked-by: Tony Lindgren <tony@atomide.com>
