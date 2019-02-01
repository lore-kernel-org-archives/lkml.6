Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB826C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E797218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V7B3jUde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbfBASfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:35:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35279 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbfBASfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:35:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so3642367plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 10:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1OtBkZag0N4BIBWAan1VrAJ+wFVHG96G7eftj8weeSI=;
        b=V7B3jUdeIGWs3B3EMjAsz1dqifM+ZwPdBbO6vo+Z1B4wyYcV6Sop4rlGMgfk8Fnf5R
         k7eicDtBF2705vfbwkxvwe59uFd/sj3AxwaezNBw2w3xCODsqV2aSA1kxmu6xFpTgpRk
         y1uKrp8reYP74EocxSjWSvzkWjb+T0eZu38vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1OtBkZag0N4BIBWAan1VrAJ+wFVHG96G7eftj8weeSI=;
        b=pc0ZuZ0R844tCFIudO/lR89JncO63wBSUjYL2fFzL4nyHyOja13Ebfxs4kPn5ZrJGV
         vn2tdig+aIg0+SjLGKioL3NLykhSwWozDjBFJmOMW2+6752O8zUOZZsRK3aur/g9bYnE
         lkotI3DHnQZaVJQtLe2cyl2B7Y1t70qdJTYkMBR0CrDteqn6vJEIuWBqUSxlKlrIh6U9
         qelyPR+GbtnQGrAGnIHz+xKPAKyLT9hj0j/BRCsWSa/RbjtNRjW2xuAyFCV98GHHvr9G
         8gQTj2P9Jrpn6ZT7oS7EuGtr1dDEr1V74/hW4FiRLZ99ILvB8wWoEdTczUz/8rp+fuvK
         v3cg==
X-Gm-Message-State: AJcUukf/xvLyhtdwJXVOODxNh0RSLAb7wyjDv1mQyM5HYmNTOBi9z4u6
        mQS4Yh6jkwMTpgsfHfqYVnFRoA==
X-Google-Smtp-Source: ALg8bN7e8L+EprCeNxO/A/1jJwEbB2V3ouTtTqLmxZdJ3wHl58jHLNIZSYEjbtEtyaUUjUYNGoWbsQ==
X-Received: by 2002:a17:902:2ac3:: with SMTP id j61mr40622494plb.185.1549046108047;
        Fri, 01 Feb 2019 10:35:08 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d16sm9027912pgj.21.2019.02.01.10.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 10:35:07 -0800 (PST)
Date:   Fri, 1 Feb 2019 10:35:06 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 3/3] Bluetooth: hci_qca: Disable IBS state machine and
 flush Tx buffer
Message-ID: <20190201183506.GR81583@google.com>
References: <20190124120808.8275-1-bgodavar@codeaurora.org>
 <20190124120808.8275-4-bgodavar@codeaurora.org>
 <20190125005534.GC81583@google.com>
 <75923da910c43e7e5e033f4ff4360a90@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75923da910c43e7e5e033f4ff4360a90@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 05:10:11PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2019-01-25 06:25, Matthias Kaehlcke wrote:
> > On Thu, Jan 24, 2019 at 05:38:08PM +0530, Balakrishna Godavarthi wrote:
> > > During hci down we observed IBS sleep commands are queued in the Tx
> > > buffer and hci_uart_write_work is sending data to the chip which is
> > > not required as the chip is powered off. This patch will disable IBS
> > > and flush the Tx buffer before we turn off the chip.
> > > 
> > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > > ---
> > > Changes v9:
> > >   * added lock while disabling the IBS state machine.
> > > 
> > > ---
> > >  drivers/bluetooth/hci_qca.c | 17 +++++++++++++++--
> > >  1 file changed, 15 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > index 6b5bcd44e24c..99ddc35f08c6 100644
> > > --- a/drivers/bluetooth/hci_qca.c
> > > +++ b/drivers/bluetooth/hci_qca.c
> > > @@ -771,16 +771,17 @@ static int qca_enqueue(struct hci_uart *hu,
> > > struct sk_buff *skb)
> > >  	/* Prepend skb with frame type */
> > >  	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
> > > 
> > > +	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> > > +
> > >  	/* Don't go to sleep in middle of patch download or
> > >  	 * Out-Of-Band(GPIOs control) sleep is selected.
> > >  	 */
> > >  	if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
> > >  		skb_queue_tail(&qca->txq, skb);
> > > +		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> > >  		return 0;
> > >  	}
> > > 
> > > -	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> > > -
> > >  	/* Act according to current state */
> > >  	switch (qca->tx_ibs_state) {
> > >  	case HCI_IBS_TX_AWAKE:
> > > @@ -1273,6 +1274,18 @@ static const struct qca_vreg_data
> > > qca_soc_data = {
> > > 
> > >  static void qca_power_shutdown(struct hci_uart *hu)
> > >  {
> > > +	struct qca_data *qca = hu->priv;
> > > +	unsigned long flags;
> > > +
> > > +	/* From this point we go into power off state. But serial port is
> > > +	 * still open, stop queueing the IBS data and flush all the buffered
> > > +	 * data in skb's.
> > > +	 */
> > > +	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> > > +	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> > > +	qca_flush(hu);
> > > +	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
> > > +
> > >  	host_set_baudrate(hu, 2400);
> > >  	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
> > >  	qca_power_setup(hu, false);
> > 
> > I was about to add my 'Reviewed-by' tag, but I'm still left with a
> > doubt. This patch certainly improves the situation by clearing the IBS
> > bit and flushing the buffered data, however IIUC new data could still
> > be added to the TX queue after releasing the spinlock:
> > 
> > static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
> > {
> > 	...
> > 
> > 	if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
> > 		skb_queue_tail(&qca->txq, skb);
> > 
> > 	...
> > }
> > 
> > To prevent this a boolean/bit like 'shutting_down' or similar would be
> > needed (I don't think there is something common in the HCI core),
> > which is set in qca_power_shutdown(). If the bit is set qca_enqueue()
> > discards the data.
> > 
> > Not sure how important this is, and I don't want to add necessarily
> > more revisions to this series. If it is preferable to have an empty
> > queue after shutdown maybe it can be done in a follow up patch.
> > 
> > Thanks
> > 
> > Matthias
> 
> [Bala]: during shutdown Bt stack will not send any data to the Bt  kernel Tx
> path.
>         so this call may not be called. once we shutdown chip.

Thanks for the clarification! I kinda expected that, but it wasn't
evident to me from the core code.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
