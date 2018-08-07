Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FF9C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713E3217B9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ndcBXqL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713E3217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389638AbeHGQs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:48:57 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48428 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389581AbeHGQsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:48:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 73E9A8EE251;
        Tue,  7 Aug 2018 07:34:14 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a7f9xv3JsFuh; Tue,  7 Aug 2018 07:34:14 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B80088EE0BA;
        Tue,  7 Aug 2018 07:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1533652454;
        bh=YN5yhb/E6YbV4gvmuIxV97ozu6bT4OeqVb0EqEcSBD8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ndcBXqL+oArYHIbPc+2vflBYV0G0BQtR6rJ6yomPKFzaeE3gEn5UV3NNiNp7d4ps1
         zlOAwKyMSZ4/xambwpjDkc+uMMIGfgGGzsHE2k+yCSCWvYZa1CC8ncFMjX7ogyeMVI
         pV7S/LTyT9S7r9dLs1WVxnOpI1XTsaxiMuxc8lo0=
Message-ID: <1533652452.5764.2.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 0/4] seccomp trap to userspace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>
Cc:     "Tobin C . Harding" <me@tobin.cc>, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 07 Aug 2018 07:34:12 -0700
In-Reply-To: <20180807024442.GA12274@cisco.lan>
References: <20180621220416.5412-1-tycho@tycho.ws>
         <20180807024442.GA12274@cisco.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-06 at 20:44 -0600, Tycho Andersen wrote:
> Hi all,
> 
> Dinesh Subhraveti has claimed that some part of this series might be
> patented. While he has not furnished me with anything to confirm this
> claim, I'll put this series on hold.

Just on a general policy for handling things like this.

Firstly, never discuss specifics on a mailing list.  Patents are a
really tricky area where advice in confidence is needed and lack of
confidentiality usually only benefits the patent holder.

Secondly, vague threats (like this) can be safely ignored.  Thanks to
the terms of the GPL and the specific actions of OIN, we legitimately
have licences to a vast pool of patents, so we should assume for every
vague threat of the existence of a patent that we do legitimately
possess a licence until the threat is made specific.

Finally, if the vague threat becomes specific (which means citation of
patent by number and claim) you need to engage the resources we have at
our disposal to investigate.  Likely it will be OIN resources that do
this investigation, but the way to begin is to start with your
corporate counsel for contributions on behalf of a company.  If they're
on behalf of you as an individual, you can begin with Counsel which the
Linux Foundation will provide.

James

