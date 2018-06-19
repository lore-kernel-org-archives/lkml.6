Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0694C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8E12075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="sK3SuQ9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8E12075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757149AbeFSKfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:35:12 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:38128 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756608AbeFSKfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:35:10 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 539235C12E8;
        Tue, 19 Jun 2018 12:35:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529404508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zts6pVK/mVhaDA7nftcPI2dsHlYX4Q2O7tWebz5+IZs=;
        b=sK3SuQ9uLWZuTqCaHKundCLrFqejUl1rcr765HOlRpAs0iWDILTvGxB9oK4sXJ1JlSXhhw
        CcMTBZ0Q8cNIqxTYcorAo76iShcOfrCsFzKcIlksIR11d+p6F6jkxkiA6gal3HvF+CuhOV
        0Fxj+KvhcfcCNrFFK+VWmQJBaQTv1dc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Jun 2018 12:35:08 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>, mark.rutland@arm.com,
        robh@kernel.org, mathieu.poirier@linaro.org,
        devicetree@vger.kernel.org, coresight@lists.linaro.org,
        john.horley@arm.com, linux-kernel@vger.kernel.org, arm@kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        sudeep.holla@arm.com, Fabio Estevam <fabio.estevam@nxp.com>,
        matt.sealey@arm.com, mike.leach@linaro.org, frowand.list@gmail.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, charles.garcia-tobin@arm.com
Subject: Re: [PATCH 15/20] dts: arm: imx7{d,s}: Update coresight binding for
 hardware ports
In-Reply-To: <20180619021218.GV16091@dragon>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-16-git-send-email-suzuki.poulose@arm.com>
 <20180619021218.GV16091@dragon>
Message-ID: <145043d7ed3ef7890b5fc78a59c1668a@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[19];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.06.2018 04:12, Shawn Guo wrote:
> Hi Stefan,
> 
> Can you take a look at the patch?  Thanks.
> 
> Shawn
> 
> On Tue, Jun 05, 2018 at 10:43:26PM +0100, Suzuki K Poulose wrote:
>> Switch to the updated coresight bindings.

Looks good to me.

Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan

>>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>  arch/arm/boot/dts/imx7d.dtsi |  5 ++++-
>>  arch/arm/boot/dts/imx7s.dtsi | 41 ++++++++++++++++++++++++++++++-----------
>>  2 files changed, 34 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
>> index 200714e..5faff17 100644
>> --- a/arch/arm/boot/dts/imx7d.dtsi
>> +++ b/arch/arm/boot/dts/imx7d.dtsi
>> @@ -87,7 +87,9 @@
>>
>>  			port {
>>  				etm1_out_port: endpoint {
>> +					direction = <1>;
>>  					remote-endpoint = <&ca_funnel_in_port1>;
>> +					coresight,hwid = <0>;
>>  				};
>>  			};
>>  		};
>> @@ -174,8 +176,9 @@
>>  	port@1 {
>>  		reg = <1>;
>>  		ca_funnel_in_port1: endpoint {
>> -			slave-mode;
>> +			direction = <0>;
>>  			remote-endpoint = <&etm1_out_port>;
>> +			coresight,hwid = <1>;
>>  		};
>>  	};
>>  };
>> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
>> index 4d42335..8e90915 100644
>> --- a/arch/arm/boot/dts/imx7s.dtsi
>> +++ b/arch/arm/boot/dts/imx7s.dtsi
>> @@ -151,23 +151,28 @@
>>  			port@0 {
>>  				reg = <0>;
>>  				replicator_out_port0: endpoint {
>> +					direction = <1>;
>>  					remote-endpoint = <&tpiu_in_port>;
>> +					coresight,hwid = <0>;
>>  				};
>>  			};
>>
>>  			port@1 {
>>  				reg = <1>;
>>  				replicator_out_port1: endpoint {
>> +					direction = <1>;
>>  					remote-endpoint = <&etr_in_port>;
>> +					coresight,hwid = <1>;
>>  				};
>>  			};
>>
>>  			/* replicator input port */
>>  			port@2 {
>> -				reg = <0>;
>> +				reg = <2>;
>>  				replicator_in_port0: endpoint {
>> -					slave-mode;
>> +					direction = <0>;
>>  					remote-endpoint = <&etf_out_port>;
>> +					coresight,hwid = <0>;
>>  				};
>>  			};
>>  		};
>> @@ -203,16 +208,19 @@
>>  				port@0 {
>>  					reg = <0>;
>>  					ca_funnel_in_port0: endpoint {
>> -						slave-mode;
>> +						direction = <0>;
>>  						remote-endpoint = <&etm0_out_port>;
>> +						coresight,hwid = <0>;
>>  					};
>>  				};
>>
>>  				/* funnel output port */
>>  				port@2 {
>> -					reg = <0>;
>> +					reg = <2>;
>>  					ca_funnel_out_port0: endpoint {
>> +						direction = <1>;
>>  						remote-endpoint = <&hugo_funnel_in_port0>;
>> +						coresight,hwid = <0>;
>>  					};
>>  				};
>>
>> @@ -229,7 +237,9 @@
>>
>>  			port {
>>  				etm0_out_port: endpoint {
>> +					direction = <1>;
>>  					remote-endpoint = <&ca_funnel_in_port0>;
>> +					coresight,hwid = <0>;
>>  				};
>>  			};
>>  		};
>> @@ -248,22 +258,26 @@
>>  				port@0 {
>>  					reg = <0>;
>>  					hugo_funnel_in_port0: endpoint {
>> -						slave-mode;
>> +						direction = <0>;
>>  						remote-endpoint = <&ca_funnel_out_port0>;
>> +						coresight,hwid = <0>;
>>  					};
>>  				};
>>
>>  				port@1 {
>>  					reg = <1>;
>>  					hugo_funnel_in_port1: endpoint {
>> -						slave-mode; /* M4 input */
>> +						direction = <0>; /* M4 input */
>> +						coresight,hwid = <1>;
>>  					};
>>  				};
>>
>>  				port@2 {
>> -					reg = <0>;
>> +					reg = <2>;
>>  					hugo_funnel_out_port0: endpoint {
>> +						direction = <1>;
>>  						remote-endpoint = <&etf_in_port>;
>> +						coresight,hwid = <0>;
>>  					};
>>  				};
>>
>> @@ -284,15 +298,18 @@
>>  				port@0 {
>>  					reg = <0>;
>>  					etf_in_port: endpoint {
>> -						slave-mode;
>> +						direction = <0>;
>>  						remote-endpoint = <&hugo_funnel_out_port0>;
>> +						coresight,hwid = <0>;
>>  					};
>>  				};
>>
>>  				port@1 {
>> -					reg = <0>;
>> +					reg = <1>;
>>  					etf_out_port: endpoint {
>> +						direction = <1>;
>>  						remote-endpoint = <&replicator_in_port0>;
>> +						coresight,hwid = <0>;
>>  					};
>>  				};
>>  			};
>> @@ -306,8 +323,9 @@
>>
>>  			port {
>>  				etr_in_port: endpoint {
>> -					slave-mode;
>> +					direction = <0>;
>>  					remote-endpoint = <&replicator_out_port1>;
>> +					coresight,hwid = <0>;
>>  				};
>>  			};
>>  		};
>> @@ -320,8 +338,9 @@
>>
>>  			port {
>>  				tpiu_in_port: endpoint {
>> -					slave-mode;
>> +					direction = <0>;
>>  					remote-endpoint = <&replicator_out_port1>;
>> +					coresight,hwid = <0>;
>>  				};
>>  			};
>>  		};
>> --
>> 2.7.4
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
