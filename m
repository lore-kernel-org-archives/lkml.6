Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97D0C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E1D21916
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="MBKpvprF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfBGXzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:55:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36254 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfBGXzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:55:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so3063635otk.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 15:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wuu6aq9mmWRYWmAEazq1JML050O5p2LjZKSNRxmlZ5g=;
        b=MBKpvprFNpUeQahrEAvcOhuvzE9JE1qn2cKGX+VcKhcGtTobMfAmsZHUqRosEFLgcs
         mUqGl2rU8gYhn58O9a908me5vTVjFFGAfQi7TJBEt1u5hthVkL/IBwBYkG8QGHavMv8v
         ZrM6I2Q60JVT2472qVlfoyUN2Cl+F0oNcqv40BYzXTZ1aPQ0yJ4Dx9Mrq5snGjsLeRJv
         oTchGkY7jc1FbVrvqWXby6kjlGBLq++/dOIKprajKwmudG/Ui/megC5gKXO7eoQdI3N4
         i5K9KVEKGofchk7sR1CxW6njled2+6eTYcpKR4WTWK/hPnW7phTQzJOnyC6L+tr7mzwz
         puGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuu6aq9mmWRYWmAEazq1JML050O5p2LjZKSNRxmlZ5g=;
        b=e02KDf4tJyuLBbXUwoSmeVkPsM8oLD83XYsuf6ggnF+sEhYk/Xw5pMFtuj/7BfkFHT
         AozqFQxbfuZY5LrX4fMLXuBbBIa14ktreqa8VmG9UH+V6uoMFwHw2BuIGmlytFeDR96O
         dEgNRc2k9A0MqyscsKkb7Sc98bfADiXPtLVgGOQvRG96N6zpbre9yC22iqI2MSbr3/9a
         9vkRZNA/TQe40aB+XTQwCKip/J7HUoFGORT1F56qfj9G4UJjAXXBG3HtiRTpzG6spzAj
         5yr/IBLy3d1FlwrxsB5Z5vddUKBPXosaGlHQjVfobGvjV6y50CnxoLoasy2QXth/3Wdu
         YOKA==
X-Gm-Message-State: AHQUAuYPPNgbTG/5WM6iaghryyH/zc45hWStvZTDGlPEqw9UY2WH9NTl
        +VUaK9LmMFMk+M3M4fBA1IpUQkOwEzXEbJ4OoNNajg==
X-Google-Smtp-Source: AHgI3IZ8oLiizk9A/wsiEDpzUAkAIj/Y5hRLuqUsFLgj6eBrY8gxGnGq1NPBw/Sw9Tz5Pq4ry68pvu7qyEBchCDRBPc=
X-Received: by 2002:a05:6808:344:: with SMTP id j4mr397968oie.149.1549583710509;
 Thu, 07 Feb 2019 15:55:10 -0800 (PST)
MIME-Version: 1.0
References: <20190206173114.GB12227@ziepe.ca> <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard> <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <20190207035258.GD6173@dastard> <20190207052310.GA22726@ziepe.ca>
 <CAPcyv4jd4gxvt3faYYRbv5gkc6NGOKjY_Z-P0Ph=ss=gWZw7sA@mail.gmail.com> <20190207171736.GD22726@ziepe.ca>
In-Reply-To: <20190207171736.GD22726@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 7 Feb 2019 15:54:58 -0800
Message-ID: <CAPcyv4hsHeCGjcJNEmMg_6FYEsQ_8Z=bvx+WmO1v_LmoXbJrxA@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dave Chinner <david@fromorbit.com>,
        Doug Ledford <dledford@redhat.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 9:17 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Feb 06, 2019 at 10:00:28PM -0800, Dan Williams wrote:
