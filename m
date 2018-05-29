Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964910AbeE2BOe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:14:34 -0400
Received: from mail04-md.ns.itscom.net ([175.177.155.114]:33486 "EHLO
        mail04-md.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936727AbeE2BOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:14:33 -0400
From: "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: Why is the length of max mount option a page size??
To: Jungsub Shin <supsup5642@gmail.com>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180529002456.GA30767@supsup-VirtualBox>
References: <20180521173959.GA12779@supsup-VirtualBox> <5670.1527244930@jrobl> <20180529002456.GA30767@supsup-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7802.1527556471.1@jrobl>
Date: Tue, 29 May 2018 10:14:31 +0900
Message-ID: <7803.1527556471@jrobl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jungsub Shin:
> I suffered this problem below environments.
> ------------------------------------------------------------------------
> OS : Ubuntu 18.04 LTS / 4.15.0-20-generic / 64bit
> AUFS module parameter : brs =3D 1 / allow_userns =3D N
> Mount command : mount -t aufs -o br=3D~/tca_agent/container_rw_dir/51509032=
	:::
(very long command line)

For such long branches, try "remount,append" option.

# mount -t aufs -o br=br0:br1:br2...:brN none /mntpnt
# mount -o remount,append=brN+1 /mntpnt
# mount -o remount,append=brN+2 /mntpnt
	:::


J. R. Okajima
