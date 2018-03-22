Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754128AbeCVL6n (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 07:58:43 -0400
Received: from mail9.hitachi.co.jp ([133.145.228.44]:35033 "EHLO
        mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbeCVL6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 07:58:42 -0400
From: =?utf-8?B?5LqA5LqV5LuB5b+XIC8gS0FNRUnvvIxISVRPU0hJ?=
        <hitoshi.kamei.xm@hitachi.com>
To: Ilya Dryomov <idryomov@gmail.com>
CC: Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>,
        "Ceph Development" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH 0/2] rbd: thick-provision image support
Thread-Topic: [!!]Re: [PATCH 0/2] rbd: thick-provision image support
Thread-Index: AQHTwFSynP1gq9EPU0Sh+WFpsmRACqPcJhZQ
Date: Thu, 22 Mar 2018 11:58:38 +0000
Deferred-Delivery: Thu, 22 Mar 2018 11:57:57 +0000
Message-ID: <C8603108370B1949BF3CC7742DDE5D35B8B39FF8@GSjpTKYDCembx31.service.hitachi.net>
References: <5AAFA661.60103@hitachi.com>
 <CAOi1vP8qz9GeP0Beypq1N8XFwzkPieEE1Qf6gJafPnngjNG86g@mail.gmail.com>
In-Reply-To: <CAOi1vP8qz9GeP0Beypq1N8XFwzkPieEE1Qf6gJafPnngjNG86g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.29.202]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2MBwoBf019349

Hi Ilya, 

> I think it should be a map time option -- e.g. rbd map -o thick.
> I don't see any reason for allowing tweaking this setting on a mapped image.

I will add such option to rbd map command. The modified rbd command
with the option writes "1" to sysfs file to disable discard operation at
run-time. And, when user programs issue discard request to an image
with the option, the patched kernel rbd driver ignores the discard
request.

Current kernel rbd driver always discards allocated blocks on an image
when user programs issue discard operation. For example, when an rbd image
is formatted by mkfs.xfs, the mkfs.xfs issues discard request and the 
kernel rbd driver discards allocated blocks. However, the kernel rbd driver
should keep all blocks of thick/fully provisioned image. This patch allows
the kernel rbd driver to ignore discard request for thick/fully provisioned
image.

> I looked through https://github.com/ceph/ceph/pull/18317 and I don't
> see an equivalent functionality there.  rbd_discard_on_zeroed_write_same
> set to false makes the actual zeroes go on the wire, but I don't see
> anything for ignoring discard requests.  Can you point me at that?

As Jason said, there is not currently an option in librbd. And the rbd
command also does not have any options for this patch. I will add the option
to rbd map command in the next step.

And, the reason why the previous email refers to the URL is that this patch
series is related to the thick/fully provisioned image described above.

Regards,

-- 
Hitoshi Kamei
