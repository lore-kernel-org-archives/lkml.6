Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A435EC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503E821724
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGvFtKdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503E821724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbeHMVGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:06:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36528 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbeHMVGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:06:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so15101277wro.3;
        Mon, 13 Aug 2018 11:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t1EWdJsUOMOEJwYwVexNbjxKB94H/MqM/MMsJuCPcqM=;
        b=XGvFtKdAwWDTgmX5Rs2FL9FiPJ7Nj3aRjTv30Ne8NIhudGdDHTEHodHJANK45tHwBh
         RSfgRDt4Pg9MX4SpdiHhl6LOdtN29oPZ6fOJJe6mCuBXHzmEtzblns4KVzxQTS2Z3WnQ
         fhwTeJa08mIw6/0DXtGW8aW4nT1Gp/EvaKjqZSsTbEjcN47QQiOviagHBRR0zG24Ho8O
         yu7PomKNtKk2ye1k072uym2huXUU2PddvGxa6/tqaOO8uK5HCwwErQRiWIkWtos/MBDZ
         3bLYR1Q7aS5zuBMcogBkaMVnXcKufwGpnE+JfEgVU9wjxeRSNCpsEqyl7+iZtCU7YfS9
         LD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=t1EWdJsUOMOEJwYwVexNbjxKB94H/MqM/MMsJuCPcqM=;
        b=E+Ne3w30RXE5ZpJK26FIb1Mhci58fRqtdCVL9+i4khgd35cvYRbIQmEh3rCCHniHw3
         bpcpMOdo1Gtt6V8myqjsGHqtPu0ldHXaLV3dRtM5MnrnnJAdEwuw4023LO20lsZ01fuN
         RGR5jRghRusbAtoeStwt3SI16K00r2hLR7IlyVyU/8A7/uLRsJrbiDWZPdWKomEDabkk
         5eXbhT3s8P1ydawyMPymYow0mhT9RjA/3U1++MjQOV0VqOTmPHMlzO36aAXyJxF0H6Wo
         cKnHhKqhtY1vzxS/dKkhWneJHlg7xPXklfEgSMeGJfRmg6Oojz34a3B85y8Y+srDUJMA
         ZeMA==
X-Gm-Message-State: AOUpUlHnaLHp/jkVh0yjrO73cp/namCY7c+jw2EnSdyuSDUCk6cbKKUf
        iRX1NtvpMF5lGnspOyvwdTY=
X-Google-Smtp-Source: AA+uWPwrmtGNLu2kIWoXjH5vcMEHqorgOcLXa5dRhd+XmC1t8Yc3U7aovV5NFDweSydSXnV7mc4iYg==
X-Received: by 2002:a5d:6550:: with SMTP id z16-v6mr10992539wrv.194.1534184572049;
        Mon, 13 Aug 2018 11:22:52 -0700 (PDT)
Received: from terrence.localdomain (cpc96818-rdng27-2-0-cust102.15-3.cable.virginm.net. [86.30.200.103])
        by smtp.gmail.com with ESMTPSA id a9-v6sm21875781wrp.55.2018.08.13.11.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 11:22:50 -0700 (PDT)
From:   thomas.m.a.todd@gmail.com
X-Google-Original-From: tom@terrence.localdomain
Date:   Mon, 13 Aug 2018 19:22:36 +0100
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Tom Todd <thomas.m.a.todd@gmail.com>, joe@perches.com,
        stern@rowland.harvard.edu, dan.carpenter@oracle.com,
        arvind.yadav.cs@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: core: devio: Restructured proc_ioctl for
 readability
Message-ID: <20180813182236.GA6582@terrence.localdomain>
Reply-To: 20180813063455.GA29496@kroah.com
References: <10f9f13a5421299a6efda1e1f84ab304ef18ddec.camel@perches.com>
 <20180812222653.3341-1-thomas.m.a.todd@gmail.com>
 <20180813063455.GA29496@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813063455.GA29496@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 08:34:55AM +0200, Greg KH wrote:
> On Sun, Aug 12, 2018 at 11:26:54PM +0100, Tom Todd wrote:
> > On, Sun, 12 Aug 2018 11:34:59 -0700 Joe Perches wrote:
> > >On Sun, 2018-08-12 at 19:06 +0100, Tom Todd wrote:
> > >> Fixed a code styling issue
> > >while it's OK to fix style only issues, it's much better
> > >to reorganize the code for reader clarity.
> > 
> > Ok, thank you, I've taken your suggestions and created the a new version
> > 
> > Restructured method proc_ioctl for readability and fixed code style
> > errors.
> 
> Please always be very specific as to exactly what code style issues you
> are fixing.  And never do more than one type of fix at a time, otherwise
> it is hard to review, and you can cause errors to be added, like you did
> here :(
> 
> Please do not start working on code cleanups in any other area of the
> kernel other than drivers/staging/ as that is what that is for.  To do
> so in other areas of the kernel causes more work for maintainers.
> 
> thanks,
> 
> greg k-h
Understood, sorry for the bother caused.

Regards,

Tom Todd
