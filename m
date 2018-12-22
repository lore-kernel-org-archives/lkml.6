Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B41EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DD6218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+OLUMN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbeLVCAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 21:00:02 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36571 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeLVCAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 21:00:01 -0500
Received: by mail-io1-f65.google.com with SMTP id m19so5186459ioh.3;
        Fri, 21 Dec 2018 18:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aZt2eyagM4lqMLEpi1b+c4/zgJkxTUDtvq67TbKB9vA=;
        b=I+OLUMN6z+8+P1cLDLfncLEfJnqV1hNMlZ8a2oowX/1qYJojSOnTzPYZ+7UwF0vSSv
         T+fk+p74TATcqe+5c9Y/uhDwYx976YelKyrSAkWN1mjemyT8PI1/2yLee6dNy1lD/68S
         c9s0UAM6zZE3eRIPQw7xomcre0XjabKJSDkpeodpHb9vBiqgXarGuV4pdAiVwg0RyBVt
         G6ODCqspTlp+3pL9qq1bgVXeYGBTPHHVZ4KeX675eTVksRs9s3vh5iHefjMdhvA2E8RZ
         5F92g1LkckujYzjoWYk3qtBnZIPLqaqb4gv1gi7epySfgUsss++4Z9HKd8tPqCzoZHYn
         31lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZt2eyagM4lqMLEpi1b+c4/zgJkxTUDtvq67TbKB9vA=;
        b=pGSsMYpLZCZSfubc3ZTQsYHTImYI7ep3+AP4hltnW5QImjA29BuXqxE9eYr951GhJb
         skKTkRWy9noqxWR3BYKuRE8bVEMBNjhlMk0HYiSFxPgP+dDsmHcqZ713byBWsc6XZEf7
         /RUzxnYMvy3nmQ9YqtVEnNS2k47k9NQn3Y5cbfDU0khViWm4N5/kaHGdBHsPmM690zja
         KmwN+est6TZyZYxNFRdjzb6ftJDb5Cg3MPERMH+7JNdIIzoqum7Fu+ozgUGFznaxntLV
         oHz1zpkOL2zAm4dWGmlRxxEnIdh3Nl/TYDowrbxp72GJT71VvF/6g+YSyi4J+bjXfeRx
         aP8A==
X-Gm-Message-State: AJcUukfZz0xKpZAhit9gKzrpaHdpnYXbor2Z3eUzNMyiqUnv7Rq6mhAj
        Z1N5arQGtYfUAYu1pZAuGhrn9RixDoY4uuK0stQ=
X-Google-Smtp-Source: ALg8bN5lGzM10ohfDS88bSHvblLouIzY9uRTT11D7WM3gsbZ0F2bw4uyrngP8ARoepHJudRu0RIAW1xCoyMmyAoQYz0=
X-Received: by 2002:a6b:a0d:: with SMTP id z13mr3203284ioi.57.1545444000039;
 Fri, 21 Dec 2018 18:00:00 -0800 (PST)
MIME-Version: 1.0
References: <1545327149-22331-1-git-send-email-wendy.liang@xilinx.com> <1545327149-22331-2-git-send-email-wendy.liang@xilinx.com>
In-Reply-To: <1545327149-22331-2-git-send-email-wendy.liang@xilinx.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 21 Dec 2018 19:59:48 -0600
Message-ID: <CABb+yY27K8V-Mg_0kvQFvvAGhzdXG+7Zcz9tGDe_1FTStvra3Q@mail.gmail.com>
Subject: Re: [PATH v7 1/2] mailbox: ZynqMP IPI mailbox controller
To:     Wendy Liang <wendy.liang@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Devicetree List <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 11:32 AM Wendy Liang <wendy.liang@xilinx.com> wrote:


> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> new file mode 100644
> index 0000000..bbddfd5
> --- /dev/null
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -0,0 +1,764 @@

......
> +
> +/* IPI SMC Macros */
> +#define IPI_SMC_OPEN_IRQ_MASK          0x00000001UL /* IRQ enable bit in IPI
> +                                                     * open SMC call
> +                                                     */
> +#define IPI_SMC_NOTIFY_BLOCK_MASK      0x00000001UL /* Flag to indicate if
> +                                                     * IPI notification needs
> +                                                     * to be blocking.
> +                                                     */
> +#define IPI_SMC_ENQUIRY_DIRQ_MASK      0x00000001UL /* Flag to indicate if
> +                                                     * notification interrupt
> +                                                     * to be disabled.
> +                                                     */
> +#define IPI_SMC_ACK_EIRQ_MASK          0x00000001UL /* Flag to indicate if
> +                                                     * notification interrupt
> +                                                     * to be enabled.
> +                                                     */
> +
The first two are unused.


