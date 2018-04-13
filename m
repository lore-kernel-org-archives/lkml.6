Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523637329; cv=none;
        d=google.com; s=arc-20160816;
        b=XgoXd2+1UM0DkDSFizdNGcWuajZUy1wAh6a4J2LYMDu/65VtDnnB3IoJ8cwfBPJWeM
         2R9oGWkXdC8hlkCQgeH++heJjTmVegyJjBTIJUcdTuvpakMNgvD5D+0ISfqlyoAKI/hK
         +i71llV7Z2UB1sGgKA+DB9tq1qog5PrXrqQv3Pz009pJM9YNXy9LyNAD+Dcfk9jidg++
         W0+QDYJkSWFYVGODJM3ozPfPat7RMyF8KyPRwJbTkwFbB+cHlQM+GcGyEOOXRLGyjTcz
         e24zGtFVnuWVCvnURl3l3djxSkP7b7PyFsRgIBUeiHSk1LV2U9k27gPEcGP/+XvPRg9k
         t+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=OPd5ddKC69KjPUwMSgCGx7mXdzYHDWp5j4+8ft+S6xQ=;
        b=P1StNM8Z52UMO71zWvdPDQ0Ml77+303YxfYeugYR6rlZ1MkqfW68x7M6l8t3DNTbqK
         EmadSj23AI8SKwXn+sfJ4Wcsy+w8G1TegN3Hb/VYdhq2j8kOe8tedw7F3gg45eXLZEZt
         YLxePjQvA/3Gv2m6uWxMUwPNyOhZWtkl6ETb04OffEZezATzvy13d8DEcRFlu2tnWpFQ
         UNtiM2eyVaCMYwM+Wy3mTmRncYAsrnmVizI649J2tA45Cs4LvTCFCW6WUGPdHmwv0QxM
         JCppcQHRIF+PybubfUqG90ksMqzjgO30rieFbN2Mb6rcNJb+Jgx2wx/6Ih79fvrKlNB0
         37XQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx49E0q400KAA5xIidBVljCfL7NNgeUpDug2BRUdE06/o7vrHYbnhn44Cb61pce281821enV+jg==
Date: Fri, 13 Apr 2018 11:35:27 -0500
From: Rob Herring <robh@kernel.org>
To: Craig Tatlor <ctatlor97@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: power: supply: qcom_bms: Add bindings
Message-ID: <20180413163527.ludqnnc5nkj4spre@rob-hp-laptop>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180407175802.29444-1-ctatlor97@gmail.com>
 <20180407175802.29444-2-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180407175802.29444-2-ctatlor97@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597095394982255487?=
X-GMAIL-MSGID: =?utf-8?q?1597649536818627757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 07, 2018 at 06:57:45PM +0100, Craig Tatlor wrote:
> Add bindings for the Qualcomm Battery Monitoring system.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> ---
>  .../bindings/power/supply/qcom_bms.txt        | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/qcom_bms.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/qcom_bms.txt b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
> new file mode 100644
> index 000000000000..6296399edc09
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
> @@ -0,0 +1,93 @@
> +Qualcomm Battery Measurement System
> +
> +The Qualcomm Battery Measurement System is found inside of Qualcomm PM8941

Is it Monitoring or Measurment?

> +PMICs. It provides OCV and coulomb counter registers that allow the kernel
> +to infer a capacity level.

s/kernel/OS/

OCV?

> +
> +Required properties:
> +- compatible:               Should contain "qcom,pm8941-bms".
> +- reg:                      Specifies the SPMI address and length of the
> +			    controller's registers.
> +- interrupts:               OCV threshold interrupt.
> +- io-channels:              Should contain IIO channel specifier for the
> +			    ADC channel that reports battery temperature.
> +- io-channel-names:         Should contain "temp".
> +- qcom,fcc-temp-legend:     An array containing the temperature, in degC,
> +			    for each column of the FCC lookup table.

What's FCC?

> +- qcom,fcc-lut:             An array of FCC values in mah, one entry for each
> +			    temperature defined in in qcom,fcc-temp-legend.
> +- qcom,ocv-temp-legend:     An array containing the temperature, in degC,
> +			    for each column of the OCV lookup table.
> +- qcom,ocv-capacity-legend: An array containing the capacity for each
> +			    row of the OCV lookup table.
> +- qcom,ocv-lut:             An array of OCV values in mV, one entry for each
> +			    capacity defined in qcom,ocv-capacity-legend.

Need to specify the sizes of these if not 32-bit.

All these seem to have units, so add unit suffixes as defined in 
property-units.txt.

> +
> +Example:
> +
> +		pm8941_vadc: vadc@3100 {

adc@...

> +			compatible = "qcom,spmi-vadc";
> +			reg = <0x3100>;
> +			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#io-channel-cells = <1>;
> +
> +			bat_temp {
> +				reg = <VADC_LR_MUX1_BAT_THERM>;
> +			};
> +		};
> +
> +		bms@4000 {
> +			compatible = "qcom,pm8941-bms";
> +			reg = <0x4000>;
> +			interrupts = <0x0 0x40 0x4 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "ocv_thr";
> +
> +			io-channels = <&pm8941_vadc VADC_LR_MUX1_BAT_THERM>;
> +			io-channel-names = "temp";
> +
> +			qcom,fcc-temp-legend = /bits/ 8 <(-10) 0 25 50 65>;
> +			qcom,fcc-lut = /bits/ 16 <6010 6070 6680 6780 6670>;
> +
> +			qcom,ocv-capacity-legend = /bits/ 8 <100 95 90 85
> +							     80 75 70 65
> +							     60 55 50 45
> +							     40 35 30 25
> +							     20 15 10 9
> +							     8 7 6 5 4
> +							     3 2 1 0>;
> +
> +			qcom,ocv-temp-legend = /bits/ 8 <(-10) 0 25 50 65>;
> +			qcom,ocv-lut = /bits/ 16 <4288 4288 4306 4315 4315
> +						  4261 4241 4259 4266 4246
> +						  4201 4181 4201 4207 4187
> +						  4153 4133 4150 4155 4135
> +						  4105 4085 4100 4104 4084
> +						  4058 4038 4052 4058 4038
> +						  4012 3992 4004 4014 3994
> +						  3970 3950 3959 3971 3951
> +						  3931 3911 3915 3927 3907
> +						  3899 3879 3880 3884 3864
> +						  3873 3853 3851 3853 3833
> +						  3848 3828 3827 3829 3809
> +						  3829 3809 3808 3809 3789
> +						  3815 3795 3791 3791 3771
> +						  3801 3781 3775 3772 3752
> +						  3785 3765 3751 3746 3726
> +						  3767 3747 3727 3719 3699
> +						  3750 3730 3702 3692 3672
> +						  3728 3708 3680 3672 3652
> +						  3720 3700 3676 3665 3645
> +						  3712 3692 3670 3660 3645
> +						  3695 3675 3658 3648 3633
> +						  3662 3647 3629 3620 3610
> +						  3620 3605 3589 3580 3570
> +						  3562 3552 3538 3529 3519
> +						  3490 3480 3474 3470 3465
> +						  3403 3398 3388 3380 3375
> +						  3320 3300 3255 3221 3206
> +						  3000 3000 3000 3000 3000>;
> +		};
> +	};
> +};
> -- 
> 2.17.0
> 
