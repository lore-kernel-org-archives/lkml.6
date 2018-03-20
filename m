Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbeCTWbY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:31:24 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:45087 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbeCTWbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:31:21 -0400
X-Google-Smtp-Source: AG47ELsg3om01ZJJXeynbD1SB3dyVILd5yeDSQzcOkirIYhqgQ/HYMEBlvJa77YTLse1iuK7+SOhNDTtummD0wiV0MM=
MIME-Version: 1.0
Reply-To: dillaman@redhat.com
In-Reply-To: <CAOi1vP8qz9GeP0Beypq1N8XFwzkPieEE1Qf6gJafPnngjNG86g@mail.gmail.com>
References: <5AAFA661.60103@hitachi.com> <CAOi1vP8qz9GeP0Beypq1N8XFwzkPieEE1Qf6gJafPnngjNG86g@mail.gmail.com>
From: Jason Dillaman <jdillama@redhat.com>
Date: Wed, 21 Mar 2018 06:31:20 +0800
Message-ID: <CA+aFP1AunD_KvE5JkFAzzEtu+D5dKS_nhEbyvS9COQM2PXuDCw@mail.gmail.com>
Subject: Re: [PATCH 0/2] rbd: thick-provision image support
To: Ilya Dryomov <idryomov@gmail.com>
Cc: KAMEI Hitoshi <hitoshi.kamei.xm@hitachi.com>,
        Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There isn't currently an option to disable discards in librbd.
However, given that's the intent of this change, why not name the
option along the lines of "discard_disbled"?

On Tue, Mar 20, 2018 at 10:06 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Mon, Mar 19, 2018 at 1:00 PM, KAMEI Hitoshi
> <hitoshi.kamei.xm@hitachi.com> wrote:
>> This patch series adds the thick-provision image support to
>> /drivers/block/rbd.c relating to https://github.com/ceph/ceph/pull/18317.
>> The rbd will not issue the discard operation to thick-provision
>> images, if applied.
>>
>> The rbd should not discard any allocated blocks of thick-provision
>> image to ensure writing data to rbd images. So this patch
>> prevents from discarding allocated blocks on thick-provision
>> image.
>>
>> This patch series creates sysfs file to manipulate thick-provision
>> status. If users write "1" to /sys/bus/rbd/devices/<dev-id>/thick,
>> then the image is changed to thick-provision image. And if users
>> write "0" to it, then the image is changed to thin-provision
>> image. I will add the code changing status for the rbd map command.
>
> Hi Hitoshi,
>
> I think it should be a map time option -- e.g. rbd map -o thick.
> I don't see any reason for allowing tweaking this setting on a mapped
> image.
>
> I looked through https://github.com/ceph/ceph/pull/18317 and I don't
> see an equivalent functionality there.  rbd_discard_on_zeroed_write_same
> set to false makes the actual zeroes go on the wire, but I don't see
> anything for ignoring discard requests.  Can you point me at that?
>
> Thanks,
>
>                 Ilya
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
