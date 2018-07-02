Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390E6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3FF25C79
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="AqkynUMb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ncH8TPjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3FF25C79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030202AbeGBK0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:26:19 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:45307 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965239AbeGBK0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:26:12 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Jul 2018 06:26:12 EDT
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 01283194;
        Mon,  2 Jul 2018 06:20:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 02 Jul 2018 06:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=8FUfl8hjvL1b474kMa0XmRPm7xL3/
        zxaAeN/blF/Ffo=; b=AqkynUMbc8LspsZW0OxdKNMJyOAAf2xTcl0iqGANvbdKM
        hxLbNpT0SAwJrBRk7d/F/xfsVjH5J7Bvp2QqmF4D7R/LJEvMCIvEvryFxxxoeR01
        yIw1Vb8dsIcqzVpgWsqgSqjU1YkfImqmLrhh67ds8We4zdpxEwb80wejRmK744kj
        jhl9MrQxxOHxdLFohca7O1GPVzjGb6pApGQHq0MlzxkZzENddxcvz2Wi5PKDamfr
        QIvSCeqVxFJem8TNloIvYm6/vL4SAiy3QgxwWD9FS8etMmcbnOQu1enzAfc0NVOE
        l2ByItNZ2IUwVlnusL9Ja0tcoZGQ+5NViLzQk+8WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8FUfl8
        hjvL1b474kMa0XmRPm7xL3/zxaAeN/blF/Ffo=; b=ncH8TPjB/Izwv7yrR90HE0
        zhiIZc6reGnjMtORxFvtol4IyHN5dZvzk0o9Zu60iyuVxWQT2WJO2v83WD2DmWoj
        hZRbuyiWvvp8tluAOv1F/dkVbtA+5+AnBjl/n1T9QLxWwj5f4rC7nQLgwqnlDkG9
        dKVoRAes8RyPRYYHYCP6cxxg2tZwut0eF5qqB1QRU5D8yyR7DfqieSFhjQED1WeE
        YYAobYARiBymfkAT78YvlYpTxq77kp6OQqJHBo24D+Z/GaV3QECNrvJLt58q4VNk
        wnbptJzXNdC5wPl7ZGYxRMkc0pJZnnlEcS3TRsNKfy7WDXmpy5XG/AOKLsYde63A
        ==
X-ME-Proxy: <xmx:afw5W3EWOswJaEtXDkGL5MX4Sa4ciggnJZKFSgTV5tyMX7RDwJaxng>
    <xmx:afw5Wx0Mg59e4CslnuImTApgLAbFL2ALFmKn_8JwaXrbmi6kDgaRKw>
    <xmx:afw5W_f2VkZuxLkCsf8WXvyansyncYPkOknOudoxdmajzth-f-ACXQ>
    <xmx:afw5W8M4jRkDfmWAz8Sc4mfhsXkXEw62azHgDpb7ixVxWq-CHIPyVA>
    <xmx:afw5W02aUE3fOJU1vGzxf5hXQXDxXz_31ruNfbRo1IlbQjaHqgXjog>
    <xmx:afw5W0pMVJpy2-KQO5k2kZLIqPyw1FNWpKn9LHwqfGb0ky0I5aNYLQ>
X-ME-Sender: <xms:afw5Wy1xlUBYnpRcMBLk2bNqjnWQvoo4zPxbOwGTVJNDoVD1cek2tQ>
Received: from localhost (unknown [121.44.171.84])
        by mail.messagingengine.com (Postfix) with ESMTPA id 716C1102CA;
        Mon,  2 Jul 2018 06:20:23 -0400 (EDT)
Message-ID: <1530526820.9527.4.camel@themaw.net>
Subject: Re: [PATCH upstream] KASAN: slab-out-of-bounds Read in
 getname_kernel
From:   Ian Kent <raven@themaw.net>
To:     tomas <tomasbortoli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        autofs@vger.kernel.org
Date:   Mon, 02 Jul 2018 18:20:20 +0800
In-Reply-To: <1bbf3634-6c2a-f40e-a9d3-9d6ffc9a0562@gmail.com>
References: <38c5a8ad-c192-74b9-b2ff-9eb2a3386930@gmail.com>
         <1530493827.2749.8.camel@themaw.net> <1530495726.2749.13.camel@themaw.net>
         <1bbf3634-6c2a-f40e-a9d3-9d6ffc9a0562@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 10:31 +0200, tomas wrote:
> Hi Ian,
> 
> you are welcome!
> 
> yes your patch is much better. You should just put the "_IOC_NR" macro
> around "cmd" in the lines added to "validate_dev_ioctl" to make it work.

LOL, yes, that was a dumb mistake.

I'll send it to Andrew Morton, after some fairly simple sanity testing,
with both our Signed-off-by added.

