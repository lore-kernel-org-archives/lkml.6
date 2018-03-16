Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeCPWGE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 18:06:04 -0400
Received: from anholt.net ([50.246.234.109]:49042 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751245AbeCPWGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 18:06:02 -0400
From: Eric Anholt <eric@anholt.net>
To: Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Stone <daniels@collabora.com>
Subject: Re: [PATCH] drm/vc4: Add support for SAND modifier.
In-Reply-To: <CAPj87rNtcN0PDFViJB_NOVzUeLSWKe9smnQx7RSXwBR1+nm__w@mail.gmail.com>
References: <20180303013431.1088-1-eric@anholt.net> <CAPj87rNtcN0PDFViJB_NOVzUeLSWKe9smnQx7RSXwBR1+nm__w@mail.gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Fri, 16 Mar 2018 15:05:59 -0700
Message-ID: <87a7v7ad6g.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Daniel Stone <daniel@fooishbar.org> writes:

> Hey Eric,
>
> On 3 March 2018 at 01:34, Eric Anholt <eric@anholt.net> wrote:
>> Ccing a couple of folks who are likely to have opinions about
>> drm_fourcc.h additions (Do we have enough docs?  Are the macros OK?),
>> and Bootlin who are likely reviewers.
>>
>> The plan is to use these modifiers in VC4 GL imports as well, and for
>> buffers coming from the v4l2 mmal camera driver.  You can find a demo
>> using this in KMS planes at
>> https://github.com/anholt/drm_mmal/commit/sand for now.
>
> I had a dig through and this seems like the most sensible thing to do
> if you have a reasonable variety of tile heights. If you only see a
> couple of combinations in the wild, then hardcoding them as separate
> modifiers might make things easier than hiving off 24 bits. If you do
> keep the split though, and especially if you're envisioning future
> flexible tile formats, maybe something like an 8 code / 48 params
> split would make more sense.
>
> Either way, those are just my opinions (you did ask), and I don't see
> anything really objectionable, so if you think that's a good split
> then this is:
> Acked-by: Daniel Stone <daniels@collabora.com>

I had been thinking of potentially specifying a meaning for the other 24
bits (separate U/V plane v stride if set, if we ever get a component
that needs to do that), so I went ahead and did this, along with a
couple of fixes due to Ville's patch.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqsP8cACgkQtdYpNtH8
nuiGzBAArhbN3GxY0Q/DJvWJwKYILAlm6+bL8lmiWh98YpZ0tpREIyYggj21cjoN
K8idTlkdtpCPkBQ0hAjA48QlX1bA3rGKRyT8AWRk4sOdqIMjZGuEfq3XENsfDvDk
8q4MObNrdzlYgK2XTj+1I6QG4mpPoZVOCH7KiC+35zVLe0M6OxEX/eL0+nGl1e6i
5o2QMNUvZAKC8Ml8v5vB/lbFBbIrXUm/+c8MpX8DRS8Qe+OqHEjrjx8VONrHY2dL
sZ9X902hEJqlWtdvdteh22THolhu+/0YOJcSkzH/k51yitEDLwlC4xjnkdh/4xcx
7otW5zGUyr2yq5rQiripuYW0aGgiTQSNA+Hh/W8oht5d5ptM7n6usq0ysN2iA+g2
mw6DCTAST4VFN4SFwzHsy6CCNDQgiK/CQ6w+2TPOJFbCIv32gQJayVP47aH/Q3LV
mUGLnP8p7iKvTDknH5BivOw9CljBwgy4ICdKnTfJ+NLxEe+VHNAVSEynftE+LLgO
jU28Hb+COjIZpTCfNNEHEmD5QNzazB1PnYRVo1L0l6hdR4GZC+5sdx00vl/gws5u
Ieg/x/o7IWUs+drnflhwBcitGBbdM4ICp02Uth1rNs6fx9yguwOFzlCX/W1Cu5dL
8ySj949Os5KyA2l1O2v7WMJkDCF0+fSNfbhZuY2bIKDYdL1iR4M=
=edgx
-----END PGP SIGNATURE-----
--=-=-=--
