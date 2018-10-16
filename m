Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E059DC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0232087B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0232087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeJQHwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:52:22 -0400
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:48381 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727088AbeJQHwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:52:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id DD23A181D341A;
        Tue, 16 Oct 2018 23:59:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: chin26_357726a2f072e
X-Filterd-Recvd-Size: 2095
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue, 16 Oct 2018 23:59:27 +0000 (UTC)
Message-ID: <bad13afe8c71860a85f12130a57fe9a96f017cf3.camel@perches.com>
Subject: Re: [RFC v1 12/31] checkpatch: added support for struct MOCK(foo)
 syntax
From:   Joe Perches <joe@perches.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org
Date:   Tue, 16 Oct 2018 16:59:26 -0700
In-Reply-To: <20181016235120.138227-13-brendanhiggins@google.com>
References: <20181016235120.138227-1-brendanhiggins@google.com>
         <20181016235120.138227-13-brendanhiggins@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-16 at 16:51 -0700, Brendan Higgins wrote:
> This adds struct MOCK(foo) as a NonptrType so that it is recognized
> correctly in declarations.

I think this commit message is lacking context.


> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  scripts/checkpatch.pl | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 447857ffaf6be..9806f190796de 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -745,6 +745,10 @@ sub build_types {
>  			(?:
>  				(?:typeof|__typeof__)\s*\([^\)]*\)|
>  				(?:$typeTypedefs\b)|
> +				# Matching a \b breaks struct MOCK(foo) syntax,
> +				# so we need to have it not lumped in with the
> +				# types in @typeList.
> +				(?:struct\s+MOCK\($Ident\))|
>  				(?:${all}\b)
>  			)
>  			(?:\s+$Modifier|\s+const)*

