Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F62C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2CA21557
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E8nTP8xG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2CA21557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeHWW2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:28:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59764 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbeHWW2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ufRSi3ui1X0UDUEaPQ/Cas/w6NU4n4AllTvL1i0R1Pw=; b=E8nTP8xGuLt0XcZ4Q/hsiloxR
        ljTE8Vohz6NbyGkT5RDvLLiJKIDtWHQHjPmkuk+U7UKQb5QMTVLVkgsMANOL6Q0UeiD/WZJXIIIfB
        dNsI/Vf39Q3LrFGqQNDhjCdywsPCM9n7oXIUu2sAt6AkgXbXm5WI2QTawZW18nqUphWNQdtfUmxw6
        vG8DK5HbOZt+yjrIsr45aHXaTKkRdmTEQxz3yHzpUnOSNIt8A1dLrYiJJ5LcNs2nfIYnv+K8t8Omw
        YkJSJJlE/LOtqsfl5+CyOwe5tmWZNpoDbTP54sePJj21R44pDV/iZegA6Z0GSfR2EWTQkmX2UaOlC
        rOSgGCm+Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsunK-0002Zu-Jq; Thu, 23 Aug 2018 18:57:22 +0000
Date:   Thu, 23 Aug 2018 11:57:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Harry Cutts <hcutts@chromium.org>
Cc:     linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jiri.kosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/3] Add the `REL_WHEEL_HI_RES` event code
Message-ID: <20180823185722.GA24777@bombadil.infradead.org>
References: <20180823183057.247630-1-hcutts@chromium.org>
 <20180823183057.247630-2-hcutts@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823183057.247630-2-hcutts@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 11:30:55AM -0700, Harry Cutts wrote:
> +  - If a vertical scroll wheel supports high-resolution scrolling, this code
> +    will be emitted in addition to REL_WHEEL. The value is the (approximate)
> +    distance travelled by the user's finger, in 256ths of a millimeter.

Is it too late to change this to an actual unit like micrometres?
