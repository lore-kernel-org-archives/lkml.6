Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4E5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C00F206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="bsTB5nOR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WDcCgd9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C00F206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeKTUYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:24:45 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:39297 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727249AbeKTUYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:24:45 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id A7887D788;
        Tue, 20 Nov 2018 04:56:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 20 Nov 2018 04:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=n
        bWnkEijxnVuoczF3DhO7GQSWMhfSVDFfZoB2RfJOWc=; b=bsTB5nORkE8Sjx7BS
        VCjYWKqVbWvRNHG+m73IJNt3ak9GDSCFFNvdAmCFsXcFdCqC+Obrbs+3PHdYf8S3
        yyzvQQ+L9m2wWXxI1N8Tryd2PpqfyyXrGBhCvypq2g1bK7QZSMM84I66vS0laSt5
        3QT6qao6VBZ4/r6q6OyAlS6itvEINeFcCNhWSjG4mgxiasE9RpP0J0bAs0Zyi4MR
        gcaMaSTrBKxCx3UKkUbg1RJUBqWn3ue5FBIW3MsjUciLfIfTUSu5yecxev9Ul10a
        1/C3Vt+PmcntSWdX08ZX0u4Gkfiguz9mFQmR29L8YnSTwVzvcCeF0vcxVT5L50En
        HaQTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=nbWnkEijxnVuoczF3DhO7GQSWMhfSVDFfZoB2RfJO
        Wc=; b=WDcCgd9AjAH3onsO2rAbEyzE2R9QwnuqYF4+DvRI1peUi4rxBrcsE/EWA
        DMBFJTlUbLNSjyZDD7FQYVEYEDKfkaNwz14YQ784Dm438weHNxEj53/foL6yojGq
        RlexbYKJAsoqPxmc0cTbYwfuz5g0yhjSw3EVXto0CJJML+EAI0iP+rn45+R0zxuC
        g8yKPilnwfUDZ+Yb+8gwr75KUhuh3eOjVBBTf67ts38KognnQYu4qgRKxR+58WYI
        Auzmj/VHR+8ZdFuO1702soiGhHinQVh0bI2SlJ85PmJ+XgY/0SzJh04MuO7pgkMh
        nR/PLSTAvpqTksoM48NoEps3GCUNg==
X-ME-Sender: <xms:StrzW3n0yuy-4SXA4-QPwJrPHwl_uEB4DbTEGhSm_9QUnvN0yL4pjg>
X-ME-Proxy: <xmx:StrzW270b8LIXCeZDI3C9wQsdwndtMm63_RQ4q3Ui9vc5_bhAkpSVw>
    <xmx:StrzW7SmdtOQd9A6q-5uekVJhucMfZL2uxd_1qdmNfDBpQG9Cp600w>
    <xmx:StrzW45k6Aj946HmCck9TOjhPvQ76X8Ow-zBYSKddBKowtopibs5Ug>
    <xmx:StrzW-4TxI0aYPaj4O4GUj9WugcmrF853cF8WKHW0NvyIkG3qnc2HA>
    <xmx:StrzWyWbRWNSlgkWTWITe2RoPFq_aGkjPFFTFlau-qTfb0jv45_dGw>
    <xmx:S9rzW-kokmM6-RsFyEYP4e8MO4zYUYlYKkxv5g1fX2nuau7F-dqVyA>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7968EE482E;
        Tue, 20 Nov 2018 04:56:26 -0500 (EST)
Date:   Tue, 20 Nov 2018 10:56:25 +0100
From:   Greg Kroah-Hartman <greg@kroah.com>
To:     wahahab <wahahab11@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        ghartman@google.com, astrachan@google.com,
        linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v3] driver-staging: vsoc.c: Add sysfs support for
 examining the permissions of regions.
Message-ID: <20181120095625.GA17738@kroah.com>
References: <20181107023043.GA18052@ubuntu>
 <20181109171558.GA8323@unbuntlaptop>
 <6ADC007E-85BB-4CA1-89FB-9254937E8C63@gmail.com>
 <20181112124049.GA2408@kroah.com>
 <C815584A-8542-4491-A7C4-CF0274C00792@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C815584A-8542-4491-A7C4-CF0274C00792@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 11:32:51AM +0800, wahahab wrote:
> 
> > On 12 Nov 2018, at 8:40 PM, Greg Kroah-Hartman <greg@kroah.com> wrote:
> > 
> > On Mon, Nov 12, 2018 at 04:49:30PM +0800, wahahab wrote:
> >> 
> >>> On 10 Nov 2018, at 1:15 AM, Dan Carpenter <dan.carpenter@oracle.com <mailto:dan.carpenter@oracle.com>> wrote:
> >>> 
> >>> On Wed, Nov 07, 2018 at 10:30:43AM +0800, Jerry Lin wrote:
> >>>> Add a attribute called permissions under vsoc device node for examining
> >>>> current granted permissions in vsoc_device.
> >>>> 
> >>>> This file will display permissions in following format:
> >>>> begin_offset  end_offset  owner_offset  owned_value
> >>>>          %x          %x            %x           %x
> >>>> 
> >>> 
> >>> (I'm not totally an expert on sysfs rules).
> >>> 
> >>> Sysfs are supposed to be one value per file, so instead of doing this
> >>> you would create a directory with four files like
> >>> vsoc_device/begin_offset vsoc_device/end_offset etc.  And each would
> >>> just hae a %x output.
> >> 
> >> Thanks for your advice. I have started with this approach.
> >> 
> >> But when I trying to create this kind of sysfs hierarchy. I encountered the difficulties of file organizing.
> >> 
> >> My current thought is to create a folder under the device node called permissions and user can examine
> >> permission though file path like vsoc_device/permissions/permission1/begin_offset. But there comes a
> >> problem that it seems hard to determine the correct index of permission to make folder name unique.
> >> 
> >> The solution I come up with is to use memory address of permission node to be the index of permission.
> >> So the path will be something like vsoc_device/permissions/0x4d23f/begin_offset.
> >> Is this OK for sysfs?
> > 
> > Ick, that is messy.  What exactly are you trying to export and why use
> > sysfs?  Is this just debugging information?  Who is going to use this
> > data?
> 
> I felt that exporting these information in sysfs will add lots of complexities in this driver.
> And I’m not sure these informations are for user space or just for debugging.
> 
> It seems there is a conflict of TODO messages between TODO file and the
> comment in vsoc.c.
> 
> Should I use debugfs first for this patch?

If it is for debugging, yes.  As I have no idea what this code is doing,
or what wants that information, it is hard to determine, sorry.

good luck!

greg k-h
