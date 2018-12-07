Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E991C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E8920838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcjsywh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E8920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeLGWZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:25:56 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36216 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGWZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 17:25:56 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so4142501lfg.3;
        Fri, 07 Dec 2018 14:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qoBoOtNjsEzrDKOJ26JYU/rmb2d6+9Olfv/SL1PpWPA=;
        b=rcjsywh2UlVr4ijw/scWRDs3kXXQS3EDW2PKWvey1FWB66PiamhBqqLTnCeQ5vvMb4
         Vr/CrSGiTJ/Ss41U51IdSScSs/vhC4A33ehPHfdRXvfzHIRLKC9Drf2Lo6EB/AwYPrTh
         EYe+1hr9D5qvYNcnQwvLEecTPBO9nynvgL3PQtywZx9ufgB4+O2tbekD9sEYQfC6B3Qj
         6Fa5V5K8KFQZy+EW63pCrZT+ruV5gLY5krKAZCLwvcsDeRgL7zjP+JwrinyPBwF7SkdS
         dCUqgKVonWdgcxTKTqmMNG04W4l47NGeN2h/k3bCpHoDmbK1EFWzg9G4d0dmNkKUmN3Q
         oKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qoBoOtNjsEzrDKOJ26JYU/rmb2d6+9Olfv/SL1PpWPA=;
        b=myvptJya1ZkQC1FnRRo7V7TYZfchqdgMTFSDA0JDkaaWnhGdZjDqZLTlEBvVvfWcO6
         1NO9rD8KnTrSpd0y/OwXUHrK7fNbEA381JrBi7nA7kg4XgnUSXshcduxdK6lIAhECdzS
         ZkPqdLu5+CGeAGZd6FubaBq25ZM88biOIzCNPc0a1nlDLR3uAh0an8kL98crlOOR3U0g
         Qu9PAbPwCI2osAyJstdG/OVKK9LHTatohv14JLjSD3y4mjcwROglgVv2a1fUePMt7SUa
         XVfJmWEwdXO22Hd7u414awJTGjeSSLkx+X/TotRYo8eRRbXQFI1OKOTBvZ/2ULFXkeK2
         PEQQ==
X-Gm-Message-State: AA+aEWZQagWnm52wvLqL3irsTIPnhPz+wwzL2R1fz6dyhU9b19YK8swF
        CVMapP/XzRViHOvg2DuwjXg=
X-Google-Smtp-Source: AFSGD/W7kyCRU10Hmul7A5y2C5pVZIMeVLdlK5SSZXw4GPNZYnH+Rfz/b5YYLkar+TH34gmnK7C3pQ==
X-Received: by 2002:ac2:4215:: with SMTP id y21mr2310316lfh.6.1544221553879;
        Fri, 07 Dec 2018 14:25:53 -0800 (PST)
Received: from [192.168.1.18] (ckc199.neoplus.adsl.tpnet.pl. [83.31.78.199])
        by smtp.gmail.com with ESMTPSA id 13-v6sm753707ljj.49.2018.12.07.14.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:25:53 -0800 (PST)
Subject: Re: [PATCH] leds: tlc591xx: fix device_node_continue.cocci warnings
 (fwd)
To:     Julia Lawall <julia.lawall@lip6.fr>, Jyri Sarha <jsarha@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbuild-all@01.org
References: <alpine.DEB.2.21.1812062126130.2464@hadrien>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <c29a8fb6-4de1-2bc3-720a-1484bb30d38e@gmail.com>
Date:   Fri, 7 Dec 2018 23:25:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1812062126130.2464@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

Thank you for the patch, but it doesn't apply to LED tree.

The patch causing the problem is out-of-LED-tree.

Best regards,
Jacek Anaszewski

On 12/6/18 9:28 PM, Julia Lawall wrote:
> Hello,
> 
> The code seems to be wrong in several ways.  If the continue is wanted,
> the of_node_put is not needed; it will happen on the next iteration.  If
> the continue is not wanted, the of_node_put is needed, and the continue
> should be dropped.
> 
> julia
> 
> ---------- Forwarded message ----------
> Date: Thu, 6 Dec 2018 19:48:54 +0800
> From: kbuild test robot <lkp@intel.com>
> To: kbuild@01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: [PATCH] leds: tlc591xx: fix device_node_continue.cocci warnings
> 
> CC: kbuild-all@01.org
> TO: Jyri Sarha <jsarha@ti.com>
> CC: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> CC: Pavel Machek <pavel@ucw.cz>
> CC: linux-leds@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> 
> From: kbuild test robot <fengguang.wu@intel.com>
> 
> drivers/leds/leds-tlc591xx.c:342:3-14: ERROR: probable double put.
> 
>   Device node iterators put the previous value of the index variable, so an
>   explicit put causes a double put.
> 
> Generated by: scripts/coccinelle/iterators/device_node_continue.cocci
> 
> Fixes: 7b2d34aaede7 ("leds: tlc591xx: Add gpio output support")
> CC: Jyri Sarha <jsarha@ti.com>
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
> ---
> 
> tree:   https://github.com/omap-audio/linux-audio peter/ti-linux-4.19.y/wip
> head:   838f24e2deaf1229002bd6555eb7e889b09ac1f9
> commit: 7b2d34aaede727b4abfc78061bbd2202fcd92bc8 [62/67] leds: tlc591xx: Add gpio output support
> :::::: branch date: 26 hours ago
> :::::: commit date: 26 hours ago
> 
> Please take the patch only if it's a positive warning. Thanks!
> 
>   leds-tlc591xx.c |    1 -
>   1 file changed, 1 deletion(-)
> 
> --- a/drivers/leds/leds-tlc591xx.c
> +++ b/drivers/leds/leds-tlc591xx.c
> @@ -339,7 +339,6 @@ tlc591xx_probe(struct i2c_client *client
>   	for_each_child_of_node(np, child) {
>   		err = of_property_read_u32(child, "reg", &reg);
>   		if (err) {
> -			of_node_put(child);
>   			continue;
>   			return err;
>   		}
> 


