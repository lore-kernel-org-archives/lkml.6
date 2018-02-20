Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbeBTXBm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:01:42 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35338 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbeBTXBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:01:40 -0500
X-Google-Smtp-Source: AH8x225TGSGSCVEp4GlVkVcSurX+YsHZew3XRu2Kj6dJ4OCBu56p39SCAv18Cut0h9KkJWRr5PUmcw==
Date: Tue, 20 Feb 2018 15:01:36 -0800
From: Tejun Heo <tj@kernel.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>
Subject: Re: A "domain invalid" cgroup *can* sometimes have member tasks
Message-ID: <20180220230136.GD170644@devbig577.frc2.facebook.com>
References: <CAKgNAkgEa9ZEHzoRWv7Y71eFVuFsy8Z4zSazZv9u7NRrx3xG9Q@mail.gmail.com>
 <20180220193547.GB170644@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220193547.GB170644@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 11:35:47AM -0800, Tejun Heo wrote:
> Hmm... nr_populated_domain_children check should have caught that
> condition and rejected it.  Will look into what's going on.

Ah, okay, I was special-casing the first level children case too
early.  If you nest the test case by one more level, it fails as
intended.  I'll fix the checks.

Thanks.

-- 
tejun
