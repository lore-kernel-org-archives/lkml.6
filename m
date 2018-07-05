Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D4BC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6406240EF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6406240EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbeGERxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:53:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43612 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753405AbeGERxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:53:46 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3B1F0D1D;
        Thu,  5 Jul 2018 17:53:46 +0000 (UTC)
Date:   Thu, 5 Jul 2018 19:53:43 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pascal PAILLET-LME <p.paillet@st.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH 2/3] regulator: core: Link consumer with regulator driver
Message-ID: <20180705175343.GB29378@kroah.com>
References: <1530800748-7300-1-git-send-email-p.paillet@st.com>
 <1530800748-7300-3-git-send-email-p.paillet@st.com>
 <20180705165351.GD6227@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705165351.GD6227@sirena.org.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 05:53:51PM +0100, Mark Brown wrote:
> On Thu, Jul 05, 2018 at 02:25:56PM +0000, Pascal PAILLET-LME wrote:
> > From: pascal paillet <p.paillet@st.com>
> > 
> > Add a device link between the consumer and the driver so that
> > the consumer is not suspended before the driver. The goal is to avoid
> > implementing suspend_late ops in regulator drivers.
> 
> This looks good but I'll wait for Greg's review of the link
> functionality - Greg, is it OK to apply this via the regulator tree or
> do you want a shared branch?

You can take it through the regulator tree, no objection from me:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
