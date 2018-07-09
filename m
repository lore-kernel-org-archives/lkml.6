Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A96C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91A52086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=exactcode.de header.i=@exactcode.de header.b="W0wvYZtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91A52086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933578AbeGIWlA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:41:00 -0400
Received: from mx.exactcode.de ([144.76.154.42]:53748 "EHLO mx.exactcode.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932812AbeGIWk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:40:57 -0400
X-Greylist: delayed 1602 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2018 18:40:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactcode.de; s=x;
        h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:Content-Type; bh=aVoTRtfLCKs1D5skpyhM33JnB0Ag63F35pNrzw36Em4=;
        b=W0wvYZtI/MX+k7R6XichdSsEa+v4wci9B6CeIQ7S7JY7EYIqvL0CdN9MU13Y3BhJQJsiRDQ7lQnJzFCyB2RFRIax2TA4PnoKUFsbZ44k4FYsj20AYl028omnMfe3A6WZJD0MLzucOaT5hCoaFmr/T8U1QUlu3QyLEixOLUdROoo=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.com>)
        id 1fceQb-00026C-5K; Mon, 09 Jul 2018 22:14:41 +0000
Received: from ip5b40d425.dynamic.kabel-deutschland.de ([91.64.212.37] helo=[192.168.0.15])
        by exactco.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.54)
        id 1fceQU-0004zI-RM; Mon, 09 Jul 2018 22:14:44 +0000
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
From:   =?iso-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.com>
In-Reply-To: <5B282FAD-EDCF-44C8-A131-A3C6FF3EA84F@fb.com>
Date:   Tue, 10 Jul 2018 00:13:50 +0200
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3F598446-EA1D-47CE-B7A1-4D3002DA3972@exactcode.com>
References: <20180322012943.4145794-1-terrelln@fb.com> <5B282FAD-EDCF-44C8-A131-A3C6FF3EA84F@fb.com>
To:     Nick Terrell <terrelln@fb.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 09 Jul 2018, at 20:04, Nick Terrell <terrelln@fb.com> wrote:

>> On Mar 21, 2018, at 6:29 PM, Nick Terrell <terrelln@fb.com> wrote:
>> This patch set adds support for a ZSTD-compressed kernel and ramdisk
>> images in the kernel boot process. It only integrates the support =
with
>> x86, though the first patch is generic to all architectures.
>=20
> Hi all,
>=20
> Is there anything blocking this from getting merged?
> Please let me know if there is anything I can do to help move this =
patch forward.

works fine on my side, initrd test booted on i486, x86-64, ppc, ppc64 =
and
sparc64. For testing on mips64 I would first need to re-base the =
Octane^1
patch-set ;-)

Greetings,
	Ren=E9

^1) https://www.youtube.com/watch?v=3DAU_RV8uoTIo

--=20
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | =
http://t2-project.org | http://rene.rebe.de

