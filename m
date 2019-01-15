Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35E6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A1F20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvHzAZQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfAOKur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:50:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53691 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbfAOKur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:50:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so2776912wmb.3;
        Tue, 15 Jan 2019 02:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nc1qdK2xfd23BCmnPdWlHCBJ3JqE7tSeQmzgsCKRAiI=;
        b=bvHzAZQh8NcQ8ScBr/qIws3ipPkwpPhFmAWoWU/x8lufQOAS4oc2/sRfFU3L4tWHyx
         XJoP4UnR5dBUzaGkKCyMTYuta6w0dnLWV4VfCY3wMypbgsiS2dhfheI8eNlSEY3hzOHk
         Id6Jc/sAtmpkXDiBEFBPYLRZ0D1gtqYEMUgwDvIEeqctZxD2n+CWTwaY5kjmE0ONBkD+
         4FZAnW7tXlZcjafKWo0Kv8YgEZ4NrB40aFuAayITpZN2gRIbWM7SMXwXinx4oFF4Rzk4
         tiOxwBczUdtSrSyXuwvPsC3hvkQJgDBHRGP7rEKLVQbNqQVcVYq80aD1e3CYAbaewBQA
         fCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nc1qdK2xfd23BCmnPdWlHCBJ3JqE7tSeQmzgsCKRAiI=;
        b=pnyska7Yzgt2nGalm3O5Ws3kI68VDFhnwBE4KHtjUlgqOB9xuC1/CpGT+UylSnWR0J
         CVrdPFC74hR7vEh9CllEIdxHZzD3R/k3aGB9y84uT0Am9bi3Sv5SZr3m6CfnSwB5JH4g
         98hZiuSeZBpnCa4Q0k96JNzk8UksnNgnJejOuyiOd+n8A5JotggAlFjR8tXf8VjdacVu
         bPO0wqQhAV3H7UqHhoSMM7vr7Dn4jG+AhgkuT15u5AvvkLnPpBDel574PFbucxAqdEcO
         VCK+tLrMJHHK7lVLr2tmLWAKmE+RJZevFoiL7RydYtd7HC/K5OyGv7mx42qX8cxp2Orf
         2HXw==
X-Gm-Message-State: AJcUuke5vQ3OL/itloI7k2Ho1N+syvgcZx7k2bHtWkOjIDlgbhSG6HEL
        z/bEjevz0CTGD0iYyyTnh8EgpEZp
X-Google-Smtp-Source: ALg8bN7Ex79qL/T6uZNflBUUY89vGivR1wg7wAxDxnwU+wf0PhMRsyxdO4GEIc/j1fGsopkIpIoLdQ==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr2681709wmi.57.1547549443354;
        Tue, 15 Jan 2019 02:50:43 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id i186sm36421048wmd.19.2019.01.15.02.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 02:50:42 -0800 (PST)
Date:   Tue, 15 Jan 2019 11:50:41 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Michael Sabolish <sabolish@me.com>,
        Kevin Weidemann <kwe-lnx@postn.eu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: udf: Prevent write-unsupported filesystem to be remounted
 read-write
Message-ID: <20190115105041.7bc3wzo7oawg7ea2@pali>
References: <124cc6ea-ca79-20f2-651e-c2f909729ac0@gmx.de>
 <8cf39b7c-505b-91e6-849d-e66ba980042f@postn.eu>
 <20190114103011.GD13316@quack2.suse.cz>
 <20190114120023.wkftfz6pwatehpfe@pali>
 <20190114123042.GH13316@quack2.suse.cz>
 <E11914DA-D254-4198-A152-F9D6E61514BE@me.com>
 <20190115083111.qq2mt2p2kn4opwx7@pali>
 <20190115084119.GE29524@quack2.suse.cz>
 <20190115084832.fypbuhyvgfizh3am@pali>
 <20190115094555.GG29524@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190115094555.GG29524@quack2.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 January 2019 10:45:55 Jan Kara wrote:
> On Tue 15-01-19 09:48:32, Pali Rohár wrote:
> > On Tuesday 15 January 2019 09:41:19 Jan Kara wrote:
> > > On Tue 15-01-19 09:31:11, Pali Rohár wrote:
> > > > On Monday 14 January 2019 19:07:35 Michael Sabolish wrote:
> > > > > I can try and make a pull-request for udftune, and I can just copy the API for tune2fs.  It would work something like:
> > > > > 
> > > > > udftune -O read-only device            (to set read-only access type)
> > > > > 
> > > > > or:
> > > > > 
> > > > > udftune -O ^read-only device          (to clear read-only access type (aka set rw))
> > > > 
> > > > This API is ambiguous. What does it mean for ^read-only? In UDF you have
> > > > following access types: overwritable, rewritable, writeonce, readonly,
> > > > pseudo-overwritable, unknown.
> > > > 
> > > > So you would need to know to which R/W access type to switch
> > > > (overwritable, rewritable, writeonce or pseudo-overwritable).
> > > > 
> > > > With information of media type, you could be able to guess correct
> > > > access type. But for UDF images stored in VFS there is no media
> > > > information. Also you can have uncommon setup, e.g. usage of CD-R
> > > > writeonce setup on CD-R/W disc. So "autodetection" of media type would
> > > > not work always correctly.
> > > > 
> > > > So I think that it would be better to have following API:
> > > > 
> > > >   udftune --access-type=<new_access_type>
> > > > 
> > > > or
> > > > 
> > > >   udftune --change-access-type=<new_access_type>
> > > > 
> > > > I understand that you would like to have similar API as tune2fs, but UDF
> > > > settings are too different from ext*.
> > > 
> > > If you wanted to follow tune2fs interface, you can have e.g.:
> > 
> > Question is if it is a good idea to follow this interface.
> 
> Agreed. I'll leave that decision up to you as a maintainer :)
> 
> > > udftune -E access-type=<foo>
> > > 
> > > Another question about the feature is - the access type is actually per
> > > partition and there can be multiple partitions on UDF media. So I think we
> > > need to specify the partition number in the command and <foo> has to
> > > actually be something like <partition number>,<access_type>.
> > 
> > Access type is stored in partition descriptor and in UDF (as opposite of
> > ECMA-167) you can have only one partition descriptor. IIRC there is some
> > exception when you have two partition descriptors, but then one have to be
> > readonly and second virtual.
> 
> Ah, right, I forgot that UDF standard limits how partitions can be set up.
> However I don't see anything that would limit number of "type 1" maps? I've
> only found in 2.2.4.7 that "Partition Maps shall be limited to Partition
> Map type 1, except type 2 maps ...". In which I'm not sure whether this is
> meant to imply there is only one 'type 1' partition map or whether there
> can be more of them.

That is interesting question... I just found following:

In section "2. Basic Restrictions & Requirements" there is information
about "Partition Descriptor":

A Partition Descriptor Access Type of read-only, rewritable,
overwritable, write-once and pseudo-overwritable shall be supported.
There shall be exactly one prevailing Partition Descriptor recorded per
volume, with one exception. For Volume Sets that consist of single
volume, the volume may contain 2 non-overlapping Partitions with 2
prevailing Partition Descriptors only if one has an Access Type of
read-only and the other has an Access Type of rewritable, overwritable,
or write-once. The Logical Volume for this volume would consist of the
contents of both partitions.

But again it does not answer to your question.

-- 
Pali Rohár
pali.rohar@gmail.com
