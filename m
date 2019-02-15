Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B42C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0506A21A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="db/3hZdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394876AbfBONF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:05:59 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53253 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfBONF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:05:58 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190215130556euoutp02e9a535c1f6845b5f269f39f8ed250dbf~Di2OPGCk71622216222euoutp02T
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:05:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190215130556euoutp02e9a535c1f6845b5f269f39f8ed250dbf~Di2OPGCk71622216222euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550235956;
        bh=dWXawSe0mDSVcpnOL5n7OaCAbCUchhb3f/p0QG3V+fU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=db/3hZdNHaJnm0kDsfqbzi3tjjwXLMRhx+eLGFZtVcGeOhXV/PH5nJJA8NEKtRUBc
         N8CSIx3GWUI7R+wIIgUNvWQRUpPJcpiX3TNDiZYWo+nH/UpmFuk79Qwna2KPAVB1pe
         uiZdg68aFYBqI9WD69GAYB17cXNkRhuuVuKOA/Oc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190215130555eucas1p1c494533a5cd60c512aedef6f6abf1d8b~Di2NUm-cO0875208752eucas1p1R;
        Fri, 15 Feb 2019 13:05:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 56.CD.04294.339B66C5; Fri, 15
        Feb 2019 13:05:55 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190215130554eucas1p25cf99000a8269b845d1056bcc50c9af7~Di2MgfDoI1666816668eucas1p2C;
        Fri, 15 Feb 2019 13:05:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190215130554eusmtrp183b772960535f0526b84ee6ecf6a64f4~Di2MRmPiG2508925089eusmtrp1k;
        Fri, 15 Feb 2019 13:05:54 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-85-5c66b933c84f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 74.22.04284.239B66C5; Fri, 15
        Feb 2019 13:05:54 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190215130553eusmtip27636d867e2df6aaa2507af7d68485e5a~Di2Lt1MKt1450314503eusmtip2p;
        Fri, 15 Feb 2019 13:05:53 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 0/2] tracing: drivers: devfreq: add basic trace mechanism
Date:   Fri, 15 Feb 2019 14:05:11 +0100
Message-Id: <1550235913-5189-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduzneV3jnWkxBhc2cVlsnLGe1eL6l+es
        Fmeb3rBb3GqQsbi8aw6bxefeI4wWa4/cZbe4dGABk8XnDY8ZLW43rmCz2NfxgMni8Jt2Vgce
        j9kNF1k8WvbdYvc4+G4Pk8f7fVfZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvjcFsfU8EU
        /oq9h9ewNDAu5uli5OSQEDCROPnmIXsXIxeHkMAKRom3Wy8wQjhfGCXWdnxkAqkSEvjMKLF7
        vj9Mx5qZP6CKljNKXL71gwmu4/fRKUCzODjYBPQkdqwqBGkQEbCSeNH+CmwFs0Azk8SztoUs
        IAlhAR+J1kfzwWwWAVWJFaeOsIPYvAKeEgt2T2GE2CYncfNcJzOE3cwusWFbHYTtIrGxayUb
        hC0s8er4FnYIW0bi9OQeFgi7WOJsxyqomhqJ9pM7oGqsJQ4fv8gKciezgKbE+l36IKaEgKPE
        2wV8ECafxI23giDFzEDmpG3TmSHCvBIdbUIQMzQktvRcYIKwxSSWr5kGNdtDYvb0RyyQUIuV
        +DDhE9sERrlZCKsWMDKuYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECEwfp/8d/7KDcdef
        pEOMAhyMSjy8KzJSY4RYE8uKK3MPMUpwMCuJ8HKuSYsR4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        zlvN8CBaSCA9sSQ1OzW1ILUIJsvEwSnVwOi6smxrDo/G7Klvnjk871LfHlWzfFpRQ8PrT17u
        wXua6ziqGOuE+Y8Z/pQr5mAoKTyX9oTtgcXsLY3O5dWmt36b6DOsso2obj+uF/5j8XKHoNAz
        HBIt81Y8ZtuxaSpfY9Lh0Hg9C//p8vkvWu5+fvb536uaKVkxuwrvatbkn11YrpgbuPNuqBJL
        cUaioRZzUXEiACrXsrEbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsVy+t/xe7pGO9NiDC5OErLYOGM9q8X1L89Z
        Lc42vWG3uNUgY3F51xw2i8+9Rxgt1h65y25x6cACJovPGx4zWtxuXMFmsa/jAZPF4TftrA48
        HrMbLrJ4tOy7xe5x8N0eJo/3+66yefRtWcXo8XmTXABblJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G4bY+poIp/BV7D69haWBczNPFyMkhIWAi
        sWbmD8YuRi4OIYGljBKH7m1gg0iISUzat50dwhaW+HOtiw2i6BOjxLljn1i6GDk42AT0JHas
        KgSpERGwkXg/9wwLSA2zQD+TRNOSDlaQhLCAj0Tro/ksIDaLgKrEilNHwIbyCnhKLNg9hRFi
        gZzEzXOdzBMYeRYwMqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIDN9tx35u3sF4aWPwIUYB
        DkYlHt4VGakxQqyJZcWVuYcYJTiYlUR4OdekxQjxpiRWVqUW5ccXleakFh9iNAVaPpFZSjQ5
        HxhbeSXxhqaG5haWhubG5sZmFkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGPOq7LgW3zPX
        0VzOZj/PLCh3Ta3LOcYNkcqMj8v+TXwlzrHd9u3dmXWllp4tqekW2vGuRV1Zf1ojty3QzDm1
        ZN4Uudf7CvWZFyiaaf/mCLsiFWImajlx78MA335BJ5eND6PFKqYeuzeF0zpzy/JiXj/tsKkH
        rESNn3rnxj26ZvKJuUecTW+ZEktxRqKhFnNRcSIAB62dsnUCAAA=
