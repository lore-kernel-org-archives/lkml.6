Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeFDKzh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:55:37 -0400
Received: from foss.arm.com ([217.140.101.70]:41750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752090AbeFDKzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:55:35 -0400
Date: Mon, 4 Jun 2018 11:55:31 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        robh@kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, skannan@codeaurora.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
Message-ID: <20180604105531.GB13977@e107155-lin>
References: <1528109194-16864-1-git-send-email-tdas@codeaurora.org>
 <1528109194-16864-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528109194-16864-2-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 04:16:33PM +0530, Taniya Das wrote:
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which are
> controlled by firmware.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-fw.txt           | 173 +++++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
> new file mode 100644
> index 0000000..e3087ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
> @@ -0,0 +1,173 @@
> +Qualcomm Technologies, Inc. CPUFREQ Bindings
> +
> +CPUFREQ FW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
> +SoCs to manage frequency in hardware. It is capable of controlling frequency
> +for multiple clusters.
> +
> +Properties:
> +- compatible
> +	Usage:		required
> +	Value type:	<string>
> +	Definition:	must be "qcom,cpufreq-fw".
> +
> +* Property qcom,freq-domain
> +Devices supporting freq-domain must set their "qcom,freq-domain" property with
> +phandle to a freq_domain_table in their DT node.
> +
> +* Frequency Domain Table Node
> +
> +This describes the frequency domain belonging to a device.
> +This node can have following properties:
> +
> +- reg
> +	Usage:		required
> +	Value type:	<prop-encoded-array>
> +	Definition:	Addresses and sizes for the memory of the perf
> +			, lut and enable bases.
> +			perf - indicates the base address for the desired
> +			performance state to be set.
> +			lut - indicates the look up table base address for the
> +			cpufreq	driver to read frequencies.
> +			enable - indicates the enable register for firmware.
> +- reg-names
> +	Usage:		required
> +	Value type:	<stringlist>
> +	Definition:	Address names. Must be "perf", "lut", "enable".
> +			Must be specified in the same order as the reg property.
> +

[...]

> +
> +	qcom,cpufreq-fw {
> +		compatible = "qcom,cpufreq-fw";
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		freq_domain_table0 : freq_table0 {
> +			reg = <0x17d43920 0x4>, <0x17d43110 0x500>,
> +				 <0x17d41000 0x4>;

Are "perf", "lut", "enable" registers part of single IP block / share memory ?
I am just trying to understand the reason for separate entries in this fashion
as part of DT register property. I am wondering if there will be multiple
entries that fall with the page size.

--
Regards,
Sudeep
