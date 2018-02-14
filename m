Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2761149-1518612331-2-14459185871912070204
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='at',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518612331; b=NtcZfX3bDVgy7t5/GOcZeARitPryquShK8QfZ/fSgFUXWSr
    MYzLacpUMSlDz8d79CVeR7RVR+g8J2nZpBAJomN3X8zdSnVVNlblDcdO2WFXUZch
    P46Czydftl2SW5pBtbr78Pkyj7r2Mx54SEUu4Bzm7t69V3lWTfaY1IUTUFGExzpk
    P0dXS+90PLh3pw5il6noIgM6h/SDh/RMamLGCpEcMEjPlWMZoL472dNnVfc9ycFz
    uVX/CmMSWur+8599ci2v4CZT8Ue521f1yi+R4CkXK0TiqBMh5kDoFn42LtFzxa0A
    AUCfsgE9ceFBJyNll/+9tNA8L5ve3PCnXJ/hqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=arctest; t=1518612331; bh=hXNZPk
    7PaJeyR6mD0z185P7+v8Y2J+MUl42OgkKBlNU=; b=Fob+ryHs5w8dKTIrC4r4it
    ffK8mYQMzIuwYSnQGIPRBS9iav/UmO3FAwoVlQsEAmxGggzLCqlyoQdrCSUWRPvw
    YxYkMR31o1+qulpPY0Co6VioRy1evErVABTSkOPikyyg5yuEzZ+VF45rtb+sj7Ce
    f+71C9J9b3iqDDSSBeTo2f7sqCaEJPxDTnKuppYU/0UaZGLVPZzdHKTyhlgLww+I
    CeC7hxPG4ON7iwmiac2I/Y/mEf1HQE9WhMWK8F7yk9iDOULGyBgkaVy8EgQYp9BO
    53ZqFMLcZ/0/6LIyY6jnkoJxx7DH1lfTEOKzn5UM0MU/BU08mFblrZoOwML3l58g
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nod.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nod.at header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nod.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nod.at header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967618AbeBNMp2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 07:45:28 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:49716 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967589AbeBNMp2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Feb 2018 07:45:28 -0500
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ubifs: Fix synced_i_size calculation for xattr inodes
Date: Wed, 14 Feb 2018 13:46:42 +0100
Message-ID: <3040988.j6LFxaOeXC@blindfold>
In-Reply-To: <20180214110248.26325-1-richard@nod.at>
References: <20180214110248.26325-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Mittwoch, 14. Februar 2018, 12:02:48 CET schrieb Richard Weinberger:
> In ubifs_jnl_update() we sync parent and child inodes to the flash,
> in case of xattrs, the parent inode (AKA host inode) has a non-zero
> data_len. Therefore we need to adjust synced_i_size too.
> 
> This issue was reported by ubifs self tests unter a xattr related work
> load.
> UBIFS error (ubi0:0 pid 1896): dbg_check_synced_i_size: ui_size is 4,
> synced_i_size is 0, but inode is clean UBIFS error (ubi0:0 pid 1896):
> dbg_check_synced_i_size: i_ino 65, i_mode 0x81a4, i_size 4
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  fs/ubifs/journal.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index 04c4ec6483e5..e3e1e093db81 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -664,6 +664,8 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct
> inode *dir, finish_reservation(c);
>  	spin_lock(&ui->ui_lock);
>  	ui->synced_i_size = ui->ui_size;
> +	if (xent)
> +		host_ui->synced_i_size = host_ui->ui_size;
>  	spin_unlock(&ui->ui_lock);

Reviewing my own patch on LKML helps a lot.
We need to take host_ui->ui_lock too...

Thanks,
//richard
