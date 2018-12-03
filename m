Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD44C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE9420864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ARpNzQsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE9420864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeLCUsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:48:19 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38930 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLCUsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:48:18 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so10247368lfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 12:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WeSbty5s2StJSZwdlxjqLIoLi6Ov8w7BzLw7TAwCPZA=;
        b=ARpNzQsYBw54I4Ym6PM+mOIQC8yrWpMeASjF4GLJR0r/Y1YXxLArgGTd4p7U4/0kIg
         p3qDN63Yll5rNVpQdraDMLu1Mh0XccZYzEvx2ezLFzFDAlExg6rOsBEhMoMh/2RDFC94
         35vI5pbPXDZmfLVYmlJ6uSbkcJ/898cKc4YwZTV4SmH6NQFNXib9CWLX0C+li505qCjd
         QU9xwVJv89/5f/85FS7WTJO/tV1wGPDiwCx9MUIeD8Raio0+77HcKlaAq8VolOQqWPrm
         Eeg0udyON/i+sNKYq4r4C6eegIJhioyejtO79dXk0gm0tGuTk2uvNUmW4K4Qx97KGS8B
         f6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WeSbty5s2StJSZwdlxjqLIoLi6Ov8w7BzLw7TAwCPZA=;
        b=Q2e1d9I+yQOe3x+FbfzLCPIqRTn/R2JwG6+bfldiEn28D2u6H9io/I3NV9ea/v3XUi
         +UyPlChRc58zb7eEF/JLrLIOegxhIVwd9bPzZwWOg+TmNedFYtXsOhTXj/OuOflooHLr
         9yeS5u5qnwmvwet+MhC77Aw5mfdu3cVblRTnLq4MiFVk1El7ysoXwKs4Gp3+5KQTPlDn
         Afay6IsZ12jwUSxSsceJvrtja+v3FiL7egHvxwFVsy8ayKKnqk9rtdGSL3JpZTVK11zD
         XZtyNnZs6+8M9ozHFe0NOKxHcoq4ipGDrUp7z7wcTFkcbYrEqULyp0+pyLq64nv9HJTD
         pE/Q==
X-Gm-Message-State: AA+aEWaQ8T36Bi3OfknRQ6OU7MZLB5xVY0auOFoBCk9d7evFcJPd5/Xq
        qrEgTuzYHS3gdcldRczxtINru9HLFlk=
X-Google-Smtp-Source: AFSGD/Vaj8TzPH77M4UDok20WtK9JS6aIl+Ep88Ia9Kwkg9E7iWCwS8ZU7He4HhZMQDj1Bk8sleOsA==
X-Received: by 2002:a19:a28e:: with SMTP id l136mr10853292lfe.87.1543870096206;
        Mon, 03 Dec 2018 12:48:16 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id 15-v6sm2933677lje.18.2018.12.03.12.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 12:48:15 -0800 (PST)
Date:   Mon, 3 Dec 2018 12:37:10 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: mediatek: Update SoC entry
Message-ID: <20181203203710.aj4payon4aym7ipx@localhost>
References: <20181016145758.12995-1-matthias.bgg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016145758.12995-1-matthias.bgg@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 04:57:58PM +0200, Matthias Brugger wrote:
> Add IRC channel and URL of the wiki.
> Also add soc drivers folder and regex to catch more
> mediatek components.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to fixes. Thanks!


-Olof
