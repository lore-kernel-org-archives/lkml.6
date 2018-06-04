Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750853AbeFDPjt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:39:49 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46671 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeFDPjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:39:48 -0400
X-Google-Smtp-Source: ADUXVKLRvsnSwCJfYO6lSX5DP0a8jWeHXTIWHOgq0Fxo0VBO2+nrVl9Q8Um+ypklI7YdXogTPHsVuQ==
MIME-Version: 1.0
References: <20180529181740.195362-1-evgreen@chromium.org> <20180529181740.195362-2-evgreen@chromium.org>
 <cfb43e6138a62889fd5ba9683c93e10ee32635df.camel@wdc.com>
In-Reply-To: <cfb43e6138a62889fd5ba9683c93e10ee32635df.camel@wdc.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 4 Jun 2018 08:39:08 -0700
X-Gmail-Original-Message-ID: <CAE=gft5tx6my6f=PVfFwPvVy_3kcuH6y6+4oRrS9x3rydxJ9vA@mail.gmail.com>
Message-ID: <CAE=gft5tx6my6f=PVfFwPvVy_3kcuH6y6+4oRrS9x3rydxJ9vA@mail.gmail.com>
Subject: Re: [PATCH 1/7] scsi: ufs: Add Configuration Descriptor to sysfs
To: Bart.VanAssche@wdc.com
Cc: jejb@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        Vinayak Holikatti <vinholikatti@gmail.com>, Stanislav.Nijnikov@wdc.com,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 1:31 AM Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
>
> On Tue, 2018-05-29 at 11:17 -0700, Evan Green wrote:
> > This change adds the configuration descriptor to the UFS
> > sysfs interface. This is done in preparation for making the
> > interface writable, which will enable provisioning UFS devices
> > via Linux.
> >
> > The configuration descriptor is laid out as a header, then a set of
> > (usually 8) copies of the same descriptor for each unit. Rather than
> > creating 8 sets of the same attribute, this interface adds a cfg_unit
> > file, which can be set as an index that defines which of the 8
> > configuration unit descriptors are being shown through sysfs.
>
> I don't know any other example of a sysfs attribute that controls the
> contents of another sysfs attribute so I don't know whether this kind
> of behavior is acceptable for sysfs attributes. Additionally, how can
> these two sysfs attributes be used together from concurrently running
> processes without triggering a race condition?
>
> Bart.

Hi Bart,
I was following the example of rpm_lvl and spm_lvl in this driver,
whose values control what is shown in rpm_target_dev_state and
rpm_target_link_state (and spm equivalents). My original thinking was
that provisioning the high level storage configuration of a UFS disk
is by definition a single threaded one-time-only activity. However
Stanislav and others have also expressed concerns about this
mechanism, so it sounds like I should revise it. I'm hoping Stanislav
will comment on one of two possible approaches I suggested in the
cover letter.

-Evan
