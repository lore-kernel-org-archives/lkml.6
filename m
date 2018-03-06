Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932751AbeCFAVQ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 19:21:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932287AbeCFAVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 19:21:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B75E2178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180226175802.20052-3-ilina@codeaurora.org>
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>,
        devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
References: <20180226175802.20052-1-ilina@codeaurora.org>
 <20180226175802.20052-3-ilina@codeaurora.org>
Message-ID: <152029567344.218381.8756848686590091138@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 2/2] dt-bindings: introduce Command DB for QCOM SoCs
Date: Mon, 05 Mar 2018 16:21:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-02-26 09:58:02)
> diff --git a/Documentation/devicetree/bindings/arm/msm/cmd-db.txt b/Documentation/devicetree/bindings/arm/msm/cmd-db.txt
> new file mode 100644
> index 000000000000..5737ed2ac6e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/cmd-db.txt
> @@ -0,0 +1,38 @@
> +Command DB
> +---------
> +
> +Command DB is a database that provides a mapping between resource key and the

s/between/between the/

> +resource address for a system resource managed by a remote processor. The data
> +is stored in a shared memory region and is loaded by the remote processor.
> +
> +Some of the Qualcomm Technologies Inc SoC's have hardware accelerators for

s/SoC's/SoCs/

> +controlling shared resources. Depending on the board configuration the shared
> +resource properties may change. These properties are dynamically probed by the
> +remote processor and made available in the shared memory.
> +
> +The bindings for Command DB is specified in the reserved-memory section in

s/bindings/node/

maybe?

> +devicetree. The devicetree representation of the command DB driver should be:

Maybe drop this last sentence entirely.

> +
> +Properties:
> +- compatible:
> +       Usage: required
> +       Value type: <string>
> +       Definition: Should be "qcom,cmd-db"
> +
> +- reg:
> +       Usage: required
> +       Value type: <prop encoded array>
> +       Definition: The register address that points to the location of the
> +                   Command DB in memory. Additionally, specify the address
> +                   and size of the actual lacation in memory.

s/lacation/location/

> +
> +Example:
> +
> +       reserved-memory {
> +               [...]
> +               qcom,cmd-db@c3f000c {
> +                       reg = <0x0 0xc3f000c 0x0 0x8>,
> +                             <0x0 0x85fe0000 0x0 0x20000>;
> +                       compatible = "qcom,cmd-db";
> +               };
> +       };
