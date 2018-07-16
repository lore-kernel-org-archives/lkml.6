Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEE1ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E0520B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdQ7+a6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E0520B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbeGPMiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:38:22 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43126 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbeGPMiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:38:22 -0400
Received: by mail-lf0-f68.google.com with SMTP id m12-v6so32031876lfc.10;
        Mon, 16 Jul 2018 05:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I1oaMkR8XAhH1Lonl4mzvrnqK23EO9I0fdcZMvxCrxM=;
        b=mdQ7+a6OSTWx3EDb41RFbbtZeIsXbiefSJ/aILysuoapBvMtm1EIaPjmspulUajAAI
         9CwNpZUtHDuPTxFHakVx+3bNj5HJ+PXzmwXi+Bzzqx+dHSy0mkP17pOZGEub093cqXrs
         S29a68l1jMMpnGOPuQ1j51tGlTWHKD9QpWLmIJxMC2qkM+/jEHNhgt+CqXTVV1m2Q9kg
         db/Hq1R7aSWwgPO3/PVlHSu15U5nZiibqKNEfZ6HooBw26ZJo/iGem6p9A36vh8BE1aG
         /GGxMH1b9qrFSfdFoTV4RC4x0L4qsfHa6m5hVMtSl+hJksHVzwSahH4CGAcE5UFdBZhE
         9wyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=I1oaMkR8XAhH1Lonl4mzvrnqK23EO9I0fdcZMvxCrxM=;
        b=uFSk8+Pf40pK+mggHeOzHDeE0Qn+a1ua5cbf0MmyrD+nA5UcGZYa0pxcAq96c+tJns
         AFRDFBYIE67Vjvqf6O+gDsBFnM73Uo/ZSWCYjwPjKqD5EAKbxYJ927mU542gndHayAWM
         3Ysl9/OEHaioxVPqC4DTmUo9E/+K2gSrlB514SvOuBsiTWtiV4AFZYGSsahTUMkKp2vZ
         tkAo0O7tfWTtdGV84eNgosd2KQFJzlpz/m7xlAYKHYWy5S3+6UaYuwabeMyWVEVR91ZC
         SvC5nGsJQJ1VbX9kuOewSNNnZSq5h9chEkcFypjmMgq0ZEbH52QYKFvcEn5s+1oIq4y2
         N8SQ==
X-Gm-Message-State: AOUpUlH9gOMlJZPBftCmvmvNHI86qWR5HKF1cEd7YgACLiFT+ZXck1XT
        9slDHv0GR7Arh5ZZihPTJII=
X-Google-Smtp-Source: AAOMgpfUSgY6MMyeQMsHQkrLViFxDPGP8RZgfS8h0Kahhv7S6Vj1ta0/BH6eq4c+G11EJE49bSjorA==
X-Received: by 2002:a19:b2c7:: with SMTP id t68-v6mr10969651lfk.132.1531743071290;
        Mon, 16 Jul 2018 05:11:11 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id a9-v6sm8115348lfi.59.2018.07.16.05.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 05:11:10 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ff2LG-0001LO-EO; Mon, 16 Jul 2018 14:11:02 +0200
Date:   Mon, 16 Jul 2018 14:11:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: serial: mos7720: remove redundant variables iflag,
 mask and serial
Message-ID: <20180716121102.GM10204@localhost>
References: <20180713100831.29120-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713100831.29120-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:08:31AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variables iflag, mask and serial are being assigned but ar never used
> hence are redundant and can be removed.
> 
> Cleans up clang warnings:
> warning: variable 'iflag' set but not used [-Wunused-but-set-variable]
> warning: variable 'mask' set but not used [-Wunused-but-set-variable]
> warning: variable 'serial' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Now applied, thanks.

Johan
