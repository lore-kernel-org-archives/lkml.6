Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97DFC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8C120875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8C120875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbeJEPdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:33:47 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:57233 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeJEPdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:33:47 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w958Y9WO001157;
        Fri, 5 Oct 2018 17:34:09 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Fri, 05 Oct 2018 17:34:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.2] (199.247.151.153.ap.dti.ne.jp [153.151.247.199])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w958Y8C8001147
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 5 Oct 2018 17:34:09 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v2] arm64: dts: rockchip: add spdif sound node for rock64
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20180917122633.31401-1-katsuhiro@katsuster.net>
 <CAGb2v64gTj7766o+6-BZkqKy=cDv9bqLcKHOzj-BiJOtjQMSyQ@mail.gmail.com>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <9b54c5e6-f705-c792-1f41-c33c3403baa9@katsuster.net>
Date:   Fri, 5 Oct 2018 17:34:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGb2v64gTj7766o+6-BZkqKy=cDv9bqLcKHOzj-BiJOtjQMSyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry for late, thank you for your comments.

On 2018年10月03日 18:53, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, Sep 17, 2018 at 8:28 PM Katsuhiro Suzuki
> <katsuhiro@katsuster.net> wrote:
>>
>> This patch adds sound card node for rock64. Currently we can support
>> S/PDIF only. It seems the lack of codec driver of rk3328 to enable
>> analog audio out.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 29 +++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> index 5852061e497b..9ee4f57557f3 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>> @@ -62,6 +62,23 @@
>>                  regulator-min-microvolt = <5000000>;
>>                  regulator-max-microvolt = <5000000>;
>>          };
>> +
>> +       sound {
>> +               compatible = "audio-graph-card";
>> +               label = "rockchip,rk3328";
> 
> I understand that this patch has been merged. However, seeing this label
> I wonder how this works when the analog codec and HDMI audio out are added,
> and how userspace is supposed to select an output.
> 

I don't know detail of HDMI audio of RK3328, but maybe it has cpu or 
codec DAIs. The audio-graph-card is supporting to use multiple DAIs on
a card. This is same as simple-audio-card.

For example, add I2S0 device as hw:X,0
(and move SPDIF to hw:X,0 -> hw:X,1)

sound {
	compatible = "audio-graph-card";
	label = "rockchip,rk3328";
	dais = <&i2s0_p0
		&spdif_p0>;
};

&i2s0 {
	status = "okay";
	#sound-dai-cells = <0>;

	i2s0_p0: port {
		i2s0_p0_0: endpoint {
			dai-format = "i2s";
			remote-endpoint = <&some_codec_abcd>;
		};
	};
};

We should write special card driver for RK3328 sound if audio-graph-card
is not enough to deal with HDMI audio.


> On the side, it seems that extra codecs, such as the rock64 add-on board,
> are easier dealt with by adding a separate simple-audio-card node to couple
> the codec and i2s nodes.

I think multiple DAIs on single card and single DAI on multiple cards
are both OK to work. But I cannot decide the way for this issue.


> 
> ChenYu
> 

Regards,
--
Katsuhiro Suzuki
