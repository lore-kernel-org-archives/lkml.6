Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC73FECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8558220BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyDbJ3tH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8558220BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbeGPMn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:43:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34921 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbeGPMn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:43:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10-v6so24329581ljg.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 05:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=taiDCw19wC/JQ0xN8qoruEquAKpOsBVLjjQxR4SDE9Y=;
        b=fyDbJ3tHiX/kN3TK7+Z91V4fvjQOgnVGxLd6O6yzc/Z/oRdSvu6AzJX2JaQ+rozB1U
         6Y0eGpX1/56thtJu/T/WB40PW/HeGGGewYzk91L2Cb2PoLY5eHEhsvZh/rpUbxgBeb8u
         PHBhxBX4clKa+aHhWuHH1sOUu0A788W0k1ClRCuGn+zn48ZQk/NbkdAcm8VP+8FVWsz1
         18ODiK0UREzSQA+VtAz3WNXz9hHm0A0P1KZxXLxv5pu/2kg0hgVqi7K+hpynUsFrat8U
         uy4sOLgufLiV69D1S7ZvEceUBO5BpC4PUXRu0GNUDklabmnNdASZUa1oaM6KPmxRWWLR
         okjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=taiDCw19wC/JQ0xN8qoruEquAKpOsBVLjjQxR4SDE9Y=;
        b=TqMX6x28k8onC/IA5+W1VP2ARnHJL/4Zpvvsz4r2/MNcN6WXZ34OT/slVW0zNQPuPo
         Ht9KjWBIx+b4Wv8E7x8IBL1QqXnIZs1JPRCYBwflojcYJ5FVgD1sLz+Bwy3ZEAOfqy8Z
         iDPFdILTYEJVwzIXoMJdBkWhYxL6tWiDcLIkTsTcZXOUNIu3RNianmVamYWooytiaX3E
         9Nzf79XsRi20gcMI2jC8NO8bD+HU7ST/JZpZB+Ul1TQmA+2zL0THg4e3WFmsVVM+Hr1N
         +6Im9Vz7zrEO8APehpgVWzdJ9knENIBA8H8tYooHTofcAfLLF+nzbN9Fqi0ueEgfwPAV
         9j3A==
X-Gm-Message-State: AOUpUlG7nCbZkdx3sUa6COm57OexI79MkfiEt+ZX7Rbhz90XH6ep2Rx9
        b+MJtqQXAHo9Fak/Hagte1+x0YtU
X-Google-Smtp-Source: AAOMgpdWywJJviP1FNqlsRU8qKQ0I95cwnKoYgQ1hFX1SN6evDnOeQlkvu18DHeiY1V7ad+SB/tOig==
X-Received: by 2002:a2e:8257:: with SMTP id j23-v6mr10586406ljh.49.1531743407247;
        Mon, 16 Jul 2018 05:16:47 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id j10-v6sm2715648ljb.33.2018.07.16.05.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 05:16:46 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ff2Qg-0002SP-Gp; Mon, 16 Jul 2018 14:16:38 +0200
Date:   Mon, 16 Jul 2018 14:16:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] gnss: fixes for char-misc-next
Message-ID: <20180716121638.GO10204@localhost>
References: <20180716104203.28440-1-johan@kernel.org>
 <20180716104845.GA18483@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716104845.GA18483@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 12:48:45PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 16, 2018 at 12:42:01PM +0200, Johan Hovold wrote:
> > Hi Greg,
> > 
> > Here's a resend of two gnss fixes for char-misc-next which I noted you
> > haven't picked up directly (I'll continue picking these up an forwarding
> > to you in batches if that's alright).
> 
> That's fine, I didn't see them myself, which is why I didn't pick them
> up.  I'll just wait for you to forward patches on for this subsystem, as
> that makes things a lot easier for me.

Perfect, thanks!

Johan
