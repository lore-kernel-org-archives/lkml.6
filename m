Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C67C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 21:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF5025321
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 21:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="dbpNoOaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF5025321
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeFXVQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 17:16:36 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:36914 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbeFXVQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 17:16:34 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id EFE695C1261;
        Sun, 24 Jun 2018 23:16:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529874993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K4FdwT4vl0VtO7y4UaTUOxVuX9YyUMO14lhMRdbpSYw=;
        b=dbpNoOaFhdub7v6AlqyNi2IvECXKyCMUZMWD6h0FUySGpJ/a6b9kCTkGo3MJWGjOA9UdaN
        u82wi/WiPS5WIsNEuZvbh8p6Fb5RxwFXOA3KEQF9H0g0HBok0Fk2IkQ40dTd9svGhSD/ch
        +O2wuQLPb7giHDZP9QJffMgGUrRfYGs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sun, 24 Jun 2018 23:16:30 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, benjamin.lindqvist@endian.se,
        pgaikwad@nvidia.com, dev@lynxeye.de, mirza.krak@gmail.com,
        richard@nod.at, pdeschrijver@nvidia.com,
        linux-kernel@vger.kernel.org, krzk@kernel.org,
        jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, marcel@ziswiler.com,
        miquel.raynal@bootlin.com, linux-tegra@vger.kernel.org,
        digetx@gmail.com, gaireg@gaireg.de
Subject: Re: [PATCH v7 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
In-Reply-To: <20180624215014.3249b382@bbrezillon>
References: <20180624192230.4674-1-stefan@agner.ch>
 <20180624192230.4674-5-stefan@agner.ch> <20180624215014.3249b382@bbrezillon>
Message-ID: <fa42ef544b3ad7f5be4ebdd115d99a59@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.08 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[23];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.98)[99.92%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.06.2018 21:50, Boris Brezillon wrote:
> On Sun, 24 Jun 2018 21:22:28 +0200
> Stefan Agner <stefan@agner.ch> wrote:
> 
>> +
>> +static int tegra_nand_remove(struct platform_device *pdev)
>> +{
>> +	struct tegra_nand_controller *ctrl = platform_get_drvdata(pdev);
>> +
>> +	nand_release(nand_to_mtd(ctrl->chip));
> 
> I still see nand_release() being used here. As I said in my review of
> v6, it's not safe. Please use mtd_device_unregister() + nand_cleanup()
> instead, and check the return code of mtd_device_unregister().

Whoops missed that one. Will send v8.

--
Stefan

> 
> With this addressed
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> 
>> +
>> +	clk_disable_unprepare(ctrl->clk);
>> +
>> +	return 0;
>> +}
>> +
