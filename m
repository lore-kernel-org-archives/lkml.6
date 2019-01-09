Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016D8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFC420656
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fypCDyvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfAIRoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:44:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfAIRoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ynpK9FWBLnSVfxjwkp1TxuFh20LWPUwlbx17NG575Lg=; b=fypCDyvW1Abpuw96jt2RgrOzE
        MS+EEaLtOtVXIq8f15M8UrNecjPAVjfVTVFSqA2Tlh9xu3y6TX7hnYkh6QJQgaUN1mvJSzXfHywbK
        +5F1NhvmhJ+BlZXvnc4byQDiCdYu+cZfzSBnWqqJRCtHVWVX+kIfsi/wMIUn8QFh6m/i7vf+6Eior
        JectG7Qv9akSgc+vX8CYhWuMnmInhpdZy3xrasoVOJIpchGtgxsaje1/6WCSZVsSpji7F+K/mpe9G
        S2LeCCDmuejYRP+CmWZXix2t2db/+/bC/m2UcVgSZOx3u0RNCbNL0cj6t9JaL0oIDH6aEChlQbO1U
        STk1oTrzQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghHtb-00084u-Vy; Wed, 09 Jan 2019 17:44:03 +0000
Date:   Wed, 9 Jan 2019 09:44:03 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 0/4] /proc/stat: Reduce irqs counting performance
 overhead
Message-ID: <20190109174403.GN6310@bombadil.infradead.org>
References: <1547054628-12703-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547054628-12703-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:23:44PM -0500, Waiman Long wrote:
> This v2 patch optimizes the way the IRQ counts are retrieved and computed
> and getting rid of the sysctl parameter altogether to achieve a performance
> gain that is close to the v1 patch. This is based on the idea that while
> many IRQs can be supported by a system, only a handful of them are actually
> being used in most cases. We can save a lot of time by focusing on those
> active IRQs only and ignore the rests.

So your reaction to being told "Make this the same as every other thing
we have to sum across all CPUs" is to make it _even more different_ and
special-cased?  I'm done.  NAK.
