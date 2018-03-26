Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeCZOOj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:14:39 -0400
Received: from mx1.riseup.net ([198.252.153.129]:50776 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbeCZOOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:14:36 -0400
X-Riseup-User-ID: 4F5C9D6C5AA9EF622C4D7DA5A7E4D00235A1C94D48FFE814649E64E10C5F581E
To: dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>, airlied@linux.ie,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>
From: =?UTF-8?Q?Joonas_Kylm=c3=a4l=c3=a4?= <joonas.kylmala@iki.fi>
Subject: Preferring cursor plane over overlay plane
Cc: linux-sunxi <linux-sunxi@googlegroups.com>
Message-ID: <5edad360-d05d-1bb8-c1f2-925138784fef@iki.fi>
Date: Mon, 26 Mar 2018 14:14:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi DRM subsystem developers,

I ran into this patch where overlay plane was switched to cursor plane
because there was no proper cursor plane available on the display
hardware: <https://lkml.org/lkml/2018/3/17/120>. Can we discuss whether
to have a policy of using a normal plane for cursor plane in case a
dedicated HW cursor plane is missing?

Daniel Vetter suggests that it might be fine to use normal plane for
cursor plane because how to use the plane would be only "a hint to
userspace" (see the email linked).

My motivation for having this discussion is that the newer Allwinner
SoCs don't have dedicated HW cursor plane and the sun4i DRM driver
currently uses the extra planes as overlay planes which makes moving the
cursor on Xfce4 DE a terrible experience. To have better cursor moving
experience one overlay plane would need to be sacrificed.

Also, I probably missed some recipients for this email so please forward
it to the recipients you think might be interested about this.

Best regards,
Joonas
