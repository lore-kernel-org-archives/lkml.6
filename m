Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id J/viBtF4G1vVDAAAmS7hNA
	; Sat, 09 Jun 2018 06:51:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DC1C8608B8; Sat,  9 Jun 2018 06:51:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="N78owXG7"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5835760290;
	Sat,  9 Jun 2018 06:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5835760290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753159AbeFIGvr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 02:51:47 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:44630 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752610AbeFIGvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 02:51:44 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id E5A465C0070;
        Sat,  9 Jun 2018 08:51:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1528527102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/eHT0B2Fac225wqrjQVepsRB+mY1mynviM/vLg168A=;
        b=N78owXG7azWV22OYe4Cjy8WR5n2R+wZmExXdk/dMqAmIYvhPORM20lf0NjVyt7lLzMexM5
        gE9MOwe/RGi2Zium7+R63qDnnKY2JhGfkBAwuKTl8r3ZyDcs4eESxSTKssogZcgF9ss1Wq
        KyH2sWLlrFIQHv9U3Gq8lPNRmfnpnNQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Jun 2018 08:51:42 +0200
From: Stefan Agner <stefan@agner.ch>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Dmitry Osipenko <digetx@gmail.com>, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
In-Reply-To: <20180609084157.0c2f12e6@bbrezillon>
References: <20180531221637.6017-1-stefan@agner.ch>
 <20180531221637.6017-5-stefan@agner.ch>
 <cdca329f-0b8d-0604-4cfb-b95baf84c867@gmail.com>
 <d625dd8ca816543e03668b74921563c1@agner.ch>
 <20180609075256.725354d6@bbrezillon>
 <792ee71847f6f4752b8bcba65d22bf81@agner.ch>
 <20180609084157.0c2f12e6@bbrezillon>
Message-ID: <5090966399e4b22eec5d3ac3f381d29a@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-1.77 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[22];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.67)[92.96%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.06.2018 08:41, Boris Brezillon wrote:
> On Sat, 09 Jun 2018 08:23:51 +0200
> Stefan Agner <stefan@agner.ch> wrote:
> 
>> On 09.06.2018 07:52, Boris Brezillon wrote:
>> > On Fri, 08 Jun 2018 23:51:01 +0200
>> > Stefan Agner <stefan@agner.ch> wrote:
>> >
>> >
>> >> >
>> >> > void tegra_nand_controller_reset(struct tegra_nand_controller *ctrl)
>> >> > {
>> >> > 	int err;
>> >> >
>> >> > 	disable_irq(ctrl->irq);
>> >> >
>> >> > 	err = reset_control_reset(ctrl->rst);
>> >> > 	if (err) {
>> >> > 		dev_err(ctrl->dev, "Failed to reset HW: %d\n", err);
>> >> > 		msleep(HW_TIMEOUT);
>> >> > 	}
>> >> >
>> >> > 	writel_relaxed(NAND_CMD_STATUS, ctrl->regs + HWSTATUS_CMD);
>> >> > 	writel_relaxed(HWSTATUS_MASK, ctrl->regs + HWSTATUS_MASK);
>> >> > 	writel_relaxed(INT_MASK, ctrl->regs + ISR);
>> >>
>> >> If we do a controller reset, there is much more state than that which
>> >> needs to be restored. A lot of it is not readily available currently
>> >> (timing, ECC settings...)
>> >
>> > This is actually a good test to detect what is not properly initialized
>> > by the driver. Timings should be configured correctly through
>> > ->setup_data_interface(). ECC engine should be disabled by default and
>> > only enabled when ->{read,write}_page() is called.
>> >
>>
>> Is setup_data_interface guaranteed to be called after a failed
>> ->exec_op()/{read,write}_page()?
> 
> No. Maybe I misunderstood when tegra_nand_controller_reset() was
> supposed to be called. That's something I would call only once, early
> in the probe function, so that the controller is placed in a well-known
> state before we start using it. Definitely not something you should
> call after each error.
> 

Dmitry suggests to make use of it in the error handling path in case the
command/DMA  timed out.

Which makes sense in general I guess, just to make sure that the state
is properly set. It just isn't entirely trivial to do, since state is
setup during probe, chip detect and timing setup...

>>
>> >>
>> >> That seems a lot of work for a code path I do not intend to ever use :-)
>> >>
>> >
>> > Not so sure it's a lot of work. If ECC and timing settings are the
>> > only thing you need to initialize then it should work just fine.
>> > Try with a controller reset and you'll know if you miss something ;-).
>>
>> Currently the setting gets written directly to the registers. Only the
>> enable flag is set in the HW ECC {read,write}_page() functions. So I
>> will have to store the complete register in the chip structure and write
>> them on every {read,write}_page()?
> 
> Well, your solution works as long as you only have one chip connected
> to the controller. What we usually set the ECC config in
> ->select_chip() (or at least make sure the current setting matches the
> one we expect) and then enable the engine in read/write_page() (as you
> seem to already do).

I did not plan to make the driver multi chip capable, as I am not aware
of any real hardware using it.

But to properly reset state, we would have to have all the chip settings
stored somewhere...

--
Stefan
