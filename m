Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F27C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4562420849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4562420849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeLMLJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:09:13 -0500
Received: from [195.159.176.226] ([195.159.176.226]:35015 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeLMLJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:09:13 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1gXOpX-0002I8-Vj
        for linux-kernel@vger.kernel.org; Thu, 13 Dec 2018 12:06:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   "Andrey Jr. Melnikov" <temnota.am@gmail.com>
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
Date:   Thu, 13 Dec 2018 13:38:36 +0300
Message-ID: <aep9ef-6rt.ln1@banana.localnet>
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net> <20181128041555.GE31885@thunk.org> <en52df-5dh.ln1@banana.localnet> <2547416.7Vy7A2kRpU@siriux> <CA+PODjo-da79FKQCmpcH9Z9CBq35HbWu2m+nB3si7WgD9w-kGA@mail.gmail.com> <cbdb2e6b-31a2-1e19-f51f-067dcbdcf183@mailbox.org> <CA+PODjpLRuc1u4SNSRqfWtx+Z+C8NGi6fs7yFuyKK0DwHggEdg@mail.gmail.com> <de67b507-ca54-e827-867e-76d57e531cb9@mailbox.org> <CA+PODjrT=pXg-jbhk=q=M6j6-v0x+c05s4Lmi3+MLm0P4iirqg@mail.gmail.com> <20181211001158.GA20388@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: tin/2.2.1-20140504 ("Tober an Righ") (UNIX) (Linux/4.3.3-bananian (armv7l))
Cc:     linux-ext4@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gmane.comp.file-systems.ext4 Pavel Machek <pavel@ucw.cz> wrote:
> [-- text/plain, кодировка quoted-printable, кодировка: us-ascii, 32 строк --]

> Hi!

> > > >> OK, - and now we are looking forward to *your* ideas how to solve this.
> > > >
> > > > After four days playing games around git bisect - real winner is
> > > > debian gcc-8.2.0-9. Upgrade it to 8.2.0-10 or use 7.3.0-30 version for
> > > > same kernel + config - does not exhibit ext4 corruption.
> > > >
> > > > I think I hit this https://gcc.gnu.org/bugzilla/show_bug.cgi?id=87859
> > > > with 8.2.0-9 version.
> > > >
> > > Good that it works for you. But others used gcc 5.4.0 or 6.3.0 and were
> > > hit anyway: https://bugzilla.kernel.org/show_bug.cgi?id=201685#c165
> > 
> > Depends on workload pattern. 4.19.5 built with 8.2.0-10 and 7.3.0-30 -
> > crashed after 4 hours of usage (previous build crash in 5 min).
> > So my assumption about broken gcc is wrong.

> Would it be possible to try vanilla 4.19? (Not stable?)

> I test vanilla and -next kernels every week or two, and did not have
> ext4 problems recently. I guess many kernel developers test mainline
> but not stable...

Fix already commited to stable/vanilla brances:
https://bugzilla.kernel.org/show_bug.cgi?id=201685#c314

