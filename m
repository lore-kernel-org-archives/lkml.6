Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C49C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1CF2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="cnVrZkEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfBYS0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:26:31 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35222 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBYS0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:26:30 -0500
Received: by mail-lj1-f196.google.com with SMTP id t13so3949771lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 10:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ykpzer4RBcU0VcCznMZdvt8qKc+1G2JLswY5vEVF8KE=;
        b=cnVrZkEa0+E2BDaBa9Bqu+PZyTg/T7u4ILs8kHP+zOTrFDaY6CjejkKtzzEEs9+41m
         vOFG5x/+cOvsmCEPzFpbmwzfS8YGkytQ0V9jHaNRK+YlguIxVhQhxsdz6wtu7IpcFmOV
         TFGwvuKdNFUFn2lX6lKSWWhjuSYnNdgmMn13s+++3g7cSe3DqeIbQP6s27DVSsDLCUtm
         yV6GIRG3JqhVcYviv7X/pFadwNA8qIhASPBvjxbX52UL1WGej1xpgqkRv/P14viBCgQC
         GL4q/kjMb8xMzz3qlJ36Byy5pMDu4ufxkU/NHX3naueT2/4qVC3F1aCZetbcdj7nX4Ly
         rWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ykpzer4RBcU0VcCznMZdvt8qKc+1G2JLswY5vEVF8KE=;
        b=X2UF7l1w4v53vFZHh6w/82KCpaCbi9iFFyvGylJJW7cWjfeOmLqk59N4JkSCKptTJT
         u/0hv8EhpWgaRHhl0Hj9MpkcDK7ONkqYuTgED57tjhtKK16XlSTvOahf7aFBcj2/T570
         ydU9K88oI8Qio7qi8jGPM94uM7VW68AFBoqTyAt0HsVqMOIHngIMG799SZiYtOctZiTQ
         jT9FFCmCkoCO2LiQL3xztMA7v+pK3wCsHc5bEStDErxY/ndF3lBFwDjeTSDNPUku2KMP
         De7gZQ3UEkN2z7HEG3EY8l/VnqLU3hLJrNWRfeWocId5h0Awr4C3O4m4FQ8DGzXilGHt
         HxjA==
X-Gm-Message-State: AHQUAuY2rcPWakaMH/w59eg24dp5uXrf0kuA/+j59l6UmtIxFTq2Ebuh
        qJxzYcGJD16YfX28jyLue6XFBw==
X-Google-Smtp-Source: AHgI3IauTkTaG9r94aYfrTbxXRe3SgfuefYMs+7/pOQ/52B+35BeBQd9H6xbT4LLh1M94kT+jd4vug==
X-Received: by 2002:a2e:7806:: with SMTP id t6mr9568859ljc.188.1551119187463;
        Mon, 25 Feb 2019 10:26:27 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.85])
        by smtp.gmail.com with ESMTPSA id r64sm1608761lff.77.2019.02.25.10.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 10:26:26 -0800 (PST)
Subject: Re: [RFC PATCH 3/5] mtd: Add support for Hyperbus memory devices
To:     "Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>)" 
        <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        tudor.ambarus@microchip.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nsekhar@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-4-vigneshr@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <92bfdbf8-cc78-c691-298d-d2eb6193e1be@cogentembedded.com>
Date:   Mon, 25 Feb 2019 21:26:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190219063607.29949-4-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19/2019 09:36 AM, Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>) wrote:

> Cypress HyperBus is Low Signal Count, High Performance Double Data Rate Bus
> interface between a host system master and one or more slave interfaces.
> HyperBus is used to connect microprocessor, microcontroller, or ASIC
> devices with random access NOR flash memory(called HyperFlash) or
> self refresh DRAM(called HyperRAM).
> 
> Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
> signal and either Single-ended clock(3.0V parts) or Differential clock
> (1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
> At bus level, it follows a separate protocol described in HyperBus
> specification[1].
> 
> HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
> to that of existing parallel NORs. Since Hyperbus is x8 DDR bus,

   HyperBus, please be consistent.

> its equivalent to x16 parallel NOR flash wrt bits per clk. But Hyperbus

   Again...

> operates at >166MHz frequencies.
> HyperRAM provides direct random read/write access to flash memory
> array.
> 
> But, Hyperbus memory controllers seem to abstract implementation details

  And again.

> and expose a simple MMIO interface to access connected flash.
> 
> Add support for registering HyperFlash devices with MTD framework. MTD
> maps framework along with CFI chip support framework are used to support
> communicate with flash.
> 
> Framework is modelled along the lines of spi-nor framework. HyperBus
> memory controller(HBMC) drivers call hb_register_device() to register a
> single HyperFlash device. HyperFlash core parses MMIO access
> information from DT, sets up the map_info struct, probes CFI flash and
> registers it with MTD framework.
> 
> Some HBMC masters need calibration/training sequence[3] to be carried
> out, in order for DLL inside the controller to lock, by reading a known
> string/pattern. This is done by repeatedly reading CFI Query
> Identification String. Calibration needs to be done before try to detect
> flash as part of CFI flash probe.
> 
> HyperRAM is not supported atm.
> 
> HyperBus specification can be found at[1]
> HyperFlash datasheet can be found at[2]
> 
> [1] https://www.cypress.com/file/213356/download
> [2] https://www.cypress.com/file/213346/download
> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>     Table 12-5741. HyperFlash Access Sequence
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
[...]
> diff --git a/drivers/mtd/hyperbus/core.c b/drivers/mtd/hyperbus/core.c
> new file mode 100644
> index 000000000000..d3d44aab7503
> --- /dev/null
> +++ b/drivers/mtd/hyperbus/core.c
> @@ -0,0 +1,167 @@
[...]
> +/* Calibrate HBMC by repeatedly reading "QRY" string from CFI space */
> +static int hb_calibrate(struct hb_device *hbdev)
> +{
> +	struct map_info *map = &hbdev->map;
> +	struct cfi_private cfi;
> +	int count = HB_CALIB_COUNT;
> +	int ret;
> +
> +	cfi.interleave = 1;
> +	cfi.device_type = CFI_DEVICETYPE_X16;
> +	cfi_send_gen_cmd(0xF0, 0, 0, map, &cfi, cfi.device_type, NULL);
> +	cfi_send_gen_cmd(0x98, 0x55, 0, map, &cfi, cfi.device_type, NULL);
> +
> +	while (count--)
> +		cfi_qry_present(map, 0, &cfi);

   Why do all 25 reads if you can encounter valid QRY in less reads than 25?

> +
> +	ret = cfi_qry_present(map, 0, &cfi);
> +	cfi_qry_mode_off(0, map, &cfi);
> +
> +	return ret;
> +}
[...]

MBR, Sergei
