Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73351C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3F2217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="J85VsFqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfACV3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:29:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40786 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfACV3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:29:09 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so30159520edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 13:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tHdsUEewYXSe8Kadix+ZY90aufWKaK0mZq33dBRtvTk=;
        b=J85VsFqy45Pa1s5bDdQGYYTinaa8O5I3TNHJY1b3i6V2dLg1x4RXAyrngOqZu6GpVL
         hBSl2n5q3NPPeoQjc64kD8Itv48U1Fx8RHvfNkowg1IYiQ83s0010ogtg43f45rKpkya
         OEllt4ReHX4CUWRCEJvXLsnOl9+8PWbZjcNrI+P4m8LiPpRcpMIYtQYvMKS6p9byy1uM
         JiwgD3irlXBIlPjJwwe3N/C/f2JVUwC2mOOjP30cOwNhKtKT3lsNN+RBf0jpBnGscRG+
         GpT1lfMHMhNGKXAoaS6uhNVsLlbzIIhSHdiHv5xi9IDnrO91nuzbqlfoMQu6HmXTDYZh
         2mVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tHdsUEewYXSe8Kadix+ZY90aufWKaK0mZq33dBRtvTk=;
        b=KhWVi0Vod0PmCM2TwdnvRZJONOnui/Yp05/M52+JS4GazR0axtXtIxeMIzfZE0brCv
         XXmQns8fZ7LF+bHfY/o/WFTHVbNRnLvk6XLR1aqrsJFUqHQo0gwRk1zKwZK9ys6N1Zzn
         0vVp/iWAyywgmF9d7gZKS/3zXLFyJstuvQES8q1LJAKOBgNwJx3ccBCyQvK3Bn8Xwvma
         jsXCJm+ywnSOdjByR4Ku51I2wyE6JN9m2/o/l7uH+DwB5VK5ptHxP19SOp2nq7sS7B1v
         pp4la8SQMcRfgFooNL3qONtvPxyTG2jBUMO+hRbuM55ieNxWrqPo8zAqT4rFxUL8SdCu
         FLiw==
X-Gm-Message-State: AA+aEWZHNTWOCAisdnXREclEKPEnC28UG/gMY2RZoPiYA2OWGQ3kJQOx
        jdtJ5fLzqeasfWFWnyEMud9eWFT0gvP2Uvnp4SvhxQ==
X-Google-Smtp-Source: AFSGD/UAy6mDIL1Xqh/aXd8Q5xdYAsoRC3tnN68i2/F35kQpcAB1L6/6kwIuwRxBn8aqHAtQj6AfnknAuMopt15U1QA=
X-Received: by 2002:a50:9a42:: with SMTP id o60mr45166776edb.180.1546550947080;
 Thu, 03 Jan 2019 13:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
 <20180719205545.16512-24-pasha.tatashin@oracle.com> <20181106054212.GA31768@nautica>
 <95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com> <20190102202032.GA1034@eldamar.local>
In-Reply-To: <20190102202032.GA1034@eldamar.local>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 3 Jan 2019 16:28:56 -0500
Message-ID: <CA+CK2bC70pnL0Wimb0xt99J4nNfi8W3zuUHgAk-jsPuOP9jpHA@mail.gmail.com>
Subject: Re: [PATCH v15 23/26] sched: early boot clock
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>,
        prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com,
        gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could you please send the config file and qemu arguments that were
used to reproduce this problem.

Thank you,
Pasha

On Wed, Jan 2, 2019 at 3:20 PM Salvatore Bonaccorso <carnil@debian.org> wrote:
>
> Hi,
>
> On Tue, Nov 06, 2018 at 06:35:36AM -0500, Steven Sistare wrote:
> > Pavel has a new email address, cc'd - steve
> >
> > On 11/6/2018 12:42 AM, Dominique Martinet wrote:
> > > (added various kvm/virtualization lists in Cc as well as qemu as I don't
> > > know who's "wrong" here)
> > >
> > > Pavel Tatashin wrote on Thu, Jul 19, 2018:
> > >> Allow sched_clock() to be used before schec_clock_init() is called.
> > >> This provides with a way to get early boot timestamps on machines with
> > >> unstable clocks.
> > >
> > > This isn't something I understand, but bisect tells me this patch
> > > (landed as 857baa87b64 ("sched/clock: Enable sched clock early")) makes
> > > a VM running with kvmclock take a step in uptime/printk timer early in
> > > boot sequence as illustrated below. The step seems to be related to the
> > > amount of time the host was suspended while qemu was running before the
> > > reboot.
> > >
> > > $ dmesg
> > > ...
> > > [    0.000000] SMBIOS 2.8 present.
> > > [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
> > > [    0.000000] Hypervisor detected: KVM
> > > [    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
> > > [283120.529821] kvm-clock: cpu 0, msr 321a8001, primary cpu clock
> > > [283120.529822] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> > > [283120.529824] tsc: Detected 2592.000 MHz processor
> > > ...
> > >
> > > (The VM is x86_64 on x86_64, I can provide my .config on request but
> > > don't think it's related)
> > >
> > >
> > > It's rather annoying for me as I often reboot VMs and rely on the
> > > 'uptime' command to check if I did just reboot or not as I have the
> > > attention span of a goldfish; I'd rather not have to find something else
> > > to check if I did just reboot or not.
> > >
> > > Note that if the qemu process is restarted, there is no offset anymore.
> > >
> > > I unfortunately just did that so cannot say with confidence (putting my
> > > laptop to sleep for 30s only led to a 2s offset and I do not want to
> > > wait longer right now), but it looks like the clock is still mostly
> > > correct after reboot after disabling my VM's ntp client. Will infirm
> > > that tomorrow if I was wrong.
> > >
> > >
> > > Happy to try to help fixing this in any way, as written above the quote
> > > I'm not even actually sure who is wrong here.
>
> A user in Debian reported the same/similar issue (with 4.19.13):
>
> https://bugs.debian.org/918036
>
> Regards,
> Salvatore
