Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C071ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D6120852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D6120852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388372AbeGWS13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:27:29 -0400
Received: from smtprelay0228.hostedemail.com ([216.40.44.228]:53037 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387981AbeGWS12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:27:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C69E2180A8CAA;
        Mon, 23 Jul 2018 17:25:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fog93_679b315cee315
X-Filterd-Recvd-Size: 2928
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 23 Jul 2018 17:25:11 +0000 (UTC)
Message-ID: <e257bc89eb082e9fdc342d6f794c15a2805c98a9.camel@perches.com>
Subject: Re: [PATCH 05/11] touchscreen: elants: Use octal permissions
From:   Joe Perches <joe@perches.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dev-harsh1998 <harshitjain6751@gmail.com>, trivial@kernel.org,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 23 Jul 2018 10:25:10 -0700
In-Reply-To: <20180723171831.GC100814@dtor-ws>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
         <20180723131954.30739-4-harshitjain6751@gmail.com>
         <20180723133200.GA1167@kroah.com> <20180723171831.GC100814@dtor-ws>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-23 at 10:18 -0700, Dmitry Torokhov wrote:
> On Mon, Jul 23, 2018 at 03:32:00PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jul 23, 2018 at 06:49:20PM +0530, dev-harsh1998 wrote:
> > > WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> > > +static DEVICE_ATTR(iap_mode, S_IRUGO, show_iap_mode, NULL);
> > > 
> > > WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
> > > +static DEVICE_ATTR(update_fw, S_IWUSR, NULL, write_update_fw)
> > > 
> > > WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> > > +		.dattr = __ATTR(_field, S_IRUGO,			\
> > > 
> > > Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
> > 
> > This name doesn't match up with the From: line above :(
> > 
> > Please fix up and try again.
> 
> dtor@dtor-ws:~/kernel/linux-next$ git grep S_IRU | wc -l
> 7605
> 
> We either need to run a tree-wide script or leave this alone. FWIW I am
> perfectly fine with either octals or symbolic names so I do not see
> benefit of doing conversion for code that is not known to be broken.

About half of those are in one subsystem (drivers/hwmon)

$ git grep -w S_IRUGO | cut -f1,2 -d'/' | \
  sort | uniq -c | sort -rn | head -10 | cat -n
     1	   3846 drivers/hwmon
     2	    748 drivers/scsi
     3	    215 drivers/infiniband
     4	    168 drivers/usb
     5	    109 drivers/media
     6	    106 drivers/input
     7	    102 drivers/platform
     8	    101 drivers/misc
     9	    101 drivers/gpu
    10	     91 drivers/edac

The generic reason is octal is readable and S_<FOO> is unintelligible.

https://lkml.org/lkml/2016/8/2/1945

