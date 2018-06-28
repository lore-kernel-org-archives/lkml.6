Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670DEC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 00:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A222563C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 00:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLo7hCaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A222563C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeF1AuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 20:50:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752538AbeF1At7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 20:49:59 -0400
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A340255D8;
        Thu, 28 Jun 2018 00:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530146999;
        bh=qpYITmQbw3uOwDWcbc9s9xUin0QrdKIqedPPYK6xdL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TLo7hCaDv/p1hsca2I4BkIWoDzMnGxjIRavGKb0fnNMj/N8mkywjNyW4SHCE4FOaR
         GIKWsU0c7oiqYZTX9O7jFCsKSjk7Qn4GCzwwnXfTL2WClYYFaiZzCMIkcRPzTepQEO
         V0Yc5a3BHz4tzmT3ZEOAriKCAOTrlW4nJcQcYqFg=
Date:   Thu, 28 Jun 2018 08:48:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] cpufreq: imx6q: check speed grades for i.MX6ULL
Message-ID: <20180628004837.GB22683@dragon>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
 <20180611053826.GC16091@dragon>
 <2d63a25f-7265-7aa7-a7dc-fd2379240804@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d63a25f-7265-7aa7-a7dc-fd2379240804@armadeus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 10:01:44AM +0200, Sébastien Szymanski wrote:
> Hi,
> 
> On 06/11/2018 07:38 AM, Shawn Guo wrote:
> > On Tue, May 22, 2018 at 08:28:51AM +0200, Sébastien Szymanski wrote:
> >> Check the max speed supported from the fuses for i.MX6ULL and update the
> >> operating points table accordingly.
> >>
> >> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> > 
> > Acked-by: Shawn Guo <shawnguo@kernel.org>
> > 
> 
> Thanks, but what about the two others patches ? Now that patch 1 is in
> 4.18-rc1, should I resend the two others patches ? Should I merge them
> together ?

Yes, please.  That's what Viresh and Stefan were asking in the review.

Shawn
