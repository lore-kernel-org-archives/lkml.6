Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5BBECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949FF21533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="D05R1CbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949FF21533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388620AbeIUFZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:25:16 -0400
Received: from sonic305-10.consmr.mail.bf2.yahoo.com ([74.6.133.49]:43707 "EHLO
        sonic305-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbeIUFZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537486756; bh=5gFemGCDTfvEi6KpnXAdEqRQLmIouF8wOxCNT5GKBj8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=D05R1CbGc54SxoB5iffcrkQqxN3xPiiH1mR85PCWNPVohnF94enKVXVFQBVvYopqGTY4h3jMDSHjPi2tez2mBiQiDKoezCXllJpvyWuTYU9BDyDOZ8fIrd8cN4Js+X4OvItVc0UCc3gjM+GxMYjlqqKz4/uOsfrFUo0nct4CCC5qNejTeV7+RyHCHPY00bGwPswxyqdzbmlrMnUo1xmHvnJmUjNps5/pCjlBl3ZyMOonuq8Fm7OHpGzNm6Eyax5lhPQ+NhjuWkSav66Jy3i5HBcyIUSrhLhDz4qJCpe14IRrThN/6/gMfvcVDfrOqi5jxydYJbhPvYP3QaA6VKROVw==
X-YMail-OSG: ZlPC1doVM1mpsHzdrAj2jRarv4Cfwjs7rNgRsAuih8Rar0wZdQnXAP98uE63UL6
 UPf4mfDhYXTOHBsXntTQN95MCkjfjKo_D9bhpDtPhmIlq_Svq47r63rBzONAOYlGIxhPsgbg6_MC
 w.2ht.se9ygHCG1V6DvrNyFCRHRFS5lWFnYdW4hRpBxB_ITxMcfAfcURQgOrX1pbW5Ygoign91zx
 IT2CRHWU9hFT22zFcvpEQ9BiFetTug_Xq1Mx.B1bQPs_Ida4LPOoIzBgDxd7cFzBZzi99zJZ8z1L
 jvf.h1tnJXzSoOYRfIdTTL_gCN4UO.8a5RlbbD.N4u5U8CtQTYNkSh5nPkIIKpwizrWrqLp_HqEi
 8WWzMPjNOvYVnDA9Q1MS5MDixF8xIUMrPhUbo5pSHZ7QeRHo_2DHDDJhwXOSvt9fAxuDehCv78NW
 jhVgPL4rLbuKNeHsW9K8kUX6ST4RFXO5RM112hSewzYzr1DonCzkwdxmKbY5VZ54U4g4deedYt9m
 W4BwiLG_FuP6drWSNfB_M0sb1EsiPArAFVVYhCFMpXO0pBBDhodOeiwM5jEWXUyDUQNDNrJLELay
 PgGJkZ6NmTjWmGd7aDwb_1pJ1WRm8igOAQSnKIs3kHpENt1.APui8biGkLPyRxfGPGC4wPHllBdW
 2PJwft56gkG7NciDPBWjIweABdiZicRzEG3z8HPT67UWnwcQEssPKcYY2KAbDHJ7tiPw3T55Oe5_
 sngu6KspIuJiE_ux3OF62vxOFlI79.jMWzQrQI2S5duVuG_piIz87AHgxBL5BRta0sVo.gf2wk5m
 WaBzFDXWsvxoEMkxeNiCD0rKNNrqap0coEmrvcO_1oEBIMucgMPXvIp0hCwB46lKhHXS4Dq1OTHj
 brt0cH1YkLkUAVN4TCyLH_FYkEc8TKGWy1ul7ekKlbo1H4MoRdjBl5El3wRE6.DsrOAMDfSPHxDm
 Cu_Z1vGjEm8Mf8ABEt.SEpuV_wuRgFJgInS0F09FLgQJz4c0J8ijL9I6kkYbMekU7lOeK_suWtK1
 pQ5eJfeBumJN7q5MUxnlg5lBajdxhXRhcKtrm
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Thu, 20 Sep 2018 23:39:16 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp426.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c66bc8791b32c3d33a1e70e70151fc15;
          Thu, 20 Sep 2018 23:39:16 +0000 (UTC)
Subject: Re: [PATCH security-next v2 01/26] LSM: Correctly announce start of
 LSM initialization
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180920162338.21060-1-keescook@chromium.org>
 <20180920162338.21060-2-keescook@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <d273e21a-4323-f2ed-84ef-6b47e89633e4@schaufler-ca.com>
Date:   Thu, 20 Sep 2018 16:39:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920162338.21060-2-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/2018 9:23 AM, Kees Cook wrote:
> For a while now, the LSM core has said it was "initializED", rather than
> "initializING". This adjust the report to be more accurate (i.e. before
> this was reported before any LSMs had been initialized.)
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/security.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/security/security.c b/security/security.c
> index 736e78da1ab9..4cbcf244a965 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -72,10 +72,11 @@ int __init security_init(void)
>  	int i;
>  	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
>  
> +	pr_info("Security Framework initializing\n");
> +
>  	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
>  	     i++)
>  		INIT_HLIST_HEAD(&list[i]);
> -	pr_info("Security Framework initialized\n");
>  
>  	/*
>  	 * Load minor LSMs, with the capability module always first.

