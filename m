Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785D2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 19:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B39A208E3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 19:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfAATap convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 14:30:45 -0500
Received: from pic75-3-78-194-244-226.fbxo.proxad.net ([78.194.244.226]:59910
        "EHLO mail.corsac.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfAATap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 14:30:45 -0500
Received: from scapa.corsac.net (unknown [IPv6:2a01:e34:ec2f:4e20:6af7:28ff:fe8d:2119])
        by mail.corsac.net (Postfix) with ESMTPS id 1EA1A92
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jan 2019 20:30:43 +0100 (CET)
Received: from corsac (uid 1000)
        (envelope-from corsac@corsac.net)
        id a02d0
        by scapa.corsac.net (DragonFly Mail Agent v0.11);
        Tue, 01 Jan 2019 20:30:42 +0100
Message-ID: <7981cfaf015f9054490832d35ef99e992c000ab8.camel@corsac.net>
Subject: Re: Stall during read() on CIFS with 4.19
From:   Yves-Alexis Perez <corsac@corsac.net>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org,
        Ronnie Sahlberg <lsahlber@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Paulo Alcantara <palcantara@suse.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Date:   Tue, 01 Jan 2019 20:30:42 +0100
In-Reply-To: <80e6c45b77a512047ec59314a00b3199f9ca86fd.camel@corsac.net>
References: <80e6c45b77a512047ec59314a00b3199f9ca86fd.camel@corsac.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-01 at 13:33 +0100, Yves-Alexis Perez wrote:
> Hi,
> 
> with the upgrade to 4.19 in Debian sid, I experienced a regression with CIFS
> filesystems.
> 
> The server is running Debian stretch with samba, the clients are running
> Debian sid or stretch. With 4.18 kernels everything is fine, but with 4.19
> while the mount succeeds, any read() syscall on a file open()ed from a share
> just stalls.

Hi all,

I'm doing a common reply following quick replies from Steve and Paul
(thanks!).

The bug is apparently fixed by 
https://marc.info/?l=linux-cifs&m=154629475812244&w=3 and also by mounting
with a rsize reduced to 16384.

Regards,
-- 
Yves-Alexis
