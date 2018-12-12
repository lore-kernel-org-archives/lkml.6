Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B591DC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CE720870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CE720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeLLXk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:40:59 -0500
Received: from namei.org ([65.99.196.166]:51466 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbeLLXk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:40:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBCNeWxU007768;
        Wed, 12 Dec 2018 23:40:32 GMT
Date:   Thu, 13 Dec 2018 10:40:32 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Florian Weimer <fweimer@redhat.com>
cc:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?ISO-8859-15?Q?Philippe_Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/5] Add support for O_MAYEXEC
In-Reply-To: <87lg4upkpv.fsf@oldenburg2.str.redhat.com>
Message-ID: <alpine.LRH.2.21.1812131039400.7600@namei.org>
References: <20181212081712.32347-1-mic@digikod.net> <alpine.LRH.2.21.1812130642250.29507@namei.org> <87lg4upkpv.fsf@oldenburg2.str.redhat.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018, Florian Weimer wrote:

> * James Morris:
> 
> > If you're depending on the script interpreter to flag that the user may 
> > execute code, this seems to be equivalent in security terms to depending 
> > on the user.  e.g. what if the user uses ptrace and clears O_MAYEXEC?
> 
> The argument I've heard is this: Using ptrace (and adding the +x
> attribute) are auditable events.

I guess you could also preload a modified libc which strips the flag.


-- 
James Morris
<jmorris@namei.org>

