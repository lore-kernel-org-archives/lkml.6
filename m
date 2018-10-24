Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656D0C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E557206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E557206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeJXRES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:04:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:3922 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbeJXRES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:04:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 01:37:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,419,1534834800"; 
   d="scan'208";a="102185655"
Received: from sakethyx-mobl2.gar.corp.intel.com ([10.249.254.29])
  by orsmga001.jf.intel.com with ESMTP; 24 Oct 2018 01:37:00 -0700
Date:   Wed, 24 Oct 2018 11:36:57 +0300 (EEST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     dhowells@redhat.com, jejb@linux.vnet.ibm.com,
        natechancellor@gmail.com, David.Laight@aculab.com,
        denkenz@gmail.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] [PATCH] KEYS: trusted: fix -Wvarags warning
In-Reply-To: <20181022234357.82217-1-ndesaulniers@google.com>
Message-ID: <alpine.DEB.2.21.1810241136130.3525@jsakkine-mobl1>
References: <0147a993d4a94426afa469a8dcc4e5d7@AcuMS.aculab.com> <20181022234357.82217-1-ndesaulniers@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018, ndesaulniers@google.com wrote:
> Fixes the warning reported by Clang:
> security/keys/trusted.c:146:17: warning: passing an object that
> undergoes default
>      argument promotion to 'va_start' has undefined behavior [-Wvarargs]
>        va_start(argp, h3);
>                       ^
> security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> char' is declared here
> unsigned char *h2, unsigned char h3, ...)
>                               ^
> Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
> standards explicitly call this out as undefined behavior:
>
> The parameter parmN is the identifier of the rightmost parameter in
> the variable parameter list in the function definition (the one just
> before the ...). If the parameter parmN is declared with ... or with a
> type that is not compatible with the type that results after
> application of the default argument promotions, the behavior is
> undefined.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/41
> Link: https://www.eskimo.com/~scs/cclass/int/sx11c.html
> Suggested-by: David Laight <David.Laight@aculab.com>
> Suggested-by: Denis Kenzior <denkenz@gmail.com>
> Suggested-by: James Bottomley <jejb@linux.vnet.ibm.com>
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
