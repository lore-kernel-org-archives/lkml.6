Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819BBECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4523E20664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="OKjM1Nij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4523E20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeKAMAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 08:00:24 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46232 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbeKAMAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 08:00:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6D66B8EE179;
        Wed, 31 Oct 2018 19:59:24 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q7Erb9BKTj7Y; Wed, 31 Oct 2018 19:59:24 -0700 (PDT)
Received: from [192.168.20.3] (unknown [216.9.105.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B0E518EE02B;
        Wed, 31 Oct 2018 19:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1541041164;
        bh=LaZ6lE7b1odiMLIIxIprUCRoLPHL+xmLclVvBsLieFw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OKjM1Nijq/6G2dx3DZ/L+Ic8C30m2LP5WyB+2oqMD1RQhChkfhWiIPwrXE9VEHJAZ
         ZksVTsse0+0shC7HY8qFsWnHRlinMBOYp9PME6jpqZs095eEJ1P1CROs1zIV5RVv6q
         W1H9zpwnVZuDMI0MxvxXFxwz5VCxLi+HTvtI8mXw=
Message-ID: <1541041159.4632.6.camel@HansenPartnership.com>
Subject: Re: [PATCH v6 0/1] ns: introduce binfmt_misc namespace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>
Date:   Wed, 31 Oct 2018 19:59:19 -0700
In-Reply-To: <7ed6f823-547b-922d-59ff-aba9c4c3ab39@vivier.eu>
References: <20181010161430.11633-1-laurent@vivier.eu>
         <7ed6f823-547b-922d-59ff-aba9c4c3ab39@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-16 at 11:52 +0200, Laurent Vivier wrote:
> Hi,
> 
> Any comment on this last version?
> 
> Any chance to be merged?

I've got a use case for this:  I went to one of the Graphene talks in
Edinburgh and it struck me that we seem to keep reinventing the type of
sandboxing that qemu-user already does.  However if you want to do an
x86 on x86 sandbox, you can't currently use the binfmt_misc mechanism
because that has you running *every* binary on the system emulated. 
Doing it per user namespace fixes this problem and allows us to at
least cut down on all the pointless duplication.

James

