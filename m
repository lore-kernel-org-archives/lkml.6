Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D68FBC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EB32089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EB32089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754451AbeFLVw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:52:59 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:43130 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754400AbeFLVw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:52:57 -0400
Received: by mail-yb0-f194.google.com with SMTP id w3-v6so179829ybq.10;
        Tue, 12 Jun 2018 14:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n6EHG+wUPmlNdA+PlCwEraU5MSYtCyQozI0P8NHcLgo=;
        b=iT86Rj0p4Rll7U8SYniLVimC2ZeN1AGffTrWcV5Nc1edfYlws8MS/ujhDnZnbgi19F
         o2UPtZH9C6Jj22Sin8d0elA3Z9sgB4aq631DXCgqRjkU1LZ0NTusSriIASd+TQ4XKyfK
         KNQDIoMevC82PkUanKRTIiqUvdTDnQv68xBO0+kKqhdK3gCSAECy/HCGT47DnuV7tciW
         lIsGqECz7taqDkG9F2nf7+/ssrYjrRDjbGJTL1cY5vp27NDE9TG+eNvsh7jJjksvK5Yi
         rkpgGtU+qrQCtlxLtcWrUAPVEstiT7WnRGC7gFPSji7eoSx4fgBTcJ3WMUz0MbETj668
         0vEw==
X-Gm-Message-State: APt69E0JHWs0O0SQ+w3HoFXprB3IgglwxWlB66mp/XTlvyKaFeW6/qeE
        0HhRwMv9vokMz1xh/OiXzQ==
X-Google-Smtp-Source: ADUXVKIx5Yer4WMp+E+FwmD3ARHoUBjeNywmd6SxtK1ZwTWFsyXHPvlYXVW9fRBco70umEMKI83TwA==
X-Received: by 2002:a25:4a44:: with SMTP id x65-v6mr1124431yba.190.1528840377109;
        Tue, 12 Jun 2018 14:52:57 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id c134-v6sm581459ywh.14.2018.06.12.14.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 14:52:56 -0700 (PDT)
Date:   Tue, 12 Jun 2018 15:52:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <monstr@monstr.eu>
Cc:     devicetree@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, SZ Lin <sz.lin@moxa.com>
Subject: Re: [PATCH] dt-bindings: Add bitmain vendor prefix
Message-ID: <20180612215255.GA5774@rob-hp-laptop>
References: <20173c07cc538544c9e6780a8ef558b97a3fe2cb.1528289384.git.monstr@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20173c07cc538544c9e6780a8ef558b97a3fe2cb.1528289384.git.monstr@monstr.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 02:49:48PM +0200, Michal Simek wrote:
> Bitmain (https://www.bitmain.com) is a vendor of cryptocurrency
> hardware.
> 
> Signed-off-by: Michal Simek <monstr@monstr.eu>
> ---
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied.

Rob
