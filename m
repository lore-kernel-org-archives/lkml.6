Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AFFC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271622089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VkDrSrdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfAHEuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 23:50:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41049 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfAHEuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 23:50:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so1248433plm.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 20:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FHxSAaJ5DjyEZ0a3M4dzKHpqkXYHb2pzUKUnN8FZIpY=;
        b=VkDrSrdSgMSN2lCM3DKfuCf7aTB+8UWnDZLdpq27eTrRpwllmWemA5AAoBnzk4a4B4
         fkCjh3UynfgP2vM7cj388ZPcHQjOMb6ToH+7IYvV4emghARQxm15qo6tkk//gOCOz6A2
         kZc6qyU5/E41WnyuQvs0XLHvCd+6kV2+TuN9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FHxSAaJ5DjyEZ0a3M4dzKHpqkXYHb2pzUKUnN8FZIpY=;
        b=nPkIGB2/QCYmPlFz8B71SSpnDHtLGWyFsdRP3z9FzMki8CVA6htrsiRRNJWP8jamd0
         nZ3BPO2gkWqm+IJ1v4UZwWQTGXB0VMSiwJTM8AAMJw4m/2JvaJQCi6h8jvH6/IsVk9FY
         aBoVYYmCyjbV7Wov+7FBGCHxW0WHtD6cSTZPc4LWffD7908py43jnySTb9/sVbMG/bX6
         kO5Erpcg9LhovVsupDJrX26l/E07Y8QN3Hv1HVgjxdnrsvBlvY4XucreIuBrhc6yZ1hB
         GIq7NG9iOf+pfWQByuk3SZXMqWvq9iwpNi/8fde6sgsqlKIE30NYdSseNBAM3GB40H/c
         NkTw==
X-Gm-Message-State: AJcUukcCjX4QA1BFOuraM9NXJOLzQ6jqCWZNqGDHJ9kZIQZN/zBOgV5t
        ltfSfcoJyZwId3Z31QM48zePYg==
X-Google-Smtp-Source: ALg8bN5S2TVLJXH2biN+Zd69B0ErAfDVm7YM3hk5NBVc/LaeN445QuKCcjXwYRsRQdOF8UjbAy8Y+Q==
X-Received: by 2002:a17:902:3124:: with SMTP id w33mr280859plb.241.1546923003766;
        Mon, 07 Jan 2019 20:50:03 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id t12sm106206398pfi.45.2019.01.07.20.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 20:50:02 -0800 (PST)
Date:   Tue, 8 Jan 2019 10:19:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     andy.gross@linaro.org, robh@kernel.org, sboyd@kernel.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com
Subject: Re: [PATCH v9 01/10] dt-bindings: opp: Introduce opp-level bindings
Message-ID: <20190108044958.katgnp4ozmpqien2@vireshk-i7>
References: <20190107100959.14528-1-rnayak@codeaurora.org>
 <20190107100959.14528-2-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107100959.14528-2-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-01-19, 15:39, Rajendra Nayak wrote:
> On some SoCs (especially from Qualcomm and MediaTek) an OPP
> node needs to describe an additional level/corner value
> that is then communicated to a remote microprocessor by the CPU, which
> then takes some actions (like adjusting voltage values across various rails)
> based on the value passed.
> 
> Describe these bindings in the opp-level bindings document.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  .../devicetree/bindings/opp/opp-level.txt     | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/opp-level.txt
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-level.txt b/Documentation/devicetree/bindings/opp/opp-level.txt
> new file mode 100644
> index 000000000000..f9134ed08164
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/opp-level.txt
> @@ -0,0 +1,29 @@
> +OPP level bindings to descibe OPP nodes with corner/level values
> +
> +OPP tables for devices on some SoCs, especially from Qualcomm and
> +MediaTek require an additional platform specific corner/level
> +value to be specified.
> +This value is passed on to a Power Manager by
> +the CPU, which then takes the necessary actions to set a voltage
> +rail to an appropriate voltage based on the value passed.
> +
> +The bindings are based on top of the operating-points-v2 bindings
> +described in Documentation/devicetree/bindings/opp/opp.txt,
> +with the exception that all of the properties are now optional,
> +including the opp-hz property.
> +
> +Additional properties are described below.
> +
> +* OPP Table Node
> +
> +Required properties:
> +- compatible: Allow OPPs to express their compatibility. It should be:
> +  "operating-points-v2-level"

All this isn't required. Just define it as a regular property in
opp.txt only, just like opp-hz or something else.

-- 
viresh
