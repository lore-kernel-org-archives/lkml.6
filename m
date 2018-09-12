Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B072C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11EA2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfzNanpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11EA2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeILX3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:29:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46239 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeILX3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:29:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id t19-v6so1358411ply.13;
        Wed, 12 Sep 2018 11:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=78zE2RUYart1eDswnsALitXSy4kUO5QJEClvYaLU1Mc=;
        b=UfzNanpIOjJUIPL3DTRf3xsBBOaUfpGDVlNipp/9CDfM/E0ki5CRuBmvxW/B1I4uRz
         IRfHFC1m8wOpBJ+TPMhkjogZOjxLF9yoYSue5ozRFvbuToNgxqzPwdM17Txz8cGCgMdM
         FE/eLb33HbmLJOO3IXipLu8TPhGvIEv5M4wlFM5whgvczzinSx4FCJS/O5YfAt9UgCfv
         PkuopU1FzdDli0zBbHwBlj2Dg6YNWHeRiWe8K5iQe05U9ER0zbm0L77Vbg6MeSxE7Xxy
         y8osktfCUbR+YuqVKD3Qpy1GqaQz825kX5o9GRfQ2fOXH2xYmrbYWZd4hTxG2bjouOeq
         2tEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=78zE2RUYart1eDswnsALitXSy4kUO5QJEClvYaLU1Mc=;
        b=Vrc30UMIWZ3TMGFQBXN+pU4c2xx5gILtDzLUvvgVO8XYOotIlil6q2omoTPBArxPNh
         BlykuJVatwvLxX79EM9Ppl/9dvYiv8OAwJdGmQZBKRBGbSNVeXhV9a2NXmMS139pjRVZ
         WVgpgKwtJyTl6OGPD/Y77WAz0dMJ12KU0vh+WMB422WmjFcKYDlP6ejaRTOaTukq+i4D
         eB8ruEoEcgTI1NW+yr0xAT1iIoKzdiXJbiCh1QKZfjziUQ+7Hd5Pl7li+RzIK1HGX+F9
         GDb8fwT1s6dAfKkkwGmsbxNvls9g4qt07b2Fc4+tLKzR38yxW4vvE1EDrxNuO45j+IVf
         F9iw==
X-Gm-Message-State: APzg51DuXIo4R4GH6pRV9whY3Fx6Z+isSTWJztb3sTwF2e+7w2sT3gVA
        3v4n++oyVaUgD/wMsaLOxd97vxq1
X-Google-Smtp-Source: ANB0Vdbi2qzIzTSBPoNgDXSgNx/wQeSAOvF42Xxp9TgcFcrEXe459rgYATm4i7r42fsFEzb+NqmOrw==
X-Received: by 2002:a17:902:1681:: with SMTP id h1-v6mr3662698plh.262.1536776638172;
        Wed, 12 Sep 2018 11:23:58 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id j184-v6sm2155672pge.77.2018.09.12.11.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 11:23:57 -0700 (PDT)
Date:   Wed, 12 Sep 2018 23:53:50 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Afonso Bordado <afonsobordado@az8.co>
Cc:     kbuild-all@01.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/5] iio: fxas21002c: add ODR/Scale support
Message-ID: <20180912182350.GA13032@himanshu-Vostro-3559>
References: <20180911150011.31964-4-afonsobordado@az8.co>
 <201809121715.5Babt1QC%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201809121715.5Babt1QC%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Afonso,

On Wed, Sep 12, 2018 at 05:26:01PM +0800, kbuild test robot wrote:
> Hi Afonso,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on iio/togreg]
> [also build test ERROR on v4.19-rc3 next-20180912]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Afonso-Bordado/iio-gyro-add-support-for-fxas21002c/20180912-084443
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "__divdi3" [drivers/iio/gyro/fxas21002c.ko] undefined!
> >> ERROR: "__udivdi3" [drivers/iio/gyro/fxas21002c.ko] undefined!

Hmm. This is nasty error that had hit me back and occurs when you
do 64 bit arithmetic in your code and assume it will also build for
32 bit environment(i386).

https://lists.01.org/pipermail/kbuild-all/2018-July/050481.html

But looking at the code seems like there is no such 64 bit division
which is why 0-day didn't inform you the exact line of error unlike
my case in above link.

And I suspect it may be originating from your code snippet:

#define FXAS21002C_SCALE(scale) (IIO_DEGREE_TO_RAD(62500U >> (scale)))

and looking at the implementation:

include/linux/iio/iio.h
/**
 * IIO_DEGREE_TO_RAD() - Convert degree to rad
 * @deg: A value in degree
 *
 * Returns the given value converted from degree to rad
 */
#define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) / 18000000ULL)

This '/' operator might be the culprit!

Just for checking that the error, remove the macro declaration `FXAS21002C_SCALE`
plus its usage and re-cross compile using `make ARCH=i386`.

In my case I used the `div64_s64` function handles builds for both 32/64
arch accordingly.


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
