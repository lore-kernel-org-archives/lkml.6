Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB948C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ABC206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbfAIPDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:03:21 -0500
Received: from mout.gmx.net ([212.227.17.21]:57105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732232AbfAIPDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:03:19 -0500
Received: from homer.simpson.net ([185.191.218.82]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ld0E0-1h7olJ03pw-00iBRh; Wed, 09
 Jan 2019 16:03:17 +0100
Message-ID: <1547046196.31155.1.camel@gmx.de>
Subject: Re: 5.0-rc1 KVM inspired "BUG: Bad page state in process" spew
From:   Mike Galbraith <efault@gmx.de>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     kvm <kvm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Date:   Wed, 09 Jan 2019 16:03:16 +0100
In-Reply-To: <20190109144257.erwh52326ucgc5tw@angband.pl>
References: <1547012338.4926.11.camel@gmx.de>
         <20190109144257.erwh52326ucgc5tw@angband.pl>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sZ79JYjLOWKiOVpoWba8MQtnnJMH1ZzfWMn49/cize7DFhuSxCp
 OmHc/DQcPW4ositk/4mWAHVcevP5ALyBBK3aWFp1PjEMgGPLH2kKPlhZ53zTaJ1O7W8/V8w
 U6Y6deJYhqPhryjHd2+5KZ9GYLi95JAU7UQzIGnP+49l1uQFc9IRAjNBENFSrGZv6dAQkOK
 Je730IZaragOOMtBMPLjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yCK2kCX1Kp4=:joa6/EZQ9CHZToCAfzUQ1T
 Yk7HCC9f9igkjZf7IQJVFN3bTuiuKEusjzv4tqnHWrv0XgV5hqn/dTuC/W+Raj64/XznpZbed
 Gx6hJ1pAm2gXQmPPIHoDTp7d0bwqpE1x0exw4c41xJSyQfbqz4tIFO0RgC+gyfrQK4QKDzzfd
 6+gVAO1eKJTf5Bfx4EGR9QR8sWsYgvYMyOzpjTURr4raAMm3DU3h1aZDsBN7GuOM0YLxB2SHu
 mxkl8ZBGJDrkv0RHsnLL2NPebivfDCha7xl8TdagUR4qwFF1s2FP6tl7M9VjNP/7Hya1Jr8i4
 rd94AMo+q+7Xsz9LCl/K2xpnLKR5cCd7cpqJaS5Blh7zaGUTu3p39A25Zo+7M3ze/4Kb0nnvL
 PqQuYZXT77UVxHs2VE+NmPOQ1k6TA47o2OM9m4WNH7AqsbYBGh+Bo1o6Qf93gLNV0tdHtTU9J
 eHyuW48m7YjxJ5jnoCD+SuDdi7Z4VC75jyrFRZqW3zGnXe4LM34XzXcnq07gSNw/iqFFqZydW
 JDv1xJI6o6seQKBZFkph9xbldfESRTsjUgNGK/zDnWmj1QXhmgccSDiSchC6uPpD70djt/seL
 QRWGJDNBzFH8mo8MMaK8a6cqzMvHcE9FlWBYuRcRiuqrHstVkNEgxCnU/Zucti0VUk1hQKAx9
 FKt9L+Ho45JX6nA0ZILxVVlnGcu6ZMaXSNGJxwXCcoG1By/YzhHhb44iATi+tXj929N76zNmi
 /yagtnWwT9aHHrYo+tbzoIKNCDPDntHic9wtLc7c+uI5B4nortQsqDIMvMDCnCByOBXpR+aVu
 EGmYvuZgnGvh9ftqOzr1BxZNBhAZckyVUDXIgXkzwuxaO2HTJLgs1Z1ZozpUFQN6k4oWSWZMl
 YaHxFzNL1/5cCXthkYxhtkwZen+X0YlzyFIMddzMXL5g5jCf3z467QwQloZ68n
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-09 at 15:42 +0100, Adam Borowski wrote:
> On Wed, Jan 09, 2019 at 06:38:58AM +0100, Mike Galbraith wrote:
> > KVM seems to be busted in master ATM.  All I have to do to have host
> > start screaming and maybe exploding (if the guest doesn't do so first)
> > is to try to install a (obese in this case) kernel over nfs mount of
> > the host in a guest.
> > 
> > Kernel producing the spew below is 3bd6e94, config attached.
> 
> I get same, except that the BUGs were preceded by a bunch of warnings,

Yeah, I was in too much of a rush...

> > homer: # grep BUG: /netconsole.log
> > [ 1531.909703] BUG: Bad page state in process X  pfn:100491
> > [ 1531.958141] BUG: Bad page state in process systemd-journal  pfn:100412
> > [ 1532.662359] BUG: Bad page state in process X  pfn:10043f
> > [ 1532.664033] BUG: Bad page state in process X  pfn:10044d
> > [ 1532.686433] BUG: Bad page state in process systemd-journal  pfn:1027b0
> 
> the first one being:
> 
> Jan  9 00:41:22 umbar kernel: [74122.790461] WARNING: CPU: 2 PID: 26769 at arch/x86/kvm/mmu.c:830 mmu_spte_clear_track_bits+0x7e/0x100

...I also get oodles of those.

	-Mike
