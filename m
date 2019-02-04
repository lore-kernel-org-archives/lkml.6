Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861D7C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5827B214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfBDMHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:07:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbfBDMHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:07:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 592718764F;
        Mon,  4 Feb 2019 12:07:24 +0000 (UTC)
Received: from gondolin (ovpn-117-129.ams2.redhat.com [10.36.117.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF37C848D8;
        Mon,  4 Feb 2019 12:07:21 +0000 (UTC)
Date:   Mon, 4 Feb 2019 13:07:18 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Harald Freudenberger <freude@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, sebott@linux.ibm.com,
        oberpar@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI
 command
Message-ID: <20190204130718.0fb8cdb3.cohuck@redhat.com>
In-Reply-To: <26ec5e3e-de2c-ad82-825d-d20ba52c8937@linux.ibm.com>
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
        <20190131105555.4af6d8ea.cohuck@redhat.com>
        <2bb57977-bf03-f0c9-abd9-8baa74d31f8a@linux.ibm.com>
        <20190201153522.4f72cf00.cohuck@redhat.com>
        <26ec5e3e-de2c-ad82-825d-d20ba52c8937@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 04 Feb 2019 12:07:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 11:15:25 +0100
Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 01.02.19 15:35, Cornelia Huck wrote:
> > On Thu, 31 Jan 2019 18:50:57 -0500
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >  
> >> On 1/31/19 4:55 AM, Cornelia Huck wrote:  
> >>> On Wed, 30 Jan 2019 12:48:46 -0500
> >>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >>> Two questions:
> >>> - Does the event cover _any_ change to the AP configuration, or can the
> >>>    periodic scan detect changes that are not signaled?    
> >> It can detect any change, such as a change to the CRYCB masks.  
> > Nice. I suppose we can not rely on those messages being generated,
> > though, and therefore need to keep the periodic scan...  
> As you wrote, I am not sure if the ap bus code can rely on this to
> cover all changes. For kvm guests I think it is currently not working
> as there is no such notification generated at all. So I'd like to
> have the periodic scan in place.

Yes, and there are bound to be QEMU versions without that support in
active use even if this is implemented in the future. But a quicker
reaction to changes on real hardware still sounds like a win to me :)
