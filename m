Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF29C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACE92086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5N3ztBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfALQZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 11:25:43 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33685 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfALQZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 11:25:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id p6so15552652eds.0;
        Sat, 12 Jan 2019 08:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Au0jyucbhdEG1CChh3IaHibyz7G2BHj5hkdF1tHORso=;
        b=g5N3ztBxTEk0Y87c8mEtDnt4ZaRaxNk4DKr/boOgaDSZxLLJccKFjEDselM5RGDBJ1
         9tX93PFj2a8ZNYvuL980juNBcO3BgsQVScxDXXkVMRdskoWfPwB4+o5vyV4SbuzmzWRl
         y9OMkDmImBxe0SsvcgEjEtYH57CVRNe0LkhzTGgSi5DRdYP236Id2SpubDJVg5em42rU
         k52ydkklXu1ATCH8XzeGcdImUw7lrNUFgWCsE0xZx2HXLQuWQXgB0JWI3hpZEaDHTURG
         JkvG4vQUB5AsK3rSbOxCLlys54hRUrmPdcvUiSwox+4lWmeQ6tKToQV7rsaaWWr/6wWQ
         p3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Au0jyucbhdEG1CChh3IaHibyz7G2BHj5hkdF1tHORso=;
        b=VX+nZtXBaRzMCrRyc/KrR7MwDCdJ/HEhqzqZzFXMoy3lJ8tBxLMTy4nF/eD4cqRqN/
         xaTjYOHVRHOvUGygY7VYIcdQSV+mCsPUTwTxKZ/DySC5BC1a+hwx0a4/wncFjQZNOfu4
         vHF5fdOeIR8vRA3g5CJmGtR3WjMt8damJyPehfL1tVlMLnCo8V0+slLBtzu7tOtrpiVU
         BlN0p1prNNeEQ8tGy5JFOkuPE65cWjVkC1wy63qgwKDtvqmrxf5mFwWDU7Q02NnmIpq9
         ldvL5d1o1ZysnGT4CKC5qmdyYgcz0Rk3ZVHlAaLdS0DlANZSpe8bPaP5j5b4/d759DRY
         ka+w==
X-Gm-Message-State: AJcUukfpOIiZ87crsZN3IfaYawmhXqojOd6/Sx5CCLX8cjt2TjeQQJ2P
        WjSXqBeqXZ2Ux3WWKfGeq8/Mf4moA/g=
X-Google-Smtp-Source: ALg8bN6bao88rZTXyMU7CgUxNwwSxARgDwULdviyBJCgdSQkF09+VmmP+qaFslU4Iwr32993WcQCLw==
X-Received: by 2002:a17:906:a44:: with SMTP id x4-v6mr15135846ejf.177.1547310339211;
        Sat, 12 Jan 2019 08:25:39 -0800 (PST)
Received: from [192.168.42.186] ([145.130.182.109])
        by smtp.gmail.com with ESMTPSA id k13-v6sm1750712ejk.50.2019.01.12.08.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 08:25:38 -0800 (PST)
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add more msm8996 uarts
To:     jakob.wuhrer@gmail.com, andy.gross@linaro.org,
        david.brown@linaro.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1544806891-12516-1-git-send-email-jakob.wuhrer@gmail.com>
 <1544806891-12516-2-git-send-email-jakob.wuhrer@gmail.com>
