Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05620C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8945223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="djsuOlkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8945223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbeKMT7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:59:11 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:54504 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbeKMT7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:59:11 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id CA94B10C0E7D;
        Tue, 13 Nov 2018 02:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542103310; bh=7shZdoJkjBbh/9l8Swdk9QYudYjDZx/aG1gOLF7tVfA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=djsuOlkRhlFeCr16gcBfqVgDXRVbyQkZVGWaFZiETWOe6uWB2fR8F/qc53Aja88u0
         G2rZM9yGi7PTygqFI41Y4u/8/jbryIVmmKZ3owXQ0ZBpzGq/OluVitvrudOTGcAmce
         YCvjdwhnjWasjcvrGlUi7uBonc5+06PEBbPxp8b09LRAhsmgPlaEJExJ03Wy+xdxzu
         mj198mp9RsjL9p3H0gF4zI5TLEZtIjAAqVznVOzBEq5qXcDlOe0GXtPEwDyR+gF4y3
         dATmPVVKsqB9YeEM7UXUnDxSY/wVyhijYlSDVe0vfCShNqyGdR/zWXtjJKqnYIMVnu
         id/PDZSckVxSQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7C9EF5A3B;
        Tue, 13 Nov 2018 02:01:50 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 02:00:54 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 11:00:52 +0100
Received: from [10.107.25.130] (10.107.25.130) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 11:00:52 +0100
Subject: Re: [V3, 3/4] Documentation: dt-bindings: media: Document bindings
 for DW MIPI CSI-2 Host
To:     Rob Herring <robh@kernel.org>,
        Luis Oliveira <luis.oliveira@synopsys.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <joao.pinto@synopsys.com>, <festevam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Keiichi Watanabe" <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        <devicetree@vger.kernel.org>
References: <1539953556-35762-1-git-send-email-lolivei@synopsys.com>
 <1539953556-35762-4-git-send-email-lolivei@synopsys.com>
 <20181024174158.GB2902@bogus>
From:   Luis de Oliveira <luis.oliveira@synopsys.com>
Message-ID: <7b0355cb-e000-619d-48ab-08cf6424fd8d@synopsys.com>
Date:   Tue, 13 Nov 2018 10:00:50 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024174158.GB2902@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.130]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24-Oct-18 18:41, Rob Herring wrote:
> On Fri, Oct 19, 2018 at 02:52:25PM +0200, Luis Oliveira wrote:
>> Add bindings for Synopsys DesignWare MIPI CSI-2 host.
> 
> Also, drop "Documentation: " from the subject. All bindings are 
> documentation and the preferred prefix is 'dt-bindings: <binding dir>: '.
> 
>>

Ok, thank you again.

>> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
>> ---
>> Changelog
>> v2-V3
>> - removed IPI settings
>>
>>  .../devicetree/bindings/media/snps,dw-csi-plat.txt | 52 ++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt
