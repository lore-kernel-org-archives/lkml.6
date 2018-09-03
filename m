Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD9FC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BE520652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BE520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeICRda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:33:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:38952 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbeICRda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:33:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A79D4B020;
        Mon,  3 Sep 2018 13:13:22 +0000 (UTC)
Date:   Mon, 3 Sep 2018 15:13:21 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Hans de Goede <hdegoede@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, kai.heng.feng@canonical.com
Subject: Re: [PATCH] HID: i2c-hid: enforce
 I2C_HID_QUIRK_RESEND_REPORT_DESCR
In-Reply-To: <CAO-hwJKABBJExKciVt5R-8bjBtUe+uSc0Z_ikc35jbf1zrNpog@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1809031512420.25787@cbobk.fhfr.pm>
References: <20180831095417.8541-1-benjamin.tissoires@redhat.com> <4687e76a-d9a8-4a20-194b-526bb345cf73@redhat.com> <CAO-hwJKABBJExKciVt5R-8bjBtUe+uSc0Z_ikc35jbf1zrNpog@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2018, Benjamin Tissoires wrote:

> > > The spec states that the HID devices should allow
> > > the host to query the HID descriptor at any time.
> > >
> > > Some devices require the HID descriptor to be set
> > > on resume, or they will fail.
> > >
> > > Instead of having a growing list of blacklisted devices
> > > make the call part of the general resume process
> > > so we can remove this list.
> > >
> > > Tested on a Dell XPS 9360 and a Surface 3.
> > >
> > > link: https://bugzilla.redhat.com/show_bug.cgi?id=1622695
> > >
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > I agree we should just do this everywhere:
> >
> > Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> Jiri, please hold with this patch, Canonical might have found a better
> solution. Simply not resetting the device after S3 might be the trick.

Thanks for the heads up.

In case that's the case, please also send a reference to the subsititute 
patch submission into this thread, so that archives to pick it up :)

Thanks,

-- 
Jiri Kosina
SUSE Labs

