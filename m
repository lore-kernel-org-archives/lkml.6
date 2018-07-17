Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219A9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B631F205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KbZwYYtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B631F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbeGQW5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:57:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeGQW5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=19UpH6ntFcT+jbAtwpGKDzQac1+16T5oT4ZsX2kuCKY=; b=KbZwYYtuTVgHEKAXHK3wg6BZG
        IrY49+0nsIhsrmA29wkJO/Hnm39qHLlZhKrJMHX1F7uEP9itgPJmcjflFTvgeMtueyGISGOo+3OFt
        NuoELLpuw9VY9ISgx0sr8QnA7uzaIaRN/Pds2H43A5iXai1Cb2mY6OGp9TvmsNg7eIxOtgbyMvbCL
        yKMZ0NAN+uLd71/97vIlZWzHRdGA7fv74QsbcnGg11AtAWdNvNzTDd0h5BwYEEXRCgcmP/FPSZBwf
        7MLqTXyJJ5JxyXNjlSbC+6oB0DQIuVp234QhFUArnxrHiaEsYllsy/KgGsXAyssVLJJypNBpAM6Bq
        i54bzUfIA==;
Received: from [121.135.244.1] (helo=vela.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffYMv-0000r0-Nz; Tue, 17 Jul 2018 22:22:53 +0000
Date:   Wed, 18 Jul 2018 07:22:46 +0900
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     valdis.kletnieks@vt.edu
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH scripts/kernel-doc
Message-ID: <20180718072246.6070f2a1@vela.lan>
In-Reply-To: <50400.1531846649@turing-police.cc.vt.edu>
References: <50400.1531846649@turing-police.cc.vt.edu>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 17 Jul 2018 12:57:29 -0400
valdis.kletnieks@vt.edu escreveu:

> Fix a warning whinge from Perl introduced by "scripts: kernel-doc: parse next structs/unions"
> 
> Unescaped left brace in regex is deprecated here (and will be fatal in Perl 5.32), passed through in regex; marked by <-- HERE in m/({ <-- HERE [^\{\}]*})/ at ./scripts/kernel-doc line 1155.
> Unescaped left brace in regex is deprecated here (and will be fatal in Perl 5.32), passed through in regex; marked by <-- HERE in m/({ <-- HERE )/ at ./scripts/kernel-doc line 1179.
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>


Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>


> ---
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 0057d8eafcc1..31a34ced55a3 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1152,7 +1152,7 @@ sub dump_struct($$) {
>  	}
>  
>  	# Ignore other nested elements, like enums
> -	$members =~ s/({[^\{\}]*})//g;
> +	$members =~ s/(\{[^\{\}]*})//g;
>  
>  	create_parameterlist($members, ';', $file, $declaration_name);
>  	check_sections($file, $declaration_name, $decl_type, $sectcheck, $struct_actual);
> @@ -1176,7 +1176,7 @@ sub dump_struct($$) {
>  			$declaration .= "\t" x $level;
>  		}
>  		$declaration .= "\t" . $clause . "\n";
> -		$level++ if ($clause =~ m/({)/ && !($clause =~m/}/));
> +		$level++ if ($clause =~ m/(\{)/ && !($clause =~m/}/));
>  	}
>  	output_declaration($declaration_name,
>  			   'struct',
> 




Cheers,
Mauro
