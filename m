Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BD9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E388222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550084774;
	bh=3tvDN2As/arque28ddabicfdY1+IRFDJfKKsxsjxBSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JEn55PnuuVAyDHwY3yNbWjsKlkzLE76aNg5lUsG67R4XyASHkiHiB3IbuY55Ue5hQ
	 dEZnawB9iX98Sq1nonFruA5FDcTKg+XmBcrpieog2rBponouYPsDEil66LbSUZignv
	 UTDt0FkggVLFb+HA4C/8/esBeKGwH5M491loq6JM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392527AbfBMTGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:06:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45885 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732214AbfBMTGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:06:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so6105236ota.12;
        Wed, 13 Feb 2019 11:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RmZBUxjU0Q4MJ39LIxlO9qvfMk8Y/Pdo6oPWEpaZ5NU=;
        b=GQ0cSgdgOdWehuexYTTMDx4FV4gseTwMmolUv0gkCySnUC1Xruxo+dac5gMV5R0z/f
         sQQP6WpH+zs0sA0N46aGW/+0kBuuamw2hL08syus4/5AgaipoTWMQIZnWHgmTvZFBT+x
         9Jx0Y15cJuWQJmqrtRpNh+/aNmnityaAZb1UElaLQqvwy3kgvMBFH7II+FZBL7RpCmzm
         RkKrF8I7ewhFnfANut3YP6h3RB+xOV9iEvXfeNX14XSjunqq0oYfDjKCRCLJ2O6gK2hL
         sQYBrgIwQ3FXBBjf0+hU0rX6IPXOmV/PCVnQfMb7ff8vVfHHZfg4kdfU5rt9omO1hERk
         rqKA==
X-Gm-Message-State: AHQUAuaD/8lJSk9X8UNh6L9SCJ9MyJnuRKfutW/9B/dzplGmuF/bqacQ
        XcAPKrLAFkqwqSnnPz5NcA==
X-Google-Smtp-Source: AHgI3IY5cSgYEQn2Ysb+XxYdlmIh5IDtGNfcOH9KK6UA8az3uOxtXJv1knsUmArwngxa1Dle26d4cg==
X-Received: by 2002:a54:4f81:: with SMTP id g1mr1128398oiy.93.1550084771436;
        Wed, 13 Feb 2019 11:06:11 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w125sm70895oiw.10.2019.02.13.11.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 11:06:10 -0800 (PST)
Date:   Wed, 13 Feb 2019 13:06:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH RESEND] of: add dtc annotations functionality to dtx_diff
Message-ID: <20190213190609.GA26659@bogus>
References: <1547762474-7832-1-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547762474-7832-1-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 02:01:14PM -0800, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Add -T and --annotations command line arguments to dtx_diff.  These
> arguments will be passed through to dtc.  dtc will then add source
> location annotations to its output.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> If dtx_diff is provided with a single devicetree source file then
> that source file will be compiled, with all appropriate includes
> and pre-processing, and the result will be output as source.  This
> provides a convenient mechanism to see what the devicetree looks
> like after all processing and replacements occur.  The
> --annotations argument will cause dtc to report information about
> where the source was located for each line of the output.
> 
>  scripts/dtc/dtx_diff | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Applied.

Rob
