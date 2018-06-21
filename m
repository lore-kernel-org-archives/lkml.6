Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C970C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B463B20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew4z6cvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B463B20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754344AbeFUBqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:46:04 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33528 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754093AbeFUBqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:46:02 -0400
Received: by mail-qt0-f195.google.com with SMTP id l10-v6so1518793qtj.0;
        Wed, 20 Jun 2018 18:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xsUjTc6yAlhkv5aUviPgwAySdCPI8SobxucJl3qyTx8=;
        b=ew4z6cvsQIX1I9mVBBFjTslr/c0OtdFOHrA6U/E0Zek2WYoZS317Q9snXBORDJrolO
         zIybAXQhKmhrYZcgg+gHt59UQ6fFqOygyvQaTepG7+BNbfOYAKr6iRQxoiCojBcM29KH
         0kuTXRC+2xru7eztMYfNu0TUI2m65RebRwXAXu2aY/m4ykz/WhHcqGk0Cw1u2AFDQDSD
         6Ck7uxIVag+DZ66J+QhQvN685+gHoFusAtBDbOhQGDsEC2z+Tsxd4UhclpVz5KL2sMKI
         jhPiTxyrifdzKzUzlLlljtpB5C861cQPFFZxpipCqx3+WzVpjtijgW4YSExufctWju0Q
         zDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xsUjTc6yAlhkv5aUviPgwAySdCPI8SobxucJl3qyTx8=;
        b=sEZcN3GfAN6eMpHqhrK5sHGjpQS2qkTT0cwbw1VsNYbBozLOQVDtqLhAgtWL8pCfws
         3ZkhxMS9BMpcjdorF37AHcAzfStypTP+0rxSHm3i4fu2HwSJLfyxOtfc/pJ2Y96RYKWe
         N1/7DQYHAoV3oAkacdqEkomhF7rh9sHIzoQROvVTuL4urgnhoVChRcYWNF9ny8jqc32P
         eLK/+FYJ8pNc8llXxnKPwTf2Piek+InXmQ00CSCfx2EZw7e2jUf1+fvONI+6rvPlWBJ7
         v6qCaZ1QRe6rjJzFnoM+QyeaKftiIuCv7ICaTXPgCf8lJOBdo09jpcvF6drTjLKXBN6/
         T6Uw==
X-Gm-Message-State: APt69E0kX/1Mpbc773WzDGrr1o3u4NhGU63WlstiPlCeM29TyBW77q9B
        TCylTDH7YUtFGfFTQSlvn9w=
X-Google-Smtp-Source: ADUXVKL7iBwY/aGDJB+2FNRazw3QR5kONIGGh9d+hhLxMhTZK2ZoEBi/pTZBirzPpdBg/6+KdsQKFA==
X-Received: by 2002:ac8:491:: with SMTP id s17-v6mr21312788qtg.46.1529545561434;
        Wed, 20 Jun 2018 18:46:01 -0700 (PDT)
Received: from eaf ([181.47.179.0])
        by smtp.gmail.com with ESMTPSA id t6-v6sm2184920qtn.86.2018.06.20.18.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 18:46:00 -0700 (PDT)
Date:   Wed, 20 Jun 2018 22:45:56 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     syzbot <syzbot+01ffaf5d9568dd1609f7@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] hfsplus: don't return 0 when fill_super() failed
Message-ID: <20180621014555.4ul7w7wwkzbeifr6@eaf>
References: <001a114467485371b605691053fc@google.com>
 <d83ce31a-874c-dd5b-f790-41405983a5be@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d83ce31a-874c-dd5b-f790-41405983a5be@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 07:08:24PM +0900, Tetsuo Handa wrote:
> From f78a5fe168290cb9e009f4d907d04b5bfe277831 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Tue, 15 May 2018 11:38:38 +0900
> Subject: [PATCH] hfsplus: don't return 0 when fill_super() failed
> 
> syzbot is reporting NULL pointer dereference at mount_fs() [1].
> This is because hfsplus_fill_super() is by error returning 0 when
> hfsplus_fill_super() detected invalid filesystem image, and mount_bdev()
> is returning NULL because dget(s->s_root) == NULL if s->s_root == NULL,
> and mount_fs() is accessing root->d_sb because IS_ERR(root) == false
> if root == NULL. Fix this by returning -EINVAL when hfsplus_fill_super()
> detected invalid filesystem image.
> 
> [1] https://syzkaller.appspot.com/bug?id=21acb6850cecbc960c927229e597158cf35f33d0
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+01ffaf5d9568dd1609f7@syzkaller.appspotmail.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>

It's been too long. I think I should give up on my patch. Maybe a review
can help your version get merged.

Reviewed-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>

> ---
>  fs/hfsplus/super.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 513c357..9e690ae 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -524,8 +524,10 @@ static int hfsplus_fill_super(struct super_block *sb, void *data, int silent)
>  		goto out_put_root;
>  	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
>  		hfs_find_exit(&fd);
> -		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER))
> +		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
> +			err = -EINVAL;
>  			goto out_put_root;
> +		}
>  		inode = hfsplus_iget(sb, be32_to_cpu(entry.folder.id));
>  		if (IS_ERR(inode)) {
>  			err = PTR_ERR(inode);
> -- 
> 1.8.3.1
> 
> 
