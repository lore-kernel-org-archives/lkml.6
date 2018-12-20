Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691AFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365282177E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545304480;
	bh=ZX3E9KLkZSZsJIlGRBHs6DgIyYx6jyueqRFmLMqTX+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xwK+Y1DOYsRANnu+LjMRN3ELj+zA7W+TulKdc9LMGByUGlHJ2Wdg6xJVTBke7G02b
	 xNpu91TrO5f67Bd5uHu3e0SbvHT3nzMUmkVAskdlX+pJujXk2iMID0VKrk2ngh7uTX
	 BWN6krgX+kANxjUKlg2qUUJ4yj3veik8IKsMJTio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbeLTLOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:14:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbeLTLOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:14:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FC3321773;
        Thu, 20 Dec 2018 11:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545304476;
        bh=ZX3E9KLkZSZsJIlGRBHs6DgIyYx6jyueqRFmLMqTX+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZ7qrSEpD/CaMKf6SSCS75j1gH4L1gdw1lpCyPhjgfVrQfu46kJzU4MwZ0qNdZ3H+
         TmXikLU4l+sgfSa6ULD09hryUW7VHhu23HgTfuzQKb6gGW1CBhXqXjXTmWkImEdZFG
         LzJi0IrDRDVcqoXYvolOQOeX2KzpZwGnqdsYW9PI=
Date:   Thu, 20 Dec 2018 12:14:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 3/3] driver core: add probe_err_ptr helper
Message-ID: <20181220111434.GC10978@kroah.com>
References: <20181220102247.4911-1-a.hajda@samsung.com>
 <CGME20181220102300eucas1p210735c7753688a52a73ccf026884dd11@eucas1p2.samsung.com>
 <20181220102247.4911-4-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220102247.4911-4-a.hajda@samsung.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 11:22:47AM +0100, Andrzej Hajda wrote:
> probe_err is useful in multiple contexts where error is encoded in pointer.
> Adding helper performing conversion to error value should simplify code
> further.

Same question as on patch 1/3, please some someone using this.

Also, it's too late for 4.21, so no rush on this.  My trees are now
closed.

thanks,

greg k-h
