Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1B8C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A02A223C9
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="qdI+VOkX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v/ax12S0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A02A223C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932309AbeGCBeO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:34:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38615 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932169AbeGCBeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:34:11 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 76506212A0;
        Mon,  2 Jul 2018 21:34:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 02 Jul 2018 21:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=gZUPtvdle2jvaRIMsMSnsse5Jc0PW
        YlfUqjtvlovVS0=; b=qdI+VOkXotQcnpi0WIr9oWiGjJJ1vguPsKZKw+Fef6Ypu
        D59DKLFaCXsinmosQGbcFpL4OzNGoeU/K0U9sweL7GlvecODlVARRFlkLbpXYUA9
        FDWsC7Gzne10y76CwgDX6UF2DnF7bbcYlICiSQh2ufCfWSJqYR855+WU37vV+JMx
        vC4ZVh0skCChrJO0Zap/ffXbINw+TUfOCjFiZU7HcfmCzUCLl/rBD31NR2TOgupb
        etj/8+/r7S4SOD+3Vh4vcwN4Vv/PKuuY9wzu0Kf7w04BJeutHeOKw0RRT45EvsME
        S4XmVmsKxIL/c2FMDyy2u5CGJWpV1guGToFzg1dwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=gZUPtv
        dle2jvaRIMsMSnsse5Jc0PWYlfUqjtvlovVS0=; b=v/ax12S0wNVYvagtNIFe7M
        Sdy/j8ca0aAjT1xzEGySfS2XlXQ8oN8Imgu50HYm19qvAXlwL4bMsTLP3JqHuR76
        m4q4Y3jCX3TTz88jtqeohSE+b17VlShNGuOgtY5jjwnloLLipJ//i0SDU3UoCuOU
        7u7g5588UZGr0fPerWFTbEoESWNKWAbt9SwGmyrKo+4LrhuAYIP6HqaCLv+Tm2Xb
        YBD4mA81qlgNFdOyCyEFAqYHHv6a3D9A1owxWDCEp0toTKf+8+/vBvZrqu/9QH7O
        X/bMkaRL0CR2Yqt/A2sWvG6PC6kq/Vio3FZDRCDHS9dzmL4MsEWmEUVlpKZ4vNMg
        ==
X-ME-Proxy: <xmx:kNI6W_5tNoH42TToUUwB_zH_bktb4cj4MnooR1f3A2HB06C9IX1juw>
    <xmx:kNI6WwSgr62Nw90zXQBdaesH6NuTRB4y0YG3d33ck2f0yEGh3jU28w>
    <xmx:kNI6W0U-UBFrlXbpF9fOq7HU-XRmo4z0rEUKpIQ0LgAO1aS4CbZB4g>
    <xmx:kNI6W7QK1Vt2o90BKdFiBFO4dz3Dv6ccKpHUrLrm1Cti6hICJx_nhA>
    <xmx:kNI6W0MqZ6rZ0MQ3-YSYpl4UdOkHzoqdo4itDfPoy2jNKngYxoumhQ>
    <xmx:kNI6W87fQS_DSrJVtRwFkt-RI6xA3b8GttcrzOjwRJIbAlRVsGPsZA>
X-ME-Sender: <xms:kNI6WwTUJOk9WZaZ-MjsY9fei8Dn9SwAp-RSod1i2kakX3WZ8nSAeQ>
Received: from localhost (unknown [121.44.171.84])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0ABA61026E;
        Mon,  2 Jul 2018 21:34:05 -0400 (EDT)
Message-ID: <1530581643.7847.2.camel@themaw.net>
Subject: Re: [PATCH upstream] KASAN: slab-out-of-bounds Read in
 getname_kernel
