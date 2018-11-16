Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B532BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAB920685
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAB920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbeKQGFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:05:34 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:58684 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbeKQGFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:05:33 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 2C9C320027;
        Fri, 16 Nov 2018 20:51:41 +0100 (CET)
Date:   Fri, 16 Nov 2018 20:51:37 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/2] modpost: drop unused command line switches
Message-ID: <20181116195137.GA15240@ravnborg.org>
References: <20181115005602.30746-1-paul.walmsley@sifive.com>
 <20181115005602.30746-2-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115005602.30746-2-paul.walmsley@sifive.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=VwQbUJbxAAAA:8 a=c-n4J4-pAAAA:8
        a=NZ-89VFvAAAA:8 a=pFyQfRViAAAA:8 a=XZFr5bKXAAAA:8 a=jdaYvgRxexuYeXKVlpoA:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22 a=AjGcO6oz07-iQ99wixmX:22
        a=L0NDqeB7ZLmQzAogN4cw:22 a=pm31WBKQz9GEXVZSZ1ft:22
        a=oJz5jJLG1JtSoe7EL652:22 a=XjNn1HFNghan22KSQb5W:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 04:56:01PM -0800, Paul Walmsley wrote:
> Drop modpost command line switches that are no longer used by
> makefile.modpost, upon request from Sam Ravnborg <sam@ravnborg.org>,
> who wrote:
> 
>     modpost is not supposed to be used outside the kernel build. [...]
>     I checked if there were any options supported by modpost that
>     was not configurable in makefile.modpost.
>     And I could see that the -M and -K options in getopt() was leftovers.
>     The code that used these option was was dropped in:
>     commit a8773769d1a1 ("Kbuild: clear marker out of modpost")
> 
>     Could you add a patch that delete these on top of what you already have.
> 
> https://lore.kernel.org/lkml/20181020140835.GA3351@ravnborg.org/
> 
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>


> ---
>  scripts/mod/modpost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 0d998c54564d..85bd93c63180 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2416,7 +2416,7 @@ int main(int argc, char **argv)
>  	struct ext_sym_list *extsym_iter;
>  	struct ext_sym_list *extsym_start = NULL;
>  
> -	while ((opt = getopt(argc, argv, "i:I:e:mnsST:o:awM:K:E")) != -1) {
> +	while ((opt = getopt(argc, argv, "i:I:e:mnsST:o:awE")) != -1) {
>  		switch (opt) {
>  		case 'i':
>  			kernel_read = optarg;
> -- 
> 2.19.1
