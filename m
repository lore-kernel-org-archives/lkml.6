Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3481772-1522279357-2-17855834526282057847
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522279356; b=KRfWV9llGPI++0vLzm6Gdoecw+yFNuGsDv2o79tYl47cxyV
    eUWr5L8s2U56zn9+O7ChTmdsYQds1oA+JHvhlsoiKOxgCnmbDSTRfHtZ4fP0TRDE
    nt9FZVlQ+2I9HWxbtW3KkBXCd/F7uCSA+IjCZfg75hZq4l9TylL7kYpHDb5cqGtC
    PbdMM43oNx9ghIR0Rz6mLtgIxPdVScsf0z6IbSUjvhIna9IS7L8Uxe9EWtrxDGtS
    Rd5p20aHu8GYd6Oo0/OeDZNSb/YW9XhTFfgh9Cf7nedO1FpvFo/M4pKMfxHwIEBl
    RmZqOnKmaJiYrQ9NC4rm+Rf7xat8gl9aaMjIAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=arctest; t=1522279356; bh=042LpKJ8
    QGHSZ690knokumQEPyEKTyMvbCj26iLpp9w=; b=ouNZT2n9M2L+8XQVIMGqqg4j
    E5+5An+rAuf77y8+qcHMPJKESpmU9CfeqDUXY3EXXlylYSUZBtv4fcPArdmwOSwj
    ERD6Knlgfp9SVB11WjXr7DcY4xr4/Op+GhEv23jVGua/Oroiu3Og2FpeuCVu+dm2
    +DShFx2axmMUbqRopWhSxLrFd4Q0saeamkpohluek2HAjmIdjzzVM6oz3IituMmC
    ICf+ASWwkUq4tMnoR6lSlg1lAi+9EArYvgaEPYNHwWgBAXPKxDepnksng3BujxPV
    dFJ273nUqiI1ww6z6a63CGkFAbPUoCreMcNFu3j/GtljXVZByHI30K92jBLbbg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=c21TUs+8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=c21TUs+8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHDlZO627eZAY86bTEeeKXZY5vI+LrcbkmzGCuRFkKkGyEO2muFjuRkvPoAeY+YzL6E5ajyh7HXmyX3QzwFKq4QX9QLp7q+WZEPfUp9WpZ9nxLuq4lh+
    IJt6xnS6fdsdOpx0AtS10EDuvsSDV4xQbBdMPGmoaxUBohwrxyuFIdS8wwFWhFjev1OM8Qs0skszr58e3EAkn5Xvf40kzmJBYwMi5EtqvFD4RfbhUQGfPbvA
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=yZq99WZayZ3vFdS7fnAA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbeC1XWU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 19:22:20 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:39204 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC1XWS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 19:22:18 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180328232216epoutp03884a11abdddd518d14ac78facb9f45eb~gOP2hD3Bq3031630316epoutp03R
X-AuditID: b6c32a36-f57ff70000000fc2-b8-5abc23a67230
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5ABC23A0.20907@samsung.com>
Date: Thu, 29 Mar 2018 08:22:08 +0900
From: Inki Dae <inki.dae@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Brian Warner <brian.warner@samsung.com>
Subject: Re: [PATCH for v3.18 00/18] Backport CVE-2017-13166 fixes to Kernel
 3.18
