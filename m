Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2687C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A1920855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548172391;
	bh=5TRt5a8vGuulVfVN/ajvxNty4+eHnEDJIrtb0AHiUAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tBU3Vz9he++qzgee8J+S0ShUXKDC2zEc1n36vAFgN3diUJ4F3UwzmIxJzyX9XGflX
	 BJDfPLx4/V6YkMLSIQdNL7X7rk4gNgJkE0duQyvqWtUT4XMGpHgPDIKzHDn+gYtFnQ
	 6qbjM9L+Q+SZdk6+N5HAFVQ5LpmcybtMTFecSeXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfAVPxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:53:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32957 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbfAVPxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:53:09 -0500
Received: by mail-oi1-f196.google.com with SMTP id c206so17816545oib.0;
        Tue, 22 Jan 2019 07:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T+MZOlzVBNvzrjEW+vQjR5e7slyvkgsERe3f0FI8tME=;
        b=PSB3GA/gN8mxN2qN3wCT0chpJC7La4WKwXcmzZI4dveetzjOx/DykR+GJwm8dNBqBW
         filPwwkPso5I4XRN+ynMXm6mHS2Pw2+zrb2lCjJUZNdLkJV3kO4eJjl5Q/BVHJl5JiZC
         U9GCRLkXDHdTdfmkzL0SaC8OaiFg8mHdOb8Q8wbOXXo1dVBXqouvSfAQedh1AO8DT3lU
         epl3MqwYqJPxhuKP+Wa8yJEmEih1Mc7LkqiZZeFDLiCtNAA8eNzMpH71MoD9MyX3YioQ
         O4WbrHcklRiBNBQDlj53T7TMicnhh7QCRVn9hqCJ7zIEgcIBsLQa+lyhfzB5IX39hTAp
         Wl/w==
X-Gm-Message-State: AJcUukd3QCgWVz1pVzIx5Doxvc7VklAM4FH6hUiIHuIZcnVFx2SGUl+2
        SQtSLNMkWl0iQ2HKs0JXOhKTtbm1KWC4S4PL+WM=
X-Google-Smtp-Source: ALg8bN6DOrBCxmk/q131LZn9Ieik0UGABQdtsKVfF8zaWHgZsdN2LuyViiVi/Pfu3mY+nlqFjtVWSrsTSW36X1snvJI=
X-Received: by 2002:aca:195:: with SMTP id 143mr8204055oib.322.1548172388414;
 Tue, 22 Jan 2019 07:53:08 -0800 (PST)
MIME-Version: 1.0
References: <20190122152151.16139-4-gregkh@linuxfoundation.org>
 <CAJZ5v0jWvk+07vUx4=KOzw4mkz7yYjmoS+Uy8qixqmpW3o2mig@mail.gmail.com> <20190122154010.GA19652@kroah.com>
In-Reply-To: <20190122154010.GA19652@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jan 2019 16:52:56 +0100
Message-ID: <CAJZ5v0htb3Uv28rqwop_8eQPa6pE_1oOPbszL6B522UGfMGiDQ@mail.gmail.com>
Subject: Re: [PATCH] acpi: no need to check return value of debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Yangtao Li <tiny.windzz@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 4:40 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 22, 2019 at 04:28:42PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 22, 2019 at 4:27 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > When calling debugfs functions, there is no need to ever check the
> > > return value.  The function can work or not, but the code logic should
> > > never do something different based on this.
> > >
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Cc: Len Brown <lenb@kernel.org>
> > > Cc: Tony Luck <tony.luck@intel.com>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Yangtao Li <tiny.windzz@gmail.com>
> > > Cc: linux-acpi@vger.kernel.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Or do you want me to take this?
>
> It's up to you, I can take it, or you can, either is fine with me :)

OK, I'll take it in case there is a clash with a different patch or similar.
