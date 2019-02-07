Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4B0C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002512175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfBGXKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:10:37 -0500
Received: from anholt.net ([50.246.234.109]:58798 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfBGXKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:10:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7EDB710A2BFC;
        Thu,  7 Feb 2019 15:10:36 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id dC8TVcE30uGc; Thu,  7 Feb 2019 15:10:35 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7081310A0353;
        Thu,  7 Feb 2019 15:10:35 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 087FF2FE464C; Thu,  7 Feb 2019 15:10:35 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     "Koenig\, Christian" <Christian.Koenig@amd.com>,
        "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx\@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sched: Always trace the dependencies we wait on, to fix a race.
In-Reply-To: <ba4a98f4-062e-0cb4-bd22-a0a191385f82@amd.com>
References: <20181207191653.30118-1-eric@anholt.net> <ba4a98f4-062e-0cb4-bd22-a0a191385f82@amd.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 07 Feb 2019 15:10:34 -0800
Message-ID: <87tvhf2o0l.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Koenig, Christian" <Christian.Koenig@amd.com> writes:

> Am 07.12.18 um 20:16 schrieb Eric Anholt:
>> The entity->dependency can go away completely once we've called
>> drm_sched_entity_add_dependency_cb() (if the cb is called before we
>> get around to tracing).  The tracepoint is more useful if we trace
>> every dependency instead of just ones that get callbacks installed,
>> anyway, so just do that.
>>
>> Fixes any easy-to-produce OOPS when tracing the scheduler on V3D with
>> "perf record -a -e gpu_scheduler:.\* glxgears" and DEBUG_SLAB enabled.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Going to pick that up for upstream and will add with a CC: stable.

Looks like this got misplaced.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxcuuoACgkQtdYpNtH8
nujinQ/+JBLbUT9vbfUdcTVKTfrdcnYbes8xTWxScWMNxRyF/D5P/sVdpAPHssaj
ExnhiCSKwKJEFvVTJ8j9IHoCXcm0WKO7j9BzLq1HMjQhmZHzyZGp+tzny4kxnlud
1oVVuwx2EwckpHA/fP9YZ0m2L25fcgCzx4FMVxoqP5Zs6Tq0AB3KXj+VyE0YseCR
uAk1QKyXHijt0YMvW8q4j5k2UQG7GMbX8Bas43RI7Tn67FLXsJkaTId36BtGAz2+
C5E+/amXYYyFstBTglx5LKH6DX0EZvvET7IEOkJ4ZKH3cYZBCnUXMlqsKj5w4dwc
lrJHFEmJQZ8cxAby+EKBfw9PWugmjVtN25E6/nqEaV4tyqp0+I2jEWj3Ht5TTxCA
JlSiIUCyFhjGx92pAXkiVIGuPiFEg+Cg0tooQTzNkPXC3XXxGdkyW930xmAxOLZw
owGHKRkCdwQQ7sHUA4AvV+2Jcm/fA1Ecd7PS1epYZL6xJ7fDm4gjtQvxi/y1rF6G
sByNPpxwvbRHbpFfg1b+Ehb6eO9Xf0XsjbSILDLdGXI8Pagy2m8LNBFCZICa7GhC
+7DmbaESv2We9ZIg5gA0I7ewiWM5VuwDu6/NitimM7Gga9HYJnfc5a5Mb4EWnTzk
C9JDKdBgrYtKb+zCKyQRFF8AKOme+ldEfPrFxKcQsQXdCCw48n4=
=RJdr
-----END PGP SIGNATURE-----
--=-=-=--
