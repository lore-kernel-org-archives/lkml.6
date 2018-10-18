Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FE2ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3452145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3452145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeJRPtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:49:19 -0400
Received: from albireo.enyo.de ([5.158.152.32]:52094 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbeJRPtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:49:18 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1gD33h-0001Sy-1T; Thu, 18 Oct 2018 07:49:29 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.89)
        (envelope-from <fw@deneb.enyo.de>)
        id 1gD33g-0004FU-T1; Thu, 18 Oct 2018 09:49:28 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Dilger <adilger@dilger.ca>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Subject: Re: statx(2) API and documentation
References: <CAJfpegsxFUGeczcC-pzK0WWROjv48_PvXtNun-f5QJMoUDn1Dw@mail.gmail.com>
        <006890C4-64D4-4DE2-A1F0-335FFFD585BB@dilger.ca>
        <CAJfpeguvJZbP83mSULc74Yhpp_CPMBW1XvcgbvCbLnF7QCncUA@mail.gmail.com>
        <CAOQ4uxjqS3R_0O6gKVFEUJR7BvB+rpaHekjZm+fhMA+7on8AwQ@mail.gmail.com>
        <20181018074101.GJ23493@quack2.suse.cz>
Date:   Thu, 18 Oct 2018 09:49:28 +0200
In-Reply-To: <20181018074101.GJ23493@quack2.suse.cz> (Jan Kara's message of
        "Thu, 18 Oct 2018 09:41:01 +0200")
Message-ID: <87in1zy9rr.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan Kara:

> On Thu 18-10-18 01:15:13, Amir Goldstein wrote:
>> FYI, I identified a similar anti-pattern in fanotify UAPI when I wanted to
>> add new flags and did not want to change the UAPI _ALL_ constants.
>> This is how we plan to solve it:
>> https://github.com/amir73il/linux/commit/8c2b1acadb88ee4505ccc8bfdc665863111fb4cc
>
> Yeah, after fanotify experience I find foo_ALL constants useless if not
> dangerous for userspace.  Kernel internal constants like this are IMO
> useful.

There are also various *_MAX constants which are increased regularly.
Some of them are part of the UAPI headers (INET_DIAG_MAX appears to be
a relevant example), some are no longer in UAPI, but still in custom
glibc headers (AF_MAX/PF_MAX).  These appear to be equally useless.
