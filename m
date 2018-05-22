Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeEVQmg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:42:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44453 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVQmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:42:33 -0400
X-Google-Smtp-Source: AB8JxZoxVFkusOcMG03RAIsx1I73ljrvHRzcm58EiBvZZfsoeeK0G6DBXKfcuuTJkVuv9czrpqen0g==
Date: Tue, 22 May 2018 11:42:30 -0500
From: Rob Herring <robh@kernel.org>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [v4 07/11] dt-bindings: hwmon: Add documents for PECI hwmon
 client drivers
Message-ID: <20180522164230.GA11707@rob-hp-laptop>
References: <20180521195905.27983-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521195905.27983-1-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 12:59:05PM -0700, Jae Hyun Yoo wrote:
> This commit adds dt-bindings documents for PECI hwmon client drivers.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> Reviewed-by: James Feist <james.feist@linux.intel.com>
> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> ---
>  .../bindings/hwmon/peci-cputemp.txt           | 23 ++++++++++++++++++
>  .../bindings/hwmon/peci-dimmtemp.txt          | 24 +++++++++++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt b/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
> new file mode 100644
> index 000000000000..2f59aee12d9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
> @@ -0,0 +1,23 @@
> +Bindings for Intel PECI (Platform Environment Control Interface) cputemp driver.
> +
> +Required properties:
> +- compatible : Should be "intel,peci-cputemp".
> +- reg        : Should contain address of a client CPU. Address range of CPU
> +	       clients is starting from 0x30 based on PECI specification.
> +
> +Example:
> +	peci-bus@0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		< more properties >
> +
> +		peci-cputemp@30 {
> +			compatible = "intel,peci-cputemp";
> +			reg = <0x30>;
> +		};

[...]

> +		peci-dimmtemp@30 {
> +			compatible = "intel,peci-dimmtemp";
> +			reg = <0x30>;
> +		};

As I said in the prior version, 2 nodes at the same address is wrong.

Rob
