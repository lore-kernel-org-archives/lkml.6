Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF5FECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7C020862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZJ7zAvdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7C020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbeKES1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:27:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKES1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l3y/CO+0xDtVPVTAZdr/0+Ai079D0gY/8QOevfiqFiw=; b=ZJ7zAvdpt6se/Q//+yR+VF1EVO
        o+6hS32l4lBXiXa6YaTte9wSj5Qirtpho4hpmJvANl2rh8LLxQjQ7JyIy91GG9C8BLlmuHKqmlJO4
        5GN3uHjnYJ5WzdnCvPhWXvqCM5WLCbxjCE+qAnDXZDoqVouY8RxZcAvfbZUppN8bvfX8Zox7p6htE
        Y0L/yJiCWU46DBohoEO1RC8RBaavCw5Nh9ZtByqAhzhgKAsmdnt2LAyB9vm8N8OboRzCHQXfp0Mh5
        v0L6mwkn6rS4Dey5J2frCPlLyyiPY9HgvtRbE93gmkd4ooG/33ya4izZeOgHwyhfruzJIwCIeOWqU
        WDSA/qDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJasO-0004CY-CL; Mon, 05 Nov 2018 09:08:52 +0000
Date:   Mon, 5 Nov 2018 01:08:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Vincent Chen <vincentc@andestech.com>, aou@eecs.berkeley.edu,
        alankao@andestech.com, greentime@andestech.com, palmer@sifive.com,
        linux-kernel@vger.kernel.org, zong@andestech.com,
        kito@andestech.com, linux-riscv@lists.infradead.org,
        deanbo422@gmail.com
Subject: Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
Message-ID: <20181105090852.GA14924@infradead.org>
References: <CAAhSdy0Y_jdc=2Lf8epof_+7HigCfhDxMNe8EF0fHfncqhs-zA@mail.gmail.com>
 <mhng-01f0ac6a-c2fd-41be-9d53-44d1c139d453@palmer-si-x1c4>
 <20181101174857.du2zu4vnrhpu5asf@excalibur.cnev.de>
 <20181105065807.GA1286@andestech.com>
 <20181105070551.GA7274@infradead.org>
 <CAK8P3a2c98VVPArCkdAR=-nnDBq1gYRCLDDgQB71eGiTSRdb4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a2c98VVPArCkdAR=-nnDBq1gYRCLDDgQB71eGiTSRdb4A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 09:52:52AM +0100, Arnd Bergmann wrote:
> > I fundamentally disagree with this… and think it should be the contrary.
> >
> > 1. The kernel shall support no vendor specific instructions whatsoever,
> > period.
> 
> I think what was meant above is
> 
> 1. If a vendor extension requires kernel support, that support
> must be able to be built into a kernel image without breaking support
> for CPUs that do not have that extension, to allow building a single
> kernel image that works on all CPUs.

No.  This literally means no vendor extensions involving instructions
or CSRs in the kernel.  They are fine for userspace, or for the M-mode
code including impementation of the SBI, but not for the kernel.