> +struct zynqmp_ipi_pdata {
> +       struct device *dev;
> +       int irq;
> +       unsigned int method;
>
'method' doesn't track the HVC option in the driver. Please have a look.

......
> +
> +static void zynqmp_ipi_fw_call(struct zynqmp_ipi_mbox *ipi_mbox,
> +                              unsigned long a0, unsigned long a3,
> +                              unsigned long a4, unsigned long a5,
> +                              unsigned long a6, unsigned long a7,
> +                              struct arm_smccc_res *res)
>
[a4,a7] are always 0, so maybe just drop them?


> +static bool zynqmp_ipi_last_tx_done(struct mbox_chan *chan)
> +{
> +       struct device *dev = chan->mbox->dev;
> +       struct zynqmp_ipi_mbox *ipi_mbox = dev_get_drvdata(dev);
> +       struct zynqmp_ipi_mchan *mchan = chan->con_priv;
> +       int ret;
> +       u64 arg0;
> +       struct arm_smccc_res res;
> +       struct zynqmp_ipi_message *msg;
> +
> +       if (WARN_ON(!ipi_mbox)) {
> +               dev_err(dev, "no platform drv data??\n");
> +               return false;
> +       }
> +
> +       if (mchan->chan_type == IPI_MB_CHNL_TX) {
> +               /* We only need to check if the message been taken
> +                * by the remote in the TX channel
> +                */
> +               arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
> +               zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
> +               /* Check the SMC call status, a0 of the result */
> +               ret = (int)(res.a0 & 0xFFFFFFFF);
> +               if (ret < 0 || ret & IPI_MB_STATUS_SEND_PENDING)
> +                       return false;
> +
OK, but ...

> +               msg = mchan->rx_buf;
> +               msg->len = mchan->resp_buf_size;
> +               memcpy_fromio(msg->data, mchan->resp_buf, msg->len);
> +               mbox_chan_received_data(chan, (void *)msg);
>
.... wouldn't this be done from zynqmp_ipi_interrupt()?



> +static int zynqmp_ipi_send_data(struct mbox_chan *chan, void *data)
> +{
  .........
> +               /* Enquire if the mailbox is free to send message */
> +               arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
> +               timeout = 10;
> +               if (msg && msg->len) {
> +                       timeout = 10;
> +                       do {
> +                               zynqmp_ipi_fw_call(ipi_mbox, arg0,
> +                                                  0, 0, 0, 0, 0, &res);
> +                               ret = res.a0 & 0xFFFFFFFF;
> +                               if (ret >= 0 &&
> +                                   !(ret & IPI_MB_STATUS_SEND_PENDING))
> +                                       break;
> +                               usleep_range(1, 2);
> +                               timeout--;
> +                       } while (timeout);
> +                       if (!timeout) {
> +                               dev_warn(dev, "chan %d sending msg timeout.\n",
> +                                        ipi_mbox->remote_id);
> +                               return -ETIME;
> +                       }
> +                       memcpy_toio(mchan->req_buf, msg->data, msg->len);
> +               }
>
This check should be done in last_tx_done, and not here.
send_data is never called unless last_tx_done returns true.

> +               /* Kick IPI mailbox to send message */
> +               arg0 = SMC_IPI_MAILBOX_NOTIFY;
> +               zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
> +       } else {
> +               /* Send response message */
> +               if (msg && msg->len > mchan->resp_buf_size) {
> +                       dev_err(dev, "channel %d message length %u > max %lu\n",
> +                               mchan->chan_type, (unsigned int)msg->len,
> +                               mchan->resp_buf_size);
> +                       return -EINVAL;
> +               }
> +               if (msg && msg->len)
> +                       memcpy_toio(mchan->resp_buf, msg->data, msg->len);
>

> +               arg0 = SMC_IPI_MAILBOX_NOTIFY;
> +               arg0 = SMC_IPI_MAILBOX_ACK;
>
This is obviously wrong.

....
> +       mbox->chans = chans;
> +       chans[IPI_MB_CHNL_TX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
> +       chans[IPI_MB_CHNL_RX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
> +       ipi_mbox->mchans[IPI_MB_CHNL_TX].chan_type = IPI_MB_CHNL_TX;
> +       ipi_mbox->mchans[IPI_MB_CHNL_RX].chan_type = IPI_MB_CHNL_RX;
> +       ret = mbox_controller_register(mbox);
>
while at it, you may want to start using
devm_mbox_controller_register() recently added by Thierry.

> +       if (ret)
> +               dev_err(mdev,
> +                       "Failed to register mbox_controller(%d)\n", ret);
> +       else
> +               dev_info(mdev, "Probed ZynqMP IPI Mailbox driver.\n");
>
You may want to also print something instance specific here.


> +static int zynqmp_ipi_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *nc, *np = pdev->dev.of_node;
> +       struct zynqmp_ipi_pdata *pdata;
> +       struct zynqmp_ipi_mbox *mbox;
> +       int i, ret = -EINVAL;
> +
> +       i = 0;
> +       for_each_available_child_of_node(np, nc)
> +               i++;
>
of_get_child_count() ?


Thnx
