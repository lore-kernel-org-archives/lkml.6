Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D94C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BE52085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548148632;
	bh=riPfo+PaYom+qfXiEE/IofcK17wWSJ7PkzfeJ/8x54c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=emrp96QBB10B8TA2G5F9hZDxsm4IcSQvrKqsv1iQq44UaoJELd44MbjwnBydbV847
	 tYXd06HtPr/1mpKJ0sMtFuSfedkJg/j+qA3A0HsHCB0jnPrb6cgXX7nOKzbe5UVzKs
	 Vsgag2fO0ftWuwrRPVNbWDYEA6AuaZ5pSxQW2Wbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfAVJRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:17:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfAVJRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:17:10 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F3BC20823;
        Tue, 22 Jan 2019 09:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548148629;
        bh=riPfo+PaYom+qfXiEE/IofcK17wWSJ7PkzfeJ/8x54c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YS3jVl+v6tyxmwrUIIY6Oh8XaRLakz5CrUCT3W4H1Wjd9XPd/L3wR7QkF8LD4XMCp
         Yipwj1SWWLu6ICaBZNrrErXsWRosFsoyi2tsv5/pzXFicJT27+1bQU6rRWipUzaZg5
         khTD9423TYFBpJEiRGhxKpQHIsUHSlSEy+8/UYH8=
Date:   Tue, 22 Jan 2019 10:16:58 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI controller
Message-ID: <20190122101658.6bb89d54@bbrezillon>
In-Reply-To: <VI1PR04MB57266D861937B99899F3C1C699980@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1547553487-9936-3-git-send-email-yogeshnarayan.gaur@nxp.com>
        <VI1PR04MB57266D861937B99899F3C1C699980@VI1PR04MB5726.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 09:00:14 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Rob / Shawn,
> 
> Can you please apply patches [1] [2].

No, DT bindings should go through Mark's tree. Just wait a bit please.
