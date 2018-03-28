Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753396AbeC1NtE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:49:04 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:57763 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbeC1NtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:49:01 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180328134859epoutp03be8b564568c95d9fb47f8a0be24c059b~gGbUnzZ5G1245912459epoutp03z
X-AuditID: b6c32a39-579ff70000000ff4-92-5abb9d4a4ec1
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Steve Glendinning <steve.glendinning@shawell.net>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3 2/3] video: smscufx: Return an error code only as a
 constant in ufx_realloc_framebuffer()
Date: Wed, 28 Mar 2018 15:48:55 +0200
Message-id: <8231980.bzy6TRmRmS@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <31ecfef4-a193-dea0-0ff3-0d5a108a14f3@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsWy7bCmnq7X3N1RBjdvGVtc+fqezeJ853Jm
        i623pC1O9H1gtbi8aw6bRfOnV0wObB73u48zefxvvszi0XSqndXj8ya5AJYoLpuU1JzMstQi
        fbsErozmuxtYC9azVHzc0s/awHiMuYuRk0NCwESi+9Iipi5GLg4hgR2MEucW7GKEcL4zSqxf
        MIkNpuroxwXMEIkNjBKTex9DtXxllNj+dToTSBWbgJXExPZVQO0cHCICphJ/ToSAhJkF9jJK
        /LzAAWILCxRJzJjWCTaURUBVYsKRbUwg5bwCmhJ79pSChEUFvCS27GsHm8gp4Cnxb9ZdRhCb
        V0BQ4sfkeywQI+Ul9u2fygph60icPbYO7GgJgS1sEt93H2WCONpF4sDB/YwQtrDEq+Nb2EF2
        SQhIS1w6agtR38wo8W3HHmhQTGCU2LNeCMK2ljh8/CLUAj6Jd197WCF6eSU62qBKPCSmrD3I
        AhF2lHi1IRASIrcZJe5M/88+gVF2FpKzZyE5exaSsxcwMq9iFEstKM5NTy02LDDVK07MLS7N
        S9dLzs/dxAhOBVqWOxiPnfM5xCjAwajEw1sQsytKiDWxrLgy9xCjBAezkgjve43dUUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR5AwJcooQE0hNLUrNTUwtSi2CyTBycUg2MwlNEC8r+sjjapEt1
        mpl/ibXQEU2tvn/z2Zn0v4L+HP6PK7oajnX0VqSkv/ZOzNRI7Paf6CO386VIwOPuKz+b2RsD
        AyLNJ097uyd3jV3ryxSf7zqJwdo8q1znGT2e/NIudWH4M8dlzNMFiuesqY14M620a2WE34L6
        aSvTZbITbdd5SWzax6LEUpyRaKjFXFScCADPLGtwAQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t9jQV3PubujDJ6cN7S48vU9m8X5zuXM
        FltvSVuc6PvAanF51xw2i+ZPr5gc2Dzudx9n8vjffJnFo+lUO6vH501yASxRXDYpqTmZZalF
        +nYJXBnNdzewFqxnqfi4pZ+1gfEYcxcjJ4eEgInE0Y8LgGwuDiGBdYwSm07+ZIVwvjJKPG++
        yAJSxSZgJTGxfRVjFyMHh4iAqcSfEyEgNcwCexklPnVfZQWpERYokpgxrZMNxGYRUJWYcGQb
        E0g9r4CmxJ49pSBhUQEviS372plAbE4BT4l/s+4yQuy6yyhx4sdLsF28AoISPybfA7OZBeQl
        9u2fygpha0ms33mcaQIj/ywkZbOQlM1CUraAkXkVo2RqQXFuem6xUYFhXmq5XnFibnFpXrpe
        cn7uJkZgAG87rNW3g/H+kvhDjAIcjEo8vAUxu6KEWBPLiitzDzFKcDArifC+19gdJcSbklhZ
        lVqUH19UmpNafIhRmoNFSZz3dt6xSCGB9MSS1OzU1ILUIpgsEwenVAPjhMniTGqCB5fN8pGf
        8ot3nXhPX7u21oWEFJ/U/JfibgHfq/lk/6+cJGxrwb7XRrpJNe7qhAd3JS64rVr5z6+O+cKt
        TIH9604edP/rtDFkyffE+bJS7dtMWhbZML5b9keD38ZhU3mY0sJrHy3u81/Un629cLdAWF/H
        9XdGE1mq97nknbvlHPBViaU4I9FQi7moOBEAE10MzVwCAAA=
X-CMS-MailID: 20180328134857epcas1p4de6df48e9c746d750b1bcf434a3effec
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20171125204312epcas2p149d6487ac83e886f95aefe0b35aef1b0
X-RootMTR: 20171125204312epcas2p149d6487ac83e886f95aefe0b35aef1b0
References: <CGME20171125204312epcas2p149d6487ac83e886f95aefe0b35aef1b0@epcas2p1.samsung.com>
        <a36fa112-40a1-703c-c2ac-ce7e88bb8609@users.sourceforge.net>
        <31ecfef4-a193-dea0-0ff3-0d5a108a14f3@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, January 07, 2018 05:04:04 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 7 Jan 2018 16:07:11 +0100
> 
> * Return an error code without storing it in an intermediate variable.
> 
> * Delete the label "error" and local variable "retval"
>   which became unnecessary with this refactoring.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
