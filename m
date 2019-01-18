Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024ADC1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBDB2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfARVNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:13:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:43914 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729517AbfARVNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:13:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 13:13:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,492,1539673200"; 
   d="asc'?scan'208";a="109366825"
Received: from jtkirshe-desk1.jf.intel.com ([134.134.177.96])
  by orsmga006.jf.intel.com with ESMTP; 18 Jan 2019 13:13:31 -0800
Message-ID: <581f33be6662d063d89da0a80e7753df2385abed.camel@intel.com>
Subject: Re: BUG: sleeping function called from invalid context at
 kernel/locking/mutex.c:908
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        intel-wired-lan@lists.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>,
        Jan Jablonsky <jan.jablonsky@thalesgroup.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Date:   Fri, 18 Jan 2019 13:14:31 -0800
In-Reply-To: <a743c273-fe13-0e96-a162-8d15b005ad94@I-love.SAKURA.ne.jp>
References: <CABXGCsOLF48xC30CofbJQMkiRa7vS8pGKu8T0Drskc4QxLy24A@mail.gmail.com>
         <a743c273-fe13-0e96-a162-8d15b005ad94@I-love.SAKURA.ne.jp>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-pHgpvGEJ56J+rQ6TcAZ8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pHgpvGEJ56J+rQ6TcAZ8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-01-18 at 18:31 +0900, Tetsuo Handa wrote:
> This is not a MM bug. ;-)
> And this change is made by below commit.
>=20
> commit 59361316afcb08569af21e1af83e89c7051c055a
> Author: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Date:   Thu Aug 2 10:13:10 2018 -0700
>=20
>     igb: reduce CPU0 latency when updating statistics
>=20

This was already identified as a problem and I already sent a patch to
revert this commit to David Miller's net tree.

commit 5642e27bf6a935c1d0d9149e83d625dfba286463
Author: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date:   Wed Jan 9 09:10:53 2019 -0800

    Revert "igb: reduce CPU0 latency when updating statistics"
   =20
    This reverts commit 59361316afcb08569af21e1af83e89c7051c055a.
   =20
    Due to problems found in additional testing, this causes an illegal
    context switch in the RCU read-side critical section.
   =20
    CC: Dave Jones <davej@codemonkey.org.uk>
    CC: Cong Wang <xiyou.wangcong@gmail.com>
    CC: Jan Jablonsky <jan.jablonsky@thalesgroup.com>
    Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

