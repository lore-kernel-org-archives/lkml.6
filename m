Return-Path: <linux+greg=kroah.com@armlinux.org.uk>
X-Cyrus-Session-Id: sloti22d1t05-2147060-1520271728-2-13303308539209233773
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='78.32.30.218', Host='pandora.armlinux.org.uk', Country='GB',
  FromHeader='uk', MailFrom='uk'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux+greg=kroah.com@armlinux.org.uk
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520271727; b=JX63MjgL7ea0pzSCUPaMsEddh1i0oElgUG9DIU53UjZvVBg
    8GSFIOgI277rJ1r2mYgfiG89rsNmjHA12wXsQ1+55Spvrwi01xpdaZ3Fd94UCtD9
    M88XvraRn9kZWpsDFBzsYhuxFBUsJe95NdVqVGA3hPn5Nug8dKTmlW7Wkv2xyv17
    oCyHhA+0TWy/41uX8nPTtZZXMufTVLSQoMWnUrwRAmkaMojgoYuaRegDCfbgNsaq
    hUT1zcUdeO1nSKHRLpqDQYOx6AP7xicHjrh/XYix2yLEyNsMRvtARgi/LOdXwSfu
    jMJUfJm1ApzJ4SlexM6AvTmBe2xxzfvDWu2Zf4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender; s=
    arctest; t=1520271727; bh=outdKw2z9HPQdjW29kJtt8VanqGD5v4QiedNNO
    gU/7Y=; b=BQsyDTQK2dwmyypWeboFe20WjV2JlPUhXH1McTrZpWvkophPc9wgLS
    65RlLPQFTTPJ7BWMwbspXGkUbbvAOC7hWfTDLsKFIAt2LvTpYd4u8Huxpy/S+jZ+
    drsapKud/6M03DZj5DDeI2vkBo3UpMxKCDn6pfd+dnYXvenb1j/dx2W++RmUCWnU
    7KnkULPwfUJBiYUfmVfk+ZphT6NhUJWop673TlrSNOvxZQ84rYGAriPo9Vd/OX7j
    nkeGQWKGY07ToTI8SMxCGt4onFxwDSCoV8MMTUbaqnT6h15VtWr4rx8AThVvGnAr
    hrzxGnj6sFGLvlzLhHUxfvKEYcX1HZ+A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kYX2sj++ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=pass (p=none,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=78.32.30.218 (pandora.armlinux.org.uk);
    spf=none smtp.mailfrom=linux+greg=kroah.com@armlinux.org.uk smtp.helo=pandora.armlinux.org.uk;
    x-aligned-from=domain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=pandora.armlinux.org.uk x-ptr-lookup=pandora.armlinux.org.uk;
    x-return-mx=pass smtp.domain=armlinux.org.uk smtp.result=pass smtp_is_org_domain=yes header.domain=armlinux.org.uk header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1 cipher=AES128-SHA bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kYX2sj++ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=pass (p=none,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=78.32.30.218 (pandora.armlinux.org.uk);
    spf=none smtp.mailfrom=linux+greg=kroah.com@armlinux.org.uk smtp.helo=pandora.armlinux.org.uk;
    x-aligned-from=domain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=pandora.armlinux.org.uk x-ptr-lookup=pandora.armlinux.org.uk;
    x-return-mx=pass smtp.domain=armlinux.org.uk smtp.result=pass smtp_is_org_domain=yes header.domain=armlinux.org.uk header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1 cipher=AES128-SHA bits=128/128
Date: Mon, 5 Mar 2018 17:41:44 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Jeffy Chen <jeffy.chen@rock-chips.com>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
	Romain Perier <romain.perier@collabora.com>,
	Archit Taneja <architt@codeaurora.org>,
	dri-devel@lists.freedesktop.org,
	Neil Armstrong <narmstrong@baylibre.com>,
	David Airlie <airlied@linux.ie>, Hans Verkuil <hverkuil@xs4all.nl>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Jernej Skrabec <jernej.skrabec@siol.net>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] drm/bridge/synopsys: dw-hdmi: Fix memleak in
 __dw_hdmi_remove
Message-ID: <20180305174143.GH9418@n2100.armlinux.org.uk>
References: <20180305074555.23368-1-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305074555.23368-1-jeffy.chen@rock-chips.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 03:45:55PM +0800, Jeffy Chen wrote:
> The platform_device_register_full() will allocate dma_mask for
> hdmi->audio, so we should free before platform_device_unregister().
> 
> Reported by kmemleak:
> unreferenced object 0xffffffc0ef70ff00 (size 128):
>   comm "kworker/4:1", pid 123, jiffies 4294670080 (age 189.604s)
>   hex dump (first 32 bytes):
>     ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000021946f44>] kmemleak_alloc+0x58/0x8c
>     [<000000009c43890d>] kmem_cache_alloc_memcg_trace+0x18c/0x25c
>     [<000000000e17cd06>] platform_device_register_full+0x64/0x108
>     [<00000000418a0882>] __dw_hdmi_probe+0xb9c/0xcc0
>     [<00000000e0b720fd>] dw_hdmi_bind+0x30/0x88
>     [<000000009af347f6>] dw_hdmi_rockchip_bind+0x260/0x2e8
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index f9802399cc0d..d9afdc59d4f4 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2567,8 +2567,10 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  
>  static void __dw_hdmi_remove(struct dw_hdmi *hdmi)
>  {
> -	if (hdmi->audio && !IS_ERR(hdmi->audio))
> +	if (hdmi->audio && !IS_ERR(hdmi->audio)) {
> +		kfree(hdmi->audio->dev.dma_mask);
>  		platform_device_unregister(hdmi->audio);
> +	}
>  	if (!IS_ERR(hdmi->cec))
>  		platform_device_unregister(hdmi->cec);

NAK.  This is a hack, plain and simple.

The audio device is created by platform_device_register_full(), and
the lifetime of that is managed by the driver model.  When it's time
to clean that up, it's handled by the platform support code in
drivers/base/platform.c.  It is not the driver's responsibility to
clean this up.

There's two issues here:
- Since you're kfree()ing it _before_ unregistering the device, the
  memory you're freeing may still be accessed by the DMA API on
  behalf of the device driver, so you're introducing a use-after-free
  bug.
- kfree()ing it _after_ unregistering the device means that you're then
  potentially accessing memory that has been kfree()'d (the underlying
  struct device) unless you save a pointer to it before unregistering
  and kfree() it after.

However, see the comment in platform_device_register_full() - if this
gets fixed at the core platform level (since every driver using
platform_device_register_full() with a DMA mask will suffer this
same problem, that's the place to fix it) adding a workaround at driver
level will introduce a non-obvious double-free bug.

I suspect the best solution to this is to arrange for struct
platform_device to also contain a DMA mask which
platform_device_register_full() can use, which means the DMA mask will
be freed automatically along with the rest of the platform device,
rather than separately allocating this.  There may be some resistance
to adding 64 bits to platform devices, but if we have lots of these
separately kmalloc'd DMA masks, we're actually wasting a lot more memory
not doing this (since kmalloc has a minimum size of the L1 cacheline
size.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
