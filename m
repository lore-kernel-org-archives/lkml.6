Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DBCC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B65B217C8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="kA1jucnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B65B217C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932918AbeFURUa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:20:30 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36709 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFURU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:20:28 -0400
Received: by mail-pf0-f195.google.com with SMTP id a12-v6so1858500pfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=X3Bb3TqVp8D0ycf5LYlzG/ionne6W1SvWcBpBsUzFJw=;
        b=kA1jucnSvDmL9VnF7aDTLcDUVh2SUQJDfr5Kbtq2x/OMewObVx9PlaqFi6OiIA+ryr
         wUmKFAMQ8V7VtQiIMv4ynCYGIlVZFHpfFJNFGD3dlKuPtt9CwOB3DBys8LubaCJEzHWb
         2muDRFPZTXNpM4MzAGCMwTlEG6tCHR5Vl4VkYhZQOE834YnZXfelF31nZwm0CeuqE8za
         wMHyR4FZrPs9Eli3wipp45dsZze60mJC4FjJYcZOtOW38FrIaT0pNLTR5f2tGI3YnsSL
         wLdbSHSm3cpcrLLLfOYqWfBK2Ivznir0groM75OMN7Gm20SMAhhhbiq12YcacrIGCG7v
         fiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=X3Bb3TqVp8D0ycf5LYlzG/ionne6W1SvWcBpBsUzFJw=;
        b=bis13ANRNxowfCEjYkoQv8fQeQ/tRONgpnrlqFwegEqECnpyNX9fqbp2mOAv7lMUm/
         K/k/C8fuwc9NmzRPNEE5iY0Hlr5B5YBuXbkS3uxvk87JLDCsksjroQ6ha+18xv/HJ4nE
         w1iPnnK9q7HNfdOU6pSaBIBfOgl21y2A5VKudP7L50QFH2m7KPdGlPK8ct1ghgqqzT+N
         UoFrTnOOTr2tu+ItwewwvvcYET22V5kg47oYrx+VXqHywLCdgkd8hVy+MQSkq1uJ9Cym
         Maxuzu/IA4//O/M88VWa2f341CRF/5r66vrTbByCPwHpCeWFJH96IpXynMW0zcCvsEJ2
         z5aw==
X-Gm-Message-State: APt69E07sQleRsxXX8/6Usox6mtCJqO5i5DENRks9u2dR2I5tVdTL2vz
        QjofUciIh4FuSSyULxn5wFq5x4xXVso=
X-Google-Smtp-Source: ADUXVKIHw51qpr+JpiOUMqnLUHF2ei0n5DAnQOq60Au2fVGi+4OPs4vQ7G6AeCt/iDadsoCQYDIUyQ==
X-Received: by 2002:a65:5944:: with SMTP id g4-v6mr23615565pgu.317.1529601628135;
        Thu, 21 Jun 2018 10:20:28 -0700 (PDT)
Received: from cabot-100.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id f63-v6sm11545501pfe.143.2018.06.21.10.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 10:20:27 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <711B183B-8F48-49C0-AC33-907384D10672@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E79BA00D-983B-49F2-BC1F-60E7BA4D0162";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/6] ext4: use 64-bit timestamps for mmp_time
Date:   Thu, 21 Jun 2018 11:20:24 -0600
In-Reply-To: <20180620153322.54221-2-arnd@arndb.de>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        y2038@lists.linaro.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
References: <20180620153322.54221-1-arnd@arndb.de>
 <20180620153322.54221-2-arnd@arndb.de>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_E79BA00D-983B-49F2-BC1F-60E7BA4D0162
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jun 20, 2018, at 9:32 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> The mmp_time field is 64 bits wide, which is good, but calling
> get_seconds() results in a 32-bit value on 32-bit architectures. Using
> ktime_get_real_seconds() instead returns 64 bits everywhere.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/mmp.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index 27b9a76a0dfa..39da4eb48361 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -147,7 +147,7 @@ static int kmmpd(void *data)
> 
> 	mmp_block = le64_to_cpu(es->s_mmp_block);
> 	mmp = (struct mmp_struct *)(bh->b_data);
> -	mmp->mmp_time = cpu_to_le64(get_seconds());
> +	mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
> 	/*
> 	 * Start with the higher mmp_check_interval and reduce it if
> 	 * the MMP block is being updated on time.
> @@ -165,7 +165,7 @@ static int kmmpd(void *data)
> 			seq = 1;
> 
> 		mmp->mmp_seq = cpu_to_le32(seq);
> -		mmp->mmp_time = cpu_to_le64(get_seconds());
> +		mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
> 		last_update_time = jiffies;
> 
> 		retval = write_mmp_block(sb, bh);
> @@ -244,7 +244,7 @@ static int kmmpd(void *data)
> 	 * Unmount seems to be clean.
> 	 */
> 	mmp->mmp_seq = cpu_to_le32(EXT4_MMP_SEQ_CLEAN);
> -	mmp->mmp_time = cpu_to_le64(get_seconds());
> +	mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
> 
> 	retval = write_mmp_block(sb, bh);
> 
> --
> 2.9.0
> 


Cheers, Andreas






--Apple-Mail=_E79BA00D-983B-49F2-BC1F-60E7BA4D0162
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlsr3lgACgkQcqXauRfM
H+ASfw//foruYMBroerLYos6rc4jWqUdoTo9h8hB1HTM4E9GxUcZKBy1rRDCd+hr
Y3jTyFozDB5RwtPfcBX7AF0SzaTC4+tJ96YyNetl2t4eKETl7OSEKM8QplFa/djF
WXD9muJfZbQ4cntrphl+n6UpBY/jbC15HdeYhwRNHLIOfkAzp2BAKe+Okdo1o+hk
zcavA0Cx1To+Vy2W96ahuEMwdVHk0lFpBs8pJJ9j0VEM7OdiIRFTatJMSdHTKZUR
FggB6CNbUSK77NXzuzb0vPfwEtnSuOH9wI7dj+axRn8iPLBY+NGMtgAbKXztpE+4
Tl7NryRC2PKKebmKteSzhFJqUGg4T6YUrUlIPDUsqCBtGmg2tlonePZbj0tBKDkd
UgZGIy+zgR1S8b9GFkdwViEjLNhllqBWPvRqkCrtSpvMah0G8Grtwwoty+IlVFT+
LJqnHvfB2VFh0YfWE6Y2pQ9aiOINzUeE02M6X8bDOOa+pBURuumg5oWdzp6xhthh
kY7CKpjQEK7mHeEH0k8Lf8a5XE0yg+UMe23xdUPLA0B6Pw9n8Vc/HRSh/TcUwYkv
9q/2VcesBRcSHgy+T0hu/LEodqx6Eux7gFvcnSX8ifoUtnVyh6OpIT2geUUESSm/
n7kGL1+fE0482DXFdo4uZXR4hOtEj/VKBZUklf7lTR+1RXtcJ9E=
=WQ5v
-----END PGP SIGNATURE-----

--Apple-Mail=_E79BA00D-983B-49F2-BC1F-60E7BA4D0162--