In-reply-to: <cover.1522260310.git.mchehab@s-opensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmge4y5T1RBrt+mlv0rO5hsmhevJ7N
        4vKuOWwWPRu2slrsOLWI2eL+kkKLBRsfMVrMmPySzYHDY/MKLY/9c9ewe2z6dJfVo2/LKkaP
        z5vkAlijUm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJz
        gC5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqRRsaGukZGpjrGRkZ6ZkYx1oZmQKVJKRm
        NB9oZyqYJlLxZstipgbGyQJdjJwcEgImEmeP7GbpYuTiEBLYwSgx4+FWRpCEkMB3Rolff3xg
        inpe7WGFiO9mlGhdXw5i8woISvyYfA+omYODWUBe4silbJAws4CmxIsvk6Bm3mOUeNaygR2i
        XkNi+7azbCA2i4CqxI/Ty8FsNiB74or7YLaoQITEzvnf2EGaRQTWMUocPrOdGcRhFjjAKPH5
        xF+wK4QFgiVW/5rOBGJzCthILPm7HWydhMAJNolJx78zgZwkIeAiMfeUKMQHwhKvjm9hhwhL
        S1w6agtR3s4osevsdTYIp4dRYvniRewQDcYSzxZ2MUH8wyfx7msPK0Qzr0RHmxBEiYdE69s2
        ZgjbUaLlznRWiJf7gSF38B/rBEbZWUihNAsRSrOQQmkBI/MqRrHUguLc9NRiwwIjveLE3OLS
        vHS95PzcTYzg9KZltoNx0TmfQ4wCHIxKPLwWi3ZHCbEmlhVX5h5ilOBgVhLhfa8BFOJNSays
        Si3Kjy8qzUktPsRoCgzkicxSosn5wNSbVxJvaGJpYGJmBExSloaGSuK8AQEuUUIC6Yklqdmp
        qQWpRTB9TBycUg2MK9RNHu19rj4lxz/3rDZPB9MhibP1lXf+fd8RJDRNq6Ru/94rVcL3Vr0T
        Erft+OYbuLjB/r6iqBjn075Xz1tZZwQzFF8rcsqastKquWXiwg8O7d3W+q+MF6aItLw8uKVg
        F2eBEfvFgLjlZy603Fh7KO2AS9v77Qcf3veNNI4oOP3hiDxX/ctwJZbijERDLeai4kQAWeR0
        Z4UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsVy+t9jAd1lynuiDBoOaln0rO5hsmhevJ7N
        4vKuOWwWPRu2slrsOLWI2eL+kkKLBRsfMVrMmPySzYHDY/MKLY/9c9ewe2z6dJfVo2/LKkaP
        z5vkAlijuGxSUnMyy1KL9O0SuDKaD7QzFUwTqXizZTFTA+NkgS5GTg4JAROJnld7WLsYuTiE
        BHYyShzdtJcdJMErICjxY/I9li5GDg5mAXmJI5eyIUx1iSlTciHKHzBKfLh2kxWiXENi+7az
        bCA2i4CqxI/Ty8FsNiB74or7bCC9ogIREt0nKkHCIgLrGCX+rXIGmcMscIBR4u6Gm4wgCWGB
        YInVv6YzgdhCAhMZJT4fsASxOQVsJJb83c4ygZF/FpLrZiFcNwvhugWMzKsYJVMLinPTc4uN
        CgzzUsv1ihNzi0vz0vWS83M3MQKDetthrb4djPeXxB9iFOBgVOLhtVi0O0qINbGsuDL3EKME
        B7OSCO97DaAQb0piZVVqUX58UWlOavEhRmkOFiVx3tt5xyKFBNITS1KzU1MLUotgskwcnFIN
        jFujX6zL3BjeePjTGXl1O9kZCYun3FuuebS6//4t1rq2Zzd237FKtno3TeLGSZX9SilLREQf
        L591x3SpzEpD7z27DupxfAhSTtx6tk9Gad1y0TV/o1Yv3/cjVEHj8pVZD0J+Ki+LqzgyKTKx
        qGRjg11w8bPcmdU/npxuP63FaFGRyZlg2STInKDEUpyRaKjFXFScCABSQgYYZgIAAA==
X-CMS-MailID: 20180328232214epcas1p3f97990bec28ef0e83a66972c7115694d
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180328181304epcas4p2593efec8fcccbf6bf30ed30d9b5f0093
X-RootMTR: 20180328181304epcas4p2593efec8fcccbf6bf30ed30d9b5f0093
References: <CGME20180328181304epcas4p2593efec8fcccbf6bf30ed30d9b5f0093@epcas4p2.samsung.com>
        <cover.1522260310.git.mchehab@s-opensource.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Mauro,

2018년 03월 29일 03:12에 Mauro Carvalho Chehab 이(가) 쓴 글:
> Hi Greg,
> 
> Those are the backports meant to solve CVE-2017-13166 on Kernel 3.18.
> 
> It contains two v4l2-ctrls fixes that are required to avoid crashes
> at the test application.
> 
> I wrote two patches myself for Kernel 3.18 in order to solve some
> issues specific for Kernel 3.18 with aren't needed upstream.
> one is actually a one-line change backport. The other one makes
> sure that both 32-bits and 64-bits version of some ioctl calls
> will return the same value for a reserved field.
> 
> I noticed an extra bug while testing it, but the bug also hits upstream,
> and should be backported all the way down all stable/LTS versions.
> So, I'll send it the usual way, after merging upsream.

Really thanks for doing this. :) There would be many users who use Linux-3.18 for their products yet.

Thanks,
Inki Dae

> 
> Regards,
> Mauro
> 
> 
> Daniel Mentz (2):
>   media: v4l2-compat-ioctl32: Copy v4l2_window->global_alpha
>   media: v4l2-compat-ioctl32.c: refactor compat ioctl32 logic
> 
> Hans Verkuil (12):
>   media: v4l2-ioctl.c: don't copy back the result for -ENOTTY
>   media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF
>   media: v4l2-compat-ioctl32.c: fix the indentation
>   media: v4l2-compat-ioctl32.c: move 'helper' functions to
>     __get/put_v4l2_format32
>   media: v4l2-compat-ioctl32.c: avoid sizeof(type)
>   media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32
>   media: v4l2-compat-ioctl32.c: fix ctrl_is_pointer
>   media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs
>   media: v4l2-compat-ioctl32.c: copy clip list in put_v4l2_window32
>   media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type
>   media: v4l2-compat-ioctl32.c: don't copy back the result for certain
>     errors
>   media: v4l2-ctrls: fix sparse warning
> 
> Mauro Carvalho Chehab (2):
>   media: v4l2-compat-ioctl32: use compat_u64 for video standard
>   media: v4l2-compat-ioctl32: initialize a reserved field
> 
> Ricardo Ribalda (2):
>   vb2: V4L2_BUF_FLAG_DONE is set after DQBUF
>   media: media/v4l2-ctrls: volatiles should not generate CH_VALUE
> 
>  drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 1020 +++++++++++++++----------
>  drivers/media/v4l2-core/v4l2-ctrls.c          |   96 ++-
>  drivers/media/v4l2-core/v4l2-ioctl.c          |    5 +-
>  drivers/media/v4l2-core/videobuf2-core.c      |    5 +
>  4 files changed, 691 insertions(+), 435 deletions(-)
> 
