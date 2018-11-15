Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1462C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46782146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46782146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbeKPEu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:50:29 -0500
Received: from anholt.net ([50.246.234.109]:39272 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeKPEu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:50:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9F25E10A135C;
        Thu, 15 Nov 2018 10:41:33 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id hSy47fUrRMF9; Thu, 15 Nov 2018 10:41:32 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 266AF10A040F;
        Thu, 15 Nov 2018 10:41:32 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id B17AE2FE3700; Thu, 15 Nov 2018 10:41:31 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Kees Cook <keescook@chromium.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     James Hughes <jnahughes@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: raspberrypi: Fix firmware calls with large buffers
In-Reply-To: <CAGXu5jJfypZu=gp5vrB1Xf_Hr-Fpa7YqmXZT2z0MJhZtqR1ubg@mail.gmail.com>
References: <CAOtG3WrGCwVd2DWq6Gq_ajZau0xJ-kPMvFRU6HyELYtUr30_VA@mail.gmail.com> <3ac94357-5860-f9fd-740d-a2cd277fd0a8@i2se.com> <CAGXu5jJfypZu=gp5vrB1Xf_Hr-Fpa7YqmXZT2z0MJhZtqR1ubg@mail.gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 15 Nov 2018 10:41:31 -0800
Message-ID: <87tvkiyyhw.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Kees Cook <keescook@chromium.org> writes:

> On Thu, Nov 15, 2018 at 10:05 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> Hi James,
>>
>> please look at
>> https://www.kernel.org/doc/html/v4.19/process/submitting-patches.html,
>> because there are several issues with this patch. Most critical one is
>> that i received it not as plain text. Please make sure that send your
>> patch with git send-email.
>
> The irony is I had to fight Gmail over your multipart HTML+plain
> email. Yay email clients! ;)
>
>> Am 15.11.18 um 14:18 schrieb James Hughes:
>> > A previous change (5bfdc1097654) moved away from VLA's
>>
>> Please use the commit format mentioned in the link above.
>
> And actually, this SHA isn't the upstream SHA. This should be:
>
> a1547e0bca51 ("firmware: raspberrypi: Remove VLA usage")
>
>> > to a fixed maximum size for mailbox data.
>> > However, some mailbox calls use larger data buffers
>> > than the maximum allowed in that change. This fix therefor
>
> Which ones did this? In the initial change I couldn't find anything
> that exceeded 32 bytes. (I'm just curious if I missed something or if
> something new appeared.)

Nothing in tree used larger, it's that there are firmware transactions
that are bigger.

>> > [...]
>> > + /* Some mailboxes can use over 1k bytes. Rather than checking
>
> Up to Eric, but I think the preferred comment style is:
>
> /*
>  * lines go here
>  */
>
> Otherwise, this seems fine to me. Thanks for getting it fixed!

I have no preference about comment style, I just want fixes to land. :)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvtvdsACgkQtdYpNtH8
nugi3hAAtZOvSJasqzErKS8uTgXTcbRYaFT07QP0TKk5B0r0ssalDaaJ0UM7i83n
nz3SeV/MbKkBM7aCQ1Ps5bXWgmD3vEFrzUA/Gr1hF9hgl5eHq/rrYL+gNaOucgFd
r7Cbl6sILQiov0p6G208+iLZbqfDpEqjYHunpISMhqRaQSS9g5OTlTocAg3Xb7XS
K1frx+9pYE6YAD69/bDF2Xt/+fN7eIYrS/dkbps5nmznHf4jc6r3MRbb3Gv1Gvmx
KQNY4tudxLzxhLmY/+S9MfWuTWsWJacfx2YsMCzi1HumV7lEoE2RdbKm7BxJrjMn
qlVAu7kQ5wIApl+8axIcTrmD4qWDbX86gc2XK8pD+Ts14C+Pm071q0H6PxV6Y4z4
vcLJiRAu+FOFzO/vaa8ge0Is0Y7uCBovjKW3bjMAiFw8udOvDKZDg/geEJLWC59i
NFFErzRiS1E/yjl+FwleZFXwZ8iLueqJXmvTdLhIgrqvzX9PqYcY7+xk8Zhzeb3r
h68v3AEDuLb6K99zTbjcUeUU8Sxzf+flosDSBqie09jqPCu0/mwZrbxMdDICeuhc
I+X461dN5Gk78x5vjt+30MQ4/nTBjzDP0i/nshhTgmuK38nTUCFqttMDELs4U+uF
JgekGP50uzMZzxbIgQ67Lg7mNbVdf7s2aw02wgolfVl/JE5sCA8=
=5TTc
-----END PGP SIGNATURE-----
--=-=-=--
