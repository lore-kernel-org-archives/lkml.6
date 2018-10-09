Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4816AECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1B7214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiFJpWgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1B7214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeJJBoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:44:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44390 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJJBoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:44:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id p25-v6so1225697pli.11;
        Tue, 09 Oct 2018 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yu2CyOZj17wyErdRmvn9iRwQoelkiwCR4HAUNTRLdvc=;
        b=jiFJpWgf2UDMwP+Yol+OK0UpOkDwSlwtmq2ZmU5f/YDRZ8s/XO5kik/sxuQyyrS1Hg
         TpOYfx1tpBI8/igmU6glEDrAyX58PjSmef0ZhlCkhnQ4wIqHgDxceq26zGKkL9Ol1Jsw
         cXvNGPZWRKZeBIwoGk03zGitUfUX8TN8lbstszpl/so9pHdugIL4p9SppfNDtntp6GWu
         8A00rvzkuJoIS5uPBMPcA/xK7V+MKi6c7NzTITx5EvpC+rzUOkdjXRmtDxU9w9uxfhyo
         TVBjQILJRvNwOJirT6B7eEByzqxYYCS8omQCArUc9L4Hq6q4Jrd0rbfioS5H49edSZ+d
         wecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yu2CyOZj17wyErdRmvn9iRwQoelkiwCR4HAUNTRLdvc=;
        b=QF0Q09EYHnsz3VntbCWiOUYo72jJ7vcNFBYIROGxwb2YgclQmv1AV5JND24xbW+D+c
         ha1O40f7K7HLQqcKYtDWfYS4Rl7/NKAualgzgOfFADIy0lVLR1/d1jv55roXccr+yM+c
         zc8RutFLvmH/1c1Y4aBwqrLqcjcWazWXppuZQVUpjYXL5lUKSCPGDpPbQ1tFzM3n9xi9
         4SRRx/YYfyBYLRs7BVQDNVJh/fLZLxuku6IAAog4tpHJ9G+03LumF2pt8WA6bbz6QfKb
         hjxI0WNp6PHZBOnAxu7mkBBsssTJl1DHKF9p2rS47IK0c02So88yNE5K879EHALjZYIz
         6SaA==
X-Gm-Message-State: ABuFfojJNxysapEh28cDkZXNQBGScipdezNpqqy9f3Atuoo5bXNL5Jz3
        FXNs3sad1F88uCkEVQAO+82R31GgjtIBnXQVFOk=
X-Google-Smtp-Source: ACcGV60DSgV7DUvMo/lC4EbGCXQ6k8Z2HdJFQFIWpWh1GJFPv6KunyBndsuhhQAWLpTjK0xk0oJzRpylSg+5Km7QGVk=
X-Received: by 2002:a17:902:6b03:: with SMTP id o3-v6mr30044122plk.333.1539109561888;
 Tue, 09 Oct 2018 11:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <1515109891-17133-1-git-send-email-jliang@xilinx.com> <1515109891-17133-3-git-send-email-jliang@xilinx.com>
