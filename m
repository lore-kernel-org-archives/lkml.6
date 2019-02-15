Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA90C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701B72192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="C4uF2YuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406144AbfBOMdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:33:03 -0500
Received: from canardo.mork.no ([148.122.252.1]:54323 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfBOMdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:33:02 -0500
Received: from miraculix.mork.no ([IPv6:2a02:2121:2c1:c222:14c6:42ff:fe4d:851f])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id x1FCWpoT001733
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 13:32:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1550233972; bh=3kTgHTCfsk0cL9N0ODEgQNqUR4tlICgbFlXl7ximvDI=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=C4uF2YuRmvTbhm1nLVb3hR727B61Yn8hCjMebEOKFjq5BNnDSZnMkw46XMarR/yIs
         KcLq7890BSOqi7E3vlmfnkzxte5Oy1Mm81FOcBP2lHvu8lNXM54J01ORSBNGdVZfGB
         yiMZQ7KV/Rryx9AVAjKeHH6m3BEMYMPOENr0AssY=
Received: from bjorn by miraculix.mork.no with local (Exim 4.89)
        (envelope-from <bjorn@mork.no>)
        id 1gucfe-0002p0-4V; Fri, 15 Feb 2019 13:32:46 +0100
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Beniamino Galvani <bgalvani@redhat.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qmi_wwan: apply SET_DTR quirk to Sierra WP7607
Organization: m
References: <20190215122042.23195-1-bgalvani@redhat.com>
Date:   Fri, 15 Feb 2019 13:32:46 +0100
In-Reply-To: <20190215122042.23195-1-bgalvani@redhat.com> (Beniamino Galvani's
        message of "Fri, 15 Feb 2019 13:20:42 +0100")
Message-ID: <87pnrtut8x.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.2 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beniamino Galvani <bgalvani@redhat.com> writes:

> The 1199:68C0 USB ID is reused by Sierra WP7607 which requires the DTR
> quirk to be detected. Apply QMI_QUIRK_SET_DTR unconditionally as
> already done for other IDs shared between different devices.
>
> Signed-off-by: Beniamino Galvani <bgalvani@redhat.com>

Thanks. Looks like it's time to consider applying this unconditionally
to all devices.  Feel free to propose something like that the next time
this issue comes up.

Acked-by: Bj=C3=B8rn Mork <bjorn@mork.no>

