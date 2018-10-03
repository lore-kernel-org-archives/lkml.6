Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E959C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED61921473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnd2C2IV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED61921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeJDFUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:20:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40051 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeJDFUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:20:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id z204-v6so6259926wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 15:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W49xGT5ZZv4KaWeWKBLBTSp3nBedVN4ea3KetCBl3iE=;
        b=tnd2C2IVVbA4VueLUn2WvPstFaR1FcCKeo3YbGftGqZrF//u6z2glUx+DDR+eQxYK3
         knu/rjRTi2CIev8G4OdmSfTG3O51NV6+LMPiE+SAiOZn7uULswo3+KWq5pxWWV6dxLzn
         6Jiv48SWt+wJjHZRu6kDnCBWm2A49pjJm2qHjlcV+a8YdOLb5ZXckPjZpM8U0aj96ejF
         FZG+A4Ikw5aJMIWx5kvDoVlU1olbEG2Cwb13hK282M0IVflcK+exOB7RSJObZQaNE4Nm
         JXg0emINa6+cO/7fCuE5oBR2yXBz8mAhQ489rmMOBhoNHgGZzOf3qqFCrbx3aSW0uyf6
         VkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W49xGT5ZZv4KaWeWKBLBTSp3nBedVN4ea3KetCBl3iE=;
        b=GnUeN2nLnCyJpH36KDKsFbuGP1TmD2dxxRDrjgJJM67G5bgWaAjO4DUEKvG4vY1AiX
         GXrqdjP0jvs2Ytz6zxe4at17D7FJ/lFotJ9WC0GbQZlHq9MR5JoQ1OQXo6GxEUUAHeyM
         aeHmpEMvdFNx2WIpoFpNdaDCHWPvG4UK30+O6+mNaOfn4pFsu5kMbgFnoDcnSGE8ixvn
         lLMKveelkX4xPp8QP45zO0XMIzK9biLHrGwyPmcygS+z0NNHjTD8t97tErmb5hPGbA3F
         8jaVTjINsmvrA5h9SLqrGDHDRrPnXt5vrHucLzzzLqhblyLIr+TQ041lWC/ch5c2OLeP
         LChA==
X-Gm-Message-State: ABuFfohBSU9W99j/6WJVNfZtQv8rsBWgqCmfuSbZ3/Bl4MYXs8qQfXQU
        Ax4g5GNwyr/+GpgqXv2o3Vs=
X-Google-Smtp-Source: ACcGV63Btmqea+GMqk4h2Li3Y7tIv2QfqrUDNbuyb8UVhSFVHIXUHXzD9pAIxG8lP/VXFKajkFlwdQ==
X-Received: by 2002:a1c:7f93:: with SMTP id a141-v6mr2692380wmd.45.1538605795203;
        Wed, 03 Oct 2018 15:29:55 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4027:2900:4590:ed25:8bd:64c7])
        by smtp.gmail.com with ESMTPSA id 12-v6sm3937305wms.11.2018.10.03.15.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 15:29:54 -0700 (PDT)
Date:   Thu, 4 Oct 2018 00:29:52 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christopher Li <sparse@chrisli.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: Sparse warnings from calls to max3() and max
Message-ID: <20181003222951.5vp47nf5x7ipyyi2@ltop.local>
References: <3afaa0ad-33a1-33d1-f306-8e0e467936dd@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3afaa0ad-33a1-33d1-f306-8e0e467936dd@lwfinger.net>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 06:44:39PM -0500, Larry Finger wrote:
> Hi,
> 
> Sparse has suddenly started issuing as many as 11 warnings of
> "expression using sizeof(void)" for each call to max3(). There are
> similar warnings for calls to max(), thus I think this is the origin
> of the problem. My sparse version is 20180324-1.3-x86_64 installed
> in openSUSE Tumbleweed. My kernel is 4.19.0-rc6.

Hi,

This problem is resolved in a more recent version of sparse,
the one you can find at:
  git://github.com/lucvoo/sparse-dev

See Linus' email about it:
  https://lore.kernel.org/lkml/CA+55aFzYEnZR2GZLR-DwpONjMNYGYoDy+6AWLCVNayWiaZuqoA@mail.gmail.com/T/#u

NB. The official version hosted on kernel.org is not uptodate but
    I hope this will solved in a few weeks.

Best regards,
-- Luc Van Oostenryck
