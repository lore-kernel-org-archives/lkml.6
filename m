Return-Path: <b-liu@ti.com>
X-Google-Smtp-Source: AG47ELvQOwrjflzVzky5zcd6+K7fTrVzk3IrwZ2RRjl4nBjy/v5m5U17bCOXfQj6cZ38Mv27fu1j
ARC-Seal: i=1; a=rsa-sha256; t=1520004433; cv=none;
        d=google.com; s=arc-20160816;
        b=nj0Q7PkKb/9DSLxKdA/XcvB1aKJ353BkAnHgcc0OG0mKrQzE7VZ6VZusy087PBMtSe
         HYbKhmsJPe/7neKsENyFV3/NX5F0b344a1kmYqwSrvbA1TVRn2s8kHX2NYnFm/chSN3l
         U96iFBNqYSTFq0TmjDcPG8F9oXAQ40cwwog5uCuRAqNzID3L8MFb5/c2a5Z8doR8yXW4
         rpivqafaMmCKJzRxv99vGCIn55lOSKXmGyEVbr021SFSR6nqIUdyw56lhqCbIb82tJKD
         NvJVe6F4zWBMiQjB8ufDhV0/t4GhTj6x08p8BPbFyYteU+lyc3OK0qL5YsnXfntxozUQ
         pQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=sk0bt7ZUTcBzu6Vi3CkULc8ap11D3qRvKIIEt3VZ00Q=;
        b=YIjxTGhfuG30wKijvSjLrW0LD+ophvST5bd/shDgmBFMzuVIn0rOslbrg0SlumJHwP
         C7vnUH0dp0JK+1b/TG0zSGKAXrEVX6pqRE8umrmBwyqKdOhHbqzxYRS7ym96VWg0EZFY
         je4JXl0QUMn19ThnA2fMgJUJahMGmx2EbHjvh/CUkG75xsAf20IuF61/INaz85Q5zrci
         5iYhvzp4p+sarMME8BSVE3mcieB+3Y23O6q9wigj5XRAZC1TG1bNmqE3N03KDjtiCRDL
         Y9ke7lyNKNJpATdGPr0XfWTxT0iV58ISRaEUpCmEFCt1b2l7tWYd9mzzd5vU+EA9TVuW
         /ZRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=i1eGBB4W;
       spf=pass (google.com: domain of b-liu@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=b-liu@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=i1eGBB4W;
       spf=pass (google.com: domain of b-liu@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=b-liu@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Date: Fri, 2 Mar 2018 09:27:12 -0600
From: Bin Liu <b-liu@ti.com>
To: Merlijn Wajer <merlijn@wizzup.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Pali
 =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Ivaylo Dimitrov
	<ivo.g.dimitrov.75@gmail.com>,
        <linux-omap@vger.kernel.org>
Subject: Re: usb: musb: "(null)" in sysfs mode file after disabling a gadget
 (and at other times, system hangs)
Message-ID: <20180302152712.GA22262@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
	Merlijn Wajer <merlijn@wizzup.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	linux-omap@vger.kernel.org
References: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593781038730915565?=
X-GMAIL-MSGID: =?utf-8?q?1593840168787670673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Fri, Mar 02, 2018 at 12:47:07AM +0100, Merlijn Wajer wrote:
> Hi,
> 
> I found that the "mode" file in musb sys node will return "(null)" when
> one would expect it show b_idle.
> 
> Wrong /mode file:
> 
> [Fresh boot, cable not connected yet]
> root@n900devuan:~# modprobe g_nokia
> [Insert cable connected to PC]
> root@n900devuan:~# cat
> /sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/mode
> b_peripheral
> [Remove cable connected to PC]
> root@n900devuan:~# cat
> /sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/mode
> b_idle
> root@n900devuan:~# rmmod g_nokia
> root@n900devuan:~# cat
> /sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/mode
> (null)

I can reproduce this on AM335x EVM,

> [Insert cable connected to PC]
> root@n900devuan:~# cat
> /sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/mode
> b_idle

but not this, I still get (null). g_nokia is not loaded here, right?

> 
> I would expect it to state "b_idle" instead of "(null)".

Actually, I'd like to see (null) whenever a gadget driver is not loaded,
which indicates a gadget is not bound to the udc.

Regards,
-Bin.
