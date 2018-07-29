Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80A3F83CA1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 08:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CD120882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 08:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CD120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbeG2Jkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 05:40:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55254 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbeG2Jkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 05:40:35 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E3FA1C03;
        Sun, 29 Jul 2018 08:10:58 +0000 (UTC)
Date:   Sun, 29 Jul 2018 10:10:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH 01/10] staging:rtl8192u: Remove typedef of struct
 cmpk_txfb_t - Style
Message-ID: <20180729081055.GA21268@kroah.com>
References: <20180725221630.28595-1-johnfwhitmore@gmail.com>
 <20180725221630.28595-2-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725221630.28595-2-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 11:16:21PM +0100, John Whitmore wrote:
> -typedef struct tag_cmd_pkt_tx_feedback {
> +struct cmpk_txfb_t {
>  	/* DWORD 0 */
>  	u8	element_id;			/* Command packet type. */
>  	u8	length;				/* Command packet length. */
> @@ -53,7 +53,7 @@ typedef struct tag_cmd_pkt_tx_feedback {
>  	/* DWORD 5 */
>  	u16	reserve3;
>  	u16	duration;
> -} cmpk_txfb_t;
> +};

People use the "_t" to try to denote a "typedef".  When converting to
just a structure, there is no need to keep the _t anymore at all, so
this should just be "struct cmpk_txfb".

Or just drop the typedef and use the name for the struct they had here
already, "struct tag_cmd_pkt_tx_feedback", that also would work.

Same for all of the other patches in this series.

thanks,

greg k-h
