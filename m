Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B66ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B68214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B68214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbeIQSvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:51:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:59998 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbeIQSvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:51:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 06:24:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,385,1531810800"; 
   d="scan'208";a="90776628"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 17 Sep 2018 06:23:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 17 Sep 2018 16:23:51 +0300
Date:   Mon, 17 Sep 2018 16:23:51 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: gpio regression in linux-next
Message-ID: <20180917132351.GG19329@kuha.fi.intel.com>
References: <20180917124935.GA26204@kuha.fi.intel.com>
 <9571ebce-d19a-c52f-3273-48dc75168341@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9571ebce-d19a-c52f-3273-48dc75168341@xs4all.nl>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 02:58:58PM +0200, Hans Verkuil wrote:
> On 09/17/2018 02:49 PM, Heikki Krogerus wrote:
> > Hi,
> > 
> > I hit a BUG while attempting to unload fusb302 driver module on my
> > Intel CHT board (GPDWin). I bisected it to commit:
> > 
> >         461c1a7d4733 ("gpiolib: override irq_enable/disable")
> 
> Does your linux-next have this patch:
> 
> https://patchwork.ozlabs.org/patch/969684/

Nope, it wasn't there yet. It wasn't yet in Linus fixes nor for-next
branches either.

> If not, please try again with that patch. If it has, then please let me
> know and I'll try to take a look.

That patch worked! The issue is gone after applying it. FWIW:

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


Thanks,

-- 
heikki
