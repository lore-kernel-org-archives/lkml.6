Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-958837-1526310968-2-403600919211039086
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526310967; b=KWCguFVGTD7xe9gq5afb5zrYNEYnMLaeg4fC3brCQ9xbSgCCSk
    7cESPLYeO4LDwRAqQcLRKdCmIQ+mKRmicND0zOGrNv0MlHz2gSMAnAK9OgS9hscd
    DG7e0ma9+QH/27jO9lWKEIVTd3L57yvJzGpbSMfreeU4F/4OW3shdApYCDOvxNim
    60ijyQrK1rUQYh+Yg7BZkwZxgdCmt0I8fq9Pl3IPWX1u427kWePD7BaEA7w5gfeN
    SYE+/3Mtf9rl4LKnW8G0lWFwPKth2Q/Dnc6vHiiwCWHvFNUaIrAHjKTv4iVvVJ3q
    UbFEJNewy4uNtwbpufRLl/dzV/O0STSYeNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526310967;
    bh=qBoJiLPK0WvWoz74I2oo2xruCIWmJzQaqIEsit0Lacs=; b=PIq2NWQHKlq3
    n/BGEgm+RoA3Qqe//dRbO4fuJuBEn6ezzNWRHacgoHSJUO+YaxEUt8gitkggvLoz
    8iBPyyu1W+RX0QjqyEc0haM+d1xMgz/EQvew2dbOhuwPtMgM0/oIxiDHMWk1e7qV
    a00zoH1MftfsLyTkGLDxR7Gpl50MumF9OUzYtbYtw3JRs30s2rlLUKSwAg1YNkDz
    pNIF4Cp4Mj//ssdrMwgiIuaXxMIGcOe+7YM/7MdQfS01lB1QqqYl5dlMpqXE+tvy
    g8SYcFn0mAxPru0y1aOQhi+HNI+U8ynZXgJfU16Mo4LMAeujhPObxVU31FgU3LwU
    C4R4+QdH+w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codethink.co.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codethink.co.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMSuX7sVbb1kMwLvclT6tsgYdslX9iTQvAvn0ZBdGciniSDnfjbPJnv4CBGc/wm5+v+PjmkwuSSHIzF8x2lurUZdEp0l4rZyEH6y8hfetFzNAvjp/L8U
    miVHvVJQuMIkmTATe5UtQ9QMSDRxC2LU2H7OkO3cpTLosOjRkKKgv2HY440QC9IyRVihfEdg9Ce/V0B96nyKURpJCdYOD9c0yvgEBjClHDQ1ORy+38YEkoeZ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=zXD8RKOj8Zky26xWRsoA:9 a=QEXdDO2ut3YA:10
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbeENPQE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 11:16:04 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:60030 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752960AbeENPQE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 11:16:04 -0400
Message-ID: <1526310960.9159.3.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 01/72] mtd: jedec_probe: Fix crash in
 jedec_read_mfr()
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Linus Walleij <linus.walleij@linaro.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc: stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Mon, 14 May 2018 16:16:00 +0100
In-Reply-To: <20180406084305.298690833@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
         <20180406084305.298690833@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-04-06 at 15:23 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> commit 87a73eb5b56fd6e07c8e499fe8608ef2d8912b82 upstream.
[...]
> --- a/drivers/mtd/chips/jedec_probe.c
> +++ b/drivers/mtd/chips/jedec_probe.c
> @@ -1889,6 +1889,8 @@ static inline u32 jedec_read_mfr(struct
>  	do {
>  		uint32_t ofs = cfi_build_cmd_addr(0 + (bank << 8), map, cfi);
>  		mask = (1 << (cfi->device_type * 8)) - 1;
> +		if (ofs >= map->size)
> +			return 0;
>  		result = map_read(map, base + ofs);
>  		bank++;
>  	} while ((result.x[0] & mask) == CFI_MFR_CONTINUATION);

Looking at the calling code several levels up, in
genprobe_ident_chips():

	max_chips = map->size >> cfi.chipshift;
[...]
	for (i = 1; i < max_chips; i++) {
		cp->probe_chip(map, i << cfi.chipshift, chip_map, &cfi);
	}

The expression i << cfi.chipshift becomes the base parameter here, so
we have base < map->size.  That implies to me that map->size is the
size of the complete mapping, and we need to compare it with the
complete address.

So shouldn't the test be ofs >= (map->size - base)?
Or even ofs >= (1 << cfi->chipshift)?

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
