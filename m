Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523351102; cv=none;
        d=google.com; s=arc-20160816;
        b=qUb1VtNcStONeaftcvWt5R3mlAb7XWBeHwtAWbzYhJSIrOpkRL7M8BrgChXLNmuP5u
         v6tZtYzis26ra0puFFYji/3sAlYqXLdFPS7v+11yh8TsGSyKR5iU3iZeTWsWQXPeeRuU
         lLiZvzwPFYQC49bihSV5MX20yTD/xnbtEO3KvFc45n8YuHgeM88mijCSsU4MOOaTfih5
         1Lmg5ntvIBn+iGxfiLehk3BcH4vzti/prB35JGuplb91giPoD+zpGEVMxOHdrMxn2ng8
         305RLui6b7otr7SC9tuN0RtnN51qBOsefMbscIJqVnf23+K8CZGybIttHR6kReWBCPWg
         qXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=miqoHc5lUdMzlxBevpdz3m17s615kP9h+O8J/7We7V0=;
        b=G/pLyebm4Dyin8uW8H62WP3p28XnSabv6xYWMRafO4GXEsff6w9BcOIl+Wejoi0BaJ
         dz2Nhj5z79dY672/aUPcX5A1c/otLLhpoJ6RDT1aLMyIi+gQqrllcUd8Eerre8gZMAs3
         I+shAJ4naUrLC2SJ/KRyiPGHHKN51Y9WFHeKeLmD+9B/2WXFR8v15+aUkNpiDKZXUDDm
         xgM1H2ehiYBLXzORYAAl0CS+Sx2Pb3udt+N7FFT5gHoAtaPaiaUqzQ5lJUKTvoAt2IZl
         xwjf8dNFQGNA/2TPo6Zbl92mSCM4qy01ZZOgVWqw7DPQI81erTK5JV+qKlcSFT2myrPF
         3Inw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gcva0UIs;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gcva0UIs;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AIpwx48Pc68KxTVF86FxGGKYxk8YrIg22umGSmW+GQVXyVMxsgJjz4IAlh01x5n0cO2imDXWAKZDiA==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Tue, 10 Apr 2018 11:04:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Edward Chang <edward.chang.mcs@gmail.com>
Cc: johan@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: serial: option: add HP LT4220 support
Message-ID: <20180410090457.GB10795@localhost>
References: <1522722879-2171-1-git-send-email-edward.chang.mcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522722879-2171-1-git-send-email-edward.chang.mcs@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596690689481175486?=
X-GMAIL-MSGID: =?utf-8?q?1597349405137764887?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 10:34:39AM +0800, Edward Chang wrote:
> This patch adds support for HP LT4220. 
> 
> Signed-off-by: Edward Chang <edward.chang.mcs@gmail.com>

> +/* HP products */
> +#define HP_VENDOR_ID				0x03f0
> +#define HP_PRODUCT_LT4220			0x0857
> +
>  struct option_blacklist_info {
>  	/* bitmask of interface numbers blacklisted for send_setup */
>  	const unsigned long sendsetup;
> @@ -2066,6 +2070,8 @@ struct option_blacklist_info {
>  	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_6802, 0xff, 0xff, 0xff) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_WMD300, 0xff, 0xff, 0xff) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0x421d, 0xff, 0xff, 0xff) }, /* HP lt2523 (Novatel E371) */
> +	{ USB_DEVICE_INTERFACE_CLASS(HP_VENDOR_ID, HP_PRODUCT_LT4220, USB_CLASS_VENDOR_SPEC),
> +	  .driver_info = (kernel_ulong_t)&telit_le920a4_blacklist_1 },

The option blacklisting-implementation has recently been updated, so
this patch would no longer apply. Could you please respin this on top of
Linus's tree or my usb-next branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/log/?h=usb-next

which have the following commit

	c3a65808f04a ("USB: serial: option: reimplement interface masking")

Also, I'm trying to move away from adding redundant id-defines, so
please use the numerical values directly in the table and add a short
comment after the entry with the product name instead.

Thanks,
Johan
