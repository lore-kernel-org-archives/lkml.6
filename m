Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8465C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89799208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="lb94FaLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89799208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeJRX15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:27:57 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:12224 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbeJRX14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:27:56 -0400
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Oct 2018 19:27:55 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1539876384;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=U/JBf+k4mCBinm4SMGOBr4By7MprRU+aldN+eCDR+YE=;
        b=lb94FaLDzSZ0Uvz+n4170D2t0IHUR9+BqtXxKSQUru7BqLZ8neIOc+DuTLvyeRYCHp
        FdYTGz3bjOp7zaLXAn+ovICOPSHhd4uOy2xWWZHbtil80VMw3LBJpTRXueoqPx1s2X3u
        rOmOzJpEiNGzBJ3MMA0X96X/krMvwBiLWKI6DELy0thld8LGKhXEFS3h2qf6NjflnrKe
        FoguH+nA7iV78haHOnYJOKMwnr6qzPbZkiDSgxGy9leHg7oGJxGSJXblN7C/CjgfH+Op
        lD+Sy6KkDDzdwZjbuhwP2oRX3WYGRRyzxoBohjnwKLxrij01gqQcEmKfuL1A6W04TMde
        hdGA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsAQtyRsdRVZ54BGpAypu4eYvjwzPAqxRcXNDW+"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.3 AUTH)
        with ESMTPSA id 906dd1u9IFK2EHq
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 18 Oct 2018 17:20:02 +0200 (CEST)
Date:   Thu, 18 Oct 2018 17:19:53 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     kys@microsoft.com, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org
Subject: Re: [PATCH V2 3/4] vmbus: add per-channel sysfs info
Message-ID: <20181018171953.079f6fb6.olaf@aepfle.de>
In-Reply-To: <20170918035419.11062-3-kys@exchange.microsoft.com>
References: <20170918034955.10913-1-kys@exchange.microsoft.com>
        <20170918035419.11062-1-kys@exchange.microsoft.com>
        <20170918035419.11062-3-kys@exchange.microsoft.com>
X-Mailer: Claws Mail 3.16.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/XM3s3d1I7SWbaUwNiYVsnLE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XM3s3d1I7SWbaUwNiYVsnLE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Sun, 17 Sep 2017 20:54:18 -0700
schrieb kys@exchange.microsoft.com:

> This extends existing vmbus related sysfs structure to provide per-channel
> state information. This is useful when diagnosing issues with multiple
> queues in networking and storage.

> +++ b/drivers/hv/vmbus_drv.c
> +static ssize_t write_avail_show(const struct vmbus_channel *channel, cha=
r *buf)
> +{
> +	const struct hv_ring_buffer_info *rbi =3D &channel->outbound;
> +
> +	return sprintf(buf, "%u\n", hv_get_bytes_to_write(rbi));
> +}
> +VMBUS_CHAN_ATTR_RO(write_avail);

This is upstream since a year.

But I wonder how this can work if vmbus_device_register is called,
and then something reads the populated sysfs files before vmbus_open return=
s.
Nothing protects rbi->ring_buffer in this case, which remains NULL
until vmbus_open populates it.

A simple reproduce, with a modular kernel, is to boot with init=3D/bin/bash
head /sys/bus/vmbus/devices/*/channels/*/*

Olaf

--Sig_/XM3s3d1I7SWbaUwNiYVsnLE
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCW8ikmQAKCRBdQqD6ppg2
fs/+AJ96XIzUhnDlu6M7bWwTIgZ/evTZXwCfXbXPxjVEp5/d/MYiNKPXtiNrN/o=
=Ip93
-----END PGP SIGNATURE-----

--Sig_/XM3s3d1I7SWbaUwNiYVsnLE--
