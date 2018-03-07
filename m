Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754359AbeCGNEC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:04:02 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:39455 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeCGND7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:03:59 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180307130357epoutp02034853f8734829cef41e279c00d754ac~ZpRASFBHs1208112081epoutp023
X-AuditID: b6c32a36-ca9ff70000001028-1f-5a9fe33d0083
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Peter Malone <peter.malone@gmail.com>
Cc: Mathieu Malaterre <malat@debian.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fixing arbitrary kernel leak in case
 FBIOGETCMAP_SPARC in sbusfb_ioctl_helper().
Date: Wed, 07 Mar 2018 14:03:54 +0100
Message-id: <2367982.TLCx2xJjlb@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <CALGb=fQFwgn6=JLq0_5WkwkTpASCXzO_sGPR0BzT3cuF58nzBg@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7bCmrq7t4/lRBj/Wc1lc+fqezeJE3wdW
        i8u75rBZnN30lsXiUuMldgdWj19tc5k9ds66y+5xv/s4k8fnTXIBLFFcNimpOZllqUX6dglc
        GX+/vmcp2CNRcWXOVKYGxmahLkYODgkBE4kVc8u7GLk4hAR2MErM3reSDcL5zijx8uMlxi5G
        TrCiKfffMEIkNjBK3Ng9nR3C+coocez+NBaQKjYBK4mJ7avAOkQENCW+bTzDDFLELLCZUWLD
        wu+sIAlhgSyJ25dPgtksAqoSH04+ZwaxeYEa/lx8D2aLCnhJbNnXzgRicwoES3zb8QaqRlDi
        x+R7YMuYBeQl9u2fygph60icPbYO7DwJgTVsEgvvXWOFeM5F4sM7F4gXhCVeHd/CDhGWlrh0
        1BaivJkRaP4eZoiaCYwSe9YLQdjWEoePX4Sazyfx7msP1EheiY42qBIPiburH7JAhB0lbp6N
        hITJVUaJLZf/MU5glJ2F5OpZSK6eheTqBYzMqxjFUguKc9NTiw0LjPSKE3OLS/PS9ZLzczcx
        gpOAltkOxkXnfA4xCnAwKvHwRuydFyXEmlhWXJl7iFGCg1lJhHfjg/lRQrwpiZVVqUX58UWl
        OanFhxilOViUxHkDAlyihATSE0tSs1NTC1KLYLJMHJxSDYxbbdz4Vh1Vc1Xhs482CnyrFX/h
        ZvU6UxafSeLfFf//f25sW9vnWv9TZO7stA8xc3zn6dhufvSw6DvzBOst5wpvvg8JYRMQPlhg
        MW1191cP72Nabw0WffG7bnZdK2XLFhG5VE37Tx/bVgQ8UG7T19sv9SJgy6N1vtuTK+X6BQQ8
        YsLFdszUq1ViKc5INNRiLipOBADLNwGL/gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsVy+t9jQV2bx/OjDB4u1rK48vU9m8WJvg+s
        Fpd3zWGzOLvpLYvFpcZL7A6sHr/a5jJ77Jx1l93jfvdxJo/Pm+QCWKK4bFJSczLLUov07RK4
        Mv5+fc9SsEei4sqcqUwNjM1CXYycHBICJhJT7r9h7GLk4hASWMcoceLdKVaQhJDAV0aJpd+q
        QWw2ASuJie2rGEFsEQFNiW8bzzCDNDALbGaUuPFpKTNIQlggS+LW39lgNouAqsSHk8/BbF6g
        hj8X34PZogJeElv2tTOB2JwCwRLz/y9lglh2lVFiynkziHpBiR+T77GA2MwC8hL79k9lhbC1
        JNbvPM40gZF/FpKyWUjKZiEpW8DIvIpRMrWgODc9t9iowDAvtVyvODG3uDQvXS85P3cTIzBw
        tx3W6tvBeH9J/CFGAQ5GJR7eiL3zooRYE8uKK3MPMUpwMCuJ8G58MD9KiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6pBsbKPK7tXgd81l/8MVW4Wi5PZdF6
        y1k/THesY444ZHP/Q7SQb5Xmjr9OM08/nxrpq3X9l6XABc2oKB/TlYyb5lsk//3GpFjkVnBc
        8LvEvTVbbc5ON1bZ9HNlL/MevvWrzq//ptLDYrnZ6UzffuHNmYyM8Vce/lj5X+wu72OdnxtP
        R2yVD+i0mqygxFKckWioxVxUnAgAhbCiwlgCAAA=
