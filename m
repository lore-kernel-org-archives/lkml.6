Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48B5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3BA20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQFwawk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3BA20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388842AbeGWSL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:11:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36608 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388628AbeGWSL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:11:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id s7-v6so828948pgv.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=buXFvWz+Fi1QxQd+KPIni3OW4250LC2k6tiaUSOWRJo=;
        b=OQFwawk+8wdmEtAv6X1WXM63vbzTytrrGrCqvHbArae4HZ8GqOhF73K9U+NbufjgMq
         o36PNGI59UXiQ2Ta2RFCgnpCIfh6AW8c2feUqtlRdiWM3T40PJcMA3ze7i48KF8xVVg4
         oOkaVkjSxcYMFtiM/dUNP/1JXSUsJADooVj5tPLRHklu6TnWNL+3P/KQQfZ2Jxv51ujl
         zDAt817gf5VybXAktAw65+7P3M6dAxVUUr19IMwhTV/YGkQrYg5exWgfFBj8HeBx1Mza
         SzCVTHYdLpg4DJiFQT10nniZ/Vbc+DABGDRsbWQ8hwgp430Ni5wsnbp0DTUuxjN5+o7s
         P8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=buXFvWz+Fi1QxQd+KPIni3OW4250LC2k6tiaUSOWRJo=;
        b=O1EI0LFv68589zNu1ujqMub5WpRPkXlxpAia2/vHWXHi/y1Vr2TN0psL0aMcwdRduE
         F2uNi0gv6+znpQ3B2Snikg6mIyvyOH2OrsykGh/sah/rk1EL+WSfMvcESQRd+5ycS8Dv
         e0l1Cb4zT5YL9IhRbCEqwe4ieDGyUPB0jijpPBgfeHOqyGCFZJoabro4jiO5eCuQ9IOg
         ygxfwlu35fkdGRNdexnYzaqSrcXtttdchcMY01y1J6d9seVO2em/OZXO2PcuZ/QhHidl
         OxNLZEETJyLr4oCGl2PIRUVWWsqwjxOQOrXIV2x/fRP1Hcx0SDoHjHME+ZGL6sbH0dpB
         XnQA==
X-Gm-Message-State: AOUpUlGNcOJ76kWlbK/OgRoolDRKtUC7BogUi9T/4onSnSmDXbqi3l/X
        UZDeVuOytpHfDZFjdgjNzE8A5jlQ
X-Google-Smtp-Source: AAOMgpde60BRw9Ehg0ivPa5quKq2KgWynRfg6t1eeR8oTM3vSGXeuGoC1xSCg1FvqHVgrEjqHKIu+Q==
X-Received: by 2002:a63:1d22:: with SMTP id d34-v6mr13030198pgd.133.1532365756214;
        Mon, 23 Jul 2018 10:09:16 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id j191-v6sm15804253pfc.136.2018.07.23.10.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 10:09:15 -0700 (PDT)
Date:   Mon, 23 Jul 2018 10:09:13 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Samuel Holland <samuel@sholland.org>,
        Pan Bian <bianpan2016@163.com>, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] firmware: vpd: Fix section enabled flag on
 vpd_section_destroy
Message-ID: <20180723170913.GA100814@dtor-ws>
References: <20180723164857.24460-1-vasilyev@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723164857.24460-1-vasilyev@ispras.ru>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 07:48:57PM +0300, Anton Vasilyev wrote:
> static struct ro_vpd and rw_vpd are initialized by vpd_sections_init()
> in vpd_probe() based on header's ro and rw sizes.
> In vpd_remove() vpd_section_destroy() performs deinitialization based
> on enabled flag, which is set to true by vpd_sections_init().
> This leads to call of vpd_section_destroy() on already destroyed section
> for probe-release-probe-release sequence if first probe performs
> ro_vpd initialization and second probe does not initialize it.
> 
> The patch adds changing enabled flag on vpd_section_destroy.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>

Good find.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/firmware/google/vpd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
> index e9db895916c3..5347c17c7108 100644
> --- a/drivers/firmware/google/vpd.c
> +++ b/drivers/firmware/google/vpd.c
> @@ -246,6 +246,7 @@ static int vpd_section_destroy(struct vpd_section *sec)
>  		sysfs_remove_bin_file(vpd_kobj, &sec->bin_attr);
>  		kfree(sec->raw_name);
>  		memunmap(sec->baseaddr);
> +		sec->enabled = false;
>  	}
>  
>  	return 0;
> -- 
> 2.18.0
> 

Thanks.

-- 
Dmitry
