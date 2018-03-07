Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520452066; cv=none;
        d=google.com; s=arc-20160816;
        b=AVfTpVbhBARz1vVemSvOvyMM2Qcbu0c14BNyT7f5CeVLQTRP1UMM3wjoa4CL1hnSJE
         NwOZs4iFPP6dQ518EVk7Abs6ODid2122VMy5lpOx5qtYCrwD1FQGByU3OGGKNJhvTdD0
         ah4o+EQt3BCjdswWkuxueDPM//t7NCCjRzIQp0UeJUqrc4ScSSo+A7OHOGwF/PHNfbUK
         obKqoAvIFGqoe+cF19rWRcun5t7iKqUjmXCCzth+8B4tDkdGA0fF3snlhMmdmKCPgs9J
         Lvrk5l5JcwHjqKjHyGi+B1U494JH/4FdJ1Ei7tgyW6TKx1mtQ+evxRxG/Qb5VLvB8R+g
         uaPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=LmR3giV1nImsf0wC1tyHaSKoZYAl1Kq+dSX5a4ISYHQ=;
        b=qLHzz81Yl2AWlrl5u3Vg60Gbl1xEelHORHgdDQTlSyIFCNvB8zIlzOeUHXDOu6Yb/T
         BhE0istNOAoP6G/f3A653OC/7UDFv7lEa1eQ9rPB57Z9OlrsgKFO01EtWOeZmUN0X7vj
         K3snlIEOB5G117VV9vpVXaVGRt/PHaNnLxgdupr0Xgl7qY9NeB0mv0Us+D0XuQ7t0//9
         RdqDxeOmgJT7iD7FbuN2qXbzi+UuZOU15C5lgVppWgtwa6DNNHbPBc+UjHBpmWJL363D
         Jxc6zdN+mTf1TTRQR/O9HiRPHfXPVXdcq51Hz3V5KL09BO8Cqt5MUGjyDhl6IWyAvEe2
         ER1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AG47ELumaErf4YLnDMcxGPxe3DtfgGngx2lRANvK/tRPPJAN1LHN/PW0jQ5a2AdwZsWw3ye3O/OJsQ==
Date: Wed, 7 Mar 2018 13:47:45 -0600
From: Rob Herring <robh@kernel.org>
To: richard.gong@linux.intel.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org,
	mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
	yves.vandervennet@linux.intel.com
Subject: Re: [PATCHv2 4/7] dt-bindings: fpga: add Stratix10 SoC FPGA manager
 binding
Message-ID: <20180307194745.657ewa6rtcta6eqm@rob-hp-laptop>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
 <1519949975-13548-5-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519949975-13548-5-git-send-email-richard.gong@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593783311696826067?=
X-GMAIL-MSGID: =?utf-8?q?1594309546005015126?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 06:19:32PM -0600, richard.gong@linux.intel.com wrote:
> From: Alan Tull <atull@kernel.org>
> 
> Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
> v2: this patch is added in patch set version 2
> ---
>  .../devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt  | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> new file mode 100644
> index 0000000..78de689
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> @@ -0,0 +1,10 @@
> +Intel Stratix10 SoC FPGA Manager
> +
> +Required properties:
> +- compatible : should contain "intel,stratix10-soc-fpga-mgr"
> +
> +Example:
> +
> +	fpga_mgr: fpga-mgr@0 {
> +		compatible = "intel,stratix10-soc-fpga-mgr";

No reg or anything else? Is that because it all goes thru the service 
layer firmware? Just get the service layer driver to instantiate a 
device for this driver or get rid of the 2 layers if that's all the 
firmware interface does. DT is not a Linux driver instantiation 
mechanism.

And build your dts files with "W=1" because there's an error in this 
example.

Rob
