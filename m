Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCWVLk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:11:40 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43549 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbeCWVLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:11:38 -0400
X-Google-Smtp-Source: AG47ELtWo/MQhvnSwCS1RYJyrAJAcTxdvbRQ6ZBGmawXJEknZA+Jj30q1FHMWwfRiC4b+N5V1pwZzA==
Subject: Re: [PATCH net-next 4/8] dt-bindings: net: add DT bindings for
 Microsemi Ocelot Switch
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-5-alexandre.belloni@bootlin.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a5db6109-c5d9-f573-893c-f7d66c3168c2@gmail.com>
Date: Fri, 23 Mar 2018 14:11:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323201117.8416-5-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 01:11 PM, Alexandre Belloni wrote:
> DT bindings for the Ethernet switch found on Microsemi Ocelot platforms.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../devicetree/bindings/net/mscc-ocelot.txt        | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mscc-ocelot.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> new file mode 100644
> index 000000000000..ee092a85b5a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> @@ -0,0 +1,62 @@
> +Microsemi Ocelot network Switch
> +===============================
> +
> +The Microsemi Ocelot network switch can be found on Microsemi SoCs (VSC7513,
> +VSC7514)
> +
> +Required properties:
> +- compatible: Should be "mscc,ocelot-switch"
> +- reg: Must contain an (offset, length) pair of the register set for each
> +  entry in reg-names.
> +- reg-names: Must include the following entries:
> +  - "sys"
> +  - "rew"
> +  - "qs"
> +  - "hsio"
> +  - "qsys"
> +  - "ana"
> +  - "portX" with X from 0 to the number of last port index available on that
> +    switch
> +- interrupts: Should contain the switch interrupts for frame extraction and
> +  frame injection
> +- interrupt-names: should contain the interrupt names: "xtr", "inj"

You are not documenting the "ports" subnode(s).Please move the
individual ports definition under a ports subnode, mainly for two reasons:

- it makes it easy at the .dtsi level to have all ports disabled by default

- this makes you strictly conforming to the DSA binding for Ethernet
switches and this is good for consistency (both parsing code and just
representation).
-- 
Florian
