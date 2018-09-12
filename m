Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A2BC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C8020C0A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C8020C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeIMAYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:24:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728014AbeIMAYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:24:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3571380401CC;
        Wed, 12 Sep 2018 19:18:07 +0000 (UTC)
Received: from ovpn-112-71.rdu2.redhat.com (ovpn-112-71.rdu2.redhat.com [10.10.112.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EF26A9E74;
        Wed, 12 Sep 2018 19:18:06 +0000 (UTC)
Message-ID: <f3c647ec7c50ae390fb92861d492e7aa4bef8c6f.camel@redhat.com>
Subject: Re: [PATCH] option: Improve Quectel EP06 detection
From:   Dan Williams <dcbw@redhat.com>
To:     Lars Melin <larsm17@gmail.com>,
        Kristian Evensen <kristian.evensen@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 12 Sep 2018 14:18:05 -0500
In-Reply-To: <f2c15eef-ed8d-12c0-2ba4-3dc068ca9fd4@gmail.com>
References: <20180908125754.1947-1-kristian.evensen@gmail.com>
         <20180910103022.GR1089@localhost>
         <CAKfDRXiVbE3-eteTCZjEqyR0LaLMpN8t4P_ihzHPChse9=FxmQ@mail.gmail.com>
         <8ce10eef-f332-a1c0-e16e-fb1c2055131a@gmail.com>
         <CAKfDRXgTL6L27JLbbOLLsXd9KK8vBtVCjrTNpv6R_MYCJoZqPg@mail.gmail.com>
         <de1b5aa3-d9d6-da49-7e49-553694f5b666@gmail.com>
         <CAKfDRXi3QdB0qCvqHPFXpxdpiHSJ2WoSqZGgjD3gEzAaPbBPUQ@mail.gmail.com>
         <f2c15eef-ed8d-12c0-2ba4-3dc068ca9fd4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 19:18:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 19:18:07 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dcbw@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-13 at 01:25 +0700, Lars Melin wrote:
> On 9/12/2018 23:57, Kristian Evensen wrote:
> > On Wed, Sep 12, 2018 at 6:32 PM Lars Melin <larsm17@gmail.com>
> > wrote:
> > > You have chosen a platform which has limited usb resources and
> > > want to
> > > solve that problem by adjusting the device driver?
> > 
> > No, you asked for a good reason for why disabling and not just
> > ignoring an interface makes sense, and I think that supporting
> > multiple EP06 on platforms with limited endpoints qualifies as a
> > reason. My motivation behind this patch and modifying the driver,
> > is
> > to make the driver work with the different options/combinations
> > supported by the modem. The platforms I am working on merely
> > triggered
> > the error and inspired the change.
> > 
> > > Why don't you just unbind those interfaces which you are not
> > > using and
> > > which are eating up your usb resources?
> > 
> > As far as I know, unbinding interfaces from the driver does not
> > free
> > up the memory allocated to the interface by/on the USB controller.
> > I
> > also tried, just in case, and the output from lsusb is the same
> > regardless of bind/unbind.
> > 
> > Btw, the patch for the QMI driver has been accepted, since you
> > mentioned that driver earlier. So the assumption about interface
> > four
> > is removed from there.
> > 
> > BR,
> > Kristian
> > 
> 
> That the patch has qmi-wwan patch has been accepted does not change
> the 
> fact that you are solving your problems in the wrong end.
> You are using the OEM re-branding AT cmd to change the interface 
> composition without changing the vid and pid at the same time, this
> is a 
> big donut and the whole reason for why you have submitted patches
> which 
> shouldn't be needed.

The fact that the firmware implementation has the ability to change the
endpoints is unrelated to Kristian's case, and that alone is
justification for this to be quirked in the driver.  People other than
Kristian will undoubtedly use the functionality, on platforms less
limited.

Also most Huawei modems have the ability to change their layout and
configuration just like the EP06 via the U2DIAG and SETPORT commands.

Dan