X-CMS-MailID: 20190215130554eucas1p25cf99000a8269b845d1056bcc50c9af7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190215130554eucas1p25cf99000a8269b845d1056bcc50c9af7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190215130554eucas1p25cf99000a8269b845d1056bcc50c9af7
References: <CGME20190215130554eucas1p25cf99000a8269b845d1056bcc50c9af7@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v2 which implements Steven's suggestions.

This patch set adds support for tracing in devfreq framework. It is related
to the discussion regarding devfreq workqueue mechanism and wake-ups.
These two tracing patches have been submitted in larger patch set, which
needs more discussion. For the further discussion and development there
is a need of measurements/testing, though. It was agreed that trace events
would help. The whole discussion is here [1].

With these patches it is possible to capture current behaviour for the 
devfreq subsystem and devices such as when and which workqueue is used,
on which CPU, what is the load and frequency of the device.

v2:
- simplified arguments list, according to Steven's comments, with only
  one arg: 'devfreq' and the rest fields taken from there.
v1:
- moved long '/' operation to post-processing phase, according to Seven's
  comments [2] 
- re-ordered fields in the structure to avoid holes, according to Seven's
  comments [3] 
- removed unneeded variable, according to Chanwoo's comment [4]
basic in larget patch set:
- added support for trace events

I did not dare to add 'Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>'
for the 1st patch, which was in [5], since the code slightly changed.
The 2nd patch has it. 

Regards,
Lukasz Luba

[1] https://lkml.org/lkml/2019/2/12/1179
[2] https://lkml.org/lkml/2019/2/12/1201
[3] https://lkml.org/lkml/2019/2/13/532
[4] https://lkml.org/lkml/2019/2/13/1587
[5] https://lkml.org/lkml/2019/2/14/2

Lukasz Luba (2):
  trace: events: add devfreq trace event file
  drivers: devfreq: add tracing for scheduling work

 MAINTAINERS                    |  1 +
 drivers/devfreq/devfreq.c      |  5 +++++
 include/trace/events/devfreq.h | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 include/trace/events/devfreq.h

-- 
2.7.4

