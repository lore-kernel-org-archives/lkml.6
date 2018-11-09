Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978CDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDC520825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEE7Wzym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDC520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeKJCKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:10:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbeKJCKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:10:14 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20A6E20825;
        Fri,  9 Nov 2018 16:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541780937;
        bh=X8oSKXWD88o7ViU80aO6xOshsClFN7D2qZncz2qfpEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UEE7WzymIiP5xPs9nQDkPNQUg0WhOJuJ/Fm8DjH8YVPs3/MlWGPeSlHbayR684YWQ
         375odOwrBFrmvXIKW4BzRqKhoxiiBsEv8qWzz6jQIwboZPnNNDdd3v7A8ysEEulSVW
         xocV1PLn5iByDeHqb68JfyNJ6MMOZBx+UVGtKeHA=
Date:   Fri, 9 Nov 2018 08:28:56 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guillaume Nault <g.nault@alphalink.fr>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.4 063/114] l2tp: hold socket before dropping lock in
 l2tp_ip{, 6}_recv()
Message-ID: <20181109162856.GA2407@kroah.com>
References: <20181108215059.051093652@linuxfoundation.org>
 <20181108215106.791041209@linuxfoundation.org>
 <20181109153332.GD1415@alphalink.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109153332.GD1415@alphalink.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 04:33:32PM +0100, Guillaume Nault wrote:
> On Thu, Nov 08, 2018 at 01:51:18PM -0800, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> This patch was partly wrong. Here is the followup fix:
> 94d7ee0baa8b ("l2tp: hold tunnel socket when handling control frames in l2tp_ip and l2tp_ip6")
> 
> Both a3c18422a4 ("l2tp: hold socket before dropping lock in l2tp_ip{, 6}_recv()")
> and 94d7ee0baa8b ("l2tp: hold tunnel socket when handling control frames in l2tp_ip and l2tp_ip6")
> should be applied/backported together.

Thanks for letting me know, I've now backported this as well.

greg k-h
