Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7AFC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094E32183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2791II8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfAHAqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 19:46:10 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:37371 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAHAqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 19:46:10 -0500
Received: by mail-pg1-f175.google.com with SMTP id c25so910342pgb.4;
        Mon, 07 Jan 2019 16:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Snvh6Ow7n3uk2POMbNVXitzrCaFvEq04lk3zzwRJXcM=;
        b=k2791II8ShxWskzTaqJFueGmHUnsV3hTJ9t40Qse9ilQTsVofbhtEJ94ddNVe9+LpV
         rtGE3goxE6psxRjGldEhbjdas2sfdqjBmfrOz9WK97Zbgp8N9IE6sI436s/spRDvMUs7
         jTLFRa4fBUJDqvhS2bMj+Qo+VRhAxc5TEOZCXUNb+34gGIEogLGs2xiOaEy4piYyM0dX
         dS5hiJ+qH7xH4q3QIZ5DvIfDUZjTPDvXVIs37Ryvx+aYUhejLIa7eI0lPlEqXiYebyYp
         FWKUFzQAlf9jeupGHGaLZRrZFpe5r2gACvZ8f0JpbC5GySJD7t685Nsr0sRSHhmRkOSf
         0E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Snvh6Ow7n3uk2POMbNVXitzrCaFvEq04lk3zzwRJXcM=;
        b=dgs9V8wl8MiQWSPYa1xNMqwFoNrNAHlzDdzw4xR7Wzeu6t96f0ErmdEZRdZ1Fp92ME
         X50LAykSKBcJl1nW/8g7fPJRRyzRII+zgkXH3+rkVq0B7pupSKU8HCRp4a1KBTnrsbU+
         1BA+C+zdTha9JZecUl6XFid/FNGpQSlROFFwvNS3QTc8/kzdgyHOfOgiR5/n35YBtO65
         gBv5L/NYaO/s/P24oNinCNsAuQXTmXu2Gcyl/uN0ebMwTCCXbUkx5k/N9epOhCou6rRE
         ASjDEBaDrH1cJZQI2muS+Dfu4PFjmCxTEBTUYMjPCIV0bAXx7BiEV4xZxWXJL3pnQZsp
         EPxQ==
X-Gm-Message-State: AJcUukdC8sNxtaxP1sCkQ1u+pKNR8cDkIq3NAY45BYZh0pOYwuLUgAZf
        1+mBUW4DIagI8PJ4bl7zEI8=
X-Google-Smtp-Source: ALg8bN7FwyZJ+F8saacMoC6xj3PEZJIeLQtbbJHC4h+w/z0VHqR6O8Rn+Ysbbg76HUWDrLX+w9rF/Q==
X-Received: by 2002:a63:db48:: with SMTP id x8mr12397898pgi.365.1546908368876;
        Mon, 07 Jan 2019 16:46:08 -0800 (PST)
Received: from icarus ([2001:268:c0a3:b52b:e409:8f0c:a3eb:73df])
        by smtp.gmail.com with ESMTPSA id v190sm97819675pfv.26.2019.01.07.16.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 16:46:08 -0800 (PST)
Date:   Tue, 8 Jan 2019 09:46:32 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Patrick Havelange <patrick.havelange@essensium.com>,
        Jonathan Cameron <jic23@kernel.org>, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        akpm@linux-foundation.org
Subject: Re: New IIO/counter driver
Message-ID: <20190108004632.GA3247@icarus>
References: <CAKKE0ZHmODzhvjPNJFVgT2cF_F=f2kNKr5K_CGP+0XgA5XZokw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKKE0ZHmODzhvjPNJFVgT2cF_F=f2kNKr5K_CGP+0XgA5XZokw@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 02:45:37PM +0100, Patrick Havelange wrote:
> Hello,
> 
> I'm in the process of adding a new IIO/counter driver, however I also saw
> that there was a work in progress to have a separate counter subsystem (
> https://marc.info/?l=linux-iio&m=153974167727206 ). But it seems there is
> no recent progress on it.
> What is the state of those patches ? Is it still interesting to develop the
> driver as an IIO/counter , or should I use already that new subsystem ?
> 
> Best Regards,
> 
> Patrick Havelange.

Hello,

I am still open to merging this patchset and maintaining the Counter
subsystem. However, I took the lack of response for my latest
submission to indicate a loss of interest in this patchset's approach.
If there are still people who want this, I can rebase and resend this
patchset for submission; the past few versions have primarily been code
clarity and documentation changes so I believe the core design itself is
somewhat stable now.

Just let me know how best to proceed and I shall be happy to oblige --
whether to continue maintaining this patchset or to drop this design in
favor of improving the existing IIO Counter code in the kernel.

I'll CC those from the patchset submission to keep them in the loop.

Sincerely,

William Breathitt Gray
