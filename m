Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933034AbeCPArz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 20:47:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:33444 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932588AbeCPAry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 20:47:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,313,1517904000";
   d="scan'208";a="211771404"
Subject: Re: [PATCH dts/arm/aspeed-g5 v1] ARM: dts: aspeed-g5: Add IPMI KCS
 node
To: joel@jms.id.au, andrew@aj.id.au
References: <1520399090-2455-1-git-send-email-haiyue.wang@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
From: "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Message-ID: <9231baaf-e77c-c517-bca2-083070a53342@linux.intel.com>
Date: Fri, 16 Mar 2018 08:47:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520399090-2455-1-git-send-email-haiyue.wang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel and Andrew,

Have time to review this patch ? Hope for your comments. :-)

BR,
Haiyue

On 2018-03-07 13:04, Haiyue Wang wrote:
> The IPMI KCS device part of the LPC interface and is used for
> communication with the host processor.
>
> Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> ---
>   arch/arm/boot/dts/aspeed-g5.dtsi | 43 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 8eac57c..f443169 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -267,8 +267,40 @@
>   				ranges = <0x0 0x1e789000 0x1000>;
>   
>   				lpc_bmc: lpc-bmc@0 {
> -					compatible = "aspeed,ast2500-lpc-bmc";
> +					compatible = "aspeed,ast2500-lpc-bmc", "simple-mfd", "syscon";
>   					reg = <0x0 0x80>;
> +					reg-io-width = <4>;
> +
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					ranges = <0x0 0x0 0x80>;
> +
> +					kcs1: kcs1@0 {
> +						compatible = "aspeed,ast2500-kcs-bmc";
> +						reg = <0x0 0x80>;
> +						interrupts = <8>;
> +						kcs_chan = <1>;
> +						kcs_addr = <0x0>;
> +						status = "disabled";
> +					};
> +
> +					kcs2: kcs2@0 {
> +						compatible = "aspeed,ast2500-kcs-bmc";
> +						reg = <0x0 0x80>;
> +						interrupts = <8>;
> +						kcs_chan = <2>;
> +						kcs_addr = <0x0>;
> +						status = "disabled";
> +					};
> +
> +					kcs3: kcs3@0 {
> +						compatible = "aspeed,ast2500-kcs-bmc";
> +						reg = <0x0 0x80>;
> +						interrupts = <8>;
> +						kcs_chan = <3>;
> +						kcs_addr = <0x0>;
> +						status = "disabled";
> +					};
>   				};
>   
>   				lpc_host: lpc-host@80 {
> @@ -294,6 +326,15 @@
>   						status = "disabled";
>   					};
>   
> +					kcs4: kcs4@0 {
> +						compatible = "aspeed,ast2500-kcs-bmc";
> +						reg = <0x0 0xa0>;
> +						interrupts = <8>;
> +						kcs_chan = <4>;
> +						kcs_addr = <0x0>;
> +						status = "disabled";
> +					};
> +
>   					lhc: lhc@20 {
>   						compatible = "aspeed,ast2500-lhc";
>   						reg = <0x20 0x24 0x48 0x8>;
