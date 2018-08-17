Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C8FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2BB20E20
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=profitbricks-com.20150623.gappssmtp.com header.i=@profitbricks-com.20150623.gappssmtp.com header.b="FPjyEBIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2BB20E20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profitbricks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeHQPmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:42:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52361 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbeHQPmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:42:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so7410018wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profitbricks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lhiv+WV1XMqQrpsPUhIeOyV14rcFg8AWwaI+6jqxYB8=;
        b=FPjyEBIjAwN5x9Ii6Aaj8hK/7PtTJRMDFWPjwJXIOOz/J6qfJpf7YP8pZYPtsR0Hv2
         +SLX0HqfJmKXPODq/vXLjbp9OcotveehZem6YDnrNal9XKBb1X2dobZPdE7SyU+J2stA
         Uqsos0piQ3bJlP2DESPgSGeyM/qTAzcpApqw7Ecl8dv1h3z54NTRa2e8pwKGcUt6KRut
         1ratrsi7JNflMtOz93ynMD+fOJPOAN/ZlvFCxDKk93WmEbj76K8KNwgv3Kw2mf0ogL/K
         q0gSGC8JcJIkj+hpw7R2Y4q7xXFnUFbN+vLADTMVP0iFnpXOeFgaHYsT4YgLlqhGwwBW
         pAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lhiv+WV1XMqQrpsPUhIeOyV14rcFg8AWwaI+6jqxYB8=;
        b=egeawSRk/0ajcWlKb3qAZBBvaYCpGK28L+wUKTh0REaSCajLSHHjj46j4HGsxNA767
         1bhjigD5REEzRnIgHB90uGBBT1DAlQ1zggeK71Ud+QYljJzIJKa7kYYZUislcfBV0bTX
         vtibrvgcpnqurUPYPX2c6bV1GEYHqZ+bLiSYhDO8QRz3s6EwYQnU8I55I6elQOVlC8pM
         ktD6E5JaMDMiDdIfyOGaGlg+8UkOBbiPjGLzQNTHD7/ZXdDzWuVyTHhc+TUaUlm7z4fh
         OYIUUht9ewKxVoKldqqEn/4f/qXRvPFdQBVQLCwAHbwrC60e9QNqLSYd5tvhHZ+f6KuA
         Sv1Q==
X-Gm-Message-State: AOUpUlFDRB2NKpqnSLZsbCXkWQRemD58FuFmXiF7+QsTf2hH6DaSz1u3
        jTI2+57HKFZmZ3PX/ME56OZ+DEBVJIax9Gigok4kng==
X-Google-Smtp-Source: AA+uWPyO5SeJSUGm/yRb4IZKXAqs9TwzKMpv3axSEvs3IA7kgBcWoU6ptcqoxYMZAfxGUaEatrpZQhYmKgdhE1PRPyQ=
X-Received: by 2002:a1c:5bc7:: with SMTP id p190-v6mr18617028wmb.101.1534509552499;
 Fri, 17 Aug 2018 05:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffEnzVo5VVSVBjCOBMhcoV1qXf0XXqJqr3C01xQn-aUiZFQ@mail.gmail.com>
 <20180816155126.GA18296@kroah.com> <CAMGffEmJR310NKHO1JpwE8yTg1Oeu_oaTaJ1D2_T_UHKCnHwKA@mail.gmail.com>
 <20180816163937.GA5105@kroah.com> <CAMGffEk2FqRn0av7T-aF-TKvRAKeinm96NYjJju_T4CmUrYPkQ@mail.gmail.com>
In-Reply-To: <CAMGffEk2FqRn0av7T-aF-TKvRAKeinm96NYjJju_T4CmUrYPkQ@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@profitbricks.com>
Date:   Fri, 17 Aug 2018 14:39:00 +0200
Message-ID: <CAMGffEnKt0xcc6LhNdZQGRmckJ3qCFxCOnQ3owZmWWiaKYdYuw@mail.gmail.com>
Subject: Re: [BUG]smt sysfs dir missing on 4.4.148 and 4.14.63
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        stable <stable@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 6:48 PM Jinpu Wang <jinpu.wang@profitbricks.com> wr=
ote:
>
> On Thu, Aug 16, 2018 at 6:39 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Aug 16, 2018 at 06:28:59PM +0200, Jinpu Wang wrote:
> > > On Thu, Aug 16, 2018 at 5:51 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Aug 16, 2018 at 05:43:23PM +0200, Jinpu Wang wrote:
> > > > > Hi Greg, hi Thomas,
> > > > >
> > > > > I noticed /sys/devices/system/cpu/smt dir is missing on 4.4.148 a=
nd
> > > > > 4.14.63, default setting.
> > > >
> > > > For 4.4, I would be amazed if anything was there, the backport was =
done
> > > > only to handle the local user issue, not the "full" protection.  So
> > > > please try 4.9 or 4.14.
> > > Thanks for quick reply. Right, just checked. the patch for create the
> > > sysfs entry is missing.
> >
> > What patch is that?  What is the git commit id that we missed?
> >
> > > > How about 4.17 and 4.18, do those trees work properly for you?
> > > I guess it's the same.
> > > >
> > > > > Tried stable/master branch 31130a16d459 ("Merge tag
> > > > > 'for-linus-4.19-rc1-tag' of
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip")
> > > > > It's the same there.
> > > >
> > > > Ah, so we are bug compatible, good :)
> > > I will try test stable master a bit more to gather the full log.
> > > >
> > > > > When boot with 'nosmt' kernel paramter kernel 4.14.63 panic durin=
g
> > > > > boot, 4.4.148 boot fine.
> > > > > The call trace seem irq related, is it known bug?
> > > >
> > > > You are not giving us much to go on here sorry.  We need full detai=
ls,
> > > > and also please cc: lkml and the other developers who worked on thi=
s.
> > > > THomas is on vacation this week.
> > > Now, add more developers to cc, also lkml.
> > >
> > > I have the config and boot dmesg attached for default setting.
> >
> > I see no error in your boot log, what exactly are you worried about?
> 2 problems here:
> 1 According to https://www.kernel.org/doc/html/latest/admin-guide/l1tf.ht=
ml
>   I expect /sys/devices/system/cpu/smt/, but it's not.
> 2 kernel 4.14.63 panic when I boot with 'nosmt' or 'l1tf=3Dfull', I
> attached the picture here again,
>   I will try to get the full log tomorrow, also test with linus tree.
> >
> > confused,
> >
> > greg k-h
>
> Thanks
I found the problem, CONFIG_HOTPLUG_SMT is enable due to CONFIG_SMP,
but I did explicitly enable CONFIG_HOTPLUG_CPU.

That's why the smt dir is missing, and kernel panic when I boot with
'nosmt' or 'l1tf=3Dfull' probably also other combination.

With CONFIG_HOTPLUG_CPU=3Dy, it works fine so far.

Thanks,
--=20
Jack Wang
Linux Kernel Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 30 577 008  042
Fax:      +49 30 577 008 299
Email:    jinpu.wang@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg, Christoph Steff=
ens
