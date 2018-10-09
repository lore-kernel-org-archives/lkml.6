Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF09C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43D2214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43D2214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJJAMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:12:37 -0400
Received: from a3.inai.de ([88.198.85.195]:47912 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeJJAMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:12:37 -0400
Received: by a3.inai.de (Postfix, from userid 25121)
        id A5B8F3BACCCA; Tue,  9 Oct 2018 18:54:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 992F63BACCC1;
        Tue,  9 Oct 2018 18:54:42 +0200 (CEST)
Date:   Tue, 9 Oct 2018 18:54:42 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     David Howells <dhowells@redhat.com>
cc:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] UAPI: bcache: Fix use of embedded flexible array
In-Reply-To: <17992.1539099666@warthog.procyon.org.uk>
Message-ID: <nycvar.YFH.7.76.1810091847450.9618@n3.vanv.qr>
References: <nycvar.YFH.7.76.1810021622320.11696@n3.vanv.qr> <153616290368.23468.7806230605345568524.stgit@warthog.procyon.org.uk> <17992.1539099666@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 2018-10-09 17:41, David Howells wrote:

>Jan Engelhardt <jengelh@inai.de> wrote:
>
>> """it [the array size expression] shall be a converted constant expression of
>> type std::size_t and its value shall be greater than zero."""
>> —http://eel.is/c++draft/dcl.array
>
>Interesting.  You're not actually quoting the full sentence:
>
>	If the constant-expression is present, it shall be a converted
>	constant expression of type std​::​size_­t and its value shall be
>	greater than zero.
>
>This suggests that:
>
>	__u64 ptr[]
>
>is actually valid

I think that kind of validity only goes for this kind of standalone 
decl:

	extern int myints[];

but not for []-inside-struct.
