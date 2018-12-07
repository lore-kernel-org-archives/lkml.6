Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE58C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED942064D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="zxAgPn9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED942064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbeLGEHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 23:07:18 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37230 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGEHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 23:07:18 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so2616573edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 20:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qI7HHVDqLno9wThC+EyiFNns6HMZLY6TPLgWZKhh/ME=;
        b=zxAgPn9Sjt7KAzYzIXtNZgZjzBjje5SKEe55XbW3KFTnjl2bkFripP/gLV1vrOq8SF
         SoKVyq5W9G/TUhGa2NXFMBwUXX0XrEE+Jb7deC8Sf78ulx9jXCrw6sxdE+XhROYEIKrD
         dV78/YQf0hrnXeOGVNCiEI0JzL1ydvcmTSvRQc11Qf+qykAQM6J0rLh3AIBoR/2Q/mAy
         6s/ldeK+mXzM3hobzvCNuNgmhj1HMMAvfjJLyaPLlD0qs6TqPqjF9qemBBS1LGUewHy6
         P+K/YEpPEDjHAiMSAdwkZ/eVRv/QTopPHBzAdMaretVwd+M7Nc/iBzejwDCRZdxvX4fj
         iJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qI7HHVDqLno9wThC+EyiFNns6HMZLY6TPLgWZKhh/ME=;
        b=m4a9oNHP1/ZDYOe4FtQBryjcm7wWwZNNfneIGBVxgHhcDeUyNAkePa7J7IBA8sVctS
         G/OMwT33lY/clbyN/auZXYgaNhlXV7SMt/VIYMYdhQe9EqfslXJdvWYZZ8JUyW/1+u/R
         Npha2p5j+fxgIrgyFcSA5K6sUmVrL+qZBGnfEZoyRsjQsbL3Yo8gMayzz3eAQ42TRsX+
         DaNTJF/y4FTep7HpvVi396LOPnR5hmZtR+crI1lcobDMqNOLlIyG8RKFzp5Msh8keedP
         HwafT20q4eRitKEGxMagYSoA7geUdOi2qAKS72BIJspz9yAM9hCUcpybwBPwSL3Z/e82
         oUXQ==
X-Gm-Message-State: AA+aEWYX/49MEPgDHhQm31P1fvGeWGINXLhK3Kp5uAgOr/dSrXnwycJg
        gRVdac+WAvTF4nG61BcU3KDlvX4Bpu4Npuwb07lM9g==
X-Google-Smtp-Source: AFSGD/WVl3vHUeGA2Npb1Xg5vUZjzsvEPBpUVYbt0MJ2aV33NVtJ8FHGAE5WVF3alaZWdBNr1jkmYzX9VRjgWXQTj8M=
X-Received: by 2002:aa7:d29a:: with SMTP id w26mr827531edq.30.1544155636170;
 Thu, 06 Dec 2018 20:07:16 -0800 (PST)
MIME-Version: 1.0
References: <20181130064617.67920-1-chiu@endlessm.com> <CAO-hwJKAnHqPi7aOGqKET+_JKnXmvdwOyhtH4nLeqS+-K8597Q@mail.gmail.com>
 <CAB4CAwfOBuAutaQdObyfrOg5Yo2M9NJGww1Ffc7o2YrAYDObEA@mail.gmail.com>
In-Reply-To: <CAB4CAwfOBuAutaQdObyfrOg5Yo2M9NJGww1Ffc7o2YrAYDObEA@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Fri, 7 Dec 2018 12:07:10 +0800
Message-ID: <CAB4CAwf34ZvF88rVCz2H6iDKoDHF09txp1oGqvUfCt18ZH-w6w@mail.gmail.com>
Subject: Re: [PATCH] HID: input: support Microsoft wireless radio control hotkey
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, rydberg@bitmath.org,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 8:56 AM Chris Chiu <chiu@endlessm.com> wrote:
>
> On Fri, Nov 30, 2018 at 7:18 PM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > On Fri, Nov 30, 2018 at 7:46 AM Chris Chiu <chiu@endlessm.com> wrote:
> > >
> > > The ASUS laptops start to support the airplane mode radio management
> > > to replace the original machanism of airplane mode toggle hotkey.
> > > On the ASUS P5440FF, it presents as a HID device connecting via
> > > I2C, name i2c-AMPD0001. When pressing hotkey, the Embedded Controller
> > > send hid report up via I2C and switch the airplane mode indicator
> > > LED based on the status.
> > >
> > > However, it's not working because it fails to be identified as a
> > > hidinput device. It fails in hidinput_connect() due to the macro
> > > IS_INPUT_APPLICATION doesn't identify HID_GD_WIRELESS_RADIO_CTLS
> > > as a legit application code.
> > >
> > > It's easy to add the HID I2C vendor and product id to the quirk
> > > list and apply HID_QUIRK_HIDINPUT_FORCE to make it work. But it
> > > can be more generic to support such kind of application on PC.
> >
> > Sounds good, but while you are at it, can you please:
> > - fix the kbuild warning
> > - rewrite the whole line to use macros,
> > - make the macro prettier by inserting new lines were required
> > - and define the missing macro:
> >   0x000d0006 -> HID_DG_WHITEBOARD
> >
> > Maybe we should keep the ranges definitions with raw values and put a
> > comment on the side with the names.
> >
> > Cheers,
> > Benjamin
> >
>
> Hi Bejamin,
>     Thanks for your comment, I've submitted other patches which may
> fulfill your suggestion.
> https://lore.kernel.org/patchwork/patch/1020373/
> https://lore.kernel.org/patchwork/patch/1020374/
>
>      Please help me review and correct me if there's any modification
> required. Thanks & Regards.
>
> Chris
>

Gentle ping. Any comment for the new patch? Thanks and Regards.

Chris

> > >
> > > Signed-off-by: Chris Chiu <chiu@endlessm.com>
> > > ---
> > >  include/linux/hid.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > > index d44a78362942..f4805f605fed 100644
> > > --- a/include/linux/hid.h
> > > +++ b/include/linux/hid.h
> > > @@ -836,7 +836,7 @@ static inline bool hid_is_using_ll_driver(struct hid_device *hdev,
> > >
> > >  /* Applications from HID Usage Tables 4/8/99 Version 1.1 */
> > >  /* We ignore a few input applications that are not widely used */
> > > -#define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || (a == 0x00010080) || (a == 0x000c0001) || ((a >= 0x000d0002) && (a <= 0x000d0006)))
> > > +#define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || (a == 0x00010080) || || (a == 0x0001000c) || (a == 0x000c0001) || ((a >= 0x000d0002) && (a <= 0x000d0006)))
> > >
> > >  /* HID core API */
> > >
> > > --
> > > 2.11.0
> > >
