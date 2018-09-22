Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FC1ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFFA21532
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEeNvgkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFFA21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeIVQLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 12:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbeIVQLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 12:11:08 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1E0821523;
        Sat, 22 Sep 2018 10:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537611485;
        bh=196skmytk4ds3Dl8r1FNBEGvAdmNW93w3sAv7eVOuWs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fEeNvgkPjM2XgvFJEmS8B3EfCuR0eOxSWfLUQ0MocP1xEV85OsWC7QHs/NDlwwq6A
         1/iydNaiUPqKAsowa4010GCfTxh/BVqmJgLycuRiVq7HL8MGoIUIWoSxq15a44k5m8
         9USHVQCVSl7Trwo7CAjbgSSfV6nnbqSs37al2lsI=
Date:   Sat, 22 Sep 2018 11:18:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     Himanshu Jha <himanshujha199640@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: hmc5843: Clean up redundant code.
Message-ID: <20180922111801.73a4d969@archlinux>
In-Reply-To: <20180922100419.GA25620@Eros>
References: <20180920141321.15251-1-songqiang1304521@gmail.com>
        <201809211608.bVz8vg0N%fengguang.wu@intel.com>
        <20180921182616.GA2077@himanshu-Vostro-3559>
        <20180922100419.GA25620@Eros>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Sep 2018 18:04:19 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> On Fri, Sep 21, 2018 at 11:56:16PM +0530, Himanshu Jha wrote:
> > Hi Song,
> > 
> > On Fri, Sep 21, 2018 at 04:10:16PM +0800, kbuild test robot wrote:  
> > > Hi Song,
> > > 
> > > Thank you for the patch! Yet something to improve:
> > > 
> > > [auto build test ERROR on iio/togreg]
> > > [also build test ERROR on v4.19-rc4 next-20180920]
> > > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > > 
> > > url:    https://github.com/0day-ci/linux/commits/Song-Qiang/iio-magnetometer-hmc5843-Clean-up-redundant-code/20180921-091239
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> > > config: x86_64-randconfig-u0-09211331 (attached as .config)
> > > compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
> > > reproduce:
> > >         # save the attached .config to linux build tree
> > >         make ARCH=x86_64 
> > > 
> > > All errors (new ones prefixed by >>):
> > >   
> > > >> ERROR: "hmc5843_volatile_table" [drivers/iio/magnetometer/hmc5843_i2c.ko] undefined!
> > > >> ERROR: "hmc5843_readable_table" [drivers/iio/magnetometer/hmc5843_i2c.ko] undefined!
> > > >> ERROR: "hmc5843_writable_table" [drivers/iio/magnetometer/hmc5843_i2c.ko] undefined!  
> > 
> > You would need to export these above symbols using EXPORT_SYMBOL()
> > to be used by i2c/spi modules.
> > 
> > But on the other hand, exporting too many symbols is a bad idea since
> > it is only used for this driver and not at any other place in IIO.
> > So, in my opinion drop this patch and leave the code as-is.
> > 
> > https://lkml.org/lkml/2018/7/16/566 --> worth reading
> > 
> > 
> > Thanks
> > -- 
> > Himanshu Jha
> > Undergraduate Student
> > Department of Electronics & Communication
> > Guru Tegh Bahadur Institute of Technology  
> 
> Hi Himanshu,
> 
> You're right, that's exactly what I was missing!
> I saw the link you mentioned above and I also think that's a very good
> idea to limit the scope of symbols. But I don't know when this work can
> be applied to the kernel, as it seems like a not little change for the
> build infrastructure.
> I think this maybe a common problem for some drivers.
> Divers for bmc150 in drivers/iio/accel/bmc-150-accel-core.c did the same
> exporting stuff as I was prefered. So I think even if either exporting or
> duplicating is not good enough, one must be choosed for now.
> 
> I think this is a topic that I have some ideas but not experienced
> enough to say what should we do is better. I would like to hear Jonathan's
> ideas about this. If this patched shouldn't be applied, then maybe bmc150
> should be patched.

As you say it's not a particularly clear advantage either way and will
depend on the size of the repetition.

So I'm afraid it's in the category of insisting on one option or the
other is just overly fussy.  Al, for existing cases it's also not
worth the noise that changing to one or other option creates.

Whilst the noise effect on things like backporting fixes is minor for patches
like this, it isn't zero so there has to be a clear advantage in whatever
is changed.  Hence I won't be taking this one, or any patches going the
other way for existing drivers.

Thanks,

Jonathan

> 
> yours,
> Song Qiang
> 

