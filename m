Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E536C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B883A21884
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="FR6aGjX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B883A21884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933274AbeFUR1V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:27:21 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35527 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933187AbeFUR1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:27:16 -0400
Received: by mail-pl0-f65.google.com with SMTP id k1-v6so2040550plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=7SjyZmn5FnmOW0XkItfmWS74Cy8n0rgmqdiD7GPrgCY=;
        b=FR6aGjX7xs54fbKPyXi41lsvBLTWi+n9A2COWLAquogZ0RyyZ/xNR8FwRZzDPdCI6g
         3Bh6kWEjPbIH0f439EWELjT7mcmku7lqSEYsza/VLsNoAFevEG5oVtbi98mLoOOnhhr0
         v2hY6eCb+5ocIkkZLp8rObJYxfLdcGuQKB6jsbGZ3K4v3QvD0YbNwqE9fxnIkqBMcUgS
         BDf8G7XUhDApVwo+TFAWABLaODezRoOJL3o+QqMPEZVEM+XBTxvxUzbcJTN/2r995Ewy
         0KAFqQ6x9h+6vGQxiv/zQ9fPekayTS0Ob5Atr/dtIHwS5j2h6ixMI+NIZkyjL8f3MbIi
         it+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=7SjyZmn5FnmOW0XkItfmWS74Cy8n0rgmqdiD7GPrgCY=;
        b=lzC95F4FeRwr/W4uuXzXcfdtSKbJcCP7ynLFffGX+e0M5yo+xyF07FLbV+6/KJLiPq
         uGbCX/viARD+Rd+n66TIqYk8llprUhiNHP5Ru57N0kI2Tej8puRsVfzWPMHla/ZQAVTU
         +Q8LnhmrV0y8yQKopEzxLoHYiGmixlJw4ubb/PM2j4/OufwhIXBbVgmZWmXEC0tcbjwQ
         HxZQ1jO9TIAggAAbgseq3TjvQnF3DaaakKrdSDrmggJlMWXeKeG0Sju0khzeu8B0+07H
         GY/zemn6PRcu1NxDRIsiKulpvbi/x+MFOaX/8otfu/6vuP7gb6IxhDriK1iFswc+kyV8
         dvWA==
X-Gm-Message-State: APt69E2lziMAEV31kr8VaOV+zF+seatl/hLYrECWmGQ/yuObeydBosVj
        MoMIiYKr1bwPY4I4L5RPDXO6DQ==
X-Google-Smtp-Source: ADUXVKIUcUN93VCp5JbRi+6btLJINNFIr7EwH2ytGPyBaVt7O5xlYAy+ElyDuE2k8LyCnN/9FHG+kw==
X-Received: by 2002:a17:902:bb81:: with SMTP id m1-v6mr29521306pls.117.1529602036012;
        Thu, 21 Jun 2018 10:27:16 -0700 (PDT)
Received: from cabot-100.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id f187-v6sm8234669pgc.61.2018.06.21.10.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 10:27:15 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F6095896-5B1A-4A20-9293-086A9350F75C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E6769417-94BF-43FF-8F93-8EAFD27B5C24";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/6] ext4: use ktime_get_real_seconds for i_dtime
Date:   Thu, 21 Jun 2018 11:27:12 -0600
In-Reply-To: <20180620153322.54221-3-arnd@arndb.de>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        y2038@lists.linaro.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Tahsin Erdogan <tahsin@google.com>,
        Miao Xie <miaoxie@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
References: <20180620153322.54221-1-arnd@arndb.de>
 <20180620153322.54221-3-arnd@arndb.de>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_E6769417-94BF-43FF-8F93-8EAFD27B5C24
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On Jun 20, 2018, at 9:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> We only care about the low 32-bit for i_dtime as explained in commit
> b5f515735bea ("ext4: avoid Y2038 overflow in recently_deleted()"), so
> the use of get_seconds() is correct here, but that function is getting
> removed in the process of the y2038 fixes, so let's use the modern
> ktime_get_real_seconds() here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks OK, one minor cleanup possible.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/inode.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 2ea07efbe016..600e2063d1df 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -317,7 +317,7 @@ void ext4_evict_inode(struct inode *inode)
> 	 * (Well, we could do this if we need to, but heck - it works)
> 	 */
> 	ext4_orphan_del(handle, inode);
> -	EXT4_I(inode)->i_dtime	= get_seconds();
> +	EXT4_I(inode)->i_dtime	= ktime_get_real_seconds();

Not strictly necessary, but it might be good from a code clarity POV
to use:

	EXT4_I(inode)->i_dtime	= (__u32)ktime_get_real_seconds();

so that it is more clear we are aware that this is being truncated
to a 32-bit value.

Cheers, Andreas






--Apple-Mail=_E6769417-94BF-43FF-8F93-8EAFD27B5C24
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlsr3/AACgkQcqXauRfM
H+DRYg//cC5j8y+Lv/9+T+/li60E2dnTqpKtRjjQ6i+yp+UWqYRCxOjPzsZzrlxo
MBoJ0HWR9QmT48wgMbnOapNCsf9uhOfazrGs7ps3E9ukKlnSoA5aFUcf/jnvsNlV
nRQSfq5u4UMptsrO2MpJeAcNQHBI5EKrsfSbyy+TjdGOHEJHZY0h7XfXU3G5U0Wf
qtKuKzI72Q+XbPCbAfX9xDpGXDihVwhyBj3vHHLGnHPLu02cS2jahqFd7PQ73qNV
P2Ho3uypo66CwnOikN8eQc0CaipwBcts7wvntvVzXhzBsKgxcscuJnkXBON9UImA
5xhN4T/+I0s5RlKigjNffY0pyyoQSrr1tEsn2VUBNXn7BxJ2jucqp4PPjQzDlcM4
Gq31QkPD2nTHWUeMC40rFoHACN1opkegpOdIuARio18i3wyoav9Jyn2TlEvG982u
HGJPXowgzMicW6X1TXm+9C53QpipsLJpOampRWTlsIvhLohWKRDgo7L1lglGJPAQ
hPo+IJyxIg8qyN17R5hVIw1kNEYFj1BsdbD7Tvgm7wnwkLvkJuYD0aaw4OHRls3F
qCpMBPw9e1tQTKlJmLIPrnY97JB16aIGEukUXP/H2ng0wMgxuNpx2Xlocb/XPBAh
QdEthlWI6GuPqqXqFoqjqsjXdYXaMWVAlrfZ3AmGQXvwI8m4Ags=
=SGjj
-----END PGP SIGNATURE-----

--Apple-Mail=_E6769417-94BF-43FF-8F93-8EAFD27B5C24--
