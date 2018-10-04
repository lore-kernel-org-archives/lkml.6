Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD32C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BD02084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=openedev.com header.i=@openedev.com header.b="BD9VA03U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BD02084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=openedev.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeJDUDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:03:22 -0400
Received: from se14t.web-hosting.com ([162.255.118.155]:40664 "EHLO
        se14t.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeJDUDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:03:21 -0400
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
        by se14.registrar-servers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <jagan@openedev.com>)
        id 1g83OE-000199-Ed; Thu, 04 Oct 2018 06:10:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=openedev.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xEl4VWVWnPqNZL+Db8EpFCATx+8C5mXHbjxF/BkVTkM=; b=BD9VA03UHuNAgfGoHqB3+JrQ5n
        7IcC/qTHM4+O3fgKF11q/M74GOYJvzilG2Rq7DK4QF2gTtzpwshTmuzJfJOVz/2C/eH2Nm7QVUC7i
        hpdI4fsdsBY9nFVLMKP9TO3q/WGew27i7KcJP6crYdV8rVEj/tTx+Ydj4ZHtoaZNU5b9Xht2+FNOt
        6p1IeRHadCkNRxo5M2VSZbalB8zvGuQrYwdqNIhqOdh2IPMIoH8K55IUyi1KEf5nvoSEwmQuEHjCH
        AjanxnlePbPbM2VOP8pmc2zxngc6MIQdUY/wC2Dvbu8fkK/N5Ekvya+ofsV5G0eV+ZlnTCSIw1H06
        ny6MD21A==;
Received: from [49.206.202.155] (port=40669 helo=[192.168.0.105])
        by server153.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <jagan@openedev.com>)
        id 1g83O9-0044Sw-D8; Thu, 04 Oct 2018 09:09:58 -0400
Subject: Re: [linux-sunxi] [PATCH] clk: sunxi-ng: enable so-said LDOs for A64
 SoC's pll-mipi clock
To:     icenowy@aosc.io, Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20181002122911.22094-1-icenowy@aosc.io>
From:   Jagan Teki <jagan@openedev.com>
Message-ID: <9bd28354-28f8-0393-20ff-e935bbc9a62c@openedev.com>
Date:   Thu, 4 Oct 2018 18:39:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002122911.22094-1-icenowy@aosc.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com; auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.12)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5r1Qxy6Ju4qsiO+u8FLb3fp602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO0Ma0zdKrj2HeYAO9pcN4rBgaa/6KAnDjbDW9Kfk8S67rc0diZKnmpMa4igsMUptb3ws
 3TRjaC42FtNJuTWwh7xL8l8rqxNaHuPCw9oN7QeJU2Itm39BdCc4FEP6OrUewhrcVJmSrd4yKrf/
 cy1+1rQfLHGTxKOzej3+TycsGem01FGQlug+MpXIDXDZ6R4f6MV33MVZLiM0tmvREfmMhchX0R/b
 IbNMTbZmehbsFvk6pnSljm/uOTpy7IKEc4TegU9c91QHjL4iGggA8q+PFMRD9cDsMD6+DMnY3BrX
 X4WG4pWx7WxWFZpsjT/483ewglaffpESOdWHL8mcF8YfXhann55Sm1gATwtZJGfjLbW+6WlYBSni
 Dc6pqiShUb555iQuqoY92JLFmKrUcp4834mHaVNT607M9kZNEaIQSUch96woBCGcRFZj5lvJv+hq
 WXGfZreTrrCodBGR0eudR/Re4NVbVEBU/8Tv9RjL1PyuPUqLOKbsG+lHg5pugio8C0/xwJn86JXZ
 ntZdday/XHpAvWR6S+8Nz/JhsIILyn0JRaKhI9PH/KI4koWcgiyjzC9BXwhtLi0XP5JixjQ+VOdX
 3pYVvP187ucXR1/Tcn9MA0++SyKoHsXaSnx03Hj/t/KYzhX51i/DfOBpfkwL5JiEKUZCoFouj/h7
 lFZN6N2kwXjQxqN+xRHPwvh2ZAsqZaJ59bLAOqY58g8AZ3JZDGN632pax8+Y6ydNDJfcf8A70Rkw
 IBS0D3l8zHX4Z5Op6+p/fYdEAhcvFLGNAi49Bl4rvWiyW/pflyYVnTzgGVOP0LK7mlEIHj08xYCs
 EX2Q80r0vFMI3N+ILl9Orwhj5WwkTk42saLvF6Mg00AlSBYT5Ky/mEyPfafXwXfN1e2oc9JMBOfk
 TF06G+sGivqY3TFjYBawgrzb0h/N4KdFftDkVy7MV6ihf224JloyThMb49jO7L+pX4xrK8fNw6/P
 tRD1H/aAwarQpYDOYx/6JtUONMFr/2JNYjMa3o85viMc3nyVoPM9YyTAo/dBOJm66FxbSA6U/PEx
 IgJ14JdFndotgfFrL3927nPLXidUYhzTL5iMxSdrNR4YHX23VqG3SZy0xd3smFtVXCuTAIgZzSh5
 GAaAWDbFQt9IkoBG/EcyNA==
X-Report-Abuse-To: spam@se16.registrar-servers.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 October 2018 05:59 PM, Icenowy Zheng wrote:
> In the user manual of A64 SoC, the bit 22 and 23 of pll-mipi control
> register is called "LDO{1,2}_EN", and according to the BSP source code
> from Allwinner , the LDOs are enabled during the clock's enabling
> process.
> 
> The clock failed to generate output if the two LDOs are not enabled.
> 
> Add the two bits to the clock's gate bits, so that the LDOs are enabled
> when the PLL is enabled.
> 
> Fixes: c6a0637460c2 ("clk: sunxi-ng: Add A64 clocks")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---

Tested-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>

