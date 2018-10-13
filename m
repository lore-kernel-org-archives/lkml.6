Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFBCC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A3B2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="I4713WVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A3B2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJNAPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 20:15:15 -0400
Received: from sonic317-20.consmr.mail.gq1.yahoo.com ([98.137.66.146]:35394
        "EHLO sonic317-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbeJNAPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 20:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1539448644; bh=gbAz2as4RPZF6iVZTLwe0EAdaCnd/3Pnsjgfato54P0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=I4713WVHK7Sb9RtNJ+c4j/I3xccoBiauByBwwuIGOQlk8xuLl9+bQgUKQeoLZw+mJx1ecuE73gJmMIWjKjuE2dYR8DK3IUuJTDjdFujlkZklCdXcOCKMuBGlO13Du4fvH5VfqDRHXxnfD6VPwuIWoR+ztUUyvbpezmc5+E/FZ+cFNzwEENS7OE/TAWL8N1/A2HPC70DeJIgXt4CYYWKSibbHaWoFck3s5emrn7S7OBoS+yp8eydpX7Gq/iDLM982IrxFjgRGCSCW2atp48+az5QDPT9Gg+9Y4JUxQtMAXju9RjEsGGNjw96+iUnBk7x48o6/LphKdwSLuMqiF9GOHw==
X-YMail-OSG: kFZhtWoVM1lIRX.ktxXE9VJTadnP8QD.SZtprRzo9CbvDGT8Fu6ugxAxEClk34_
 stQrAxOtMQ7orJXklZVSlaNAb51zW9B3QiF4MCVVX2Gj4nUYPRmDUh_zNMU70wu_t6V9RBJbUz0Y
 gMo_5PUVbdLKdiCkD5rWY_iPsVAGKY3qbPajzwcdfncE8ouD7soARGJvpGgYUB6J2nHIn3hXlGm1
 .akBAtbUxKEb.xDOk_BVcTZ0ZsfwHbjy4zbDrUib4gA9SCQOz4Ug.EB.zTFr_VRuvpbfxSpae5z7
 NRTODDWRwGopiLawfi5z1O5W_f7iD08gfWsvnKCeDAxHmq4F8W9_AYyQPzXXQbf8DaLVFPZaX6Kt
 5WW29MPFd09a4nWT7ywFH6rBvAMPj9O3E0qKdZsqayGPClXbKdkxDVXoALMrExjC2mRcjr_jBKsL
 8Of76GMypfmbUUjP9EpVX3JpS.0PT58lfnXpG_dAR5Jszt1yd1R4p85h99v3qMXWBQS_sOo8l_Dv
 FumsADqSaK8697nfanZT2D03RVINITpp_PrD9vCoX3ILXWMl2cjIn9gepmPJvXwpGziMAFXb4DoU
 YvsBhI7fCh2V5A70pBHcZSJOs84bFcI2Vxk9gGjX_M8iI7tr_g6Q3H8d8dzv_AUi38LxWlUFNTZP
 vjiyE0sH7h6NofoyP8FzAgwdwnAkqBFyaXWbuZarX4dyGdcEYEYzOmEmLWGHbHMG.mkBwtVF2Bqe
 OqVk9D_YkQMQ6Ls9V.vAWH2jrLQFr65oU97lcv_oLEMvqETvaS2DQutlXxKil2iu3DeyseJjYUe5
 _o7dx7QGm_X20dZUnitgsT_Imyn3Xy2oEJBpY5CC1ZpTmJdaeBZ8cNV37cxk5OvRXU2puuag6fuh
 rw4734ybwb4upYsTZEmG45m0_MaZKMk.UWGltogqX7thCVastnIbUTbI419pTSgjlub5MYOzLVCt
 TK4Td68y9_7xOKIaBLIG92LXaCAFn6ObSeqPUlcmCmLk.9AMiiIAA7Wie39McNSwPK9WxDXesUIv
 7vK6oEzVzKY5silRf09C9RAz4N0g2aaivrvazmlkNPLgxLC1pDm6eue8Cc9R6a5.aiK7IPOsE3SU
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Sat, 13 Oct 2018 16:37:24 +0000
Received: from 183.156.49.100 (EHLO [192.168.199.211]) ([183.156.49.100])
          by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0e0f862d9e4dcf6998805d04edaf398f;
          Sat, 13 Oct 2018 16:37:24 +0000 (UTC)
Subject: Re: [PATCH RESEND] staging: erofs: clean erofs_lookup()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>
References: <a267e4b0-887e-6de9-38db-7ca9a5518b72@aol.com>
 <1539367189-20186-1-git-send-email-hsiangkao@aol.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <896b49d1-8d19-2bfc-ca20-6b4704e737c2@aol.com>
Date:   Sun, 14 Oct 2018 00:37:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539367189-20186-1-git-send-email-hsiangkao@aol.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please ignore this patch, it has been queued by Al for 4.20 in
https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=8300807f9e2dffb6552514763ad60e005c12eb94

Sorry for bothering...

Thanks,
Gao Xiang

On 2018/10/13 1:59, Gao Xiang via Linux-erofs wrote:
> From: Al Viro <viro@ZenIV.linux.org.uk>
> 
> 	d_splice_alias() does the right thing when given
> ERR_PTR(-E...) for inode.  No need for gotos, multiple
> returns, etc. in there.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> Hi,
> 
> Frankly, I think it is a straight-forward cleanup by Al enough
> to be submitted to Linux 4.20 in constant to other pending fixes
> found in the process of EROFS productization these days, which
> I need more time to think over and fix formally to the community.
> 
> p.s. I have no idea whether this patch has been already queued up
> in Al's fs tree for 4.20... :'( +Cc Greg / the staging mailing
> list as well. Or please ignore this email...
> 
> Thanks,
> Gao Xiang
> 
>  drivers/staging/erofs/namei.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/erofs/namei.c b/drivers/staging/erofs/namei.c
> index 0039b76..5596c52 100644
> --- a/drivers/staging/erofs/namei.c
> +++ b/drivers/staging/erofs/namei.c
> @@ -223,18 +223,13 @@ static struct dentry *erofs_lookup(struct inode *dir,
>  	if (err == -ENOENT) {
>  		/* negative dentry */
>  		inode = NULL;
> -		goto negative_out;
> -	} else if (unlikely(err))
> -		return ERR_PTR(err);
> -
> -	debugln("%s, %s (nid %llu) found, d_type %u", __func__,
> -		dentry->d_name.name, nid, d_type);
> -
> -	inode = erofs_iget(dir->i_sb, nid, d_type == EROFS_FT_DIR);
> -	if (IS_ERR(inode))
> -		return ERR_CAST(inode);
> -
> -negative_out:
> +	} else if (unlikely(err)) {
> +		inode = ERR_PTR(err);
> +	} else {
> +		debugln("%s, %s (nid %llu) found, d_type %u", __func__,
> +			dentry->d_name.name, nid, d_type);
> +		inode = erofs_iget(dir->i_sb, nid, d_type == EROFS_FT_DIR);
> +	}
>  	return d_splice_alias(inode, dentry);
>  }
>  
> 
