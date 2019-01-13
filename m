Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CF7C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 04:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0029320842
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 04:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XKFEZp2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfAMEPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 23:15:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36460 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfAMEPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 23:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nmFl/uEAqlo3nq4EOSk5n+jO8tNiPVE6ABgNJUh42Dk=; b=XKFEZp2LImrTZjQbAFemcZmpxH
        TW6HuJLKaVutkaP4k5eRjxbpD5nkfLjiPd+lbyc9Ki75dhlGcsucEPSj+EqiaejM0K3CSEdfURvL5
        5+jgN5WmU6xBRe3sQoMMY//9QwEB2RVciAvTrdBQNvqZHYYZC5NKXQ4BAeOve9vTHYUWpeE8svLL6
        PK7J7z2eIxRweqQlDE24twR5Nn28raNFG9D3Jj9Xffkx+qn0sO8UN1bP1ctovqxFmFfvJ/nrSwOG/
        9JKIhVrH3YwkJ+9xCqQxubxOoaXOgeAyAqD52A1hGDDKwtlXivZ0TuM8S9K1RFloNlG2C7x86ZTAw
        qhkFkGtg==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giXBO-0004qd-4H; Sun, 13 Jan 2019 04:15:34 +0000
Date:   Sat, 12 Jan 2019 20:15:32 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Mario.Limonciello@dell.com
Cc:     jerome.debretagne@gmail.com, alex.hung@canonical.com,
        platform-driver-x86@vger.kernel.org, andy@infradead.org,
        rjw@rjwysocki.net, cwhuang@android-x86.org,
        tristian.celestin@outlook.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: intel-hid: Missing power button release on
 some Dell models
Message-ID: <20190113041532.GB1349@wrath>
References: <20190106175644.24872-1-jerome.debretagne@gmail.com>
 <057ab73bef634b4f8c474924eb6db572@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <057ab73bef634b4f8c474924eb6db572@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 03:36:48PM +0000, Mario.Limonciello@dell.com wrote:
> 
> 
> > -----Original Message-----
> > From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
> > owner@vger.kernel.org> On Behalf Of Jérôme de Bretagne
> > Sent: Sunday, January 6, 2019 11:57 AM
> > To: Alex Hung
> > Cc: platform-driver-x86@vger.kernel.org; Andy Shevchenko; Darren Hart;
> > Limonciello, Mario; Rafael J. Wysocki; Chih-Wei Huang; Tristian Celestin; linux-
> > kernel@vger.kernel.org
> > Subject: [PATCH] platform/x86: intel-hid: Missing power button release on some
> > Dell models
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > Power button suspend for some Dell models was added in:
> > 
> > commit 821b85366284 (intel-hid: Power button suspend on Dell Latitude 7275)

I've addressed this one, but please do run checkpatch and correct reported
errors in the future. It checks commit reference format.

> > 
> > by checking against the power button press notification (0xCE) to report
> > the power button press event. The corresponding power button release
> > notification (0xCF) was caught and ignored to stop it from being reported
> > as an "unknown event" in the logs.
> > 
> > The missing button release event is creating issues on Android-x86, as
> > reported on the project mailing list for a Dell Latitude 5175 model, since
> > the events are expected in down/up pairs.
> > 
> > Report the power button release event to fix this issue.
> > 
> > Link: https://groups.google.com/forum/#!topic/android-x86/aSwZK9Nf9Ro
> > Tested-by: Tristian Celestin <tristian.celestin@outlook.com>
> > Tested-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> > Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>

Queued for testing, thanks for the patch.

-- 
Darren Hart
VMware Open Source Technology Center
