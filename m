Return-Path: <stefan.wahren@i2se.com>
X-Google-Smtp-Source: AG47ELvmL5jhFIdMzl+vowkV8u3xrFcba6Sv2PRNnn6pvucmos7eqyANqKY4e8sKZm96iEymVe9g
ARC-Seal: i=1; a=rsa-sha256; t=1520530318; cv=none;
        d=google.com; s=arc-20160816;
        b=xt3Rt3YW3XWQwx2osAxyhl9APLkPFiIsoVBPduc1K6Uj27MlGixLotQWhyWZqhAgoz
         mGY6NAHNdgHCQAa89H2to09JhXtZ1R3ZG8AgXH7zX9T4yprywScQgkmSxcn/LrHZV6wD
         OohjPFrYnxelXwljA6GoSX5krxUXf8ju0FNsQjD6iqlSYnqWeEy/UzoX14LkcO1Yp7J9
         LrAT9RvsB3sTAgWLa/VYBbeKeg7+g3JvTh5UkEM6icCwOMR9fgLvXkusjD3N7BJoXj/C
         f+mr67FTL8NRXK6D5pIVdx+1XTtDVtg/ZPLWK3ni6Nc5AV8i1lbjZ/rvPvbLLxhAgMVY
         p7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=importance:content-transfer-encoding:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date
         :arc-authentication-results;
        bh=AC0LSDslGE9QAe7ru4eqpCoZD2xukaEKigABNMG0kWw=;
        b=Ga0P1J6xcrLcuNAxububYX2p69umXksrRxkaHWf2saykYpVhk1129TLYNQMVfBAwcR
         wZ1DWlRymMEUTyeYOaXy3YQru1mA2SRc3viploMTmbYT+R1yltUmrpL+n1ttqdcVrDv9
         fCPRr3ByLwZZOI871DjrwULENB9sTYqdPWjx7ZLwF7GJok1Qh+gJ5M7Cze+Z0X0Etkqk
         TWsZAyh6fnsOA2CAW1KQgJeF0uWuNIG1hLWlOpgibIUgW5BYFh/coUmM2Hlj4RYHQBFd
         t3KP4cuL/kRNZVxzpENlO/XkrzvbpxVCdxhe1n4UB5FTSrroDSeu3/88/NCPTEH+yPUC
         GjjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 217.72.192.73 is neither permitted nor denied by best guess record for domain of stefan.wahren@i2se.com) smtp.mailfrom=stefan.wahren@i2se.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 217.72.192.73 is neither permitted nor denied by best guess record for domain of stefan.wahren@i2se.com) smtp.mailfrom=stefan.wahren@i2se.com
Date: Thu, 8 Mar 2018 18:31:54 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: John Youn <johnyoun@synopsys.com>, Felipe Balbi <balbi@kernel.org>
Cc: Gevorg Sahakyan <gevorg.sahakyan@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1893294987.392820.1520530314966@email.1und1.de>
In-Reply-To: <1518466808-30318-1-git-send-email-stefan.wahren@i2se.com>
References: <1518466808-30318-1-git-send-email-stefan.wahren@i2se.com>
Subject: Re: [PATCH] usb: dwc2: Print error if unable to set DMA coherent
 mask
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:JqFDRU6kZ1+JVREGTA7lxKQkSKge1ivI0kUkXF6Kou7i6Zm9DRM
 Eo+6lpQYobnlk4pVq0CxGp1bYsZRyST6ivjpBaBTpoMUDTedeD5w7UC5SpqySyCy8aFICv1
 xWJURGKB8MO0uNpZyVlWIX5++PhoHJcuLCzKZGkOdUzjosg2YGE9w0LyI7I6U8+5qFMVWh9
 6PLkYwukLMcemN2EkaJJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:grAkhhStOJE=:q5HiX97VIGXP8T+SKNUjwI
 oBEL+BKAL0umASKgBAJM5xlkWIRGql0MAF06ivG2RRx/8niSvVyJAb140d0rRiH0HybHqilFy
 nsFxtzMLr2YUeR5u3u1Uww0+2Y0ckDmXwWnRM79+j5U3NZEuNVwv/bG7OXZU3q6X6EM8d+wGx
 GlVrh15DmeCBUjZnn0fMJ9a2mpZvHoerw5OnticSiI6gh1CJpSBeJuRystr+mPZq6UGzFOms0
 AUT5HtnirvTBqX7nbmf+YfiHwgMMJJ4hA+E1ni+cb0lYjI+6BUIyYo6Tx3cgeTidp2i/Q4AiN
 WQlho7r17CMHIy/1uHzdVHjWSLldSJRLwsWckMHeJbjK5taJjIUgEeupw0Y9M+1XXDoSQKV2a
 Z1OZSzJqKZMwxX+zrrFpPuikBbXnzan3uizsouaYAPxRbiN9M07DZQ+Fu/JEF6SFm+sVBkAVH
 zkbWSDPFLuk9KQVdZFhofxoam3iv7smhZl21T5OWz3/f2wOEW4Ck+psP4j7nSIJ75PlpJ3SwX
 e3Rq7tqGk/xZr2brGhDxKPNHAW1ksnEFD6xeJby9YBz84G8iXmQ5GrbtkV5VrG6Bz89nxj6Ok
 J25yrSDKI6R8x/xh1XffdFIUWkFvgj4Pl09rI9up+a1M90O9IywrxeNHEYdV5kWpeaHnz69S8
 cwnuoVVNDCQ3aT3H2qrPVHqANkGjqYyiKl85mF1Q/L1ffT6bk+2yFzjKVFY+7KKyNvgCOXwiL
 aEdxyNzyKbK7r+KgYPhZrxn4hUFhu2R5EkftqVrB7aqJDe1cZFflkJqP2Yo=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592227879675111138?=
X-GMAIL-MSGID: =?utf-8?q?1594391598683651977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> Stefan Wahren <stefan.wahren@i2se.com> hat am 12. Februar 2018 um 21:20 geschrieben:
> 
> 
> We better print an error in case probing of dwc2 fails on
> setting the DMA coherent mask.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/usb/dwc2/platform.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
> index 4703478..4ddbdbd 100644
> --- a/drivers/usb/dwc2/platform.c
> +++ b/drivers/usb/dwc2/platform.c
> @@ -382,8 +382,10 @@ static int dwc2_driver_probe(struct platform_device *dev)
>  	if (!dev->dev.dma_mask)
>  		dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
>  	retval = dma_set_coherent_mask(&dev->dev, DMA_BIT_MASK(32));
> -	if (retval)
> +	if (retval) {
> +		dev_err(&dev->dev, "can't set coherent DMA mask: %d\n", retval);
>  		return retval;
> +	}
>  
>  	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
>  	hsotg->regs = devm_ioremap_resource(&dev->dev, res);
> -- 
> 2.7.4
>

ping ...