From:   Jakob Wuhrer <jakob.wuhrer@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jakob.wuhrer@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFn5eDcBEACmEBJNf2EXzd6LEv25zgAQZ3nX5vkSGIH0QJZjWrlnB8HnBpq2DApRnz2n
 OOb4DLElo0LXVGFyihYSBc2idB3Lhe2K+Y1OxFmcmsOl/iTVlxd2JK6SqqWk3MP3vzgimXZu
 xBEbd/gddcKcVfZfnWj/S5di5OHOG5uG+ghF01S9G6g1PXC0+LRCCp0iPy61+KJIpBbRhfLl
 JyJnZ3ApBL8SaB+Rg2cKqDlUT5+AoFEx7UuUOlhB3wp3qAgEbtrWq1dKKD0svAj/FLRp2872
 WeeIaBi7s8BRcEMPHmrHSJFyoevguZQk+Vxa0sDJJMQEGY/uPHy6n+VbqBqzvsYrhbLyRy3h
 vneblyIKauz/8YCk0cEXKZv/4lobL5A/OS7QZq2UU3TJ/+rLGPU3d4jggyWzlGYawkxkfWU7
 jPpwjvUAprgCn/udnCowxMmUyTllWIa1pyQITha0gTK9un0u72ymFyVdEtARZpwKMbd/gOAp
 RkFowBeGuHZ8eboGwmfZL7mlILG1w5Ix/PfmT+ZgBV896vH8HUAHidBXrWqgc6kqRj+koV8R
 55wJez8mvwJO3IB3CNEBD/9dKUHVWJFIsyc1KI/qdsQb3yneOqnhvme7S94wXI6i43w9mFRV
 r6kgiP2aVbrBxG+GZUiUP64XHXxLEHRjzaCpLjbrGIol1bTrBQARAQABtB5waW5vYWZmZSA8
 cGlub2FmZmVAYWlybWFpbC5jYz6JAlQEEwEIAD4WIQQ37zxA1odt1ahcc9VCnZQVriArRAUC
 Wfl4NwIbIwUJCWYBgAULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRBCnZQVriArRFJJD/9f
 LdLa18zXS00ERrLXLBwJNif0LADaxT0ha+y2Oc+lgawnQWlTmVg4VL+lLw8bmzrmc1t5Y7o1
 hyr5VKElrh8qeWVDspD1kHoZQZWL9csrwokUz1fHz8wVQxjj4OKjzzWmofBLleQjnUQlVVcx
 72kzeeGJnTI13oIBdkGLmFCZJz7DEBqqSb5NKRqtLby8wJV2Xi60eU5U/3Ef+L2Rs9a15/gV
 KmMZaLx9m00srixpXhmCBuvdfU/Is4mvgsF/CSUAvXdGKHL8xE70CZP/d33+wmB1a+NAoZE0
 JyUIjVCrTw1v90HOu7QilD0/xfDupmwJNPHpOhs/eyYKxqhb3Mo2kbgzaC3qbeKdaayU1W1j
 Dll1DvwQjbGcVJEeXaVr3Wyo4q06enn7kcCrWeHnc6HHTMLOYVZNCFdcGNGRRMAl49V+yzMm
 2NFbuaxWN2RENaa+6YrwqgJgupKvYpgwOIIBAyUlmquRw03ESwWlrg2Zk65mLUpUhsKSJCNr
 XV2oSuf5EyRMZUx4AingveOVga5mPhDj/NLXXlnic2lIdxzfGog5jpyqaK/hqtraGISvMbgG
 kAXQIkw8xpnYCgiMQoFsgM/GyftG1f/R8rti2a1nD5PeOOL5e4zKND9jPsccvr3ntFIREtK2
 V+ncc3Pvc2fGnh2x8CYqFLVAI+5hX82rW7kCDQRZ+Xg3ARAAwq+OmmOTbcf/wsw6i7t7v1+I
 V8+yHuBslf+h9EjW6GnlKT6guvkP26bED4db88d6aoSFjy6/yBebu9dQ7ySwSBQJBLkyc9ms
 aFMt9KTaiu0gbtoWCgLI1VkEaAO5fE8KlYHmyXre7pmI0rkKSj86sBRhWh2TPzn9yRX4wUQ7
 UMh9QTR0TNN5KADT/EEj1f2g71UIVVNle7IFNu84KhTREK5nu8uwk07naQObm25oGZvuhzq2
 ReJJQFAwo/ZUvdFVoMLKXIDCGBHU5zFFTZJE1Go+LjGkqWKeQnla2rS7WLQubBiCYE8H1h49
 lVwQnRYVCEIUDKmGlmWlGNYkoeZHo7rS3pjdA3HZGxt+LXlOA90/1/XWg8e6w2NE68NuP7Dk
 A36P2ze3sWHpgbDxs+4slHTdT2ceCWXAqheIyQSp5MmqLVkVSV9tC8yAERkeWMUtMBhEcaPs
 nsam/azN6lhxLlcGe6EVYQgV6pTauBa9xiIhdHCGt+/7SzDG+Z0o6QbtMDAep7GePVc8CWzM
 jLetkSi2Q3PHH4qNUOv/1LUTX+bMd9Bpxt+zCVxlJORThFoY75mBkEeBvksB/9yUQOtwSKfH
 E4FWyRZzadU8NBiQHtkNQDby8Gu8+0U3FEC/sor6tWOtJrWxDQD7nyEAp6woVzP/o3LcJosZ
 dyzlypEr298AEQEAAYkCPAQYAQgAJhYhBDfvPEDWh23VqFxz1UKdlBWuICtEBQJZ+Xg3AhsM
 BQkJZgGAAAoJEEKdlBWuICtErTIP/0djPr6w4OJwW3X+pfibv/CoTXgo2u0TVu1fML+HQRp2
 YmIpEqPlNXO3KUT/O3T6pEnYzebKUmwia6T6gqxth/6ai/p+slbe5bX7XMrEIwTlRPR2LwKu
 P7qX9UIRmA8BOUUvxgLdsy6e3oJnLAUBeYC4905c14N5yf0FY6QQTOgPCIqs0N3MX3FSZJGf
 ZPSV2MDFOtIcs6qd0ZnHw6opkx7wVmc9Yn4/46KJKRw2EcNi1FPOGscTqTf4V8ZRvcrFttnc
 IUrhbke7v1ZmRNDDDIwPHaqtixuL13KWx8Au1WqMyEJezPKYQ8o+xuYTSzcR45CtGtr9XEft
 ip/H3qiOONhHbv3QW/wYhD/bZiD5ySWpRUOeWjBPfXuLoYgUUkaKqSrHDbtFtoGGrQJ0HmRO
 dszPFxaRB1rjL8MGg7x+dHiiWa+hD67ZfCbnwo4Qh4a1b62/jrNdp5amGMi4sz73TN8zKfli
 +7rcZ80U955RouywZ/BqgCGRYpn8Ne9NmvRKeTRU7xDg7tKcoTxzC36b+20FN2mpD47z3J2X
 K87A2dYcJZRuoA8dQDy/bvFticuHmtyWSSj9QGFKmkvlNBuICh2oE/wy8fm2uvR7q3EHg+lE
 sTCzSNW7NjOoeO2r/LSUpKv722iRFqYfhaClfssYiAvNKG1gEGpsVz5osObACBm7