In-Reply-To: <1515109891-17133-3-git-send-email-jliang@xilinx.com>
From:   Wendy Liang <sunnyliangjy@gmail.com>
Date:   Tue, 9 Oct 2018 11:25:49 -0700
Message-ID: <CAA07jV8EinRQGtfhLchrZLkbkdRao7hugPD=02CO7MMv06WUSQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
To:     Wendy Liang <wendy.liang@xilinx.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wendy Liang <jliang@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 4, 2018 at 3:53 PM Wendy Liang <wendy.liang@xilinx.com> wrote:
>
> Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block
> in ZynqMP SoC used for the communication between various processor
> systems.
>
> Signed-off-by: Wendy Liang <jliang@xilinx.com>
> ---
>  .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 104 +++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
>
> diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> new file mode 100644
> index 0000000..5e270a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> @@ -0,0 +1,104 @@
> +Xilinx IPI Mailbox Controller
> +========================================
> +
> +The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
> +messaging between two Xilinx Zynq UltraScale+ MPSoC IPI agents. Each IPI
> +agent owns registers used for notification and buffers for message.
> +
> +               +-------------------------------------+
> +               | Xilinx ZynqMP IPI Controller        |
> +               +-------------------------------------+
> +    +--------------------------------------------------+
> +ATF                    |                     |
> +                       |                     |
> +                       |                     |
> +    +--------------------------+             |
> +                       |                     |
> +                       |                     |
> +    +--------------------------------------------------+
> +            +------------------------------------------+
> +            |  +----------------+   +----------------+ |
> +Hardware    |  |  IPI Agent     |   |  IPI Buffers   | |
> +            |  |  Registers     |   |                | |
> +            |  |                |   |                | |
> +            |  +----------------+   +----------------+ |
> +            |                                          |
> +            | Xilinx IPI Agent Block                   |
> +            +------------------------------------------+
> +
> +
> +Controller Device Node:
> +===========================
> +Required properties:
> +--------------------
> +- compatible:          Shall be: "xlnx,zynqmp-ipi-mailbox"
> +- reg:                 IPI buffers address ranges
> +- reg-names:           Names of the reg resources. It should have:
> +                       * local_request_region
> +                         - IPI request msg buffer written by local and read
> +                           by remote
> +                       * local_response_region
> +                         - IPI response msg buffer written by local and read
> +                           by remote
> +                       * remote_request_region
> +                         - IPI request msg buffer written by remote and read
> +                           by local
> +                       * remote_response_region
> +                         - IPI response msg buffer written by remote and read
> +                           by local
> +- #mbox-cells:         Shall be 1. It contains:
> +                       * tx(0) or rx(1) channel
> +- xlnx,ipi-ids:                Xilinx IPI agent IDs of the two peers of the
> +                       Xilinx IPI communication channel.
> +- interrupt-parent:    Phandle for the interrupt controller
> +- interrupts:          Interrupt information corresponding to the
> +                       interrupt-names property.
> +
> +Optional properties:
> +--------------------
> +- method:              The method of accessing the IPI agent registers.
> +                       Permitted values are: "smc" and "hvc". Default is
> +                       "smc".
> +
> +Example:
> +===========================
> +       /* APU<->RPU0 IPI mailbox controller */
> +       ipi_mailbox_rpu0: mailbox@ff90400 {
> +               compatible = "xlnx,zynqmp-ipi-mailbox";
> +               reg = <0x0 0xff990400 0x0 0x20>,
> +                     <0x0 0xff990420 0x0 0x20>,
> +                     <0x0 0xff990080 0x0 0x20>,
> +                     <0x0 0xff9900a0 0x0 0x20>;
> +               reg-names = "local_request_region", "local_response_region",
> +                           "remote_request_region", "remote_response_region";
> +               #mbox-cells = <1>;
> +               xlnx-ipi-ids = <0 1>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 29 4>;
> +       };
> +       /* APU<->RPU1 IPI mailbox controller */
> +       ipi_mailbox_rpu1: mailbox@ff990440 {
> +               compatible = "xlnx,zynqmp-ipi-mailbox";
> +               reg = <0x0 0xff990440 0x0 0x20>,
> +                     <0x0 0xff990460 0x0 0x20>,
> +                     <0x0 0xff990280 0x0 0x20>,
> +                     <0x0 0xff9902a0 0x0 0x20>;
> +               reg-names = "local_request_region", "local_response_region",
> +                           "remote_request_region", "remote_response_region";
> +               #mbox-cells = <1>;
> +               xlnx-ipi-ids = <0 2>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 29 4>;
> +       };
The Xilinx IPI hardware one IPI agent contains multiple IPI mailboxes.
Please make ipi mailbox as subnodes to the IPI agent device node.
> +       rpu0 {
> +               ...
> +               mboxes = <&ipi_mailbox_rpu0 0>,
> +                        <&ipi_mailbox_rpu0 1>;
> +               mbox-names = "tx", "rx";
> +       };
> +       rpu1 {
> +               ...
> +               mboxes = <&ipi_mailbox_rpu1 0>,
> +                        <&ipi_mailbox_rpu1 1>;
> +               mbox-names = "tx", "rx";
> +       };
> --
> 2.7.4
>
