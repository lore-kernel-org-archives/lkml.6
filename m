Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E47C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36132086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="M4N/C1wt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36132086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbeKJDsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:48:46 -0500
Received: from sonic310-21.consmr.mail.gq1.yahoo.com ([98.137.69.147]:46770
        "EHLO sonic310-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728162AbeKJDsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1541786824; bh=yQJkBtN7lSvAJ4kOq/GubbEDzJk3wH13TAO824XnKw4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=M4N/C1wt0Xl4cjDYzCX1dBVQX6q3PyBuiWeAzuYOyj+nsenZSDjYJq2jbIiQeh79N8JN7ZjJasYCN30tpqeqChxLFJW0hY1rcSAR3agK4CNLNxa0GjnNFNyy+h2p3JOH9Kc6Z1q4syUtudRXD/nd610ZTGszcSVoEdbKhP6dBydiMB5RQZPpiXl9iHc1gZExeiZi4Qw7m8vYN41qG+gb9Ius7hBdVfvgWDhIr5a043ir6WZunSmR+rTx0a+rHTXNDXbb4YjcV9zgXRtsoSXowpTwwu8UsdVz7FG3rPBCuikCtOjE081nJcGedeESpr+eqnVzmTtB4WqBeE/7c4u6iw==
X-YMail-OSG: KwWXtu8VM1msmCPPgWO5NHz_QpkfgC60YZxLAWih9n2t1zTkZl7C9eq0hVICmwv
 fV2iJ5yWeeXHVQPdlSjEMjfwXeq7JdAoFjFYhIaDBv_JIjOWVONczLuYLPWEhpxbmhKf5.8DO3c8
 YoNH83qQf9A7ZbjkyWzH3TliwmwoUrkc2f7c9iGtLKfBUqkxrTpQ1kml.E2ks7ytpPdqacAywEmH
 O.g4W2Njxk8oqlSOJA2fcfqXC2tHF_EWBabJwX7pjtlGdMAEfMoPmkbvTHYRmQdadfMVlHXuKuCt
 gX8lvVtZIGrLFTBiprAxfZnEOCEUDygDYSfMsBsJPl1flFN6sOsJJYSbx5YjvPd.aFCeJFu4uB80
 _xCTdrxpbNMEgNe8Wc8W8hvg1285.5W81QhIy.YDMCw07gEz7IOqiCimzvBGTzxXI_3TUJ_f8Bhk
 nd5ju.N5_x7OrftpS72ihvoCeUw3vHXbl2TeOizv0HohgJZnqzLLweUmI5Q3S0CmUa0ni9VFwcp7
 gfRHG9qMgxopkzv1uMQvXVXpUx3.Shl1HT7.MboU2mJNVcDwxo.4ijcyy9rmy.wOs1Mzv_ZGK0rb
 ZuvpXerdBJjnqPquCOn9Hg.BKYgWemUHLv7H.J2iozhBx2B63N8CY1XRtW0vLsNIgM18F2twydHG
 .h.QISfasC5a.TNjeiFdS2STM1J0bIz1_eTdvUPNRY7X5_S0Mw.J9d1iDB_UfOs41KXdTlb8CszD
 r.kWLS0Pricfnt9qG28OMtWFe7wUPr6C_Gt3r6PiwMTMv7GGP8g6Z1uBkEd._35nNzEYFINIjF0B
 AyNcS1ixfHfkMqVGnN90b3jOOaqHrjlMtGgcoOtbVWv5Hchgc8MCZ_t4SUwj.xSoR0lmQIeXqZ4.
 Nk2b9CYsWDCpvCLPANYh5xmI7V4Jr8jwgi4Zl7anT_EvFgCds0WxBQPDFznirzOz.thLl53DtBr7
 K4_niorPfTuBGBM36yExmPLqtByVzolKaVBSCWfhrTU3gN70rXtqG9LfJxvwHhE.r4N5UMePmhTX
 rqzhevNiHqOxjWJMvcGGdhVK3W0_sEsCeeHPSAP.pDofhlw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Fri, 9 Nov 2018 18:07:04 +0000
Received: from 115.204.194.147 (EHLO [10.1.1.220]) ([115.204.194.147])
          by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 210425bf1609ea178f945a5cdea3c67d;
          Fri, 09 Nov 2018 18:06:59 +0000 (UTC)
Subject: Re: [PATCH] staging: erofs: select LZ4_DECOMPRESS to fix build error
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-erofs@lists.ozlabs.org, kbuild test robot <lkp@intel.com>
References: <e2365d5f-aabb-a631-1338-1e32f8c9bea6@infradead.org>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <fcee5841-70cd-d961-8bff-834d0cb2da94@aol.com>
Date:   Sat, 10 Nov 2018 02:06:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <e2365d5f-aabb-a631-1338-1e32f8c9bea6@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thanks for taking time, I have sent a patch to Greg fixing this issue. :)
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=7962e63a2f4140631ad10d475d96193a3bc8ec2f

Thanks,
Gao Xiang

On 2018/11/10 1:58, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> EROFS Data Compression support uses LZ4 decompression, so it
> should select LZ4_DECOMPRESS to prevent this build error:
> 
> drivers/staging/erofs/unzip_vle_lz4.o: In function `z_erofs_unzip_lz4':
> drivers/staging/erofs/unzip_vle_lz4.c:18: undefined reference to `LZ4_decompress_safe_partial'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kbuild test robot <lkp@intel.com>
