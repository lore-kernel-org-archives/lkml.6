Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3ACC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839FE21477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839FE21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeJRWDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:03:52 -0400
Received: from albireo.enyo.de ([5.158.152.32]:57274 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbeJRWDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:03:52 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1gD8sq-0006kT-Ai; Thu, 18 Oct 2018 14:02:40 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.89)
        (envelope-from <fw@deneb.enyo.de>)
        id 1gD89G-00013T-WF; Thu, 18 Oct 2018 15:15:35 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 2/3] uapi: get rid of STATX_ALL
References: <20181018131125.6303-1-mszeredi@redhat.com>
        <20181018131125.6303-2-mszeredi@redhat.com>
Date:   Thu, 18 Oct 2018 15:15:34 +0200
In-Reply-To: <20181018131125.6303-2-mszeredi@redhat.com> (Miklos Szeredi's
        message of "Thu, 18 Oct 2018 15:11:24 +0200")
Message-ID: <875zxzxuo9.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Miklos Szeredi:

>  #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */

What about this?  Isn't it similar to STATX_ALL in the sense that we
don't know yet what it will mean?
