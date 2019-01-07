Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AADC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2662070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="IYal9B5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfAGWog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:44:36 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38033 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfAGWog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:44:36 -0500
Received: by mail-oi1-f194.google.com with SMTP id a77so1754242oii.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 14:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7CQRLIQGEpjDzMUFSzqVulh3CykIf2DTWFklK1nIEEk=;
        b=IYal9B5vax53SfmdiMtjuRd6in9mBvTBzBG6xZoEfpdgsejf3c8ho6bkZzLQ0Vx2s6
         Pre6TRcOVD6WDEgeFupUjdOLoBjgdZfw03NnH1jVDCIkXxhneNSawvMT9pMZd1oSQhja
         79qwlk6qaHihn5moLtxQ0LLxKvIAqBpyHl2Y0d7WqiYGKNIti6K+din84vaFZC8olO+z
         oe8RphFleQwn0RUYd6CDgj7ikPq2YWPCiEvNKz/i3ojcm9dr0c9tUh7eljTh8D2IFIWr
         8k9934W1pJdJDDso4DL8XVtkUKvFQo96+IOt5XJYhPwtmAWALHIIEo597+dy5oDwK9vI
         zuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7CQRLIQGEpjDzMUFSzqVulh3CykIf2DTWFklK1nIEEk=;
        b=k8+muzL3+3UMdBmIyl0mo9omSDGrUKtsuOBy+bjTEk7rGrV/skKWmowOMwhumKK2U6
         BD690RPEyCed/TsgXSoydicXZiVw3v98KXISE3EkMVzdIOoQq+GlNNkD26Aa3TjiStn/
         5AVJbgS0OEMPe/sf3IF50PHYO94Y8mIv6tJSEJ8bMykYLK75RwywSgJoqx6wpcWn6tKh
         /txhA3zL2y3yJ0u1ZOIGMJ8dsGjjq+vX2eVGrXQk1sFCjD++wQsD8vlq2EYxDlS1UAbf
         Nj344gse5h5NDObXrZ2ywbH+Jc939gPV20oUPqp9DC8HLD1196sh3QDw4GbgcviDruGm
         QlKw==
X-Gm-Message-State: AJcUukdo9lkk/GmWob4TkxgJ2B96K+f6jB/ANsKQdblLgEdNpQyIFei/
        BrP1Y9C+XZNQdc9CNdekvtBzBJ5VcFRQfLdJPkrPXQ==
X-Google-Smtp-Source: ALg8bN4J/zPHxuSBh4g2tZGeZGIVL2Q0MbE1yoTBrFhUxs8BQPecKRJ9XlR8Extir/vxjRor5WsjXxnQ2ZdtrMesIRg=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr8770801oig.232.1546901075209;
 Mon, 07 Jan 2019 14:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20181229124656.3900-1-jasowang@redhat.com> <20190102154038-mutt-send-email-mst@kernel.org>
 <0efd115a-a7fb-54bf-5376-59d047a15fd3@redhat.com> <20190106221832-mutt-send-email-mst@kernel.org>
 <c15a17b3-b604-a105-af44-a7e6dfd79801@redhat.com> <20190106230224-mutt-send-email-mst@kernel.org>
 <CAPcyv4iXFy0jfoQ_jQYq2yA7cqu4_Jcap4mvQesRRrV-hahGvQ@mail.gmail.com>
 <20190107084853-mutt-send-email-mst@kernel.org> <CAPcyv4jf-4=2oGJrdvMBeRiAJnQoKbYhwZDD+5ZEH+xgDaOzRQ@mail.gmail.com>
 <20190107172517-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190107172517-mutt-send-email-mst@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 7 Jan 2019 14:44:24 -0800
Message-ID: <CAPcyv4iQMQxZC8ehr2OP8_rqpuCeSWn5xyKN64JSyfR8_r7eOg@mail.gmail.com>
Subject: Re: [RFC PATCH V3 0/5] Hi:
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 2:25 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jan 07, 2019 at 01:39:15PM -0800, Dan Williams wrote:
> > On Mon, Jan 7, 2019 at 6:11 AM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> > >
> > > On Sun, Jan 06, 2019 at 11:15:20PM -0800, Dan Williams wrote:
> > > > On Sun, Jan 6, 2019 at 8:17 PM Michael S. Tsirkin <mst@redhat.com> =
wrote:
> > > > >
> > > > > On Mon, Jan 07, 2019 at 11:53:41AM +0800, Jason Wang wrote:
> > > > > >
> > > > > > On 2019/1/7 =E4=B8=8A=E5=8D=8811:28, Michael S. Tsirkin wrote:
> > > > > > > On Mon, Jan 07, 2019 at 10:19:03AM +0800, Jason Wang wrote:
> > > > > > > > On 2019/1/3 =E4=B8=8A=E5=8D=884:47, Michael S. Tsirkin wrot=
e:
> > > > > > > > > On Sat, Dec 29, 2018 at 08:46:51PM +0800, Jason Wang wrot=
e:
> > > > > > > > > > This series tries to access virtqueue metadata through =
kernel virtual
> > > > > > > > > > address instead of copy_user() friends since they had t=
oo much
> > > > > > > > > > overheads like checks, spec barriers or even hardware f=
eature
> > > > > > > > > > toggling.
> > > > > > > > > Will review, thanks!
> > > > > > > > > One questions that comes to mind is whether it's all abou=
t bypassing
> > > > > > > > > stac/clac.  Could you please include a performance compar=
ison with
> > > > > > > > > nosmap?
> > > > > > > > >
> > > > > > > > On machine without SMAP (Sandy Bridge):
> > > > > > > >
> > > > > > > > Before: 4.8Mpps
> > > > > > > >
> > > > > > > > After: 5.2Mpps
> > > > > > > OK so would you say it's really unsafe versus safe accesses?
> > > > > > > Or would you say it's just a better written code?
> > > > > >
> > > > > >
> > > > > > It's the effect of removing speculation barrier.
> > > > >
> > > > >
> > > > > You mean __uaccess_begin_nospec introduced by
> > > > > commit 304ec1b050310548db33063e567123fae8fd0301
> > > > > ?
> > > > >
> > > > > So fundamentally we do access_ok checks when supplying
> > > > > the memory table to the kernel thread, and we should
> > > > > do the spec barrier there.
> > > > >
> > > > > Then we can just create and use a variant of uaccess macros that =
does
> > > > > not include the barrier?
> > > > >
> > > > > Or, how about moving the barrier into access_ok?
> > > > > This way repeated accesses with a single access_ok get a bit fast=
er.
> > > > > CC Dan Williams on this idea.
> > > >
> > > > It would be interesting to see how expensive re-doing the address
> > > > limit check is compared to the speculation barrier. I.e. just switc=
h
> > > > vhost_get_user() to use get_user() rather than __get_user(). That w=
ill
> > > > sanitize the pointer in the speculative path without a barrier.
> > >
> > > Hmm it's way cheaper even though IIRC it's measureable.
> > > Jason, would you like to try?
> > > Although frankly __get_user being slower than get_user feels very wro=
ng.
> > > Not yet sure what to do exactly but would you agree?
> >
> > Agree. __get_user() being faster than get_user() defeats the whole
> > point of converting code paths to the access_ok() + __get_user()
> > pattern.
>
> Did you mean the reverse?

Hmm, no... I'll rephrase: __get_user() should have lower overhead than
get_user().
