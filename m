Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D65C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9050420844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="cCGF4d1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9050420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbeIGBJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:09:06 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:30279 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeIGBJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:09:05 -0400
X-Greylist: delayed 50275 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Sep 2018 21:09:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1536265912;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=VjUwwoNsR7yFbp4WPkFvsjQPOXopN+AZdvetspiGvlw=;
        b=cCGF4d1QqJP6kGpyLqc805D6HP1Y0ZJbDRl68gRSWHpZW4Knae4w4GU70M8BS4Nb+w
        RcH8Y0fzjXixICS1jEZDQAFX7LTSiFODXfGO9Nl0FPw/cj0IDERc1XZ9jg7J7stFFtZi
        dnUT25AfvFg82Wp2uK204599v74r0fWcxjo8FetzfvC+sIsughZZCInqg1T/nVOtCpoA
        jqtdqULoX/Pt0WagBFw3t5HtdHhwrB+wNMeQvh9tge1tnHIBnDRsPzchxF/yQE5dAoTk
        JEH7b5NriflcPkF5rt8gNOGg7BGrTNTWRGrjExxIxOhMf3WsjdzLgmsLOxEJVLFhF2wM
        GFCg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsAQtyRsdRVZ54BGpAypu4eYvjwzPAqxRcXNDW+"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.0 AUTH)
        with ESMTPSA id L0862bu86KVpCFZ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 6 Sep 2018 22:31:51 +0200 (CEST)
Date:   Thu, 6 Sep 2018 22:31:45 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] xen: avoid crash in disable_hotplug_cpu
Message-ID: <20180906223145.37f7009b.olaf@aepfle.de>
In-Reply-To: <b7306d7f-e827-6556-e1bb-4b934a162e46@oracle.com>
References: <20180906063712.28639-1-olaf@aepfle.de>
        <b7306d7f-e827-6556-e1bb-4b934a162e46@oracle.com>
X-Mailer: Claws Mail 3.16.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/tskpqat.bDZCNZqA9o0sYsv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tskpqat.bDZCNZqA9o0sYsv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu, 6 Sep 2018 14:45:57 -0400
schrieb Boris Ostrovsky <boris.ostrovsky@oracle.com>:

> On 09/06/2018 02:37 AM, Olaf Hering wrote:
> > The command 'xl vcpu-set 0 0', issued in dom0, will crash dom0:

> > This happens because handle_vcpu_hotplug_event is called twice. In the
> > first iteration cpu_present is still true, in the second iteration
> > cpu_present is false which causes get_cpu_device to return NULL.
> > In case of cpu#0, cpu_online is apparently always true.

> I think we should check both this and num_online_cpus() !=3D 0.

This can not possibly help. cpu#0 is the first one that goes offline.
IF cpu0_hotpluggable is broken, then only "if (!cpu) return;" can help.

Olaf

--Sig_/tskpqat.bDZCNZqA9o0sYsv
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCW5GOsQAKCRBdQqD6ppg2
floXAKCrnwaC4KbLH/1h4SPHYTIFty1K1QCgqtpEYxNU7utPdsHHHNjNKGFbODU=
=6dXi
-----END PGP SIGNATURE-----

--Sig_/tskpqat.bDZCNZqA9o0sYsv--
