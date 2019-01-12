Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF4DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 06:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A7D2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 06:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbfALGnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 01:43:12 -0500
Received: from mout.gmx.net ([212.227.17.22]:60807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfALGnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 01:43:12 -0500
Received: from homer.simpson.net ([185.191.219.88]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8pKi-1gYKZQ0Ham-00CBcs; Sat, 12
 Jan 2019 07:43:04 +0100
Message-ID: <1547275382.26908.7.camel@gmx.de>
Subject: Re: 5.0-rc1 KVM inspired "BUG: Bad page state in process" spew
From:   Mike Galbraith <efault@gmx.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Adam Borowski <kilobyte@angband.pl>, kvm <kvm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Sat, 12 Jan 2019 07:43:02 +0100
In-Reply-To: <20190109192637.GA1697@linux.intel.com>
References: <1547012338.4926.11.camel@gmx.de>
         <20190109144257.erwh52326ucgc5tw@angband.pl>
         <1547046196.31155.1.camel@gmx.de> <20190109192637.GA1697@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NBDvAfRRL5pK8kMdKZmdtPVvdNuL/fLHkqJfOqg/Plg5/KNX8aC
 z6MpeWepRgvClaR/SD9HfWzSTPIYKPidG+hhGT43r3T9KdfU0W7lkwjWNPS3Mh7xKXplU39
 Gx//SpCfGhKJZCPWRv5qW3fVv/sYBUSgCcqlWfnAR/2T4DWfyf3gpZ5NEpFYh+GgxdUGBM/
 Q1ObgALdxFS7gvDrHKA8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zkj1fCrhMBo=:Id4S+YXk1UboX2U0TmK1go
 H2EOqYE5ZBvKOahMSzVx9PZYMFB7JKZPpuFdsGR5gkQvDH7arXuem6ht0r3NT3u/2PtheDtm6
 7PGo2PzD77z6BzMZROfhMvyUTpazkh2EKuGzZQwIphYQ0bNwSTFUBT3lWezRQOqk3V4J+jgMM
 7LONkETVj4K5MeR3lxKFL9X9T04yA2WzqVQEsehZV/l9nV7GXU41V4XYCq+yGoxfy5Br/thE1
 +bWRvWwMelocXVpdbmcjbu4zkTyZoDEkGXhnsq12eNTu0TNiJaizYEEj0GWM3ll7a+XxqUURs
 xxYvsjZQv/t9gVCfGbPcD95GylDMJAaV2rLUp3jyl5vmxsKdds9c8vMMXfur+QzrgLprUyIhz
 pk+AInv2kRR/JYbSQQTK/HLGSS0lcHLk+o9iAGrEs8ze64zIi6OB2Qy1FSjAbdMU7pqkt06lc
 AjKJ/6T7PIi71zuL0bg9qJ/yABSX3+jlEmC1TgSD6mEwZhpDZmtyvpdBc0MrfA/PG1gvuOVyV
 ny70JwjRnNJJ3SM4fTt3ptjZRCFBwrhJWjvbVk3y7DM0GY+1WeggltyWdVmubZQJBv2mZUfcU
 uhmKIi7J+SqAE55IFTNE8hfjrT+Q8GsibjhAl3N85T61Ld0djVhpEpRpL6K7mETrLoOPrIC0Y
 5+x1d6ncbl/yaJketyBMG3uiQq/CI358d4O1rBdI+lK3GEXdZPKw3wGuDVwvKf1+cc2iGsIEA
 MUKb20D3r+xRm497TYwy0d3GnOq1/CndBK2IW46bicz/cvGPo5RzktkqHQKLSmLlf20y3VI/N
 NiksIoQ9jzshwtxkggitlX6iqXIu32BUUilb+grvEM6GGLhY8PMcjEkqptbePn+Z3RSkr1jlS
 rVGubt2u06FxYkhcQn0D6oc8i8Kshk0Kz+8qkYmOkaHktykPdCoMz7IeWwVbI7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-09 at 11:26 -0800, Sean Christopherson wrote:
> 
> I'll try to bisect.

Good luck with that.  I gave it a go, but that apparently invalidated
the warrantee of my vm image :)

	-Mike
