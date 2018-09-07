Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B45BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F1C206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="oql4ifuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F1C206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeIGOFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:05:04 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:29775 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbeIGOFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1536312299;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=PN9ufYE4bYuTymwxgqJU00OnrFTlxptoDnKG2K3fg00=;
        b=oql4ifuhSrdYVKRmizPfid2EYnKlMxU9qhNCpNTQEMmMw0PX03sGeFgxMFITyMNmcJ
        AZZXDJf5W+RCYrJoS7UJjT2dMKUxXVATdiOhTqaH3zc+oM92Exc7gcNuSMen2F3X70x2
        MhxUaNIC1V8qLmcG1GyY/XaEJ74EIsvZqxwfaDVQjQu25qaOM16OAbzqwARJ3D2MYGts
        TO5va8beiIvuxui4G0XJMS4EbzwaiVaQcfAZL8DW/3YquydZM0tt2hoIr2W3PuDox1I9
        leEBClY7W/lBvj6dv3M+u9sK2GMGe3L31Vq/TTfy/uCyweiRziawa025TcJIttB1qT++
        dfCA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsAQtyRsdRVZ54BGpAypu4eYvjwzPAqxRcXNDW+"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.0 AUTH)
        with ESMTPSA id L0862bu879OwE7m
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 7 Sep 2018 11:24:58 +0200 (CEST)
Date:   Fri, 7 Sep 2018 11:24:51 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] xen: avoid crash in disable_hotplug_cpu
Message-ID: <20180907112451.442b46fe.olaf@aepfle.de>
In-Reply-To: <c26bfbe1-9032-468c-d4d0-c05eda8af762@suse.com>
References: <20180907063023.16913-1-olaf@aepfle.de>
        <c26bfbe1-9032-468c-d4d0-c05eda8af762@suse.com>
X-Mailer: Claws Mail 3.16.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/UeViPe4cDLalinr9AGThlP2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UeViPe4cDLalinr9AGThlP2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Fri, 7 Sep 2018 09:48:28 +0200
schrieb Juergen Gross <jgross@suse.com>:

> On 07/09/18 08:30, Olaf Hering wrote:
> > +	if (cpu_online(cpu))
> > +		return;
> >  	if (cpu_present(cpu))
> >  		xen_arch_unregister_cpu(cpu); =20

> Could you merge the two if conditions?
> if (!cpu_online(cpu) && cpu_present(cpu))
> 	xen_arch_unregister_cpu(cpu);

Is that any different, beside being wrong, from what the patch actually doe=
s?
It would still clear the present bit later on.

Olaf

--Sig_/UeViPe4cDLalinr9AGThlP2
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCW5JD4wAKCRBdQqD6ppg2
fgKUAJ9qUyfX87dZMcfGNMva1zc/zA/GxgCfTLOAZ5oxZ3BAHwMQr9339Cupsd0=
=hFzS
-----END PGP SIGNATURE-----

--Sig_/UeViPe4cDLalinr9AGThlP2--
