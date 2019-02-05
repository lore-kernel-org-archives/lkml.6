Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B02DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE3B207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vOQ28/1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfBEQ3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:29:01 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39220 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBEQ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:29:01 -0500
Received: by mail-qt1-f194.google.com with SMTP id u47so4468458qtj.6;
        Tue, 05 Feb 2019 08:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :mime-version:content-disposition:content-transfer-encoding;
        bh=HjIkJD3qTvEXKFWD+xgGyJCRFRHNQeOjkCOjAm2uAvk=;
        b=vOQ28/1gFg7uqq/DRwzRsWTY2BP0SCFDCx3KiU5YHqBYzl/O/z6IaVcUtN+WGJYMhN
         SNrT8forxxjhSC87GtG+LOb+EJOYcS1IEv0K85wXtuGhDeKsBZSq/bzIN9olbWXviwBs
         tl2+6TtNEEsOdfYdpmaG7ewhpdCB33URg0+bgwtpOFOUgKZdhl3MKj9LOfS/yle3fuXz
         ihRoKB89S7Lh+81pIK2CsXl7TJQvMiebImNBKUfmlxRE7xGA/sumFDrgmohAHmvOSjX5
         Yw/RtV2U7xsHYLYv3bZdIP3fyQbnbGAZ3EPGcYhT6/MBdlxQSuLWr4cd5W3+Ado5H2Vm
         e2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding;
        bh=HjIkJD3qTvEXKFWD+xgGyJCRFRHNQeOjkCOjAm2uAvk=;
        b=j5MIghn6w2jxv+lSnqslxWxx9TTqWU8gPgrIwBYYzcP8OId8NB/Xje/XFAPw81GZ64
         RR1ZN5zJObkBojUJzmb3/MaQn+3vL4/PK6LxayPFkiHkxRf7ej+pNEm39+/lpdn70Sdj
         jQ3S5h2Q2o2YpN/fOdG2kf2vnIa9nVMHc2FrTkaMDct+md8K//KNBua+ziFJS1LNofph
         x7MZT/X1twh4X+ym+k2EgJ2glSrN49VrjQ30rVhjx4zdopg6Yh2gTD7ZU/TSOe7/T0Dj
         oKfI8C0uXRnbNlOUjy0YDTBQWhbH74TrwU7WRRZlNL2GhE8E69z1OOmvpvJHHvTkAsQK
         71Pw==
X-Gm-Message-State: AHQUAuYEzUXQ+kRPLumvvhIvAiPe42kkMhVO8k8OYG9NH35l8H1HP+Hg
        WLllrb8LxOjKbXgCuN9Y2ms=
X-Google-Smtp-Source: AHgI3IbbB/qytxwN22O2V9s29pMpdLKVwJmT16HbOqYOse/VygKVIjIJyBQHChQ6ESvxGHByBe4Fhg==
X-Received: by 2002:ac8:7215:: with SMTP id a21mr4131707qtp.327.1549384139555;
        Tue, 05 Feb 2019 08:28:59 -0800 (PST)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id 32sm18499067qto.55.2019.02.05.08.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 08:28:58 -0800 (PST)
Date:   Tue, 5 Feb 2019 11:28:57 -0500
Message-ID: <20190205112857.GB13620@t480s.localdomain>
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Prevent suspend to RAM
In-Reply-To: <20190205110728.11451-1-miquel.raynal@bootlin.com>
References: <20190205110728.11451-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Tue,  5 Feb 2019 12:07:28 +0100, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> +/* There is no suspend to RAM support at DSA level yet, the switch configuration
> + * would be lost after a power cycle so prevent it to be suspended.
> + */
> +static int __maybe_unused mv88e6xxx_suspend(struct device *dev)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int __maybe_unused mv88e6xxx_resume(struct device *dev)
> +{
> +	return 0;
> +}

The code looks good but my only concern is -EOPNOTSUPP. In this
context this code is specific to callbacks targeting bridge and
switchdev, while the dev_pm_ops are completely parallel to DSA.

It is intuitive but given Documentation/power/runtime_pm.txt, this
will default to being interpreted as a fatal error, while -EBUSY
seems to keep the device in an 'active' state in a saner way.

I don't understand yet how to properly tell PM core that suspend to RAM
isn't supported. If an error code different from -EAGAIN or -EBUSY
is the way to go, I'm good with it:

Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>


Thanks,

	Vivien
