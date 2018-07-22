Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7444DECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D8420875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dF2y/IHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D8420875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbeGVQTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 12:19:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbeGVQTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 12:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sHpX5qyDp2cYCPgKQrJmiHbjNGxkmtKloxDKA+tNXTM=; b=dF2y/IHUD+pQQgISAZCn2Mvn1
        GC98eS1L0I7sMoRIDCPC4HqY9Q5h4rCygB0Jtj71lpsjgIyx6c2yvV1M3Y6RW9hvqp8Y0kIGnmKxL
        ghEIuA5QQGqZh0m6TBy3af7UknwB7t44gkcCn0tC3dg08p8Z6qatAAnJZKeN2pTXHR9VXEFCPkh+g
        PlE5we+TlfE5uHoagyYxCIlQXLCT2IK/kTensxLzUfN2CKP+OtpPBrb+Q615BkKnQH+I/fkRjsZ1/
        Js1Bf1V/B/1jMHU2Gqxb3L/x4dPkzuTjTrWmDulBcA0pwhDanIJ36GLfEN9ga88ceptU9/VS+nqGJ
        BAOHqt03Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhGC9-0006V2-11; Sun, 22 Jul 2018 15:22:49 +0000
Date:   Sun, 22 Jul 2018 08:22:48 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com
Subject: Re: [PATCH] arch/s390: Use new return type vm_fault_t
Message-ID: <20180722152248.GB12125@bombadil.infradead.org>
References: <20180722134109.GA31840@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180722134109.GA31840@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 07:11:09PM +0530, Souptick Joarder wrote:
> use new return type vm_fault_t for fault handler vdso_fault.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Reviewed-by: Matthew Wilcox <willy@infradead.org>
