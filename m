Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932470AbeCEXPB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 18:15:01 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39541 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752936AbeCEXO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 18:14:59 -0500
X-Google-Smtp-Source: AG47ELu8d6xIG2feXoCkCQ0UuJcTltiRCjx0UK5Pyfu26iZ+IhW7swRkSVhmXzVsEjPesM8wjZwWKQ==
Date: Mon, 5 Mar 2018 15:14:55 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: introduce Command DB for QCOM SoCs
Message-ID: <20180305231455.GJ18510@minitux>
References: <20180226175802.20052-1-ilina@codeaurora.org>
 <20180226175802.20052-3-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226175802.20052-3-ilina@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26 Feb 09:58 PST 2018, Lina Iyer wrote:

> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> 
> Command DB provides information on shared resources like clocks,
> regulators etc., probed at boot by the remote subsytem and made
> available in shared memory.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> 
> Changes in v4:
> 	- Fix unwanted capitalization
> 	- Add reg property
> ---
>  .../devicetree/bindings/arm/msm/cmd-db.txt         | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/cmd-db.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/cmd-db.txt b/Documentation/devicetree/bindings/arm/msm/cmd-db.txt
[..]
> +	reserved-memory {
> +		[...]
> +		qcom,cmd-db@c3f000c {
> +			reg = <0x0 0xc3f000c 0x0 0x8>,
> +			      <0x0 0x85fe0000 0x0 0x20000>;

I'm still concerned about the use of the redirection mapping here,
the relocation at 0xc3f000c is used a convenience thing so that the
command db can be relocated, but because of how Linux will consume any
non-reserved memory the dts would still need to be manually updated.

As such I think you should just describe only the 0x85fe0000 + 0x20000
region here and to support the dynamic aspect of this from a system
point of view you can have the boot loader read the information at
0xc3f000c and adjust the reserved memory. (Or just keep the step of
manually update the dts without caring about the indirection)

Regards,
Bjorn
