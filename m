Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A3DC6C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A845208C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LMhfE16s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A845208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934318AbeFLOv2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:51:28 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:40707 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933228AbeFLOv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:51:26 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7F6DD1E04F8;
        Tue, 12 Jun 2018 16:51:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1528815084; bh=OSD9rGKKDdqajB/yyXAoLqFcDI2wqN2iGsuiVSpqL9s=;
        h=Subject:To:References:CC:From:Date:In-Reply-To:From;
        b=LMhfE16s493V4EPc5Ii1msUb47HGp67l+xwVFp1aZo3Dcy8rkTzeAILttRzpGLQCS
         ulcZBDaUHLIOWNZmf6TTDqFFZ6SA0h4njnclOz7sSgKh/kuT4IfrJHJ9d7gKwamxbZ
         x7iMV8P+3YoYITfL8OXDOUNWUe3ogWEKLu4YG7nh91+1X2yneYEqmcLdyiUENKNYns
         C3yTEJRFStQcXCGYbiEsP3UBZaLK6/L5dk0qAB4eMDDKwZ6+6rQwfzszOzFo5HGPmu
         MscwbL8vZNdskD8lEsxWU0UB1mWv1laTs6l6X0gkQRNhz5Q6H/mH6E5svvtvSXoTbC
         FrwxcY6z36Aug==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3CC433F09;
        Tue, 12 Jun 2018 07:51:22 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 12 Jun 2018 07:51:22 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 12 Jun 2018 16:51:19 +0200
Received: from [10.0.2.15] (10.107.19.20) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 12 Jun
 2018 16:51:19 +0200
Subject: Re: [PATCH 3/3 RFC] Revert "net: stmmac: fix build failure due to
 missing COMMON_CLK dependency"
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S . Miller" <davem@davemloft.net>
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
 <1528706663-20670-4-git-send-email-geert@linux-m68k.org>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-m68k@lists.linux-m68k.org>,
        <linux-mips@linux-mips.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Jose Abreu <Jose.Abreu@synopsys.com>
Message-ID: <1a1f3bea-1680-ce1c-09cb-0d5e2b4531d1@synopsys.com>
Date:   Tue, 12 Jun 2018 15:51:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1528706663-20670-4-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.20]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-06-2018 09:44, Geert Uytterhoeven wrote:
> This reverts commit bde4975310eb1982bd0bbff673989052d92fd481.
>
> All legacy clock implementations now implement clk_set_rate() (Some
> implementations may be dummies, though).
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>

This seems okay by me. You can send a non-rfc patch with my ack
once other 2 patches get accepted:

Acked-by: Jose Abreu <joabreu@synopsys.com>

Thanks and Best Regards,
Jose Miguel Abreu
