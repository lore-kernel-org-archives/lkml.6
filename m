Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD7BC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBD32089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u+1vJBnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBD32089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbeJQBHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:07:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbeJQBHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XGpHNrfXXzTHM7z82i3czex6Bn3a96pylayefEh/l5o=; b=u+1vJBnF07yHNgYbESo2t0SO6
        +dOZwAECGPlg0jGA76+GVVdndFWeb6U0ELpRvlHlv5MpZ6eaWuKADtG1HkgSLhYd+bjCy3Ixk2+fn
        QrbwHSfK/hoIXDWqqlqB93kox+xRgAeT5bQDNGrAWNifa+w/Tpc/ak3kq7tx2qXDcgg01NcsYX5E/
        v8KMk3Owys3/U9DSlQyGvseU9/wYRz/yZM/59JVp7qtaXuMiSyLl3/VWwZhAMOGC9g+7zkf8rzjdz
        Xv2dCkUjqy91vih7Y/490kgeAvLug5/daCtmNEa5juGCOJRznAGsZIDQiz2Q1hcYiM9WhTXlMfkBf
        SpWL8rLtA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCSwy-0007jd-Lv; Tue, 16 Oct 2018 17:16:08 +0000
Date:   Tue, 16 Oct 2018 10:16:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [GIT PULL] IDA/IDR fixes for 4.19
Message-ID: <20181016171608.GA19184@bombadil.infradead.org>
References: <20181015204017.GA10953@bombadil.infradead.org>
 <20181016165632.GF9547@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016165632.GF9547@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 06:56:32PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 15, 2018 at 01:40:17PM -0700, Matthew Wilcox wrote:
> > 
> > Hi Greg,
> > 
> > I have two tiny fixes, one for the IDA test-suite and one for the IDR
> > documentation license.
> > 
> > The following changes since commit f0a7d1883d9f78ae7bf15fc258bf9a2b20f35b76:
> > 
> >   afs: Fix clearance of reply (2018-10-15 15:31:47 +0200)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.infradead.org/users/willy/linux-dax.git ida-fixes-4.19-rc8
> 
> How about you at least test these in linux-next?  Putting things on top
> of the most recent change is a huge tip-off that this branch got no
> testing :(

One of the two changes is a comment line in a doc file.
The other has been tested by 0day (which originally reported the issue).

I don't see how spending time in linux-next is going to achieve anything.
