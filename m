Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAA4C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2A3218EA
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK9T9tfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfAEAju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:39:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46125 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAEAjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 19:39:49 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so33787610ljh.13;
        Fri, 04 Jan 2019 16:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iYEfAsvFxmrMhRF7OKfKPW2v7gF64a0pQdbeabOPPlc=;
        b=PK9T9tfr8NxtBH+iurCRLyMyZm7PAKzeeUaqEQEi8niQK5Cj8Cj19EohYKIvTaF0km
         YWry/vXyIASmPIGZpB2l+8JMru3TTLMQjqqpxiiGdRv3lcOCxBTtRkZh7AizDbpx8KFC
         an0Gn65u7LoMkTv2XX1foxhaFUq63UNIeTrXQgWBlyn8e9TK2sqaPptjESgeft/eJbUV
         zyMnD/E2dozFhtRZb57wM/K5dQefwyYacvvgc2zP7WSr84HNzEFw+mZbKhP4jsaxLyd4
         elxLH3HNyENXR7u/9RD555wn9GcQpV3y6BxSJJjZoxLzypj5UMrr/048DmPpAhg+EuI6
         KECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iYEfAsvFxmrMhRF7OKfKPW2v7gF64a0pQdbeabOPPlc=;
        b=Jye34W2nN0bOTDlvc1FaXU2X8GiOJLBqO/YM1g5J/s8suFcrvtJYwJ/H1qBz6cQ4N0
         HPe1QnERipPGSnUrSFrTQiPuTNqFVCAVfl6F9cjKlN3hs4Lkj/cMOaCMgNatCFikoeOx
         rHJrsTF9vjqS7pdhA+JRkeYbotbG175a6kmuy3hiI+K5EIjPw+HixkgS0jkN507NsWMM
         PwX5uE28BvLCSwzVil7wv3vrX0VExkjIlMQEP6P5JFg4eplSSljcAb6i5Ky1c1/4rbdK
         SZKrOuV1W8q9bTTcuhOsTi/o9wO+qDvFj/qgXWf6YQgNrkXSDcpMY3MEzKn1pi0pjWMy
         zh+A==
X-Gm-Message-State: AA+aEWajdXhzAm/lphstggOGM7yMVaF8ypaWaLDilxd3YJcoINAUvDbV
        M9seX1Ukx0tH8KcZbZogAeJkihreTqc=
X-Google-Smtp-Source: ALg8bN7IJCaGyg+OKOQacFKo29yXytgu1eN+sP8d3ZFb75uAc7BYkC4sG8NdpDHHsfxSgTkemwE/Ow==
X-Received: by 2002:a2e:9a84:: with SMTP id p4-v6mr28916466lji.73.1546648785386;
        Fri, 04 Jan 2019 16:39:45 -0800 (PST)
Received: from ?IPv6:2001:14ba:8017:3300:4da2:4604:cb6f:7dbe? (dtynxhycqzldylw7ss2-y-3.rev.dnainternet.fi. [2001:14ba:8017:3300:4da2:4604:cb6f:7dbe])
        by smtp.googlemail.com with ESMTPSA id 65sm11590526lfp.55.2019.01.04.16.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 16:39:44 -0800 (PST)
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com>
 <20181219201047.GA23448@amd> <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <a72c11c0-949b-bdbc-df2c-4490e04a1065@gmail.com>
 <986b5105-2fdb-bd25-7c8a-ca8fd1ade821@gmail.com>
 <7f205102-e854-f1cb-cc03-1307d1cddc87@gmail.com>
 <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
 <cf6c0025-36e7-197b-b27a-1f31fb45cc38@gmail.com> <20190104201256.GA2931@amd>
 <a4e3a782-de76-ba91-3727-4db69cf27c3a@gmail.com>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
Message-ID: <90a2ed79-b437-af14-4538-430d8723cc6b@gmail.com>
Date:   Sat, 5 Jan 2019 02:39:43 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <a4e3a782-de76-ba91-3727-4db69cf27c3a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 04/01/2019 23.37, Jacek Anaszewski wrote:
> But, aside from that hypothetic issue, we need a solution for
> LEDn_BRIGHTNESS feature of lp5024, i.e. setting color intensity
> via a single register write. How would you propose to address that?

You could model it to something like this in device tree:

led-module @ <i2c-address> {
	compatible = "lp5024";

	// There is in hardware setup to use either linear or
	// logarithmic scaling:
	//enable-logarithmic-brightness;

	led0 {
		// this will create led instance for LED0 in lp5024
		label = "lp-led0";
		
		// This specifies LED number within lp5024
		led-index = <0>;   // set output-base as 0*3 == 0
		
		element-red {
			// refers to OUT0
			output-offset = <0>;
		};
		
		element-green {
			// refers to OUT1
			output-offset = <1>;
		};
		
		element-blue {
			// refers to OUT2
			output-offset = <2>;
		};
		
	};	

	led1 {
		// this will create led instance for LED1 in lp5024
		label = "lp-led1";
		
		// This specifies LED number within lp5024
		led-index = <1>;   // set output-base as 1*3 == 3

		element-red {
			// refers to OUT3
			output-offset = <0>;
		};
		
		element-green {
			// refers to OUT4
			output-offset = <1>;
		};
		
		element-blue {
			// refers to OUT5
			output-offset = <2>;
		};
		
	};

	bank-led {
		// this will create led instance for bank leds in lp5024
		label = "lp-bank-led";

		// configured bank led configuration
		led-index = <2 3 4 5 6 7>;
		// As here is list of led-indices this entry is
		// assumed to be bank configuration. Bank mode is enable
		// for the indices.

		// set output-base as BANK A

		element-red {
			// refers to BANK A
			output-offset = <0>;
		};
		
		element-green {
			// refers to BANK B
			output-offset = <1>;
		};
		
		element-blue {
			// refers to BANK C
			output-offset = <2>;
		};
	};	
};

This would then create three led instances and each led instance has 
brightness setting and that goes straight to hardware.

If one would want to override hardware control for brightness then I 
suppose you would define in led node something like:

	brightness-model = "hsl"

This would then pick red, green and blue elements for hsl calculations 
and others color elements for linear. LED specific hardware brightness 
would then be either 0 or 0xFF depending if all of LED color elements 
are zero or not.

Would that kind of model work?

Thanks,
Vesa Jääskeläinen
