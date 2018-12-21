Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFB3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED8A2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ltZP66GU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390974AbeLURlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:41:39 -0500
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:37161
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388325AbeLURli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1545414096; bh=LHVWCV7tZZr8Mo2LtZi9Mt+UqgfTgREhbX1PqFeruog=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ltZP66GUDvZdfduvlkl9Nlp+o9upe+l2Z2opbCeREZRrTnN+EC+dE3xQv9ARijg7z3m+x9BTjZ0nYj9nV0sy46fS7G/M6AKGA6Bc+0DxsvlyaYZtfInXaQeS+vaEYXkF8iMKy2/drbKluoeb7oH9Jl2eiNlga37g1iSIM0YEs5+YyO/Vt9fRE+7obZu0sbEt1qfy91HivFeOAjLf8F3J8ub/ipM5g9CASPjODzuYEhTPiwWmmFRVAZDQRl/n3F2RnR6lbx/7g0wgI6nLPD/DMeKlEXUTDqbV6XX5Ubj3U05/hLqkWDjJboYGc6nUD14hsb7Pk2poGP/7NGRcq2EDGA==
X-YMail-OSG: vOdHciQVM1mpTBlSwl6f0trxHEknnw6iakrwwx3ObD6_91Tsqgr882Is2zXZaG5
 UFbRZ8NNQEdSO3HpsoEFnIr6cK1TUTyPsGqTQbwvV9..NKvMZrVqvCyNIuztpQ5uHgrWmf1oMPaZ
 iyWsq0HloXout.WeYKuEpiHxvn74sk3R8j.HUzSYFxT.lgWE8n1n.3DX32fQOkVRvPVKnISmOnV0
 HxRocQrdq.Q6t.R0dYlS6DSvNDt72aHmQ8.hAXL.kSCGerlXodM0HUq5lOLPKgq3lEm7sBNiZByS
 74h043tTCBJDUNToKZ.XSha6BF.gguTLnVVf910FU_Ja5O_uO2JJmrivqv4PJ9dctMazjzztnhxG
 y_4LSyJsapfi4whQhxL6ZFUryS5a27KIrlcG9FF3OvNLhu7eghoWMJlctNyL64UKaKJ7K9UYwkfU
 LjU6cJHxXupJDh5uZAXVChHAa2eOhPV29W9vdRUYgnWLbSxwZR93JV3DZUT8y5OGe02ntI.rUQs5
 S8UIHtcAOH8bLYQp0OSRiomFNH0ZCU8sxwKVYiCMoBCfA9PTh5sC7OrgjYUoZl36DOPNFCIwAioZ
 zc.vB1zcn26VqzLmMYPtX5xo81OY5jYiT7IyE8vlJfpPPaiRrdAdWAcA.kgont2MfCDxXPCN_hPt
 vDQBkJuZt2Ek79kSk352bE7g0uSvlAjX3Ws_1RAdbcJZTyhBFwFkdMInyrYAbfX.9bVX3kx19vqB
 Atz1fItn0Q38eLbW4EtrYt_qf98gOS.DInBBcpxZvhkvW5VD8ZZYj85.UHElwQdpCJPBi3TpncgX
 6hBBAaJzLj4ym5LD9e4di1Cydc1OMlJCztbMAg0sR.fymvE.lkiiimMYU69hsAuR4Bbkq8oo6USJ
 67e6svb21Wdeac9MBSVmzHQoMUm71VHaABhh3KSrVGY517Ip.74nOBy7BNz36c_vMkAVqzYJ_u6q
 Cf_88mzNXVxosRWMWDPsJSuwRHzn1UwTok2ari5yWh10oiuxxhsY_PignJfHO5scdJ4F8RNqCCPO
 ZVxMl25Ymy1NsIHU9Y.bkr34Zx6jT6VKqGPN2Dh8b2LVkG9ETSRlRgWmo1Dp2gDtg0BNIg6PiaJJ
 HoqSf_8c3A_D6A2TqPJY46RbeJ9jLUZf3CkOU
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Dec 2018 17:41:36 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp418.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID fc15a6c7c3799222f033986be111029c;
          Fri, 21 Dec 2018 17:41:36 +0000 (UTC)
Subject: Re: [PATCH] smack: Fix a memory leak in smack_add_opt()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20181221090958.GE2735@kadam>
 <20181221163654.GY2217@ZenIV.linux.org.uk>
 <20181221164219.GZ2217@ZenIV.linux.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <bd05d276-91a2-c849-065c-18aa17a0ff82@schaufler-ca.com>
Date:   Fri, 21 Dec 2018 09:41:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181221164219.GZ2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/2018 8:42 AM, Al Viro wrote:
> On Fri, Dec 21, 2018 at 04:36:54PM +0000, Al Viro wrote:
>> On Fri, Dec 21, 2018 at 12:09:58PM +0300, Dan Carpenter wrote:
>>> The function is leaking "opts" on the error paths.
>>>
>>> Fixes: 90e3b564ab93 ("smack: take the guts of smack_parse_opts_str() into a new helper")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> D'oh...  Applied, thanks for spotting that braino.
> On the other hand, it's easier to do it this way - the caller will free the damn thing
> on error, anyway:

What tree/branch is the happening in?

>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 11da1e2531c8..cf0c0380e5dd 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -608,6 +608,7 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
>  		opts = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
>  		if (!opts)
>  			return -ENOMEM;
> +		*mnt_opts = opts;
>  	}
>  	if (!s)
>  		return -ENOMEM;
> @@ -639,7 +640,6 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
>  		opts->fstransmute = s;
>  		break;
>  	}
> -	*mnt_opts = opts;
>  	return 0;
>  
>  out_opt_err:
>

