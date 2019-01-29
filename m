Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE25C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAED20870
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="KqncQ7tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfA2M5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:57:21 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35579 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfA2M5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:57:21 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so4345895itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LDo7uvHFH0ResB8p0NNeSDMW/4YzCyvfKDGArQAkhT4=;
        b=KqncQ7tzJ83Lj0BJFAiaqaPgGjn82ovD6cZDdb5DsvQE6xWgVSIxP8jmsy8klotWkp
         MB+8B/DNUQtpkWBnCiAaeYdABFXbcadXB3lX/rPOt/9zoc86cFxXZBykSMU407Ygpak4
         1fDqtYTNRV+C5eOKosJ1wT/jovh6beAITRH+1WV1DLR0hQRxe3HwgmeoCCVQOb6qWBo3
         ZvMTi4/yAQd/tcy2xo96XZAAXO9Fq1reAphHEz8PEpJSTWQgYH+Zn5ilNZg/T5jrrmTF
         tuRQU828guOYji3GN4ckGifHQqY5RYp4Du4EycQmAjTM2th72xbnb5qVI8ZVj3g4seOD
         UYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LDo7uvHFH0ResB8p0NNeSDMW/4YzCyvfKDGArQAkhT4=;
        b=A4UfeTnNWnO+4eMwn5fymaj6ew51WZG7xhbKbXVEB8DpY/WA02B62o+F9hTY8AHJ3n
         7M0GQZyat0vxTE/B6TQZrHcXP8b9eVI8Qpjg6HdBgSweA4/t7rrFdbTg9mYEmItJ5EaE
         N5PbO4nzCuF1Jdr166oAEAWK2UU8iBeew3peST7J7Z8ziJC3xyYdD3yvqTl8ZyGKVyRV
         C+vRxWOM0QqOoC2SLt71pnYJqcpiW3AWw5CmlU+dwYlklrQdTTKWo8A9qzlsT9CtDNqT
         ixZjdQheE9O1Gg9yRHhIlWgvCsB5JzVDmvyrCPzfXvwuGzc4EdkBpeqovPjgkfbwUg8w
         FDBw==
X-Gm-Message-State: AHQUAua7DTgHT6tkEC5A+jPNVbJHHd9hCrFoZJ7PDrYUxht0EZWks35H
        Sjof44/qxD9g+FCq6oml3+j8oNKFf2k=
X-Google-Smtp-Source: AHgI3Iav6Y7q5oVL5cDUlCiekPttVXl1H/3buQA63d0pEFqllMTURjfeHfwSNTYzDuDpZtIZaUi24g==
X-Received: by 2002:a24:eb0b:: with SMTP id h11mr2666294itj.138.1548766640334;
        Tue, 29 Jan 2019 04:57:20 -0800 (PST)
Received: from x220t ([45.72.135.206])
        by smtp.gmail.com with ESMTPSA id o192sm1843544itb.31.2019.01.29.04.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 04:57:19 -0800 (PST)
Date:   Tue, 29 Jan 2019 07:57:08 -0500
From:   Alexander Aring <aring@mojatatu.com>
To:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Cc:     linux-lpwan@lists.infradead.org, linux-wpan@vger.kernel.org,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        support@enocean.com
Subject: Re: [RFC net-next 1/4] net: Reserve protocol identifiers for EnOcean
Message-ID: <20190129125708.plsbgcpcwhtezgo5@x220t>
References: <20190129050130.10932-1-afaerber@suse.de>
 <20190129050130.10932-2-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129050130.10932-2-afaerber@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 29, 2019 at 06:01:27AM +0100, Andreas Färber wrote:
> EnOcean wireless technology is based on ASK (ERP1) and FSK (ERP2) modulations
> for sub-GHz and on IEEE 802.15.4 for 2.4 GHz.
> 

I am not sure what you try to do here. If I see that correctly you
want to add for some special protocol vendor specific transceiver which
is underneath an 802.15.4 transceiver a new ARPHRD type and even more
for each modulation what it supports?

If it's a 802.15.4 transceiver why not using the 802.15.4 subsystem?

For me it sounds more like a HardMAC transceiver driver for doing the
vendor protocol. The different modulations is part of a 802.15.4 phy
device class. Similar like in wireless.

- Alex
