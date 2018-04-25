Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524653667-2-11654010049120383031
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653667; b=uFlmCKtk2FdN12onTK/TQ2wycYLt6BThgh0qHHJHDFudx9R7d3
    /tLpMSRgkWX7y0S6QxcPSXccBKvmt28/tmqGciXVo7ww/tWGtt3ynqUY554FgrfG
    dTBPBdKp6pw7dYSPMTpraTPQpNRd2YNtbR07zTC//SM0m9kp6McnfQwCGJe7R6aV
    AqObcvudETVjC6uRkYyQ5UOdlV5nfg6H8c1d2dHQwCKDe7FF4xXxHuAilXKcfvfY
    ZGrz69WzYvlEMT7Asub3m1PqTf2Wx9nU8zOtep+DttekEomm6cMvZoIt0xVX3dO3
    YP+C9CuD3V9ErTDlUSRxk7yWDcvEEKzUq8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653667; bh=bVr+rOjn0Y616hv/SIkMBhAW9K0rM8
    n+ftHgt17OH8s=; b=JafYYYeFjy1Aubn1Svoode6JR8u5tNLj6Djq640g1hqqFP
    LAQ2tx6os/Z9th1tW/Y7M7zz5aBzMOiXZuV9mpAOJuzhA6b32Cpm296Phgx+q/Tm
    VNPs/a39PXUNfSOIXrt9n02mXxYGlzSeF6U55sAC82wKw9TkMvcPjmZA4gMDAR3o
    k2sRzLB11hVvicnP5PGtqMTMFw3uLmnEDyVDcFQ78eSGkaygopgivND0An2J7nVN
    QPlhC6Lf0uiwvUJe6d3oQCrTvRPHtKKN80vrH5h2+/KqdvI90EgWoshXBCKeGdLm
    76NawVqjLM83ZHDCxbsBOIFSd6W0g44fmUpZ6AWg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOY40O8q01HDRsMYDiS+OMCTBIEA7u88fDTf7hXlWhBBaCnmP3WPJdneAlLCzFanAl774VmDlN+tmvlNlBp1DIFV13Y8EfWWTY4F9PTi1aFXnlVRuGDy
    L4IoiLcLgqlPQ9GZ/CcEt2a8ZVM8EVV2iph+oFGPZ4UZ5o1zte/MT2lvdEre1acGQcZN++jHRAlFw8PQDoOIprcQKLOuHvl5NhYQZnR/kuTpYWut8I6P8TTX
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=JDjsHSkAAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=l2jCzf7jOVhU8yY9kJsA:9 a=OeDwdVjzLO2CIJ2_:21
    a=DaWiiW_IgbzS1-IW:21 a=QEXdDO2ut3YA:10 a=dseMxAR1CDlncBZeV_se:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeDYKyK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:54:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53064 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753847AbeDYKnf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:43:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 154/183] svcrdma: Fix Read chunk round-up
Date: Wed, 25 Apr 2018 12:36:14 +0200
Message-Id: <20180425103248.730641230@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>


[ Upstream commit 175e03101d36c3034f3c80038d4c28838351a7f2 ]

A single NFSv4 WRITE compound can often have three operations:
PUTFH, WRITE, then GETATTR.

When the WRITE payload is sent in a Read chunk, the client places
the GETATTR in the inline part of the RPC/RDMA message, just after
the WRITE operation (sans payload). The position value in the Read
chunk enables the receiver to insert the Read chunk at the correct
place in the received XDR stream; that is between the WRITE and
GETATTR.

According to RFC 8166, an NFS/RDMA client does not have to add XDR
round-up to the Read chunk that carries the WRITE payload. The
receiver adds XDR round-up padding if it is absent and the
receiver's XDR decoder requires it to be present.

Commit 193bcb7b3719 ("svcrdma: Populate tail iovec when receiving")
attempted to add support for receiving such a compound so that just
the WRITE payload appears in rq_arg's page list, and the trailing
GETATTR is placed in rq_arg's tail iovec. (TCP just strings the
whole compound into the head iovec and page list, without regard
to the alignment of the WRITE payload).

The server transport logic also had to accommodate the optional XDR
round-up of the Read chunk, which it did simply by lengthening the
tail iovec when round-up was needed. This approach is adequate for
the NFSv2 and NFSv3 WRITE decoders.

Unfortunately it is not sufficient for nfsd4_decode_write. When the
Read chunk length is a couple of bytes less than PAGE_SIZE, the
computation at the end of nfsd4_decode_write allows argp->pagelen to
go negative, which breaks the logic in read_buf that looks for the
tail iovec.

The result is that a WRITE operation whose payload length is just
less than a multiple of a page succeeds, but the subsequent GETATTR
in the same compound fails with NFS4ERR_OP_ILLEGAL because the XDR
decoder can't find it. Clients ignore the error, but they must
update their attribute cache via a separate round trip.

As nfsd4_decode_write appears to expect the payload itself to always
have appropriate XDR round-up, have svc_rdma_build_normal_read_chunk
add the Read chunk XDR round-up to the page_len rather than
lengthening the tail iovec.

Reported-by: Olga Kornievskaia <kolga@netapp.com>
Fixes: 193bcb7b3719 ("svcrdma: Populate tail iovec when receiving")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Tested-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -727,12 +727,16 @@ static int svc_rdma_build_normal_read_ch
 		head->arg.head[0].iov_len - info->ri_position;
 	head->arg.head[0].iov_len = info->ri_position;
 
-	/* Read chunk may need XDR roundup (see RFC 5666, s. 3.7).
+	/* Read chunk may need XDR roundup (see RFC 8166, s. 3.4.5.2).
 	 *
-	 * NFSv2/3 write decoders need the length of the tail to
-	 * contain the size of the roundup padding.
+	 * If the client already rounded up the chunk length, the
+	 * length does not change. Otherwise, the length of the page
+	 * list is increased to include XDR round-up.
+	 *
+	 * Currently these chunks always start at page offset 0,
+	 * thus the rounded-up length never crosses a page boundary.
 	 */
-	head->arg.tail[0].iov_len += 4 - (info->ri_chunklen & 3);
+	info->ri_chunklen = XDR_QUADLEN(info->ri_chunklen) << 2;
 
 	head->arg.page_len = info->ri_chunklen;
 	head->arg.len += info->ri_chunklen;