> 
> Tomas
> 
> 
> On 07/02/2018 03:42 AM, Ian Kent wrote:
> > On Mon, 2018-07-02 at 09:10 +0800, Ian Kent wrote:
> > > On Mon, 2018-07-02 at 00:04 +0200, tomas wrote:
> > > > Hi,
> > > > 
> > > > I've looked into this issue found by Syzbot and I made a patch:
> > > > 
> > > > https://syzkaller.appspot.com/bug?id=d03abd8b42847f7f69b1d1d7f97208ae425
> > > > b116
> > > > 3
> > > 
> > > Umm ... oops!
> > > 
> > > Thanks for looking into this Tomas.
> > > 
> > > > 
> > > > The autofs subsystem does not check that the "path" parameter is present
> > > > within the "param" struct passed by the userspace in case the
> > > > AUTOFS_DEV_IOCTL_OPENMOUNT_CMD command is passed. Indeed, it assumes a
> > > > path is always provided (though a path is not always present, as per how
> > > > the struct is defined:
> > > > https://github.com/torvalds/linux/blob/master/include/uapi/linux/auto_de
> > > > v-io
> > > > ct
> > > > l.h#L89).
> > > > Skipping the check provokes an oob read in "strlen", called by
> > > > "getname_kernel", in turn called by the autofs to assess the length of
> > > > the non-existing path.
> > > > 
> > > > To solve it, modify the "validate_dev_ioctl" function to check also that
> > > > a path has been provided if the command is
> > > > AUTOFS_DEV_IOCTL_OPENMOUNT_CMD.
> > > > 
> > > > 
> > > > --- b/fs/autofs/dev-ioctl.c    2018-07-01 23:10:16.059728621 +0200around
> > > > +++ a/fs/autofs/dev-ioctl.c    2018-07-01 23:10:24.311792133 +0200
> > > > @@ -136,6 +136,9 @@ static int validate_dev_ioctl(int cmd, s
> > > >              goto out;
> > > >          }
> > > >      }
> > > > +    /* AUTOFS_DEV_IOCTL_OPENMOUNT_CMD without path */
> > > > +    else if(_IOC_NR(cmd) == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD)
> > > > +        return -EINVAL;
> > > 
> > > My preference is to put the comment inside the else but ...
> > > 
> > > There's another question, should the check be done in
> > > autofs_dev_ioctl_openmount() in the same way it's checked in other
> > > ioctls that need a path, such as in autofs_dev_ioctl_requester()
> > > and autofs_dev_ioctl_ismountpoint()?
> > > 
> > > For consistency I'd say it should.
> > > 
> > > >  
> > > >      err = 0;You should just put the "_IOC_NR" directive around "cmd" in
> > > > the lines added to "validate_dev_ioctl" to make it work.
> > > >  out:
> > > > 
> > > > 
> > > > Tested and solves the issue on Linus' main git tree.
> > > > 
> > > > 
> > 
> > Or perhaps this (not even compile tested) patch would be better?
> > 
> > autofs - fix slab out of bounds read in getname_kernel()
> > 
> > From: Ian Kent <raven@themaw.net>
> > 
> > The autofs subsystem does not check that the "path" parameter is
> > present for all cases where it is required when it is passed in
> > via the "param" struct.
> > 
> > In particular it isn't checked for the AUTOFS_DEV_IOCTL_OPENMOUNT_CMD
> > ioctl command.
> > 
> > To solve it, modify validate_dev_ioctl() function to check that a
> > path has been provided for ioctl commands that require it.
> > ---
> >  fs/autofs/dev-ioctl.c |   15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
> > index ea4ca1445ab7..61c63715c3fb 100644
> > --- a/fs/autofs/dev-ioctl.c
> > +++ b/fs/autofs/dev-ioctl.c
> > @@ -135,6 +135,11 @@ static int validate_dev_ioctl(int cmd, struct
> > autofs_dev_ioctl *param)
> >  				cmd);
> >  			goto out;
> >  		}
> > +	} else if (cmd == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD ||
> > +		   cmd == AUTOFS_DEV_IOCTL_REQUESTER_CMD ||
> > +		   cmd == AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD) {
> > +		err = -EINVAL;
> > +		goto out;
> >  	}
> >  
> >  	err = 0;
> > @@ -433,10 +438,7 @@ static int autofs_dev_ioctl_requester(struct file *fp,
> >  	dev_t devid;
> >  	int err = -ENOENT;
> >  
> > -	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
> > -		err = -EINVAL;
> > -		goto out;
> > -	}
> > +	/* param->path has already been checked */
> >  
> >  	devid = sbi->sb->s_dev;
> >  
> > @@ -521,10 +523,7 @@ static int autofs_dev_ioctl_ismountpoint(struct file
> > *fp,
> >  	unsigned int devid, magic;
> >  	int err = -ENOENT;
> >  
> > -	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
> > -		err = -EINVAL;
> > -		goto out;
> > -	}
> > +	/* param->path has already been checked */
> >  
> >  	name = param->path;
> >  	type = param->ismountpoint.in.type;
> 
> 