From:   Ian Kent <raven@themaw.net>
To:     Dmitry Vyukov <dvyukov@google.com>, tomas <tomasbortoli@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>, autofs@vger.kernel.org
Date:   Tue, 03 Jul 2018 09:34:03 +0800
In-Reply-To: <CACT4Y+YanGz1DNav=cxDj1ianjmAKnA4s7wuhhop2RzrOsKAUQ@mail.gmail.com>
References: <38c5a8ad-c192-74b9-b2ff-9eb2a3386930@gmail.com>
         <1530493827.2749.8.camel@themaw.net> <1530495726.2749.13.camel@themaw.net>
         <1bbf3634-6c2a-f40e-a9d3-9d6ffc9a0562@gmail.com>
         <1530526820.9527.4.camel@themaw.net>
         <b9188b32-d50a-4498-a05b-5f0e589bf985@gmail.com>
         <CACT4Y+YanGz1DNav=cxDj1ianjmAKnA4s7wuhhop2RzrOsKAUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 14:15 +0200, Dmitry Vyukov wrote:
> On Mon, Jul 2, 2018 at 1:55 PM, tomas <tomasbortoli@gmail.com> wrote:
> > Yes, thanks. Please use my full name, Tomas Bortoli.
> 
> 
> Please also include:
> 
> Reported-by: syzbot+60c837b428dc84e83a93@syzkaller.appspotmail.com

Done.

> 
> from the original bug report. This this help to keep automatic testing
> process running.

Umm ... should I include this email address on the actual cc when
submitting the patch?

