Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959BFC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601ED2133D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547477597;
	bh=3nSDAHdO/9VHTp9lyQ9IizE2vjPvoC7evUDy01LwW3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MCqEjcDqz0Fyf2pjP9/ouHGabt51wltNqcBgd+n/XD2uqruY06Kcnpn9N6l3iqZEV
	 acDWucdTVtSJuYfPHtWaa8VYjKHIXFW4w60/vunt2I7vMopljDKEU6tbXcdQNmH2wB
	 qwgZlMH+s7DIcQiRgnEz4vY5JPiW9tPeS0AK4+wY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfANOxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:53:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbfANOxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:53:14 -0500
Received: from localhost (unknown [178.227.249.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FBA120657;
        Mon, 14 Jan 2019 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547477594;
        bh=3nSDAHdO/9VHTp9lyQ9IizE2vjPvoC7evUDy01LwW3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CaOz6mnlpkuCo52uZUTeE4fxZ92uKqCQnYUkVMM07OqMtvBPFmHGxNU/v1KdJZNr7
         hJpsvBtcEocU0Xzd8kIG5/5KWo+wVCY483xIVYA/0FSJLakSDmlRombNM7A1FWv6sd
         Bb5Ph+yf+9YdSROsgurxD15p0PaGf2ujf1aIRTl0=
Date:   Mon, 14 Jan 2019 15:53:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/4] slimbus: minor fixes.
Message-ID: <20190114145311.GA14821@kroah.com>
References: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 01:44:45PM +0000, Srinivas Kandagatla wrote:
> Here are some minor fixes to slimbus core for issues found while testing wcd9335.
> First one is make the slimbus core match full device id,
> second one is to avoid using big lock in status callback function,
> third one is to use status function rather than directly invoking the status ops.
> finally last one is to fix missing spinlock init.

Should all of these go into 5.0-final?  backported to any older releases
as well?  Or can we wait until 5.1-rc1?

thanks,

greg k-h