Message-ID: <f4ae9404-3da4-ad72-7be1-68af854173e7@gmail.com>
Date:   Sat, 12 Jan 2019 17:22:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1544806891-12516-2-git-send-email-jakob.wuhrer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Did I submit these to the right lists?
If so, could someone please take a look at these patches?

On another note: I think the mailing lists might be a bit overzealous
with respect to what it blocks, I was unable to submit patches using an
@airmail.cc email account.

thanks in advance,
Jakob Wuhrer

On 12/14/18 6:01 PM, jakob.wuhrer@gmail.com wrote:
> From: Jakob Wuhrer <jakobwuhrer@airmail.cc>
> 
> msm8996 has 12 uarts, but the devicetree only lists 3. Add the
> pinmuxing and the main devicetree entries for the others.
> 
> Signed-off-by: Jakob Wuhrer <jakobwuhrer@airmail.cc>
> ---
>  arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 524 +++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/msm8996.dtsi      |  80 +++++
>  2 files changed, 604 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
> index 1d1f7f9..99056b6 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
> @@ -495,4 +495,528 @@
>  			bias-disable;
>  		};
>  	};
> +
> +	blsp1_uart0_2pins_default: blsp1_uart0_2pins {
> +		pinmux {
> +			function = "blsp_uart1";
> +			pins = "gpio0", "gpio1";
> +		};
> +		pinconf {
> +			pins = "gpio0", "gpio1";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart0_2pins_sleep: blsp1_uart0_2pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio0", "gpio1";
> +		};
> +		pinconf {
> +			pins = "gpio0", "gpio1";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart0_4pins_default: blsp1_uart0_4pins {
> +		pinmux {
> +			function = "blsp_uart1";
> +			pins = "gpio0", "gpio1", "gpio2", "gpio3";
> +		};
> +
> +		pinconf {
> +			pins = "gpio0", "gpio1", "gpio2", "gpio3";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart0_4pins_sleep: blsp1_uart0_4pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio0", "gpio1", "gpio2", "gpio3";
> +		};
> +
> +		pinconf {
> +			pins = "gpio0", "gpio1", "gpio2", "gpio3";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart1_2pins_default: blsp1_uart1_2pins {
> +		pinmux {
> +			function = "blsp_uart2";
> +			pins = "gpio41", "gpio42";
> +		};
> +		pinconf {
> +			pins = "gpio41", "gpio42";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart1_2pins_sleep: blsp1_uart1_2pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio41", "gpio42";
> +		};
> +		pinconf {
> +			pins = "gpio41", "gpio42";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart1_4pins_default: blsp1_uart1_4pins {
> +		pinmux {
> +			function = "blsp_uart2";
> +			pins = "gpio41", "gpio42", "gpio43", "gpio44";
> +		};
> +
> +		pinconf {
> +			pins = "gpio41", "gpio42", "gpio43", "gpio44";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart1_4pins_sleep: blsp1_uart1_4pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio41", "gpio42", "gpio43", "gpio44";
> +		};
> +
> +		pinconf {
> +			pins = "gpio41", "gpio42", "gpio43", "gpio44";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart2_2pins_default: blsp1_uart2_2pins {
> +		pinmux {
> +			function = "blsp_uart3";
> +			pins = "gpio45", "gpio46";
> +		};
> +		pinconf {
> +			pins = "gpio45", "gpio46";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart2_2pins_sleep: blsp1_uart2_2pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio45", "gpio46";
> +		};
> +		pinconf {
> +			pins = "gpio45", "gpio46";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart2_4pins_default: blsp1_uart2_4pins {
> +		pinmux {
> +			function = "blsp_uart3";
> +			pins = "gpio45", "gpio46", "gpio47", "gpio48";
> +		};
> +
> +		pinconf {
> +			pins = "gpio45", "gpio46", "gpio47", "gpio48";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart2_4pins_sleep: blsp1_uart2_4pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio45", "gpio46", "gpio47", "gpio48";
> +		};
> +
> +		pinconf {
> +			pins = "gpio45", "gpio46", "gpio47", "gpio48";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart3_2pins_default: blsp1_uart3_2pins {
> +		pinmux {
> +			function = "blsp_uart4";
> +			pins = "gpio65", "gpio66";
> +		};
> +		pinconf {
> +			pins = "gpio65", "gpio66";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart3_2pins_sleep: blsp1_uart3_2pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio65", "gpio66";
> +		};
> +		pinconf {
> +			pins = "gpio65", "gpio66";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart3_4pins_default: blsp1_uart3_4pins {
> +		pinmux {
> +			function = "blsp_uart4";
> +			pins = "gpio65", "gpio66", "gpio67", "gpio68";
> +		};
> +
> +		pinconf {
> +			pins = "gpio65", "gpio66", "gpio67", "gpio68";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart3_4pins_sleep: blsp1_uart3_4pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio65", "gpio66", "gpio67", "gpio68";
> +		};
> +
> +		pinconf {
> +			pins = "gpio65", "gpio66", "gpio67", "gpio68";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart4_2pins_default: blsp1_uart4_2pins {
> +		pinmux {
> +			function = "blsp_uart5";
> +			pins = "gpio81", "gpio82";
> +		};
> +		pinconf {
> +			pins = "gpio81", "gpio82";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart4_2pins_sleep: blsp1_uart4_2pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio81", "gpio82";
> +		};
> +		pinconf {
> +			pins = "gpio81", "gpio82";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart4_4pins_default: blsp1_uart4_4pins {
> +		pinmux {
> +			function = "blsp_uart5";
> +			pins = "gpio81", "gpio82", "gpio83", "gpio84";
> +		};
> +
> +		pinconf {
> +			pins = "gpio81", "gpio82", "gpio83", "gpio84";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart4_4pins_sleep: blsp1_uart4_4pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio81", "gpio82", "gpio83", "gpio84";
> +		};
> +
> +		pinconf {
> +			pins = "gpio81", "gpio82", "gpio83", "gpio84";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart5_2pins_default: blsp1_uart5_2pins {
> +		pinmux {
> +			function = "blsp_uart6";
> +			pins = "gpio25", "gpio26";
> +		};
> +		pinconf {
> +			pins = "gpio25", "gpio26";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart5_2pins_sleep: blsp1_uart5_2pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio25", "gpio26";
> +		};
> +		pinconf {
> +			pins = "gpio25", "gpio26";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart5_4pins_default: blsp1_uart5_4pins {
> +		pinmux {
> +			function = "blsp_uart6";
> +			pins = "gpio25", "gpio26", "gpio27", "gpio28";
> +		};
> +
> +		pinconf {
> +			pins = "gpio25", "gpio26", "gpio27", "gpio28";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp1_uart5_4pins_sleep: blsp1_uart5_4pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio25", "gpio26", "gpio27", "gpio28";
> +		};
> +
> +		pinconf {
> +			pins = "gpio25", "gpio26", "gpio27", "gpio28";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart0_2pins_default: blsp2_uart0_2pins {
> +		pinmux {
> +			function = "blsp_uart7";
> +			pins = "gpio53", "gpio54";
> +		};
> +		pinconf {
> +			pins = "gpio53", "gpio54";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart0_2pins_sleep: blsp2_uart0_2pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio53", "gpio54";
> +		};
> +		pinconf {
> +			pins = "gpio53", "gpio54";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart0_4pins_default: blsp2_uart0_4pins {
> +		pinmux {
> +			function = "blsp_uart7";
> +			pins = "gpio53", "gpio54", "gpio55", "gpio56";
> +		};
> +
> +		pinconf {
> +			pins = "gpio53", "gpio54", "gpio55", "gpio56";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart0_4pins_sleep: blsp2_uart0_4pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio53", "gpio54", "gpio55", "gpio56";
> +		};
> +
> +		pinconf {
> +			pins = "gpio53", "gpio54", "gpio55", "gpio56";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart3_2pins_default: blsp2_uart3_2pins {
> +		pinmux {
> +			function = "blsp_uart10";
> +			pins = "gpio8", "gpio9";
> +		};
> +		pinconf {
> +			pins = "gpio8", "gpio9";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart3_2pins_sleep: blsp2_uart3_2pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio8", "gpio9";
> +		};
> +		pinconf {
> +			pins = "gpio8", "gpio9";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart3_4pins_default: blsp2_uart3_4pins {
> +		pinmux {
> +			function = "blsp_uart10";
> +			pins = "gpio8", "gpio9", "gpio10", "gpio11";
> +		};
> +
> +		pinconf {
> +			pins = "gpio8", "gpio9", "gpio10", "gpio11";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart3_4pins_sleep: blsp2_uart3_4pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio8", "gpio9", "gpio10", "gpio11";
> +		};
> +
> +		pinconf {
> +			pins = "gpio8", "gpio9", "gpio10", "gpio11";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart4_2pins_alt_default: blsp2_uart4_2pins_alt {
> +		pinmux {
> +			function = "blsp_uart11";
> +			pins = "gpio100", "gpio101";
> +		};
> +		pinconf {
> +			pins = "gpio100", "gpio101";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart4_2pins_alt_sleep: blsp2_uart4_2pins_alt_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio100", "gpio101";
> +		};
> +		pinconf {
> +			pins = "gpio100", "gpio101";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart4_2pins_default: blsp2_uart4_2pins {
> +		pinmux {
> +			function = "blsp_uart11";
> +			pins = "gpio58", "gpio59";
> +		};
> +		pinconf {
> +			pins = "gpio58", "gpio59";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart4_2pins_sleep: blsp2_uart4_2pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio58", "gpio59";
> +		};
> +		pinconf {
> +			pins = "gpio58", "gpio59";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart4_4pins_default: blsp2_uart4_4pins {
> +		pinmux {
> +			function = "blsp_uart11";
> +			pins = "gpio58", "gpio59", "gpio60", "gpio61";
> +		};
> +
> +		pinconf {
> +			pins = "gpio58", "gpio59", "gpio60", "gpio61";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart4_4pins_sleep: blsp2_uart4_4pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio58", "gpio59", "gpio60", "gpio61";
> +		};
> +
> +		pinconf {
> +			pins = "gpio58", "gpio59", "gpio60", "gpio61";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart5_2pins_default: blsp2_uart5_2pins {
> +		pinmux {
> +			function = "blsp_uart12";
> +			pins = "gpio85", "gpio86";
> +		};
> +		pinconf {
> +			pins = "gpio85", "gpio86";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart5_2pins_sleep: blsp2_uart5_2pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio85", "gpio86";
> +		};
> +		pinconf {
> +			pins = "gpio85", "gpio86";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart5_4pins_default: blsp2_uart5_4pins {
> +		pinmux {
> +			function = "blsp_uart12";
> +			pins = "gpio85", "gpio86", "gpio87", "gpio88";
> +		};
> +
> +		pinconf {
> +			pins = "gpio85", "gpio86", "gpio87", "gpio88";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +	};
> +
> +	blsp2_uart5_4pins_sleep: blsp2_uart5_4pins_sleep {
> +		pinmux {
> +			function = "gpio";
> +			pins = "gpio85", "gpio86", "gpio87", "gpio88";
> +		};
> +
> +		pinconf {
> +			pins = "gpio85", "gpio86", "gpio87", "gpio88";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 13bb964..c2a5062 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -435,6 +435,16 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		blsp1_uart0: serial@756f000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x0756f000 0x1000>;
> +			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
>  		blsp1_uart1: serial@7570000 {
>  			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>  			reg = <0x07570000 0x1000>;
> @@ -445,6 +455,76 @@
>  			status = "disabled";
>  		};
>  
> +		blsp1_uart2: serial@7571000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x07571000 0x1000>;
> +			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART3_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
> +		blsp1_uart3: serial@7572000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x07572000 0x1000>;
> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART4_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
> +		blsp1_uart4: serial@7573000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x07573000 0x1000>;
> +			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART5_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
> +		blsp1_uart5: serial@7574000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x07574000 0x1000>;
> +			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART6_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
> +		blsp2_uart3: serial@75b2000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x075b2000 0x1000>;
> +			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP2_UART4_APPS_CLK>,
> +				 <&gcc GCC_BLSP2_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
> +		blsp2_uart4: serial@75b3000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x075b3000 0x1000>;
> +			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP2_UART5_APPS_CLK>,
> +				 <&gcc GCC_BLSP2_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
> +		blsp2_uart5: serial@75b4000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x075b4000 0x1000>;
> +			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP2_UART6_APPS_CLK>,
> +				 <&gcc GCC_BLSP2_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
>  		blsp1_spi0: spi@7575000 {
>  			compatible = "qcom,spi-qup-v2.2.1";
>  			reg = <0x07575000 0x600>;
> 
