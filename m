Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-625980-1523265863-2-17879271220744218628
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523265862; b=YH6O7jKFwVkY1Bri3E5h8UbrwYqgwlx3lNBuvLaDUkrb43FRYd
    VMx1UrvyZls1FocfM1WiEcBQETVxeOBx40TBYz4o4v7FtfB77oxdAEqxvzls3OIj
    h48Gb4/CtQU8r6duINDWkL859tHMc8sVKq4GmXlbidKWwcV2W3gNloluxgMVvnv2
    1VIF2YwXCaUOl5TAFju9fOxkmQPncz6RtGW4g0h2pqvYVmvzvj3gWev0q0kNFklc
    bAhMAHoZlmi7Nr+nri5hoziirCPd7oV2tZay0MpxBEty+Q6ANHQ8ZkLRPEwxb67a
    Lnsg9eDGDpdlcGdLbVDvZ/YPNAIgNUGQXapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523265862;
    bh=5K4sSSNxrv0RdUTjpF2JIKGeYKxr7yXU8N2HdFKLmdI=; b=WkHpt76cBmTX
    60gFic/cbNJbGU0C7Br/r6qXEESGQDsRDjkR/KApQ+XNh5LV8o+3J+U4Atgx2T/B
    MFeGpNQ6JTeQdsVZOY6G2qp5H4Angz2h+QlrB6Ww6VG0zCLg5wlmEH0qdx/8IDd6
    +eJ4gl17OrrMJ7bw2oOiVhA+BhL65W98aanfhxke+mi91hOrD6T8Ozwg+vlmJ27l
    jTUBNH8r155JRp+HY88uMM2zIPuxg5YuotJ//L0BQPv9YJzfkNBp9jFUT2ppde8h
    8fkof4plwQu7REQtjLnpsHSpHDOgOzwQeMH4jAyKFZtdA2QPfsiuHEdDusLc4kwA
    5kNdItYTOA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPcXtojvIiHovfyWqgj2kSrQ1zcnKDwyzHysvWicDyCl/RmFfXXvr0TxU4B2f3Dfz5T3hAMVOOP1j36hCPSpeo+wJfmhCIJWOg/65AQ3ncEXsvsyP0Gr
    wvsAnxtbLr/hZn/+GMurSD9Ep2PbxGxDfNlrVqrF5b9/9fA67IItkBPV6lod/ew/Y27GAnx/CZ998XZn8tfqxTgxQEW2JqQCsNPUUX/fzYWonDEQhS11wWNf
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8
    a=8htIcggnOyYHfF8ZweQA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750863AbeDIJYU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 05:24:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:49525 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750759AbeDIJYT (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 9 Apr 2018 05:24:19 -0400
Date: Mon, 9 Apr 2018 11:24:16 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH AUTOSEL for 4.9 078/293] firmware: dmi_scan: Check DMI
 structure length
Message-ID: <20180409112416.24324f93@endymion>
In-Reply-To: <20180409002239.163177-78-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
        <20180409002239.163177-78-alexander.levin@microsoft.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 9 Apr 2018 00:23:55 +0000, Sasha Levin wrote:
> From: Jean Delvare <jdelvare@suse.de>
> 
> [ Upstream commit a814c3597a6b6040e2ef9459748081a6d5b7312d ]
> 
> Before accessing DMI data to record it for later, we should ensure
> that the DMI structures are large enough to contain the data in
> question.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  drivers/firmware/dmi_scan.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> (...)
> @@ -191,13 +191,14 @@ static void __init dmi_save_ident(const struct dmi_header *dm, int slot,
>  static void __init dmi_save_uuid(const struct dmi_header *dm, int slot,
>  		int index)
>  {
> -	const u8 *d = (u8 *) dm + index;
> +	const u8 *d;
>  	char *s;
>  	int is_ff = 1, is_00 = 1, i;
>  
> -	if (dmi_ident[slot])
> +	if (dmi_ident[slot] || dm->length <= index + 16)

I'm afraid this check is off by one and nobody noticed :-( I'll send a
fix-up patch.

Probably harmless in practice as I have never seen a system with a DMI
type 1 structure of exactly 24 bytes (would be 8 bytes for very old
implementations and at least 25 for anything even remotely recent), but
still not good. Sorry about that.

>  		return;
>  
> +	d = (u8 *) dm + index;
>  	for (i = 0; i < 16 && (is_ff || is_00); i++) {
>  		if (d[i] != 0x00)
>  			is_00 = 0;

-- 
Jean Delvare
SUSE L3 Support