>=20
> On 2019/01/18 18:21, Mikhail Gavrilov wrote:
> > Hi folks.
> >=20
> > Starting from 5.0 rc1 every time after launch atop I see subject
> > error message.
> >=20
> > And this issue afle negatively impact on system performance.
> >=20
> > Unclear on which subsystem it related but I hope here in mm list
> > somebody help clarify what is happened.
> >=20
> > Thanks.
> >=20
> > Full dmesg also attached.
> >=20
> > [ 2164.694709] BUG: sleeping function called from invalid context
> > at
> > kernel/locking/mutex.c:908
> > [ 2164.694724] in_atomic(): 1, irqs_disabled(): 0, pid: 10498,
> > name: atop
> > [ 2164.694729] 2 locks held by atop/10498:
> > [ 2164.694732]  #0: 0000000061e564e5 (&p->lock){+.+.}, at:
> > seq_read+0x41/0x430
> > [ 2164.694753]  #1: 0000000081e34167 (rcu_read_lock){....}, at:
> > dev_seq_start+0x5/0x120
> > [ 2164.694762] CPU: 10 PID: 10498 Comm: atop Tainted: G         C
> >   5.0.0-0.rc2.git1.2.fc30.x86_64 #1
> > [ 2164.694765] Hardware name: System manufacturer System Product
> > Name/ROG STRIX X470-I GAMING, BIOS 1103 11/16/2018
> > [ 2164.694768] Call Trace:
> > [ 2164.694773]  dump_stack+0x85/0xc0
> > [ 2164.694778]  ___might_sleep.cold.73+0xac/0xbc
> > [ 2164.694783]  __mutex_lock+0x55/0x9a0
> > [ 2164.694788]  ? seq_vprintf+0x30/0x50
> > [ 2164.694792]  ? seq_printf+0x53/0x70
> > [ 2164.694806]  ? igb_get_stats64+0x29/0x80 [igb]
> > [ 2164.694813]  igb_get_stats64+0x29/0x80 [igb]
> > [ 2164.694818]  dev_get_stats+0x5b/0xc0
> > [ 2164.694822]  dev_seq_printf_stats+0x32/0xe0
> > [ 2164.694836]  dev_seq_show+0x10/0x30
> > [ 2164.694840]  seq_read+0x2fd/0x430
> > [ 2164.694847]  proc_reg_read+0x39/0x60
> > [ 2164.694852]  __vfs_read+0x36/0x1a0
> > [ 2164.694861]  vfs_read+0x9f/0x160
> > [ 2164.694866]  ksys_read+0x52/0xc0
> > [ 2164.694872]  do_syscall_64+0x60/0x1f0
> > [ 2164.694876]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > [ 2164.694880] RIP: 0033:0x7fa0f51bd255
> > [ 2164.694883] Code: fe ff ff 50 48 8d 3d 2a 03 0a 00 e8 35 01 02
> > 00
> > 0f 1f 44 00 00 f3 0f 1e fa 48 8d 05 c5 94 0d 00 8b 00 85 c0 75 0f
> > 31
> > c0 0f 05 <48> 3d 00 f0 ff ff 77 53 c3 66 90 41 54 49 89 d4 55 48 89
> > f5
> > 53 89
> > [ 2164.694886] RSP: 002b:00007ffe79288db8 EFLAGS: 00000246
> > ORIG_RAX:
> > 0000000000000000
> > [ 2164.694890] RAX: ffffffffffffffda RBX: 0000000000a55260 RCX:
> > 00007fa0f51bd255
> > [ 2164.694892] RDX: 0000000000000400 RSI: 0000000000a55490 RDI:
> > 0000000000000004
> > [ 2164.694895] RBP: 0000000000000d68 R08: 0000000000000001 R09:
> > 0000000000000000
> > [ 2164.694898] R10: 00007fa0f50a3740 R11: 0000000000000246 R12:
> > 00007fa0f528d740
> > [ 2164.694900] R13: 00007fa0f528e340 R14: 00000000000007ff R15:
> > 0000000000a55260
> >=20
> >=20
> >=20
> > --
> > Best Regards,
> > Mike Gavrilov.
> >=20


--=-pHgpvGEJ56J+rQ6TcAZ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlxCQbcACgkQ5W/vlVpL
7c4kdA/9Gvpie8FefT9Mf19rnPlicNHzPUOnUGMRN4aR17GRKfu2FBboVsEpowGB
+sWfgl8X5xDxU/vtgc1JoKD5jgQK6lBJmJbP7qvDqXIrLSRZOZsiJQ2aVq+3/hlb
tJkhc5r/HPEEvQ/6PozX6Z1yx4JOIkkzE9OrDIBOrb/7PsYsOOlOd6AKwFFd7KjK
ZjdapgGhCY4Nm0SfjNFhnRKemNwuU/SCzq67zbsGVh/WaNoistL1r7qvZbQedSlZ
uh/vunA2GEwneoEl+PSBgaVpEJnLvSjdza0sl5uV3IfTPadr9Ghd1EGPOGlcWeQO
ixgqaQ7M5d2KuwNfL9UodKjj0UtC1/t9cjNX+psTU3DIZEEbgF8rO1pHuBnevAte
JTAV0ZnhSGt9dIxxe2emTf5LYh4hhxifnsRfluEZqvtSfbcnjp6Ax8U7cSySDNhX
IEmtaV4ZBdpKEXlaisJ4CzGrHAqbTBVulWDtw6dAMAKRnfAPsZU8b9OrtZtiFZO2
vzYawQj3ikr0CDohNKcBFt7urPQ0kefOlBK/PddMImwim+QX81H+VBCCutsDUyiB
c9YHBw/26Kv5ZUUUDpI6cauwbnwgSnQPbBzIokd57aXu25gtOCE7Yu3+YJmytmk2
oXMJD90KTDXwBsFAgkkkIRs3jPWibU1zr+sKpFiPJicCtPXEV8w=
=fmdR
-----END PGP SIGNATURE-----

--=-pHgpvGEJ56J+rQ6TcAZ8--