> 
> Thanks
> 
> 
> > 
> > On 07/02/2018 12:20 PM, Ian Kent wrote:
> > > On Mon, 2018-07-02 at 10:31 +0200, tomas wrote:
> > > > Hi Ian,
> > > > 
> > > > you are welcome!
> > > > 
> > > > yes your patch is much better. You should just put the "_IOC_NR" macro
> > > > around "cmd" in the lines added to "validate_dev_ioctl" to make it work.
> > > 
> > > LOL, yes, that was a dumb mistake.
> > > 
> > > I'll send it to Andrew Morton, after some fairly simple sanity testing,
> > > with both our Signed-off-by added.
> > > 
> > > > Tomas
> > > > 
> > > > 
> > > > On 07/02/2018 03:42 AM, Ian Kent wrote:
> > > > > On Mon, 2018-07-02 at 09:10 +0800, Ian Kent wrote:
> > > > > > On Mon, 2018-07-02 at 00:04 +0200, tomas wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > I've looked into this issue found by Syzbot and I made a patch:
> > > > > > > 
> > > > > > > https://syzkaller.appspot.com/bug?id=d03abd8b42847f7f69b1d1d7f9720
> > > > > > > 8ae425
> > > > > > > b116
> > > > > > > 3
> > > > > > 
> > > > > > Umm ... oops!
> > > > > > 
> > > > > > Thanks for looking into this Tomas.
> > > > > > 
> > > > > > > The autofs subsystem does not check that the "path" parameter is
> > > > > > > present
> > > > > > > within the "param" struct passed by the userspace in case the
> > > > > > > AUTOFS_DEV_IOCTL_OPENMOUNT_CMD command is passed. Indeed, it
> > > > > > > assumes a
> > > > > > > path is always provided (though a path is not always present, as
> > > > > > > per how
> > > > > > > the struct is defined:
> > > > > > > https://github.com/torvalds/linux/blob/master/include/uapi/linux/a
> > > > > > > uto_de
> > > > > > > v-io
> > > > > > > ct
> > > > > > > l.h#L89).
> > > > > > > Skipping the check provokes an oob read in "strlen", called by
> > > > > > > "getname_kernel", in turn called by the autofs to assess the
> > > > > > > length of
> > > > > > > the non-existing path.
> > > > > > > 
> > > > > > > To solve it, modify the "validate_dev_ioctl" function to check
> > > > > > > also that
> > > > > > > a path has been provided if the command is
> > > > > > > AUTOFS_DEV_IOCTL_OPENMOUNT_CMD.
> > > > > > > 
> > > > > > > 
> > > > > > > --- b/fs/autofs/dev-ioctl.c    2018-07-01 23:10:16.059728621
> > > > > > > +0200around
> > > > > > > +++ a/fs/autofs/dev-ioctl.c    2018-07-01 23:10:24.311792133 +0200
> > > > > > > @@ -136,6 +136,9 @@ static int validate_dev_ioctl(int cmd, s
> > > > > > >              goto out;
> > > > > > >          }
> > > > > > >      }
> > > > > > > +    /* AUTOFS_DEV_IOCTL_OPENMOUNT_CMD without path */
> > > > > > > +    else if(_IOC_NR(cmd) == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD)
> > > > > > > +        return -EINVAL;
> > > > > > 
> > > > > > My preference is to put the comment inside the else but ...
> > > > > > 
> > > > > > There's another question, should the check be done in
> > > > > > autofs_dev_ioctl_openmount() in the same way it's checked in other
> > > > > > ioctls that need a path, such as in autofs_dev_ioctl_requester()
> > > > > > and autofs_dev_ioctl_ismountpoint()?
> > > > > > 
> > > > > > For consistency I'd say it should.
> > > > > > 
> > > > > > > 
> > > > > > >      err = 0;You should just put the "_IOC_NR" directive around
> > > > > > > "cmd" in
> > > > > > > the lines added to "validate_dev_ioctl" to make it work.
> > > > > > >  out:
> > > > > > > 
> > > > > > > 
> > > > > > > Tested and solves the issue on Linus' main git tree.
> > > > > > > 
> > > > > > > 
> > > > > 
> > > > > Or perhaps this (not even compile tested) patch would be better?
> > > > > 
> > > > > autofs - fix slab out of bounds read in getname_kernel()
> > > > > 
> > > > > From: Ian Kent <raven@themaw.net>
> > > > > 
> > > > > The autofs subsystem does not check that the "path" parameter is
> > > > > present for all cases where it is required when it is passed in
> > > > > via the "param" struct.
> > > > > 
> > > > > In particular it isn't checked for the AUTOFS_DEV_IOCTL_OPENMOUNT_CMD
> > > > > ioctl command.
> > > > > 
> > > > > To solve it, modify validate_dev_ioctl() function to check that a
> > > > > path has been provided for ioctl commands that require it.
> > > > > ---
> > > > >  fs/autofs/dev-ioctl.c |   15 +++++++--------
> > > > >  1 file changed, 7 insertions(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
> > > > > index ea4ca1445ab7..61c63715c3fb 100644
> > > > > --- a/fs/autofs/dev-ioctl.c
> > > > > +++ b/fs/autofs/dev-ioctl.c
> > > > > @@ -135,6 +135,11 @@ static int validate_dev_ioctl(int cmd, struct
> > > > > autofs_dev_ioctl *param)
> > > > >                             cmd);
> > > > >                     goto out;
> > > > >             }
> > > > > +   } else if (cmd == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD ||
> > > > > +              cmd == AUTOFS_DEV_IOCTL_REQUESTER_CMD ||
> > > > > +              cmd == AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD) {
> > > > > +           err = -EINVAL;
> > > > > +           goto out;
> > > > >     }
> > > > > 
> > > > >     err = 0;
> > > > > @@ -433,10 +438,7 @@ static int autofs_dev_ioctl_requester(struct file
> > > > > *fp,
> > > > >     dev_t devid;
> > > > >     int err = -ENOENT;
> > > > > 
> > > > > -   if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
> > > > > -           err = -EINVAL;
> > > > > -           goto out;
> > > > > -   }
> > > > > +   /* param->path has already been checked */
> > > > > 
> > > > >     devid = sbi->sb->s_dev;
> > > > > 
> > > > > @@ -521,10 +523,7 @@ static int autofs_dev_ioctl_ismountpoint(struct
> > > > > file
> > > > > *fp,
> > > > >     unsigned int devid, magic;
> > > > >     int err = -ENOENT;
> > > > > 
> > > > > -   if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
> > > > > -           err = -EINVAL;
> > > > > -           goto out;
> > > > > -   }
> > > > > +   /* param->path has already been checked */
> > > > > 
> > > > >     name = param->path;
> > > > >     type = param->ismountpoint.in.type;
> > 
> > --
> > You received this message because you are subscribed to the Google Groups
> > "syzkaller" group.
> > To unsubscribe from this group and stop receiving emails from it, send an
> > email to syzkaller+unsubscribe@googlegroups.com.
> > For more options, visit https://groups.google.com/d/optout.
