Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2182782-1527602388-2-18190953727338738432
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527602387; b=SK7qoNuUTO93sArAqXoDjXCynb9Pp++9G5JjyizBebRgBLldRz
    nYJrPCwAv5J3cCPLqDEN/vTL4WjQ3Pp7CC6thUnMYuN2m1oBxWgqCaRXS2ZBUJGF
    pjy37shkonT7xZ2Rdh55ngw7Xs2RKSJ4GADI/NkkVMh8FWVp2HTa1ZS6gGcgQNwz
    vAH1ojifYU9Vofru/9ij4jYgKY1EceULAXagf1GJiJXk/p28ux/dV/QAGHB/ixol
    GtDvmT5r9SD1WRnHlVQKPWjHdekmuaN4WDnH8g6qRH8DEfOiWy9e63ILcLjEJPpO
    rCiJPlKhUP+K0Rz8EkElW+9345MbyvfRFxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527602387; bh=IQpRuu9Dr98zx1yGFS+lNyO/Apabio
    OAgwQr75T3Umg=; b=Ms1jYKw8RykLgAcHVsgASjFizjVEyBUeu03ZDnS6hrShF5
    2vdR8P7dIhGZDCY5ri7iuD+kLM7xmSZOWXMgLN7Ko838hYwsJeh7CGSrBDEQl06s
    tqxIqRqTOL/UyW6FASCJDCVctZ5k0rzduIuPA/FJPavb7QcKL60AEPHi4L1zzCTW
    uY5mqz7/wH2PK0DuLqn3ZpuMo+1DAtS4BKmE3Utsc3VnJNXkicas8+LEDWAX6K8v
    LwbEtVkzzpc8rMOtkO2oTD0K1K0WynRletOStlshx4cSqumjv9p3tifZPhSVCzTW
    z7/KkXOwVk0vFDau3oTftodhrBvGegQreSxLR6+A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=Frx/MDVo
    header.a=rsa-sha256 header.s=bombadil.20170209 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=Frx/MDVo
      header.a=rsa-sha256 header.s=bombadil.20170209 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD/k2MHyxbHGuktmkYcdWQSMK956MlKQMJ/8cHI3/sfGEPFIsdqndoc9MEbVgrJmCqlSZtwyjqUoKVFrXbundb61drjbbnTlM1+tkZ+3MNqbJVf7XHAU
    ZNii2fgPW1ZYfR5eSyf9y0sjzVL4PNioWAup4f9vt5uyB1vfk6n36RZ9fHnpy7L5Z02FeUwTH8K9lDXXGNeJT5jeKgNgkDJq/t7jvRl8fXy6rUlB3UuiqDNr
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=A-YTzUw1q3reLJhYk-QA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934842AbeE2N7n (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 09:59:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934533AbeE2N7k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 09:59:40 -0400
Date: Tue, 29 May 2018 06:59:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [GIT PULL] overlayfs update for 4.18
Message-ID: <20180529135938.GA5631@infradead.org>
References: <20180529132148.GC23785@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529132148.GC23785@veci.piliscsaba.redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>       vfs: add f_op->pre_mmap()

We've been through these pre-mmap games a few times, and always rejected
them, why is this any different?

>       vfs: export vfs_dedupe_file_range_one() to modules

Please use EXPORT_SYMBOL_GPL for all these crazy low-level exports.

To be homest I'd really like to see the whole thing as a patch series
instead of a pull request.  Very little seems to have gotten any
reviewed-by tags which makes me very suspicious.
