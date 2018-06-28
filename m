Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A36C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFD623D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R82SJ2H1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WMogn4rI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFD623D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932911AbeF1GUe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:20:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50094 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932094AbeF1GUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:20:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 014F660B10; Thu, 28 Jun 2018 06:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530166829;
        bh=TNNXpZ2YyCkrujHvTCYFk4wx4jc2ipKoPlz2UP9uqrM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=R82SJ2H1NVePVH7//HzW90O8+/LvkFV/DxsuMogmDxz5A0TED4ammqLiTocBffMKk
         MXBx8RH7QlOYTArM18GWt+nuDjKsCQ0KNRd06P2vETKeZPet7/fMOU/th+qGyXVNgm
         D87PtKaXBzVadVNbflpp+hgoqTllyNvtaSToEAsk=
Received: from [10.204.110.13] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87AFA60791;
        Thu, 28 Jun 2018 06:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530166827;
        bh=TNNXpZ2YyCkrujHvTCYFk4wx4jc2ipKoPlz2UP9uqrM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WMogn4rI1T1NiC48lWI/3wPkwk2aNf1tiFuXLtRDJx/WC+5hn68t28uycSHdxyWSN
         AdXzsxqXP+dgjw7fhtBdK5HMQQ9loEnV5RK4fsnUHyArSSiJS6kiq3DpZgAJcz8d4J
         RPFJOYRJEKSFES3VyVkn9LivfJWb9Xis9NCt7VaA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87AFA60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v2 1/2] ASoC: qcom: dt-bindings: Add sdm845
 machine bindings
To:     Rob Herring <robh@kernel.org>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org
References: <1529578399-3633-1-git-send-email-rohitkr@codeaurora.org>
 <1529578399-3633-2-git-send-email-rohitkr@codeaurora.org>
 <20180625191737.GA13246@rob-hp-laptop>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <5c976a29-b1ff-4fb5-9346-2288dfecd4c3@codeaurora.org>
Date:   Thu, 28 Jun 2018 11:50:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625191737.GA13246@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob for reviewing.


On 6/26/2018 12:47 AM, Rob Herring wrote:
> On Thu, Jun 21, 2018 at 04:23:18PM +0530, Rohit kumar wrote:
>> Add devicetree bindings documentation file for SDM845 sound card.
>>
>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>> ---
>>   .../devicetree/bindings/sound/qcom,sdm845.txt      | 82 ++++++++++++++++++++++
>>   1 file changed, 82 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
>> new file mode 100644
>> index 0000000..68feb08
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
>> @@ -0,0 +1,82 @@
>> +* Qualcomm Technologies Inc. SDM845 ASoC sound card driver
>> +
>> +This binding describes the SDM845 sound card, which uses qdsp for audio.
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,sdm845-sndcard"
>> +
>> +- qcom,audio-routing:
> Use just 'audio-routing'.

This is same which is being followed in apq8096 machine driver. As all 
qcom machine drivers will
mostly follow the same design, Vinod asked to pull out the APIs in 
common file - https://patchwork.kernel.org/patch/10479625/ .
Same is for qcom,model. I will add missing documentation for it in the 
next patchset.

>> +	Usage: Optional
>> +	Value type: <stringlist>
>> +	Definition:  A list of the connections between audio components.
>> +		  Each entry is a pair of strings, the first being the
>> +		  connection's sink, the second being the connection's
>> +		  source. Valid names could be power supplies, MicBias
>> +		  of codec and the jacks on the board.
>> +
>> +- cdc-vdd-supply:
>> +	Usage: Optional
>> +	Value type: <phandle>
>> +	Definition: phandle of regulator supply required for codec vdd.
> The codec supply should be in the codec node.

Sure. Will add this in codec driver.
>> +
>> += dailinks
>> +Each subnode of sndcard represents either a dailink, and subnodes of each
>> +dailinks would be cpu/codec/platform dais.
>> +
>> +- link-name:
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: User friendly name for dai link
>> +
>> += CPU, PLATFORM, CODEC dais subnodes
>> +- cpu:
>> +	Usage: required
>> +	Value type: <subnode>
>> +	Definition: cpu dai sub-node
>> +
>> +- codec:
>> +	Usage: required
>> +	Value type: <subnode>
>> +	Definition: codec dai sub-node
>> +
>> +- platform:
>> +	Usage: Optional
>> +	Value type: <subnode>
>> +	Definition: platform dai sub-node
>> +
>> +- sound-dai:
>> +	Usage: required
>> +	Value type: <phandle>
>> +	Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
>> +
>> +Example:
>> +
>> +audio {
>> +	compatible = "qcom,sdm845-sndcard";
>> +	qcom,model = "sdm845-snd-card";
> Not documented. Just use 'model'.
>
>> +	pinctrl-names = "default", "sleep";
>> +	pinctrl-0 = <&pri_mi2s_active &pri_mi2s_ws_active>;
>> +	pinctrl-1 = <&pri_mi2s_sleep &pri_mi2s_ws_sleep>;
>> +
>> +	cdc-vdd-supply = <&pm8998_l14>;
>> +
>> +	mm1-dai-link {
>> +		link-name = "MultiMedia1";
>> +		cpu {
>> +			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
>> +		};
>> +	};
>> +
>> +	pri-mi2s-dai-link {
>> +		link-name = "PRI MI2S Playback";
>> +		cpu {
>> +			sound-dai = <&q6afedai PRIMARY_MI2S_RX>;
>> +		};
>> +
>> +		platform {
>> +			sound-dai = <&q6routing>;
>> +		};
>> +	};
>> +};
>> -- 
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
>> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Regards,
Rohit

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

