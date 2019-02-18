Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62939C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398BF217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbfBRNAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:00:40 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55925 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfBRNAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:00:40 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8B254CF2C7;
        Mon, 18 Feb 2019 14:08:31 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH][next] Bluetooth: hci_event: Use struct_size() helper
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190208004033.GA15609@embeddedor>
Date:   Mon, 18 Feb 2019 14:00:38 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1DF08879-5FE4-42CA-AF1B-5404D66E9E9E@holtmann.org>
References: <20190208004033.GA15609@embeddedor>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, change the following form:
> 
> sizeof(*ev) + ev->num_hndl * sizeof(struct hci_comp_pkts_info)
> 
> to :
> 
> struct_size(ev, handles, ev->num_hndl)
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> net/bluetooth/hci_event.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

