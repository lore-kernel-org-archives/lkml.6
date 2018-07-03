Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7416EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD4A22544
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD4A22544
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753941AbeGCCaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:30:46 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:37656 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753804AbeGCCan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:30:43 -0400
Received: by mail-yw0-f193.google.com with SMTP id w76-v6so147369ywg.4;
        Mon, 02 Jul 2018 19:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yiXP+aodzuuIPomqwKt45jrMYdZ1MCiJ+9WAjicnxLE=;
        b=mUpzHfuAtABbQ40FlbBPIg5PiHZ7LQTMWUp9vKwZIJY7ybQJBCX31OV/+GvX3SDwbc
         aZtFXOWfJlOQDtdgRROWZC99vBW4JCUwlC/UiPscqI5Btf+2kN1MUKgw9eykTCgCPc2E
         kdzb/iMrlMMIci85sFSwx8U4ACdaYa3MlecIYsQqTL/ylBy5+CmajOrCnk+895RhfNxw
         FdmBSK5u8x+ZRQBghc0aYByu1m/ixx/UWRtGvNGDSLkJuYj2FLFznj1mNKEKI+o5Z3Qm
         Gia+Bjbvc8c97DSCNrOBWjwXhTX+IHoVI2/9lkdeVqXCzqR6Dh0bJzh9oeA/HePZbUqT
         MQjQ==
X-Gm-Message-State: APt69E3UtzMqroQvv/6nKuBcF+O5kfcf3xtsGbj82ZvDOqQ4pDmUQnQA
        SRRxVlD1hb7pzCBmrTVQcg==
X-Google-Smtp-Source: AAOMgpcenjf7GGF+G7sqq6Pz/2kzNzLLIhHYX5mi47d2SKU4iW0utcQAPh7KXBzty2e+koFlqbPliQ==
X-Received: by 2002:a0d:d105:: with SMTP id t5-v6mr14186829ywd.53.1530585042983;
        Mon, 02 Jul 2018 19:30:42 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 204-v6sm8501ywk.86.2018.07.02.19.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 19:30:42 -0700 (PDT)
Date:   Mon, 2 Jul 2018 20:30:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Houlong Wei <houlong.wei@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        CK HU <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Monica Wang <monica.wang@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>, ginny.chen@mediatek.com,
        enzhu.wang@mediatek.com
Subject: Re: [PATCH v22 1/4] dt-bindings: soc: Add documentation for the
 MediaTek GCE unit
Message-ID: <20180703023040.GA24508@rob-hp-laptop>
References: <1530098172-31385-1-git-send-email-houlong.wei@mediatek.com>
 <1530098172-31385-2-git-send-email-houlong.wei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530098172-31385-2-git-send-email-houlong.wei@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 07:16:09PM +0800, Houlong Wei wrote:
> This adds documentation for the MediaTek Global Command Engine (GCE) unit
> found in MT8173 SoCs.
> 
> Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> Signed-off-by: HS Liao <hs.liao@mediatek.com>
> ---
> Hi Rob,
>   I don't add your ACK in this version since the dt-binding description
> has been changed. Thanks.
> ---
>  .../devicetree/bindings/mailbox/mtk-gce.txt        |   65 ++++++++++++++++++++
>  include/dt-bindings/gce/mt8173-gce.h               |   48 +++++++++++++++
>  2 files changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
>  create mode 100644 include/dt-bindings/gce/mt8173-gce.h
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> new file mode 100644
> index 0000000..26f65a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> @@ -0,0 +1,65 @@
> +MediaTek GCE
> +===============
> +
> +The Global Command Engine (GCE) is used to help read/write registers with
> +critical time limitation, such as updating display configuration during the
> +vblank. The GCE can be used to implement the Command Queue (CMDQ) driver.
> +
> +CMDQ driver uses mailbox framework for communication. Please refer to
> +mailbox.txt for generic information about mailbox device-tree bindings.
> +
> +Required properties:
> +- compatible: Must be "mediatek,mt8173-gce"
> +- reg: Address range of the GCE unit
> +- interrupts: The interrupt signal from the GCE block
> +- clock: Clocks according to the common clock binding
> +- clock-names: Must be "gce" to stand for GCE clock
> +- thread-num: Maximum threads count of GCE.

mediatek,thread-num

Is this needed for anything other than error checking the thread id in 
the mbox cells? if that's it, then drop it. 

> +- #mbox-cells: Should be 4.
> +	<&phandle channel timeout priority atomic_exec>
> +	phandle: Label name of a gce node.
> +	channel: Channel of mailbox. Be equal to the thread id of GCE.
> +	timeout: Maximum time of software waiting GCE processing done, in unit
> +		of millisecond.
> +	priority: Priority of GCE thread.
> +	atomic_exec: GCE processing continuous packets of commands in atomic
> +		way.
> +
> +Required properties for a client device:
> +- mboxes: Client use mailbox to communicate with GCE, it should have this
> +  property and list of phandle, mailbox specifiers.
> +- gce-subsys: Specify the sub-system id which is corresponding to the register
> +  address.

What is this for?

> +
> +Optional properties for a client device:
> +- gce-event: Specify the event if the client has any. Because the event is
> +  parsed by client, so client can replace 'gce-event' with other meaningful
> +  name.

If the client sets the name, then no point having here. It must be 
documented in the client binding. But then, what is this for in the 
first place?

> +
> +Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'. Such as
> +thread number, sub-system ids, thread priority, event ids.
> +
> +Example:
> +
> +	gce: gce@10212000 {

mailbox@...

> +		compatible = "mediatek,mt8173-gce";
> +		reg = <0 0x10212000 0 0x1000>;
> +		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&infracfg CLK_INFRA_GCE>;
> +		clock-names = "gce";
> +		thread-num = CMDQ_THR_MAX_COUNT;
> +		#mbox-cells = <4>;
> +	};
> +
> +Example for a client device:
> +
> +	mmsys: clock-controller@14000000 {
> +		compatible = "mediatek,mt8173-mmsys";
> +		mboxes = <&gce 0 2000 CMDQ_THR_PRIO_LOWEST 1>,
> +			 <&gce 1 2000 CMDQ_THR_PRIO_LOWEST 1>;
> +		gce-subsys = <SUBSYS_1400XXXX>;
> +		mutex-event-eof = <CMDQ_EVENT_MUTEX0_STREAM_EOF
> +				CMDQ_EVENT_MUTEX1_STREAM_EOF>;
> +
> +		...
> +	};
