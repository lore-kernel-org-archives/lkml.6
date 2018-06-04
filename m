Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1958741-1528146100-2-15010899299441076951
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528146100; b=GlPd3KdL/beARCZ/yDn7MhBXWKZw3RmVlzaQtzkszFMg+z+Jqq
    gkD/N3vpqTvSFLFC1bQBDGeZtB8ATHDQ1PMUEU6mmPp31DuvgRHUEVNTNxSqr5O6
    HVbjNX+eeDf98TJ7dTH1A0nfXZx/kscIioOtvutF8a7Rk0YnOOJmYzd/YU2qboSk
    8pLMf3FoHZQ8gGLFY6VrYxbj7zHuMTBbtvaPdbrjp9HLxQ/7R6DBnIFNBcD0MWOp
    lO8zi1iXwFsZqG0GDhYmPnXDfgfip1+1MFA4GUS3Zv2RqkOLRRN1GJKCJFMpC/80
    CiviLS4copG9wxpTrSaPKU9IEN3NHDrZvFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528146100;
    bh=VAxjPiaGAYkhqhjeJQIF1UkCAG23DVc0dHVkLSYzISE=; b=h5KBrDIAlUkj
    F1L+9om/o5HnPhmOq1TheqS+XtHMQTaJdSMDxJ1wddBppZMZmXgcxDHvwnTZw20w
    3c5asZOznCRO8asV1NrkXBixljVtUZlrvapBBsZFWkUHy+ckLhGL5drstw8WDRP7
    XzRa49GRdsPVvyMfxN6M5vdVohq7HObmTQ/S6T5Utb0dRpM3RvulTSMKK5jX4IFA
    vCrL7llkjQ9w/QtD9mYXd57s3DpkjAxGLiPLvbmvzADvKZ6KuGUu3QRXkjhvVL7x
    CU213EYUwdQ0kpk1+TMQvkRk+7zJAgNLpIwKJ9rpitBEuaRU4PGzs1DeeH32++g8
    oMJYvpUMFg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=yahoo.com header.i=@yahoo.com header.b=G4ADRGC3
    header.a=rsa-sha256 header.s=s2048 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=schaufler-ca.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=yahoo.com header.i=@yahoo.com header.b=G4ADRGC3
      header.a=rsa-sha256 header.s=s2048 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=schaufler-ca.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFbxJ4OVS1fa8fbRiaKynKGRSFjo/deg/hhjyZuFTCddIVw1SLx7O22YJ4vDSuq/sTve51uQVX9dgz3nxp2Y1UeHfWbMSv/afrcLodVwEpqYa86fuNHN
    VxQiIbI3gU27T+kuB8QYPnIM1u18mhqEWcF2YmvjMAfwnVWmWoOo0hhd2V07QWX2riDezARrf91SKW6KlZkS80lso6kMWr0l/flZsC2yI9dcsviA6xsmF8EN
    Ai2c0Ydx6uqNnZFDqSnYXg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=5HJ6KZJP-kkA:10
    a=7mUfYlMuFuIA:10 a=rs0AftgEab0A:10 a=3NGxsLzzGfgA:10 a=ZZnuYtJkoWoA:10
    a=vpqfxihKAAAA:8 a=VwQbUJbxAAAA:8 a=ySSoE8UPKxjcoRelgnkA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AULIiLoY-XQsE5F6gcqX:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeFDVBh (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 17:01:37 -0400
Received: from sonic301-28.consmr.mail.gq1.yahoo.com ([98.137.64.154]:39456
        "EHLO sonic301-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751010AbeFDVBg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Jun 2018 17:01:36 -0400
X-YMail-OSG: lh1JmTQVM1kI0CsVmsC4Z6oOb2ERfyB2UdELI3TnVmDIRxw9Kw4r2kDyuBpvwUV
 HAUj4gt3HvWxNPOpWRdwb.Vv0.sU5kC1CawVgc5siLs4iDtL.pWFT03_NPEVE5zRzhphGDHaKxsY
 EGWbHguCWdp5KtiBUprzfVonk7ZPdz2bffChrdJ7hTXPZtKkzXiTbY9eU2d7.GgrYfIVXBMl24b3
 301INb0nCvm0o4HOiY.PovzMGSP5TzlrbOy8NnC_dZnnIqfL45n6x7PxIfhDqiZKOXUAfdacLTgs
 rrgPyU1dHaPPMpEIeGdzQ6J0A7rNKFrXQ62J9jYAG.2sdnkMR379TUaDVtHlHB.ddcJtXqEkn6.s
 S81DuBeDc3mo03Pkhjc4YbV3pKY2ILHNuKxHJscL_53pD6ujs26zu3XZTq1IPGGoAiupDmgbN2DR
 jM5ydmjKnARoFtQzOJKy1_lXRpnicoDNsxkIu8E5B0NGlv3D0FNsi2VSEn8ZBJgiITa5YseETBa7
 AsX9HHBP.bD2yBfaRqvcq_bjYzpUFyE10JyQtxmG4i2dUttq0tLz2Xv8EPaZ6bn1G4QHDQVjdUWU
 xyi_1CyX.P0D3IchtRg3.J7YbMPdH5T6fYTtRbIRNiskPP1qaeDObV5Y9qcUiZtFHDneAAjImUHm
 J9_1ovRpLGI3Rgi1IAfT_zM4PS9ayT_WgUkQFAnvymRVfNNBlhczH1hLyKim37G4g
Subject: Re: [PATCH] Smack: Fix memory leak in smack_inode_getsecctx
To: "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Cc: chandan.vn@samsung.com,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        CPGS <cpgs@samsung.com>,
        Sireesha Talluri <sireesha.t@samsung.com>,
        Chris Wright <chrisw@sous-sol.org>
References: <02d9878e-65bf-5de8-9658-cf0f692f358c@schaufler-ca.com>
 <1ced6bce-92cc-7e0c-fab4-0aaa3d03b82f@schaufler-ca.com>
 <1527758911-18610-1-git-send-email-chandan.vn@samsung.com>
 <20180531153943.GR1351649@devbig577.frc2.facebook.com>
 <4f00f9ae-3302-83b9-c083-d21ade380eb2@schaufler-ca.com>
 <20180531161107.GV1351649@devbig577.frc2.facebook.com>
 <20180601085609epcms5p5fefac0156a4816e9e48751211ab595ee@epcms5p5>
 <CGME20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b@epcms5p7>
 <20180601162913epcms5p7737f5b4376d8865af1eae119aa866550@epcms5p7>
 <5b0b157a-0e8c-d8f5-901e-836d545a8e4c@schaufler-ca.com>
 <fa278910-5c99-11dc-c9cb-b88a97592e53@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <b6cc4bd5-8d79-bbc2-373f-ea0bf0806884@schaufler-ca.com>
Date: Mon, 4 Jun 2018 14:01:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <fa278910-5c99-11dc-c9cb-b88a97592e53@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 6/1/2018 10:45 AM, Casey Schaufler wrote:
> Fix memory leak in smack_inode_getsecctx
>
> The implementation of smack_inode_getsecctx() made
> incorrect assumptions about how Smack presents a security
> context. Smack does not need to allocate memory to support
> security contexts, so "releasing" a Smack context is a no-op.
> The code made an unnecessary copy and returned that as a
> context, which was never freed. The revised implementation
> returns the context correctly.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Tejun, does this pass your tests?

> ---
>  security/smack/smack_lsm.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 0b414836bebd..5e3beae334a8 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1545,9 +1545,9 @@ static int smack_inode_listsecurity(struct inode *inode, char *buffer,
>   */
>  static void smack_inode_getsecid(struct inode *inode, u32 *secid)
>  {
> -	struct inode_smack *isp = inode->i_security;
> +	struct smack_known *skp = smk_of_inode(inode);
>  
> -	*secid = isp->smk_inode->smk_secid;
> +	*secid = skp->smk_secid;
>  }
>  
>  /*
> @@ -4538,12 +4538,10 @@ static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
>  
>  static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
>  {
> -	int len = 0;
> -	len = smack_inode_getsecurity(inode, XATTR_SMACK_SUFFIX, ctx, true);
> +	struct smack_known *skp = smk_of_inode(inode);
>  
> -	if (len < 0)
> -		return len;
> -	*ctxlen = len;
> +	*ctx = skp->smk_known;
> +	*ctxlen = strlen(skp->smk_known);
>  	return 0;
>  }
>  
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