X-CMS-MailID: 20180307130356epcas1p259bf7d0d6ce0f2b92125a1a4ea802955
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180204141807epcas1p1039a2ae47bed656a1fd456bb868a182b
X-RootMTR: 20180204141807epcas1p1039a2ae47bed656a1fd456bb868a182b
References: <20180130203042.4797-1-peter.malone@gmail.com>
        <CGME20180204141807epcas1p1039a2ae47bed656a1fd456bb868a182b@epcas1p1.samsung.com>
        <CALGb=fQFwgn6=JLq0_5WkwkTpASCXzO_sGPR0BzT3cuF58nzBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, February 04, 2018 09:18:03 AM Peter Malone wrote:
> Hi folks,

Hi,

> CVE-2018-6412 has been created for this. Is it possible for you to add
> a note indicating the CVE number when merging the patch?
> 
> I received the CVE number after the patch was created and ack'd, which
> is why I didn't include it in the commit message.

I queued the patch (with Mathieu's ACK and CVE number added to the patch
description) for v4.16, thanks.

> On Wed, Jan 31, 2018 at 10:49 AM, Mathieu Malaterre <malat@debian.org> wrote:
> > Hi Peter,
> >
> > On Wed, Jan 31, 2018 at 3:57 PM, Peter Malone <peter.malone@gmail.com> wrote:
> >> Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in
> >> sbusfb_ioctl_helper().
> >>
> >> 'index' is defined as an int in sbusfb_ioctl_helper().
> >> We retrieve this from the user:
> >> if (get_user(index, &c->index) ||
> >>     __get_user(count, &c->count) ||
> >>     __get_user(ured, &c->red) ||
> >>     __get_user(ugreen, &c->green) ||
> >>     __get_user(ublue, &c->blue))
> >>        return -EFAULT;
> >>
> >> and then we use 'index' in the following way:
> >> red = cmap->red[index + i] >> 8;
> >> green = cmap->green[index + i] >> 8;
> >> blue = cmap->blue[index + i] >> 8;
> >>
> >> This is a classic information leak vulnerability. 'index' should be
> >> an unsigned int, given its usage above.
> >>
> >> This patch is straight-forward; it changes 'index' to unsigned int
> >> in two switch-cases: FBIOGETCMAP_SPARC && FBIOPUTCMAP_SPARC.
> >>
> >> Signed-off-by: Peter Malone <peter.malone@gmail.com>
> >> ---
> >
> > much better :)
> >
> >> v2: fixed formatting
> >>
> >>  drivers/video/fbdev/sbuslib.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/video/fbdev/sbuslib.c b/drivers/video/fbdev/sbuslib.c
> >> index af6fc97f4ba4..a436d44f1b7f 100644
> >> --- a/drivers/video/fbdev/sbuslib.c
> >> +++ b/drivers/video/fbdev/sbuslib.c
> >> @@ -122,7 +122,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
> >>                 unsigned char __user *ured;
> >>                 unsigned char __user *ugreen;
> >>                 unsigned char __user *ublue;
> >> -               int index, count, i;
> >> +               unsigned int index, count, i;
> >>
> >>                 if (get_user(index, &c->index) ||
> >>                     __get_user(count, &c->count) ||
> >> @@ -161,7 +161,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
> >>                 unsigned char __user *ugreen;
> >>                 unsigned char __user *ublue;
> >>                 struct fb_cmap *cmap = &info->cmap;
> >> -               int index, count, i;
> >> +               unsigned int index, count, i;
> >>                 u8 red, green, blue;
> >>
> >>                 if (get_user(index, &c->index) ||
> >> --
> >> 2.14.3
> >>
> >
> > By just looking at the code and commit message:
> >
> > Acked-by: Mathieu Malaterre <malat@debian.org>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
