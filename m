Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFDBC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC75B2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUg4cUck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC75B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeKTXiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:38:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42346 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeKTXiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:38:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so1896944wrx.9;
        Tue, 20 Nov 2018 05:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7NZ/xVlUfPpnqYC9BP/cMc65vHefuKvjMR7MCkPyfeg=;
        b=QUg4cUckU0TJ9Rfn2S+mKU38UqCf5W5oSxfTsxRIVTUOGkQv6ldQptI/4mJ9SH1w/z
         JFFxcGKBF0oY47gIwf0XukiWNiuKrCRF6qm2EMlqtrSLRbQ7V59lNHp0DC5fa8T+BS/1
         0E5hsvU+iDlrZwCzsCySlLi5h52n8HlD7nKCXLlaox/vrj85dptJXhgygb9qrtyC5oek
         E9G59cAU8/TPqkMyCwBDUNPw7oWpAx8odWtoEzMXcnZJO09ht1ueIclJqL4bEUa/zW/D
         95/KbNhDm6Er5TrYJkShBmLoEnnA2vB2bQ7Qy9Wp/X9fE8Oc9Pkudf+NLN1gay+hNGV7
         F5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7NZ/xVlUfPpnqYC9BP/cMc65vHefuKvjMR7MCkPyfeg=;
        b=dNuGPryGGNu7DYzPmkGFoMrAGf+Y2lAq9IVGs2mkFAtkkJBtfZLiuMmitPStIouiKT
         NewKX/ADwMzvoCygf2k0ERlrtnnZRJJLZSrB+e3OaBhG1yOgHyIJLlk8I2DQjR0y0YlP
         F/muiEtcCdSWPu/QTGjQ62SBogfwoGkr0eybRt4GHJHvf5JeY5h+lY7IKKsaLIqYbDSO
         JQMs1D5ODffgmdretL0ULnHZ3uPXYOfBzoDW++oDeaNJN2hbpyHodDTklMEFFeN/GKYx
         fpc+jOZQInWs3pkgiybwLigsy/gRf0+tZIlPBKWUrF4UP1dEFoLwWBD+LeP9WKlNGqtR
         DH9Q==
X-Gm-Message-State: AA+aEWZ1Hll+KDaH/25LjB5HMv9t+PTYgoiOP1ox5A2gPg3sLG5+xNv1
        9q2FjFQHXp+y/KUnyWyFoGjp3BPDvRU=
X-Google-Smtp-Source: AFSGD/VcF3kJaHeI8rUV56S5HZfi/kj8OjOtyVqXlWDy42Lmx+cPeLy95VfmXizNTbvdFUDDQrr64A==
X-Received: by 2002:a5d:64c7:: with SMTP id y7mr1884663wrv.207.1542719347389;
        Tue, 20 Nov 2018 05:09:07 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id v189-v6sm33598381wmd.40.2018.11.20.05.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 05:09:06 -0800 (PST)
Subject: Re: [PATCH 1/2] spi: Add Renesas R-Car RPC SPI controller driver
To:     masonccyang@mxic.com.tw
Cc:     boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, tpiepho@impinj.com,
        zhengxunli@mxic.com.tw
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
 <0223f43b-c6a6-eade-49af-4e7b7ef7f022@gmail.com>
 <OF4FAD10C5.F4F6D29B-ON4825834B.001FAB40-4825834B.00289635@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <6b024f18-d0bc-3e65-f07c-cef913f795ab@gmail.com>
