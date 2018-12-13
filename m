Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048FAC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6C120811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cknB3/Rf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6C120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbeLMRoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:44:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbeLMRoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vHGUuj0rnCXK7jCzmngG9EdSGcppwG64C2WaGQxemxQ=; b=cknB3/RfhMcgP/LryCBIdo1cOp
        Feqy1/knxhUX8eAa3sORC/FcKvArI4TbXYZ1aklrDdcXirP9YOAr5Q7G/r8Lk9KD1D0emIc9+EUH7
        +2Ib50F4sxDSQi82OL7/W4CBDLlchqmeWJporWm809fLYmDvK+vu/Jy+bnIFlGrRzYErC5I6fGzqc
        ZXpkOflllvTR+KUMdZa0myJZ0oKfImIYq4p9/OAv3rewao99cH2xjRuzwNs+2vKYzAmg9CQBEmMJE
        swKz9k8fF6xjH0MWSZdjGmGr1XllQ+Od0BU4CX+18Bi7bJHjKioedp1AczQ4XEj86G1gj3//Tanr4
        B4m+/tCA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXV1s-00082H-FV; Thu, 13 Dec 2018 17:44:08 +0000
Date:   Thu, 13 Dec 2018 09:44:08 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/5] Add support for O_MAYEXEC
Message-ID: <20181213174408.GS6830@bombadil.infradead.org>
References: <20181212081712.32347-1-mic@digikod.net>
 <20181213030228.GM6830@bombadil.infradead.org>
 <374ea88c-edc5-f1a6-3637-748635e1e7df@ssi.gouv.fr>
 <20181213171310.GR6830@bombadil.infradead.org>
 <ba523381-1b98-a8bf-ee5b-94a71caee48c@ssi.gouv.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba523381-1b98-a8bf-ee5b-94a71caee48c@ssi.gouv.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 06:36:15PM +0100, Mickaël Salaün wrote:
> On 13/12/2018 18:13, Matthew Wilcox wrote:
> > On Thu, Dec 13, 2018 at 04:17:29PM +0100, Mickaël Salaün wrote:
> >> Adding a new syscall for this simple use case seems excessive. I think
> > 
> > We have somewhat less than 400 syscalls today.  We have 20 O_ bits defined.
> > Obviously there's a lower practical limit on syscalls, but in principle
> > we could have up to 2^32 syscalls, and there are only 12 O_ bits remaining.
> > 
> >> that the open/openat syscall familly are the right place to do an atomic
> >> open and permission check, the same way the kernel does for other file
> >> access. Moreover, it will be easier to patch upstream interpreters
> >> without the burden of handling a (new) syscall that may not exist on the
> >> running system, whereas unknown open flags are ignored.
> > 
> > Ah, but that's the problem.  The interpreter can see an -ENOSYS response
> > and handle it appropriately.  If the flag is silently ignored, the
> > interpreter has no idea whether it can do a racy check or whether to
> > skip even trying to do the check.
> 
> Right, but the interpreter should interpret the script if the open with
> O_MAYEXEC succeed (but not otherwise): it may be because the flag is
> known by the kernel and the system policy allow this call, or because
> the (old) kernel doesn't known about this flag (which is fine and needed
> for backward compatibility). The script interpretation must not failed
> if the kernel doesn't support O_MAYEXEC, it is then useless for the
> interpreter to do any additional check.

If that's the way interpreters want to work, then that's fine.  They
can just call the verify() syscall and ignore the -ENOSYS.  Done.

Or somebody who cares very, very deeply can change the interpreter to
decline to run any scripts if the kernel returns -ENOSYS.
