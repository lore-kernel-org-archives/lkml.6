Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932608AbeCPRUH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:20:07 -0400
Received: from vern.gendns.com ([206.190.152.46]:33292 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbeCPRUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:20:04 -0400
Subject: Re: [PATCH v8 42/42] ARM: dts: da850: Add clocks
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-43-git-send-email-david@lechnology.com>
From: David Lechner <david@lechnology.com>
Message-ID: <cf0c4153-b65d-da57-cd0f-0a16cb186377@lechnology.com>
Date: Fri, 16 Mar 2018 12:20:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521168778-27236-43-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 09:52 PM, David Lechner wrote:
> This adds clock provider nodes for da850 and wires them up to all of the
> devices.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

...

This is the mcasp0: mcasp@100000 node...

> @@ -560,6 +720,7 @@
>   			dmas = <&edma0 1 1>,
>   				<&edma0 0 1>;
>   			dma-names = "tx", "rx";
> +			clocks = <&psc1 7>;

After some testing, it looks like it needs to be:

+			power-domains = <&psc1 7>;

instead of

+			clocks = <&psc1 7>;

>   		};
>   
>   		lcdc: display@213000 {
