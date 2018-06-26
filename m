Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73C0C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF19267BD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gM7sCLCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF19267BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934373AbeFZJ3J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:29:09 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44890 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934248AbeFZJ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:29:04 -0400
Received: by mail-lf0-f65.google.com with SMTP id j26-v6so8938399lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9mSYkRNtS30d7fWlQasRila7W09Eqwxhi6iiSGF0VOU=;
        b=gM7sCLCCsr3wqdxmmvRFUkpvdrGkwjixJqxriCz60uNrae6CbcFCaEyUCghCszkovq
         mUrq3CtpCORDan/Dc41LvONXykFiKu+n/zaPteH6Bps8ZtAqk93MnYS2ogx7mgn6qoBy
         ZHW26zw9RB0meTnNga6FXkJlScgY9ZFNX49ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9mSYkRNtS30d7fWlQasRila7W09Eqwxhi6iiSGF0VOU=;
        b=tpnDeRsQI6sNAvro1av0GKYigDewIUErZMny2KopMPTMWoKGLz6HDmwJZ3PHduHJ5i
         17Dlh1ImGFzgzRBW/JjozwNLA6H4kCXDLQR0IV3O9teb5k/t5czz5tOx+fSbctbjxwXL
         YGHOY1q9yLeoHhHfkqkSj+5EgIOCNMwVDc29QJu5z7oAVyp1GwMqmpfmTBpcKPBTtVEP
         8IiNElygEeiS09Ww1byg9aG5ENeQXKZtfttrVPRWZ8Rmac1etHh6Ux3JySJTa13j3BnS
         vil9t7VVPBLjRPcrkDqamaLUdznYJquzBZ5axYPZUdCOn+XgcNYePhiHGdoNWYJDFkc2
         etsg==
X-Gm-Message-State: APt69E3GVeS6tE3OqGLLTTvzEwZ4a4HK3TQ+lk7SBhDYjtuIV44d97Nv
        s2HNoyw/JCzc3V4au+swbOo+Og==
X-Google-Smtp-Source: AAOMgpehBXvx3jhtX2RZFvFkk9pAx5Wyd7Tw/wfjJ0eHHqvMlMXv4frR8fMEd7zOPiISQ9i7sRWtlQ==
X-Received: by 2002:a19:910a:: with SMTP id t10-v6mr694256lfd.24.1530005342634;
        Tue, 26 Jun 2018 02:29:02 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id z5-v6sm235094lff.96.2018.06.26.02.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 02:29:02 -0700 (PDT)
Date:   Tue, 26 Jun 2018 11:28:59 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 03/12] ASoC: q6afe: dt-bindings: add compatible string
 to dais
Message-ID: <20180626092859.GA25217@centauri.ideon.se>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626092016.9296-4-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Tue, Jun 26, 2018 at 10:20:07AM +0100, Srinivas Kandagatla wrote:
> Add compatible string to dais so that it can support DT based module
> autoloading.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,q6afe.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
> index bdbf87df8c0b..a8179409c194 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
> @@ -17,6 +17,11 @@ used by all apr services. Must contain the following properties.
>  subnode of "dais" representing board specific dai setup.
>  "dais" node should have following properties followed by dai children.
>  
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,q6afe-dais"
> +
>  - #sound-dai-cells
>  	Usage: required
>  	Value type: <u32>
> @@ -100,6 +105,7 @@ q6afe@4 {
>  	reg = <APR_SVC_AFE>;
>  
>  	dais {
> +		compatible = "qcom,q6afe-dais";
>  		#sound-dai-cells = <1>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -- 
> 2.16.2
> 
