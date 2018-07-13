Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E1FECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA77208E9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA77208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeGMFPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 01:15:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbeGMFPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 01:15:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD3798182D31;
        Fri, 13 Jul 2018 05:02:11 +0000 (UTC)
Received: from xz-mi (dhcp-14-142.nay.redhat.com [10.66.14.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44C161102E2A;
        Fri, 13 Jul 2018 05:02:06 +0000 (UTC)
Date:   Fri, 13 Jul 2018 13:02:04 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@gibson.dropbear.id.au
Subject: Re: [PATCH] vfio-pci: Disable binding to PFs with SR-IOV enabled
Message-ID: <20180713050204.GB2379@xz-mi>
References: <20180712223243.9593.24855.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180712223243.9593.24855.stgit@gimli.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 13 Jul 2018 05:02:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 13 Jul 2018 05:02:11 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'peterx@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 04:33:04PM -0600, Alex Williamson wrote:
> We expect to receive PFs with SR-IOV disabled, however some host
> drivers leave SR-IOV enabled at unbind.  This puts us in a state where
> we can potentially assign both the PF and the VF, leading to both
> functionality as well as security concerns due to lack of managing the
> SR-IOV state as well as vendor dependent isolation from the PF to VF.
> If we were to attempt to actively disable SR-IOV on driver probe, we
> risk VF bound drivers blocking, potentially risking live lock
> scenarios.  Therefore simply refuse to bind to PFs with SR-IOV enabled
> with a warning message indicating the issue.  Users can resolve this
> by re-binding to the host driver and disabling SR-IOV before
> attempting to use the device with vfio-pci.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
