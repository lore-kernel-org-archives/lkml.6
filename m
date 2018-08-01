Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9440C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A1020894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QyCEwMHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A1020894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbeHBAoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:44:10 -0400
Received: from sonic311-20.consmr.mail.bf2.yahoo.com ([74.6.131.194]:38230
        "EHLO sonic311-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbeHBAoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1533164163; bh=qAONtwGOA9TywLTQa8feaY8T7BgZS6Glew+428WtAB0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=QyCEwMHRvW4RZKZWzcEVAGroIcCrC18eqQyXUmI/PBUiOWLu6kO22WblOZPgFB35vySup/hvwcAwFCHvsdXtz4HOBFhWtjVr6xen6/DEKGWJAhSGXV5bZOLCnA9JXRCdwQoDaERYcV1/Nd5NXhtwL8vILNq6merdZETZuVbM0v+W2tegrF3u9g6mNnjsIo00baQhMWwLkKzkg5RkSLPAo8M4JxWrHffi3+hpC9dC1OZ+DUMPfax0tXTPTxi7DtnTxS7Zlgf964AjA69Eci37tGWYOnBxmcLpgZBMk2Bbnxu4fpFxa3DM5uOKtHxeQYDwrrBNxZKTT0Hsu1YtU7gHCQ==
X-YMail-OSG: WSBNgToVM1k.CL3g9yuDNAIb86z.SigE.d0JuEzjvCngDOSTe83a.5FXOMZz0Hp
 QYT8At38TGwuM7QqEnR1O7TmnUOWcqLaEuIf6A4v0mfeRj3iuDqyQwFpHIkzBL_vt1efYD.rhTkV
 g9hnJhRlBLcyG4hyISAZfyFQeMm40unyLoBn2VBI9X53i810Ggt0Pr.2vdgc.SNtVIbkBzmFQ4Kq
 ssHztzZJyQMhiNcO3xiTuM1yZ5Fqy9W0xZX_HJH0jCpcJpbwmhyzQ6mtyWaDOw8vgLdxnxy2yo4H
 EIxVoU1m_ggXZYK2Ir8rwlZ6G9VfVYgL4yFeyjgW5Syxo6bJC9alxqHHVdDjrKuu.v7W8PtNISdc
 zXLBQRoz_3FhvswtVqdc0SvUQF6kfrmrd6GAsy84tNIxrHPq14h1n4mXOTvaBEm.w2MRYALLa_fG
 JnOCASu.jb5dktPd7v0D5zajWnrNVZQMO_nRmcJIJwsXRY65.DKOL1bvbaoyLfMfydrfuT0Pi5.S
 jg42UwbmozAIyHn1M3lQj.X9rgKTBiZUnjUfh9fWq8a2yrW..Mh0JmMAlrRs45Fys6IgUhXNHz7f
 GO.anO.r4BHX0r8h1IMMU.eZ35GaEA3q1D1fPwWbRS9yFMXUjx7ukwJkCg34New6k8M81kuKLVub
 n04xfIHlU0EVLyyCBbXQ6KoUCtNPY7zl53B33ZcKjdp0SCn8rDvpY62e0_O9A5Q2e085IHQz.dG6
 8cVMTJpYs_qxbhOaMaM.pmCcS43sFfCEDA_BDJGdNL07mavp86MpObbhCpVb_Xtoriq1wRQ.y5ae
 k5wEnEJjH0s6C0V2xmt7Eh0040UYANsj8MWufoRLeI4wnj5YfH87xvZMKMYMjnAiVcYjQ8n7pBnM
 VtLTqOzkJZT__ITVhKBshyFTV_YLAtoO0ZlAmL3WAZVSuCrHpxT0Hp2Lnk7sTz9uYJK6QOYyjJNA
 6smx1Z28um.JptMcphTm9z0.8s.pi7GfW2JHXcvleaGc803.UGNuOOVbVCMSSaCcU7uRDSNttN0v
 MUgFn16tGt0_3DzbvIiVm8gxvUqFqWxpz
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Wed, 1 Aug 2018 22:56:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.104]) ([67.169.65.224])
          by smtp412.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 445dd5a84bbe948e3f090958c8efd614;
          Wed, 01 Aug 2018 22:55:58 +0000 (UTC)
Subject: Re: [PATCH] Smack: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20180801223854.GA14499@embeddedor.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <da15be5c-6c5f-3002-6562-50c60cd44263@schaufler-ca.com>
Date:   Wed, 1 Aug 2018 15:55:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801223854.GA14499@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/2018 3:38 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Notice that in this particular case, I replaced "No break" with a
> proper "Fall through" annotation, which is what GCC is expecting
> to find.

Holy bikeshedding, Batman! For decades I've seen "no break" as
the proper way to warn that the lack of a "break;" is intentional.
I suppose that "Fall through" makes just as much sense. Grumble.

> Warning level 2 was used: -Wimplicit-fallthrough=2
>
> Addresses-Coverity-ID: 115051 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Sure, I'll take this for 4.20 as my 4.19 changes are complete
and there doesn't seem to be special urgency.

> ---
>  security/smack/smack_lsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index ad45761..a307b00 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3739,7 +3739,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>  		 */
>  		final = &smack_known_star;
>  		/*
> -		 * No break.
> +		 * Fall through.
>  		 *
>  		 * If a smack value has been set we want to use it,
>  		 * but since tmpfs isn't giving us the opportunity

