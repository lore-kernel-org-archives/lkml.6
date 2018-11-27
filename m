Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBFEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618BC20645
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jA6D8baU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618BC20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbeK1HSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:18:05 -0500
Received: from sonic315-20.consmr.mail.bf2.yahoo.com ([74.6.134.194]:39887
        "EHLO sonic315-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725764AbeK1HSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1543349941; bh=ZeW4A0WRiIY0RljImsQz7rtv1MTO/NfkEhixbHKV51s=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=jA6D8baUSaDQgSg2WDCNpeA8ZHqBstt5G/tNScEfNMkNI5G3Es58r1ua2dH1sc4e+B14tP1AX4kyriQfloyiUifdV/mZENhaK6aswgiHAfajGULG+MwIqYaTzk/Xof1mHBoiQJ3dP1uq+08SOKUIRzQGd2dJ4oVfo887aybnxkyEBy8K/hY3VBg0ByO4UlihuDbMoYuLFWniuic3/G2ZBoCcY3tOPtJYNHvehs4WUdP8FAdLu8o5UM2N68dwAp5hqQxO2nk/ybWZjjmVLiq1n+Wkkxcs6VsNvZn69bw7Pdec9xE7z3NFUq4z0l92u7rV4HG3Cobc8qiHZPLYAv52KQ==
X-YMail-OSG: LEpw7t8VM1l3_mG.iV_Ry6rq9fapMvdUn8YajkcHmqEXqJNLfX6KvSln7W5PGSk
 Ga1vTFjC8gJpHA6GKZHK7mE_qHox.f1NA4oWKBdtQCNO0laXDgfekb4CVOkOqEFOs1OXBYJ1aCm1
 fhgXWVj9vBORw7MnAph1zYBZEE86YvzxUQ2X4OsrDcLygT721PhXnnVZzYdEAEzp65KV9x8MDMXg
 WK7tUUrJgBlX_dPX0s6j3rsA0_0Nk1WcDqDKzs4MwljXrYl9uz3wp4q4aEwkXJjvb87AV0O84bqm
 ud4yUDZhbjjm1I_EZtSnsyRFz4cQojKra9THz_eoA17pjU6_Pm3TTnjSgVZ55Ek0Tnel3GXNmxt8
 U2fJoWjMHMIp8DS5Nc6VsGzG28LdFn0SMrW6fyCBLMkkIXM3bBg_p.QQ90EY6OdVt8Qml3th.ZxR
 sG0Ex3aBrF4vMYfusvpcHNV7CRRHkK0EuO_jMlENSHo42OP5BGYIPrvtk3p6ey1Sah3CBFqWY70L
 8l0uRNvfviSLL8N5aQdQXhHWpyKZBcMjKemCZvzPeD1.LXY5mLq9TZfSk_M_nqhNJkkDuDW2s5ad
 GLIk3QtR1z6H83hHsLK9ERbEXQbI212suoUw5hKRpVrnCqsrOC6cOIvXIzQ8aWOeyEKhTmAkDe7s
 pJ2zSd5dIM7.UI8BVBeW7RUEhGAf0w1VbAcWOCTkSAJ2pFvWbmU3Da9atbKq3K772gaWw58PhOEf
 Tcr8N95GD8s480obIFjHciE8pabnQB.widHe5on1XTHMxHC_.P0SlSLy87.9WM9ZbL0ZI9GiQ.Lc
 RZ1t2oVKV4FZxpiGIdqg.mkajqE4DGoZkmVinhbB8fSMqsvR0Y2d8AvZEQqDN3JSdvCHNiFi51Yo
 HlGkAsHGdD6IBOqyJS.9_F1gLvvd655Gw2.3Xho5kfWJ74Lm4.9IA1oAoeIkrZAao.u8Kz1c5Iby
 V4Kr892EwpGzfa6kovURIJHUzc9SEkzVVGj5VZDyh6h_kX7x7a.._rGZuZMMqGT9yteq8Nsungig
 rK8ZKtxh6H9JKxUNBLe_MWn5kZJNOZ7.jxCIOAGGi4oj5kTx7lW9_nZs_D69PWgWK08G6QGgLWs8
 NIZ5U9QE4hD6XQoPQbPWO
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Tue, 27 Nov 2018 20:19:01 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp401.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a85d5e5c7da857e3277d6788a8ed893e;
          Tue, 27 Nov 2018 20:18:58 +0000 (UTC)
Subject: Re: [RFC PATCH] smack: fix access permissions for keyring
To:     Zoran Markovic <zmarkovic@sierrawireless.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <1539818744-30912-1-git-send-email-zmarkovic@sierrawireless.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <922bb08b-60e5-d43a-d48e-5b54575efa8b@schaufler-ca.com>
Date:   Tue, 27 Nov 2018 12:18:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539818744-30912-1-git-send-email-zmarkovic@sierrawireless.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 4:25 PM, Zoran Markovic wrote:
> Function smack_key_permission() only issues smack requests for the
> following operations:
>  - KEY_NEED_READ (issues MAY_READ)
>  - KEY_NEED_WRITE (issues MAY_WRITE)
>  - KEY_NEED_LINK (issues MAY_WRITE)
>  - KEY_NEED_SETATTR (issues MAY_WRITE)
> A blank smack request is issued in all other cases, resulting in
> smack access being granted if there is any rule defined between
> subject and object, or denied with -EACCES otherwise.
>
> Request MAY_READ access for KEY_NEED_SEARCH and KEY_NEED_VIEW.
> Fix the logic in the unlikely case when both MAY_READ and
> MAY_WRITE are needed. Validate access permission field for valid
> contents.

Do you have any test cases for this?

> Signed-off-by: Zoran Markovic <zmarkovic@sierrawireless.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> ---
>  security/smack/smack_lsm.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 340fc30..77e405f 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4326,6 +4326,12 @@ static int smack_key_permission(key_ref_t key_ref,
>  	int request = 0;
>  	int rc;
>  
> +	/*
> +	 * Validate requested permissions
> +	 */
> +	if (perm & ~KEY_NEED_ALL)
> +		return -EINVAL;
> +
>  	keyp = key_ref_to_ptr(key_ref);
>  	if (keyp == NULL)
>  		return -EINVAL;
> @@ -4349,10 +4355,10 @@ static int smack_key_permission(key_ref_t key_ref,
>  	ad.a.u.key_struct.key = keyp->serial;
>  	ad.a.u.key_struct.key_desc = keyp->description;
>  #endif
> -	if (perm & KEY_NEED_READ)
> -		request = MAY_READ;
> +	if (perm & (KEY_NEED_READ | KEY_NEED_SEARCH | KEY_NEED_VIEW))
> +		request |= MAY_READ;
>  	if (perm & (KEY_NEED_WRITE | KEY_NEED_LINK | KEY_NEED_SETATTR))
> -		request = MAY_WRITE;
> +		request |= MAY_WRITE;
>  	rc = smk_access(tkp, keyp->security, request, &ad);
>  	rc = smk_bu_note("key access", tkp, keyp->security, request, rc);
>  	return rc;

