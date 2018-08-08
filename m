Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6C7C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62DD21509
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jO3VfQ1g";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="k1GXTc4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62DD21509
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeHHMqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:46:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56050 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeHHMqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:46:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 487EE607C6; Wed,  8 Aug 2018 10:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533724069;
        bh=iiSnH65U8nlyRKPdgOPtolpgApYXn3iK2up+3LRZqDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jO3VfQ1gbLessdHsYL7AQs5oboEANgGJKtB1oeV8C9o+zFSGnLBDH91o5badVB6q7
         /HLA+LaPbEfE+6qY4SYCmYvzIC3IlFm0K1ycTSUr/vEpP10o9ddkr49Ptt3Qby1pzW
         iavRYQAoF0TV7d7f437Z1Eouc0APgr6AXoo1EefM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9DA15607C6;
        Wed,  8 Aug 2018 10:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533724068;
        bh=iiSnH65U8nlyRKPdgOPtolpgApYXn3iK2up+3LRZqDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k1GXTc4qwbAhDn/Q6o58A6hNDG0eVXgvIwQowzY52zPtST6BBsdhPW3+OXuMuIR/e
         g63cUAV2ahULcsKxLLOaaApAmU0/Ef5g3YmcQ4GpQeDkzikzb5+baddE+rRWW7QRcO
         ydIr1mwLDFp9NzVj9Ig7ST4w8Lpy8WTQE12iX6qk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 08 Aug 2018 15:57:48 +0530
From:   Amit Nischal <anischal@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk-owner@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: Add camera clock controller driver for
 SDM845
In-Reply-To: <153322925025.10763.7919558124009549240@swboyd.mtv.corp.google.com>
References: <1532942540-2814-1-git-send-email-anischal@codeaurora.org>
 <1532942540-2814-2-git-send-email-anischal@codeaurora.org>
 <153322925025.10763.7919558124009549240@swboyd.mtv.corp.google.com>
Message-ID: <bdc2e5b95a403f9b28b87c53d5478520@codeaurora.org>
X-Sender: anischal@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-02 22:30, Stephen Boyd wrote:
> Quoting Amit Nischal (2018-07-30 02:22:20)
>> diff --git a/drivers/clk/qcom/camcc-sdm845.c 
>> b/drivers/clk/qcom/camcc-sdm845.c
>> new file mode 100644
>> index 0000000..702ca66
>> --- /dev/null
>> +++ b/drivers/clk/qcom/camcc-sdm845.c
>> @@ -0,0 +1,1744 @@
>> +       },
>> +};
>> +
>> +static const struct freq_tbl ftbl_cam_cc_bps_clk_src[] = {
>> +       F(19200000, P_BI_TCXO, 1, 0, 0),
>> +       F(100000000, P_CAM_CC_PLL0_OUT_EVEN, 6, 0, 0),
>> +       F(200000000, P_CAM_CC_PLL0_OUT_EVEN, 3, 0, 0),
>> +       F(404000000, P_CAM_CC_PLL1_OUT_EVEN, 2, 0, 0),
>> +       F(480000000, P_CAM_CC_PLL2_OUT_EVEN, 1, 0, 0),
>> +       F(600000000, P_CAM_CC_PLL0_OUT_EVEN, 1, 0, 0),
>> +       { }
>> +};
>> +
>> +/*
>> + * As per HW design, some of the CAMCC RCGs needs to
>> + * move to XO clock during their clock disable so using
> 
> Per hw design sure, but what about hw design is causing this?

The RCGs which sources to the CBCRs further connected to the
camera memory blocks needs to be moved to XO clock during
clock disable. This is required to power down the camera memories
gracefully as these memories cannot be powered down instantly.
And after memory power down, HW will gate the clock.

> 
>> + * clk_rcg2_shared_ops for such RCGs.
>> + * Also, use CLK_SET_RATE_PARENT flag for the RCGs which
>> + * have non-fixed PLL as parent source and requires
> 
> Mention the PLL that isn't fixed?
> 

Yes sure. I will mention the PLL's name in the next patch.

>> + * reconfiguration of the PLL frequency.
>> + */
>> +static struct clk_rcg2 cam_cc_bps_clk_src = {
>> +       .cmd_rcgr = 0x600c,
>> +       .mnd_width = 0,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
