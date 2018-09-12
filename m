Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3603DC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71B620890
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="NR6YfcU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71B620890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeILVrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:47:04 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38713 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeILVrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:47:04 -0400
Received: by mail-oi0-f67.google.com with SMTP id x197-v6so5030054oix.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MQNS2+MB1WvXQGkFzimTkm0YZw5DiZDJ2X2JPuJ35ag=;
        b=NR6YfcU99ypdGj9sr2JvQW3ENYi+kWO8iNPRGpnfKoElOWQhudS2c+4UQHKZRyOtjY
         9sFRu0VK+su1/b6ZeMZSh8z2OAG5PZo884q44fzrbFqpW9Ln37NYBfvslW0JaCt7is5k
         c6NbEV0vt3sZXSdODnxlIwQBNeWjmoa9+6fBns3KtbWDtzo8U3KP62RetAeKSW37qnEb
         D5DLQ4GRIpw5JbTSdgF5Qh9TR+3M7HVgTAN2Uk8AfxLRAc7A7BYxfysqnKEGJzpyN+f8
         nk4gqQLSo/PLlChtZh/v91cn7Bo/UylKlOs9HNdzbLT36f+gBOnP2gMsOiUtbeCrnhL6
         WHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MQNS2+MB1WvXQGkFzimTkm0YZw5DiZDJ2X2JPuJ35ag=;
        b=MR7ICTzsVhh4LotDHt3a5jC2IvdJxZOh1RsGE/PNBvmhL5G629b8hOPi511ez5i+Mu
         q/hXpcFwwsYk//dbITB23N2uLdb1SBhT4RmJwRBSfx46cRdddxEAHHS77EjryUOJ9wKa
         mjd2UOFB3Z/QXf+ZpSr+bGjs6TbIRn3yfXUE2iIgmQqiSJVEenMCSiZejZ//WrbbLEN/
         veCNnmwN1Yp4XixDLcPHk66YLrHePMzhtiMXV9Puqw2lnR2yJNWQDEEdulPKhzKLISxw
         7pciIUt2Ms+J1W8ROdkvrUS+nJeCxAL2KCpGq1avBgtlouuMl9zFiv9wtU3bWlpMyPJr
         jdDw==
X-Gm-Message-State: APzg51ABIUjrx893iZxHLFm5BmHqfcPfIhXF7yw9EkPYK+HfuWdjLIOw
        OUgS0UXh+FMcfK6/d0bOV0kHorJmmFqmFvdY2KIfcg==
X-Google-Smtp-Source: ANB0VdbQ+fWGtkzmFkKae4vp2dLSTFbqTqh2ChK2PxaRmc/PYeHAKXdFcbiLBOJpcxYmR9f05cVRhgLpBqDQvOD8og0=
X-Received: by 2002:aca:4914:: with SMTP id w20-v6mr3070467oia.5.1536770503164;
 Wed, 12 Sep 2018 09:41:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 09:41:42
 -0700 (PDT)
In-Reply-To: <1f1cf9db3981390d2ad5a08d5f1987d9c933e687.camel@hpe.com>
References: <20180911154246.6844-1-toshi.kani@hpe.com> <20180911154246.6844-3-toshi.kani@hpe.com>
 <CAPcyv4iEZ7q0MV7n-_eovrJw_U9S3=pkY_nYwtw1jSBS7vPqCQ@mail.gmail.com>
 <20180912093140.GB7782@quack2.suse.cz> <1f1cf9db3981390d2ad5a08d5f1987d9c933e687.camel@hpe.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Sep 2018 09:41:42 -0700
Message-ID: <CAPcyv4ggwdBdT0-znPxcGn=2G=VuFfJaQcZiBqb8VHV2oUQ5LQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ext4, dax: set ext4_dax_aops for dax files
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     "jack@suse.cz" <jack@suse.cz>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 9:08 AM, Kani, Toshi <toshi.kani@hpe.com> wrote:
> On Wed, 2018-09-12 at 11:31 +0200, Jan Kara wrote:
>> On Tue 11-09-18 11:15:18, Dan Williams wrote:
>> > On Tue, Sep 11, 2018 at 8:42 AM, Toshi Kani <toshi.kani@hpe.com> wrote:
>> > > Sync syscall to an existing DAX file needs to flush processor cache,
>> > > but it does not currently.  This is because 'ext4_da_aops' is set to
>> > > address_space_operations of existing DAX files, instead of 'ext4_dax_aops',
>> > > since S_DAX flag is set after ext4_set_aops() in the open path.
>> > >
>> > >   New file
>> > >   --------
>> > >   lookup_open
>> > >     ext4_create
>> > >       __ext4_new_inode
>> > >         ext4_set_inode_flags   // Set S_DAX flag
>> > >       ext4_set_aops            // Set aops to ext4_dax_aops
>> > >
>> > >   Existing file
>> > >   -------------
>> > >   lookup_open
>> > >     ext4_lookup
>> > >       ext4_iget
>> > >         ext4_set_aops          // Set aops to ext4_da_aops
>> > >         ext4_set_inode_flags   // Set S_DAX flag
>> > >
>> > > Change ext4_iget() to call ext4_set_inode_flags() before ext4_set_aops().
>> > >
>> > > Fixes: 5f0663bb4a64f588f0a2dd6d1be68d40f9af0086
>> >
>> > Same format nit:
>> >
>> > Fixes: 5f0663bb4a64 ("ext4, dax: introduce ext4_dax_aops")
>> > Cc: <stable@vger.kernel.org>
>> >
>> >
>> > > Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
>> > > Cc: Jan Kara <jack@suse.cz>
>> > > Cc: Dan Williams <dan.j.williams@intel.com>
>> > > Cc: "Theodore Ts'o" <tytso@mit.edu>
>> > > Cc: Andreas Dilger <adilger.kernel@dilger.ca>
>> > > ---
>> > >  fs/ext4/inode.c |    3 ++-
>> > >  1 file changed, 2 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> > > index 775cd9b4af55..93cbbb859c40 100644
>> > > --- a/fs/ext4/inode.c
>> > > +++ b/fs/ext4/inode.c
>> > > @@ -4998,6 +4998,8 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
>> > >         if (ret)
>> > >                 goto bad_inode;
>> > >
>> > > +       ext4_set_inode_flags(inode);
>> > > +
>> >
>> > Hmm, does this have unintended behavior changes?
>> >
>> > I notice that there are some checks for flags "IS_APPEND(inode) ||
>> > IS_IMMUTABLE(inode)" *before* the call to ext4_set_inode_flags(). I
>> > didn't look too much deeper at whether those checks are bogus, but it
>> > would seem safer to do something like this for a lower risk fix.
>> >
>> > Thoughts?
>>
>> Well, safer but it would leave the landmine around for others to hit.
>> Toshi, please move the ext4_set_inode_flags() call to be just after the
>> assignment:
>>
>> ei->i_flags = le32_to_cpu(raw_inode->i_flags);
>>
>> in ext4_iget(). That way people won't introduce checks for i_flags that can
>> never hit... And yes, it fixes also other bugs (mostly in sanity checks
>> AFAICS) than the DAX issue.
>
> Sure.  Assuming you think the implicit change Dan pointed out is not a
> problem, yes, I will go with this cleaner approach.
>

Yes, Jan's proposal looks best to me.
