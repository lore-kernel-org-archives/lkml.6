Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF571C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F878204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJDRVBvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F878204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeJITeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:34:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42228 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeJITeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:34:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id g15-v6so1569189wru.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l036Q/UFkUUqicQqNfneN9vMYq+5SocYLAHwwS7vc9Y=;
        b=XJDRVBvKFMOpuM1dowL3cOdbvsS2WQXRq2Y/whgTf8yQCK9nSJK7yyZ7xTCIRVfmpU
         8Nq3TBkYuIMByFzEddHdO4sBLIcnUZcNGMaemHV8qj/PxsKTZxkr5oJPWQhLSCDY+pys
         UxJKF6GGmXnDGKiDNw45l6Rt7tMd+CAb5WjhUKUjnGF0a+o5TuvCmf+/l/OUuOoSaz4R
         ERPNEGkwPSrUJOkVqMx7hk+GZxWjCwNnKhYIxKVTS2ASCRfZPRAlFb5tym7/krOSbcf2
         sCD/VvL8Vz9LyGVMb4Nz7WuU590YmV9PZxNPKMaxARmXZv6zcXPbhJyHqdshjYB0P9qi
         THgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l036Q/UFkUUqicQqNfneN9vMYq+5SocYLAHwwS7vc9Y=;
        b=ZlPdy/B0YckwxAxw4ORPQp/uVWpMfcvUBn2UnbDVAuBYQxAUInarH1CFtHIwb71FPc
         UpGySsnL9aEqJjp70ZBatrexstO6C93zghzOkxAoTKDfi+OX1s1LM5PeqqsfdMA1CYP6
         kBRMDFWhHXatw/pRXz5wtLRxsdGHbkOwLBHc4VmRmbPS5DnTjUe6paf5ukhNrqAW242B
         S8vfHcXdwn2nPTjjR9wI7loAJ8jlptrrGPgV5NSOH6IuC4zogniYRRisB9vHVTDoaBeI
         itvTRRJ8qSqbYJBhSisjMPHUz4k0Z0kDOhKvNhZ8cMHSfACvroweIMI2z9P4HVj5AA9I
         BhqA==
X-Gm-Message-State: ABuFfojA7fJ9nE7zbGzS9uLAfb6Ze3Ktq16x6MPWqr8udAJPcboDagt1
        SUNXLhDTpUhB02yDTlQCaeD7cJhu1BE6Lu3JxeBc
X-Google-Smtp-Source: ACcGV62hdpavTRvi72L9nQUQTYGy7U0z5DwU9vigixMsYB3XvI5/HNcsgHgGRV1beNznN3AVg0FDy220dB7tIRDK3mU=
X-Received: by 2002:adf:a781:: with SMTP id j1-v6mr17215493wrc.277.1539087445973;
 Tue, 09 Oct 2018 05:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <1539069292.17569.7.camel@abdul.in.ibm.com> <87woqr1mfr.fsf@concordia.ellerman.id.au>
 <1539081603.17569.10.camel@abdul.in.ibm.com>
In-Reply-To: <1539081603.17569.10.camel@abdul.in.ibm.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 9 Oct 2018 07:17:14 -0500
Message-ID: <CAErSpo5RGSdX_g36KSBE1er_bmKpHih=X7DoTtTwos5PW4qn7w@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtsaW51eC1uZXh0XVtiaXNlY3RlZCBlM2ZiY2M3Y10gYnVpbGQgZXJyb3IgYXQgZA==?=
        =?UTF-8?B?cml2ZXJzL3BjaS9wY2llL2Flcl9pbmplY3QuYzo0NDQ6NjogZXJyb3I6IOKAmHN0cnVjdCBwdF9yZWdz?=
        =?UTF-8?B?4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYaXA=?=
To:     abdhalee@linux.vnet.ibm.com
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sachinp@linux.vnet.ibm.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-next list <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 5:40 AM Abdul Haleem <abdhalee@linux.vnet.ibm.com> w=
rote:
>
> On Tue, 2018-10-09 at 20:47 +1100, Michael Ellerman wrote:
> > Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> > > Greeting's
> > >
> > > Today's linux-next fails to build on ppc with below error
> > >
> > > drivers/pci/pcie/aer_inject.c: In function =E2=80=98aer_inject_ftrace=
_thunk=E2=80=99:
> > > drivers/pci/pcie/aer_inject.c:444:6: error: =E2=80=98struct pt_regs=
=E2=80=99 has no
> > > member named =E2=80=98ip=E2=80=99
> > >   regs->ip =3D (unsigned long) hook->function;
> > >       ^
> > > make[3]: *** [drivers/pci/pcie/aer_inject.o] Error 1
> > > make[2]: *** [drivers/pci/pcie] Error 2
> > > make[1]: *** [drivers/pci] Error 2
> > >
> > > Machine: Power 9
> > > kernel version: 4.19.0-rc7-next-20181008
> > > gcc version: 4.8.5 20150623
> > > config attached
> > >
> > > Recent code changes from these commits:
> > >
> > > c79ad38b36dd4967d67f83fc48bade37ee041a47 PCI/AER: Abstract AER interr=
upt handling
> > > 7b23285f930a8dedcbf749661cd0f2cc27f79be6 PCI/AER: Reuse existing pcie=
_port_find_device() interface
> > > e3fbcc7c4b130f81ea586183db561fa3ce9c6447 PCI/AER: Covertly inject err=
ors with ftrace hooks
> >
> > I don't see this commit in today's linux next (20181009) so presumably
> > someone else has noticed and dropped the commit?
>
> Yes, the commit is dropped from next-20181009, and now build is fine.

I dropped those commits yesterday.
