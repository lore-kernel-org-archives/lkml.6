Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBADFC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED5624077
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuinhWyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED5624077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754262AbeGEUI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753969AbeGEUI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:08:27 -0400
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com [209.85.214.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A5B8240D5;
        Thu,  5 Jul 2018 20:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530821306;
        bh=OzGD9yj5x1g9oVO/c/VbFRolvpreAqKUfY5nryRsq/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KuinhWyDGzUAv7Jj14PX5Ngay3Iugo3uxbvPfEzmCm3X7BLFHEPWitjd1jdubId/6
         g1H0LwSRNWpXxU/5+/ZhIyOGa8pJVaiqJLlMv+idzS9rJf+7U6GRiSTsbU3JLFfDR9
         r1f17FNwcLTNl22e2jZDDk6cS1pI6HSUHsGfNj9E=
Received: by mail-it0-f53.google.com with SMTP id p185-v6so14108716itp.4;
        Thu, 05 Jul 2018 13:08:26 -0700 (PDT)
X-Gm-Message-State: APt69E0nSjr84r0uppRXEk4dht79Ri8y0I6tAwCGAC6j6bZENv1usPxN
        8/RbjEmAn2WFDcPGtPWO70ppxCTo7FYxJLuZ/w==
X-Google-Smtp-Source: AAOMgpePOARGW5FVJ5SYHtSkI6CVHp+6knsOnIHUve1knzm8SqmSm22B5lHMV/33ObwY9x+SPMW/EmoHXt+UW9lqhNE=
X-Received: by 2002:a24:41e9:: with SMTP id b102-v6mr5739695itd.19.1530821306014;
 Thu, 05 Jul 2018 13:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <1530098172-31385-1-git-send-email-houlong.wei@mediatek.com>
 <1530098172-31385-2-git-send-email-houlong.wei@mediatek.com>
 <20180703023040.GA24508@rob-hp-laptop> <1530661158.21991.45.camel@mhfsdcap03>
In-Reply-To: <1530661158.21991.45.camel@mhfsdcap03>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 5 Jul 2018 14:08:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLZ-+-kY2QSY3cZMoR2zZuuZA8C9VUoHG=F7rpa4s5fgA@mail.gmail.com>
Message-ID: <CAL_JsqLZ-+-kY2QSY3cZMoR2zZuuZA8C9VUoHG=F7rpa4s5fgA@mail.gmail.com>
Subject: Re: [PATCH v22 1/4] dt-bindings: soc: Add documentation for the
 MediaTek GCE unit
To:     Houlong Wei <houlong.wei@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <Bibby.Hsieh@mediatek.com>,
        YT Shen <Yt.Shen@mediatek.com>,
        Daoyuan Huang <Daoyuan.Huang@mediatek.com>,
        Jiaguang Zhang <Jiaguang.Zhang@mediatek.com>,
        Dennis-YC Hsieh <Dennis-YC.Hsieh@mediatek.com>,
        Monica Wang <monica.wang@mediatek.com>,
        HS Liao <Hs.Liao@mediatek.com>, ginny.chen@mediatek.com,
        enzhu.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 5:39 PM houlong wei <houlong.wei@mediatek.com> wrote:
>
> On Tue, 2018-07-03 at 10:30 +0800, Rob Herring wrote:
> > On Wed, Jun 27, 2018 at 07:16:09PM +0800, Houlong Wei wrote:
> > > This adds documentation for the MediaTek Global Command Engine (GCE) unit
> > > found in MT8173 SoCs.
> > >
> > > Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> > > Signed-off-by: HS Liao <hs.liao@mediatek.com>
> > > ---
> > > Hi Rob,
> > >   I don't add your ACK in this version since the dt-binding description
> > > has been changed. Thanks.
> > > ---
> > >  .../devicetree/bindings/mailbox/mtk-gce.txt        |   65 ++++++++++++++++++++
> > >  include/dt-bindings/gce/mt8173-gce.h               |   48 +++++++++++++++
> > >  2 files changed, 113 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > >  create mode 100644 include/dt-bindings/gce/mt8173-gce.h
> > >
> > > diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > > new file mode 100644
> > > index 0000000..26f65a4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > > @@ -0,0 +1,65 @@
> > > +MediaTek GCE
> > > +===============
> > > +
> > > +The Global Command Engine (GCE) is used to help read/write registers with
> > > +critical time limitation, such as updating display configuration during the
> > > +vblank. The GCE can be used to implement the Command Queue (CMDQ) driver.
> > > +
> > > +CMDQ driver uses mailbox framework for communication. Please refer to
> > > +mailbox.txt for generic information about mailbox device-tree bindings.
> > > +
> > > +Required properties:
> > > +- compatible: Must be "mediatek,mt8173-gce"
> > > +- reg: Address range of the GCE unit
> > > +- interrupts: The interrupt signal from the GCE block
> > > +- clock: Clocks according to the common clock binding
> > > +- clock-names: Must be "gce" to stand for GCE clock
> > > +- thread-num: Maximum threads count of GCE.
> >
> > mediatek,thread-num
> >
> > Is this needed for anything other than error checking the thread id in
> > the mbox cells? if that's it, then drop it.
> >
>
> 'thread-num' is used to configure the GCE thread number, which is the
> channel number of gce mailbox. This property is read in
> cmdq_probe()/mtk-cmdq-mailbox.c and a mailbox's channel array is
> allocated according to the number.
> Since the thread number may be different on different SoC, we wish it
> could be configured in device tree.

You should have different compatible strings for different SoCs and
can imply the number of threads from that.

Or if the number of threads doesn't vary greatly, just allocate the
max # of channels. Or allocate the per thread data when a thread is
actually in use.

>
> > > +- #mbox-cells: Should be 4.
> > > +   <&phandle channel timeout priority atomic_exec>
> > > +   phandle: Label name of a gce node.
> > > +   channel: Channel of mailbox. Be equal to the thread id of GCE.
> > > +   timeout: Maximum time of software waiting GCE processing done, in unit
> > > +           of millisecond.
> > > +   priority: Priority of GCE thread.
> > > +   atomic_exec: GCE processing continuous packets of commands in atomic
> > > +           way.
> > > +
> > > +Required properties for a client device:
> > > +- mboxes: Client use mailbox to communicate with GCE, it should have this
> > > +  property and list of phandle, mailbox specifiers.
> > > +- gce-subsys: Specify the sub-system id which is corresponding to the register
> > > +  address.
> >
> > What is this for?
>
> You mean the new added property 'gce-subsys'?
> It is used for GCE to distinguish the high 16-bit of a hardware register
> address. When a client driver packets a register setting into a GCE
> instruction, it uses a sub-system code and register offset instead of
> the 32-bit register address.
> Since sub-system code may be different on different SoC, we wish it
> could be configured in device tree.

Okay. It needs a vendor prefix and to specify the size and type of the value.

>
> >
> > > +
> > > +Optional properties for a client device:
> > > +- gce-event: Specify the event if the client has any. Because the event is
> > > +  parsed by client, so client can replace 'gce-event' with other meaningful
> > > +  name.
> >
> > If the client sets the name, then no point having here. It must be
> > documented in the client binding. But then, what is this for in the
> > first place?
>
> Since display driver will use GCE firstly, so we will move the
> description to
> 'Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt'
> when display driver start using the GCE driver.
> Is that ok?

Not sure. I don't understand how it is used.

> > > +
> > > +Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'. Such as
> > > +thread number, sub-system ids, thread priority, event ids.
> > > +
> > > +Example:
> > > +
> > > +   gce: gce@10212000 {
> >
> > mailbox@...
>
> Will do.
>
> >
> > > +           compatible = "mediatek,mt8173-gce";
> > > +           reg = <0 0x10212000 0 0x1000>;
> > > +           interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
> > > +           clocks = <&infracfg CLK_INFRA_GCE>;
> > > +           clock-names = "gce";
> > > +           thread-num = CMDQ_THR_MAX_COUNT;
> > > +           #mbox-cells = <4>;
> > > +   };
> > > +
> > > +Example for a client device:
> > > +
> > > +   mmsys: clock-controller@14000000 {
> > > +           compatible = "mediatek,mt8173-mmsys";
> > > +           mboxes = <&gce 0 2000 CMDQ_THR_PRIO_LOWEST 1>,
> > > +                    <&gce 1 2000 CMDQ_THR_PRIO_LOWEST 1>;
> > > +           gce-subsys = <SUBSYS_1400XXXX>;
> > > +           mutex-event-eof = <CMDQ_EVENT_MUTEX0_STREAM_EOF
> > > +                           CMDQ_EVENT_MUTEX1_STREAM_EOF>;
> > > +
> > > +           ...
> > > +   };
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