>
> > > > If your argument is that "existing RDMA apps don't have a recall
> > > > mechanism" then that's what they are going to need to implement to
> > > > work with DAX+RDMA. Reliable remote access arbitration is required
> > > > for DAX+RDMA, regardless of what filesysetm the data is hosted on.
> > >
> > > My argument is that is a toy configuration that no production user
> > > would use. It either has the ability to wait for the lease to revoke
> > > 'forever' without consequence or the application will be critically
> > > de-stablized by the kernel's escalation to time bound the response.
> > > (or production systems never get revoke)
> >
> > I think we're off track on the need for leases for anything other than
> > non-ODP hardware.
> >
> > Otherwise this argument seems to be saying there is absolutely no safe
> > way to recall a memory registration from hardware, which does not make
> > sense because SIGKILL needs to work as a last resort.
>
> SIGKILL destroys all the process's resources. This is supported.
>
> You are asking for some way to do a targeted *disablement* (we can't
> do destroy) of a single resource.
>
> There is an optional operation that could do what you want
> 'rereg_user_mr'- however only 3 out of 17 drivers implement it, one of
> those drivers supports ODP, and one is supporting old hardware nearing
> its end of life.
>
> Of the two that are left, it looks like you might be able to use
> IB_MR_REREG_PD to basically disable the MR. Maybe. The spec for this
> API is not as a fence - the application is supposed to quiet traffic
> before invoking it. So even if it did work, it may not be synchronous
> enough to be safe for DAX.
>
> But lets imagine the one driver where this is relavents gets updated
> FW that makes this into a fence..
>
> Then the application's communication would more or less explode in a
> very strange and unexpected way, but perhaps it could learn to put the
> pieces back together, reconnect and restart from scratch.
>
> So, we could imagine doing something here, but it requires things we
> don't have, more standardization, and drivers to implement new
> functionality. This is not likely to happen.
>
> Thus any lease mechanism is essentially stuck with SIGKILL as the
> escalation.
>
> > > The arguing here is that there is certainly a subset of people that
> > > don't want to use ODP. If we tell them a hard 'no' then the
> > > conversation is done.
> >
> > Again, SIGKILL must work the RDMA target can't survive that, so it's
> > not impossible, or are you saying not even SIGKILL can guarantee an
> > RDMA registration goes idle? Then I can see that "hard no" having real
> > teeth otherwise it's a matter of software.
>
> Resorting to SIGKILL makes this into a toy, no real production user
> would operate in that world.
>
> > > I don't like the idea of building toy leases just for this one,
> > > arguably baroque, case.
> >
> > What makes it a toy and baroque? Outside of RDMA registrations being
> > irretrievable I have a gap in my understanding of what makes this
> > pointless to even attempt?
>
> Insisting to run RDMA & DAX without ODP and building an elaborate
> revoke mechanism to support non-ODP HW is inherently baroque.
>
> Use the HW that supports ODP.
>
> Since no HW can do disable of a MR, the escalation path is SIGKILL
> which makes it a non-production toy.
>
> What you keep missing is that for people doing this - the RDMA is a
> critical compoment of the system, you can't just say the kernel will
> randomly degrade/kill RDMA processes - that is a 'toy' configuration
> that is not production worthy.
>
> Especially since this revoke idea is basically a DOS engine for the
> RDMA protocol if another process can do actions to trigger revoke. Now
> we have a new class of security problems. (again, screams non
> production toy)
>
> The only production worthy way is to have the FS be a partner in
> making this work without requiring revoke, so the critical RDMA
> traffic can operate safely.
>
> Otherwise we need to stick to ODP.

Thanks for this it clears a lot of things up for me...

...but this statement:

> The only production worthy way is to have the FS be a partner in
> making this work without requiring revoke, so the critical RDMA
> traffic can operate safely.

...belies a path forward. Just swap out "FS be a partner" with "system
administrator be a partner". In other words, If the RDMA stack can't
tolerate an MR being disabled then the administrator needs to actively
disable the paths that would trigger it. Turn off reflink, don't
truncate, avoid any future FS feature that might generate unwanted
lease breaks. We would need to make sure that lease notifications
include the information to identify the lease breaker to debug escapes
that might happen, but it is a solution that can be qualified to not
lease break. In any event, this lets end users pick their filesystem
(modulo RDMA incompatible features), provides an enumeration of lease
break sources in the kernel, and opens up FS-DAX to a wider array of
RDMA adapters. In general this is what Linux has historically done,
give end users technology freedom.
