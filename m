Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F98C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9EC205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9EC205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966797AbeFSPaQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:30:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966502AbeFSPaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:30:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC12987A4B;
        Tue, 19 Jun 2018 15:30:12 +0000 (UTC)
Received: from redhat.com (ovpn-120-100.rdu2.redhat.com [10.10.120.100])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2FB512026D68;
        Tue, 19 Jun 2018 15:30:11 +0000 (UTC)
Date:   Tue, 19 Jun 2018 18:30:10 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Farhan Ali <alifm@linux.ibm.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, arei.gonglei@huawei.com,
        longpeng2@huawei.com, pasic@linux.ibm.com, frankja@linux.ibm.com,
        Jason Wang <jasowang@redhat.com>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Detect & register virtio-crypto algos only if it
 can be supported by backend
Message-ID: <20180619182948-mutt-send-email-mst@kernel.org>
References: <cover.1528921468.git.alifm@linux.ibm.com>
 <44ccc5db-e1d4-27b7-8942-c77f467f422e@linux.ibm.com>
 <0c5d7e42-e6c5-6aa2-8c1b-487c8cc9eb21@de.ibm.com>
 <20180619143230.zjemmhhz7embs2li@gondor.apana.org.au>
 <4301ac2e-a8f5-7432-cdd9-f39d30a9fb5e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4301ac2e-a8f5-7432-cdd9-f39d30a9fb5e@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 19 Jun 2018 15:30:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 19 Jun 2018 15:30:12 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:57:54AM -0400, Farhan Ali wrote:
> 
> 
> On 06/19/2018 10:32 AM, Herbert Xu wrote:
> > On Tue, Jun 19, 2018 at 04:08:05PM +0200, Christian Borntraeger wrote:
> > > On 06/19/2018 03:26 PM, Farhan Ali wrote:
> > > > A polite ping :)
> > > > 
> > > > If no one has any more comments/feedback then I would like to how to merge these patches to the mainline kernel tree.
> > > 
> > > I think it should go via Michael Tsirkin or Jason Wang (Adding Jason).
> > > Also adding Herbert Xu as FYI.
> > > 
> > > 
> > > I have not looked into the details of the patch, but I like the idea.
> > > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > 
> > Please post crypto patches to linux-crypto.
> > 
> > Thanks,
> > 
> 
> I have cc'ed linux-crypto folks. Sorry I missed them
> 
> Thanks
> Farhan

Yes but not just the header. you want to repost the whole
patchset.
