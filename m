Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A745C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2724320880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2724320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbeLML1F convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:27:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728611AbeLML1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:27:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 59B637F3E8;
        Thu, 13 Dec 2018 11:27:04 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-82.ams2.redhat.com [10.36.116.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E57D960A9C;
        Thu, 13 Dec 2018 11:26:57 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        =?utf-8?Q?Micka=C3=ABl_Sala?= =?utf-8?Q?=C3=BCn?= 
        <mic@digikod.net>, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Philippe =?utf-8?Q?Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/5] Add support for O_MAYEXEC
References: <20181212081712.32347-1-mic@digikod.net>
        <20181213030228.GM6830@bombadil.infradead.org>
        <1544699060.6703.11.camel@linux.ibm.com>
Date:   Thu, 13 Dec 2018 12:26:56 +0100
In-Reply-To: <1544699060.6703.11.camel@linux.ibm.com> (Mimi Zohar's message of
        "Thu, 13 Dec 2018 06:04:20 -0500")
Message-ID: <874lbhoef3.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 13 Dec 2018 11:27:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mimi Zohar:

> The indication needs to be set during file open, before the open
> returns to the caller.  This is the point where ima_file_check()
> verifies the file's signature.  On failure, access to the file is
> denied.

Does this verification happen for open with O_PATH?

Thanks,
Florian