Date:   Tue, 20 Nov 2018 14:09:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <OF4FAD10C5.F4F6D29B-ON4825834B.001FAB40-4825834B.00289635@mxic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/2018 08:23 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> Marek Vasut <marek.vasut@gmail.com>
>> 2018/11/19 下午 10:12
>>
>> To
>>
>> > +
>> > +static int rpc_spi_set_freq(struct rpc_spi *rpc, unsigned long freq)
>> > +{
>> > +   int ret;
>> > +
>> > +   if (rpc->cur_speed_hz == freq)
>> > +      return 0;
>> > +
>> > +   clk_disable_unprepare(rpc->clk_rpc);
>> > +   ret = clk_set_rate(rpc->clk_rpc, freq);
>> > +   if (ret)
>> > +      return ret;
>> > +
>> > +   ret = clk_prepare_enable(rpc->clk_rpc);
>> > +   if (ret)
>> > +      return ret;
>>
>> Is this clock disable/update/enable really needed ? I'd think that
>> clk_set_rate() would handle the rate update correctly.
> 
> This is for run time PM mechanism in spi-mem layer and __spi_sync(),
> you may refer to another patch [1].
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-4.21&id=b942d80b0a394e8ea18fce3b032b4700439e8ca3

I think Geert commented on the clock topic, so let's move it there.
Disabling and enabling clock to change their rate looks real odd to me.

>> > +   rpc->cur_speed_hz = freq;
>> > +   return ret;
>> > +}
>> > +
>> > +static void rpc_spi_hw_init(struct rpc_spi *rpc)
>> > +{
>> > +   /*
>> > +    * NOTE: The 0x260 are undocumented bits, but they must be set.
>> > +    */
>>
>> FYI:
>>
> http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/spi/renesas_rpc_spi.c#l207
>>
>> I think the STRTIM should be 6 .
>>
> 
> In my D3 Draak board, the STRTIM is 0x3 for on board qspi flash and
> mx25uw51245g.
> And this is also refer to Renesas R-Car Gen3 bare-metal code,
> mini-monitor v4.01.

The copy of minimon I have says 6 , but maybe this is flash specific ?

[...]

>> > +         writel(rpc->cmd, rpc->regs + RPC_SMCMR);
>> > +         writel(rpc->dummy, rpc->regs + RPC_SMDMCR);
>> > +         writel(rpc->addr + pos, rpc->regs + RPC_SMADR);
>> > +         writel(rpc->smenr, rpc->regs + RPC_SMENR);
>> > +         writel(rpc->smcr | RPC_SMCR_SPIE, rpc->regs + RPC_SMCR);
>> > +         ret = wait_msg_xfer_end(rpc);
>> > +         if (ret)
>> > +            goto out;
>> > +
>> > +         data = readl(rpc->regs + RPC_SMRDR0);
>> > +         memcpy_fromio(rx_buf + pos, (void *)&data, nbytes);
>> > +         pos += nbytes;
>> > +      }
>> > +   } else {
>> > +      writel(rpc->cmd, rpc->regs + RPC_SMCMR);
>> > +      writel(rpc->dummy, rpc->regs + RPC_SMDMCR);
>> > +      writel(rpc->addr + pos, rpc->regs + RPC_SMADR);
>> > +      writel(rpc->smenr, rpc->regs + RPC_SMENR);
>> > +      writel(rpc->smcr | RPC_SMCR_SPIE, rpc->regs + RPC_SMCR);
>> > +      ret = wait_msg_xfer_end(rpc);
>> > +   }
>> > +out:
>>
>> Dont you need to stop the RPC somehow in case the transmission fails ?
> 
> It seems there is no any RPC registers bit to monitor xfer fail !

What happens if wait_msg_xfer_end() returns non-zero ? I guess that
means the transfer timed out ?

[...]

>> > +static const struct of_device_id rpc_spi_of_ids[] = {
>> > +   { .compatible = "renesas,rpc-r8a77995", },
>> > +   { /* sentinel */ }
>> > +};
>> > +MODULE_DEVICE_TABLE(of, rpc_spi_of_ids);
>> > +
>> > +static struct platform_driver rpc_spi_driver = {
>> > +   .probe = rpc_spi_probe,
>> > +   .remove = rpc_spi_remove,
>> > +   .driver = {
>> > +      .name = "rpc-spi",
>> > +      .of_match_table = rpc_spi_of_ids,
>> > +      .pm = &rpc_spi_dev_pm_ops,
>> > +   },
>> > +};
>> > +module_platform_driver(rpc_spi_driver);
>> > +
>> > +MODULE_AUTHOR("Mason Yang <masonccyang@mxic.com.tw>");
>> > +MODULE_DESCRIPTION("Renesas R-Car D3 RPC SPI controller driver");
>>
>> This is not D3 specific and not SPI-only controller btw.
> 
> In R-Car Gen3, there are some registers(i.e,. RPC_PHYCNT) in different
> setting
> for R-Car H3, M3-W, V3M, V3H, D3, M3-N and E3 model.
> 
> I test this patch is based on D3 Draak board, it works fine but I am not
> sure
> if these registers setting is ok for others R-Card model.
> 
> I think this could be a reference when patch others Gen3 model is needed.
You can take a look into the U-Boot driver(s) I linked, that's used on
the other SoCs you listed (except for V3H).

-- 
Best regards,
Marek Vasut
