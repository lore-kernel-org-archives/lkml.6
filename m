Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF152C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 05:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DDF219D0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 05:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Y+30seqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DDF219D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeHFHTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 03:19:36 -0400
Received: from ozlabs.org ([203.11.71.1]:59223 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbeHFHTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 03:19:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41kQkN2Kr6z9s0R;
        Mon,  6 Aug 2018 15:12:12 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533532332;
        bh=m7p4iw65+2TZJyOEqq4ysiMZHvFRN8ElVUfVn8VLVc0=;
        h=Date:From:To:Cc:Subject:From;
        b=Y+30seqLR343nA2VdtoMyAhhPDTHXYq7mzuj/lp/OhKdGgmnf6UCL7SHBeSVhTROt
         I5Ba+mZv3BmDVXDyY1GN9o6ikKOnOzFw3fXi7FiBcsKIO6pnCap2nUQirJhHPbU8Yi
         Tu1OdGEfIzRNZ+Tu/QZ2R5XSdk+eU7NMW/sSGSze+gu0bQRTB/x9q/HAzf8vp3Wmvl
         Wk/zGvB4XC6g1Zuj64j3ZZiJohRid22p094X5pCEgT/1GVBctPX0nQmupCU8efMC0Q
         31XfRyCLL6sPTwcpM61480WT3QmS+6PGKrQTJ/rzZAFEBhZ9/3Mt6FwJBWkfR/RtU4
         hfPB3Rr1UR1Ag==
Date:   Mon, 6 Aug 2018 15:12:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: linux-next: manual merge of the kvm tree with the tip tree
Message-ID: <20180806151211.710b8615@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_bOe+tZbLn./B9yM7NCAmO_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_bOe+tZbLn./B9yM7NCAmO_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/x86/include/asm/trace/hyperv.h

between commit:

  58ec5e9c9044 ("x86/hyper-v: Trace PV IPI send")

from the tip tree and commit:

  47c054685621 ("X86/Hyper-V: Add hyperv_nested_flush_guest_mapping ftrace =
support")

from the kvm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/include/asm/trace/hyperv.h
index 9c0d4b588e3f,e1ffe61de8d6..000000000000
--- a/arch/x86/include/asm/trace/hyperv.h
+++ b/arch/x86/include/asm/trace/hyperv.h
@@@ -28,21 -28,20 +28,35 @@@ TRACE_EVENT(hyperv_mmu_flush_tlb_others
  		      __entry->addr, __entry->end)
  	);
 =20
 +TRACE_EVENT(hyperv_send_ipi_mask,
 +	    TP_PROTO(const struct cpumask *cpus,
 +		     int vector),
 +	    TP_ARGS(cpus, vector),
 +	    TP_STRUCT__entry(
 +		    __field(unsigned int, ncpus)
 +		    __field(int, vector)
 +		    ),
 +	    TP_fast_assign(__entry->ncpus =3D cpumask_weight(cpus);
 +			   __entry->vector =3D vector;
 +		    ),
 +	    TP_printk("ncpus %d vector %x",
 +		      __entry->ncpus, __entry->vector)
 +	);
 +
+ TRACE_EVENT(hyperv_nested_flush_guest_mapping,
+ 	    TP_PROTO(u64 as, int ret),
+ 	    TP_ARGS(as, ret),
+=20
+ 	    TP_STRUCT__entry(
+ 		    __field(u64, as)
+ 		    __field(int, ret)
+ 		    ),
+ 	    TP_fast_assign(__entry->as =3D as;
+ 			   __entry->ret =3D ret;
+ 		    ),
+ 	    TP_printk("address space %llx ret %d", __entry->as, __entry->ret)
+ 	);
+=20
  #endif /* CONFIG_HYPERV */
 =20
  #undef TRACE_INCLUDE_PATH

--Sig_/_bOe+tZbLn./B9yM7NCAmO_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltn2KsACgkQAVBC80lX
0GxyzwgApK/mlth2oBwl+B6s4lGI6/1sOm7yPMFsdixDY8QVHGGx53DN5RL165b7
4Z+aNyXYgxOdxL/BpqdlEahoO11RrGL/n5q9ola2wE0orX1XdddwWlrrQ0YMw0YJ
yF1v56OqsP5fVqwYIRAC39DjV46Xs3ueoeXB952gNXmLglcKUfZdpfAvx4yjJh7w
JlBaGG+Osf/DsdBR4GrSIdrnXpGB3ImPv2cR/fa3GdpjTxOXcrkNxu0nDD+1c2YG
Gmef64ft5i3wFI0kw1PyeqzdYJa4ebQHw4cI5JG4vEk54T+NCtiEsUXv7NKS5Zmx
wNvHOX2+pXKZ+2oWp+0teQHWtMq4kA==
=Z4ON
-----END PGP SIGNATURE-----

--Sig_/_bOe+tZbLn./B9yM7NCAmO_--
