Return-Path: <chunfeng.yun@mediatek.com>
X-Google-Smtp-Source: AG47ELvYvIznKtVKoUaoPWlLj6kKKvwXabKvXiuL2TDP12T477U8tmE9KozHPWN6w55QQ7DCXe9n
ARC-Seal: i=1; a=rsa-sha256; t=1521015695; cv=none;
        d=google.com; s=arc-20160816;
        b=tUXkTiY2a5Ve0/F9XNHgae0FoHom8VlLtAJFCrsyXgHLEsHIdgAQJB0dPghxehB4w7
         hDPp0T1NTHRazgkptXI9IU2CH2cYkCOpp5wGzR49+MXZ8vrYS96GWOqCWtld5Fu1BO7G
         4OG5381phboId3TH7KtqhJti1G93kosCOB/DW410Vxb6zvGaebD3s8BXqRh88HlQdDAa
         nJnuuYkRpcdbnEsOSx18bb5LEIM+mslARIIfOGdDTfeRBOcQ2qaysazD3JwwKEUSgxoO
         3RHT4BMM8DBlezY4+ac+r9yTYvk3RbUbOxS7LmALSHyggS630rxY+vGk9X8iJGer3105
         lN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=8wjr/4/QD7KagENVYzJblvs63EeWyNgEKAEBpCwNRxA=;
        b=jSLf5JWuSu2Fx2WxeC+6ejKYNFkv0yzOAeH9/qfnwYOMy6SJd9KnSE3gPE+8ESrJT9
         NdFwtuKRupF364U9Tr5gpctS9QAjRALgmW7WYPs1nPLD/yYtLJBNYeVwLOHpCyuqet07
         g5yP2j3g21DAgjZAr0Dv8qVhLALh2ev9ZMtmS2u+/xXhb3qAFfyUxayYD7p+sEvSacYz
         ShpEHUCp8ILl7zLEWGtGHp88yTmHsOuoSjXF0bZe+Ksy6SSgjOT/N8bIk/NVXe3mROjz
         IX3YTMwY3QbqntQcIBD4C9joPNJX3iddYOOqz0VfDjcgVuFG4Uz6ant36wGYUWK3rIYQ
         PJCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
X-UUID: ca874d0f97554d3582cdd6e1f57ede1f-20180314
Message-ID: <1521015652.3717.28.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: misc: supports Apple Carplay driver
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>, Serge Semin <fancer.lancer@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>, Kate Stewart
	<kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, "Alan
 Stern" <stern@rowland.harvard.edu>, <linux-kernel@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Date: Wed, 14 Mar 2018 16:20:52 +0800
In-Reply-To: <20180314061612.GA17263@kroah.com>
References: <1521007356-12306-1-git-send-email-chunfeng.yun@mediatek.com>
	 <1521007356-12306-2-git-send-email-chunfeng.yun@mediatek.com>
	 <20180314061612.GA17263@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594891848677699255?=
X-GMAIL-MSGID: =?utf-8?q?1594900553814928473?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-03-14 at 07:16 +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 14, 2018 at 02:02:36PM +0800, Chunfeng Yun wrote:
> > The driver is used to support Apple carplay feature by a debugfs
> > interface which can force the driver to send a USB Vendor Request
> > of "Apple Device to Host Mode Switch" to switch Apple Device
> > into host mode.
> 
> While I am all for crazy debugfs interfaces, I would _strongly_ suggest
> not doing that here for the main API to the device.  I know Android is
> trying to prevent any new devices from even enabling debugfs, and as the
> file system requires root permissions by default, you are forcing any
> user of your new api to run as root, which is not a good idea either.
> 
> Given that all you are doing here is a single usb control message, why
> does this even need to be a kernel driver at all?  Can't you do the same
> thing from userspace with a simple libusb/usbfs program?  Or even a
> simple script?
Ok, I'll abandon this patch, and do it by libusb

Thanks a lot

> 
> thanks,
> 
> greg k-h
