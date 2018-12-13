Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04152C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA91120870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544717065;
	bh=vNm3IGl8HrzAOOA7gsx7JlgHnn2xu8vJPWMm2RUR/4c=;
	h=Date:From:To:Subject:List-ID:From;
	b=ApusQLlx5ONSNmP8I3S+iTCs6Mai24qY7nEV1jaYDfJre5MF7V5W9cQGaqPfltbeX
	 B7g4QyiR0dd1qXuXrNfpiautLnAB3JdGK2UMkyoaO1qANdnrcIkgCKe1I6+IQ8GZmZ
	 IRDh689fqAWyqQwqbd415pB1RORrqCYaMXUM0WMQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA91120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbeLMQEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:04:24 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40546 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeLMQEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:04:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id k12so2673861qtf.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 08:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CZwOGaHwUDkVEbcDFvtxWXvjlRfbgrLVnKNlDbbMUR8=;
        b=gWsqOd73l3YdTgcpSpPGL6tvOkMvu/pI0wGYYW5g54p2cD3HMClcdEptQV4GYZO577
         vydHROpGc101RVPoVwngqfDoSBT9IrFOGNlQtyvksxemugQrSB39ayd10J0dXnaXIR56
         v7CakjwRcFJzV8HaOaBL3asUbN+eDyoUe1M1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CZwOGaHwUDkVEbcDFvtxWXvjlRfbgrLVnKNlDbbMUR8=;
        b=i54RNGEd72ISjrENULkBm5yowqaql1YXxSWztHXfKKLrt3HuuwRwdHxUqZE4fs9uE0
         wtpL4tX/uz5qUgnDpfdk3no6cBKvrkkW+GNOX/O9lJcnwss//izcirvmp/ZNKwz4ph3O
         NniMf1hgQpqxYumJUg6ZxGrWeTuzh3MrlMkyppeZz4slL7EOfeu0XZ3CEwzR7DgjgxzZ
         8TqoY1D+R3t2vy8iCyJuOwbIb38nTs5LH4VEtfaYrgNiM87SN2GitLEqoKKLUT8U3Wom
         0524EuwnxML4jm8vnB3qfZy85EH1G8nOAt46L+3zyl3NAaHdw5iHFYSKHIVRKp1brBFe
         Y7nw==
X-Gm-Message-State: AA+aEWZBVektichng1j+B8f115RqkvqOCvj3M3QbWrjnuzdIEaAwDgjT
        EMlne816w7bFfvMmVTMywZ+cKCuTyTRQ0yj4
X-Google-Smtp-Source: AFSGD/W2BJVtFfWVtnMVPdNxe3w2QWpgCGsQhQTwX5kDWrO+hET/6J5vBdQnJiVQAm/gMQ2AmzLOPw==
X-Received: by 2002:aed:3bb8:: with SMTP id r53mr24150096qte.77.1544717062109;
        Thu, 13 Dec 2018 08:04:22 -0800 (PST)
Received: from pure.paranoia.local ([198.144.156.49])
        by smtp.gmail.com with ESMTPSA id i65sm1883950qkh.49.2018.12.13.08.04.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 08:04:21 -0800 (PST)
Date:   Thu, 13 Dec 2018 11:04:19 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Subject: Get notified when your patches are applied to linux-next or mainline
Message-ID: <20181213160419.GA13001@pure.paranoia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

We are trialing out a new feature that can send you a notification when
the patches you send to the LKML are applied to linux-next or to the
mainline git trees. If you are interested in trying it out, here are the
details:

- The patches must be sent to the LKML (linux-kernel@vger.kernel.org).
- One of the cc's must be notify@kernel.org (Bcc will not work).
- Alternatively, there should be a "X-Patchwork-Bot: notify" email header.
- The patches must not have been modified by the maintainer(s).
- All patches in the series must have been applied, not just some of them.

The last two points are important, because if there are changes between
the content of the patch as it was first sent to the mailing list, and
how it looks like by the time it is applied to linux-next or mainline,
the bot will not be able to recognize it as the same patch. Similarly,
for series of multiple patches, the bot must be able to successfully
match all patches in the series in order for the notification to go out.

If you are using "git-format-patch", it is best add the special header
instead of using the Cc notification address, so as to avoid any
unnecessary email traffic:

    --add-header="X-Patchwork-Bot: notify"

You should receive one notification email per each patch series, so if
you send a series of 20 patches, you will get a single email in the form
of a reply to the cover letter, or to the first patch in the series. The
notification will be sent directly to you, ignoring any other addresses
in the Cc field.

The bot uses our LKML patchwork instance [0] to perform matching and
tracking, and the source code for the bot is also available [1] if you
would like to suggest improvements.

[0] https://lore.kernel.org/patchwork
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/git-patchwork-bot.py

-K
