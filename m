Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741CBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4395320659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="dl1Tod/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfANLnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:43:32 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44633 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfANLn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:43:29 -0500
Received: by mail-qt1-f194.google.com with SMTP id n32so26046169qte.11;
        Mon, 14 Jan 2019 03:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YSsm5KHK1vgCekTlZkLBW7Oe/copp0QlvQ1V9CXjt5o=;
        b=dl1Tod/+fmKMxz4fSs5uM5OM9EYe6up7FyBft3vlu7o6dlsBOasONH5bd4nc3hvSZl
         E5WQMXS2tLJKQ2lT5FUVS8T/vygn+OgEKcvdctm8G3V+cXd+LFDgdKSyHN9JnabIRRqN
         pQH2AL8bnVeS0u8feuE6mAnJEYTOYe4BiZwRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSsm5KHK1vgCekTlZkLBW7Oe/copp0QlvQ1V9CXjt5o=;
        b=GPcIaFriXCFOsT7URf/ECXtLTuEzfzsA0a+z8Vm3shEKs5bwJ+pdIEd+ElSfA7qoBG
         24LkMTnQ3PhZU2IDgYftdsz295K6UG0JQu3En8RJ0mKnSDNI6oQIwq5BOXnECNunGQiw
         j2NZb+xV/HzwI+70fOeFj0gp61qSH4nynq1+MvdcHiYDiIrsfdc+yFC+3VwsiKIYsdpF
         cDhx8B+ObzLpb0Ye+aHRajl976UNOiay2EU3n3KXxLrvOO82V1+C1hR5KFjfqIyj2qS6
         qBFYhqVRVaDOEzwzQCnUo0u9RC86wHyn5uIuTUqccvUUeLHevri3YQN2iS86OMbbPi6O
         OGsg==
X-Gm-Message-State: AJcUukfV+BB/x/aPLLHubdMnwJCJ7uZYNTqBo7/E4WeO/IDwcLVyLP2J
        g4zlmYyFW7vSc0hMcryd43kEgv2d16tPpUGUDQk=
X-Google-Smtp-Source: ALg8bN5msTpaMGdDNrcEC56t+z7OMLr65M73GRhD2on6tc5RQReecFM8zdmQ4xtnRFOpjFrk5SvU3HtNxMx0mTaG++o=
X-Received: by 2002:a0c:89b4:: with SMTP id 49mr23814949qvr.85.1547466207923;
 Mon, 14 Jan 2019 03:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20190107214136.5256-1-jae.hyun.yoo@linux.intel.com> <20190107214136.5256-10-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20190107214136.5256-10-jae.hyun.yoo@linux.intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 14 Jan 2019 22:13:17 +1030
Message-ID: <CACPK8XdK-VpV7y1UT81QUo7CXuUp=gjjnZmTbvLvRVERtv5fDA@mail.gmail.com>
Subject: Re: [PATCH v10 09/12] Documentation: hwmon: Add documents for PECI
 hwmon client drivers
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Wu Hao <hao.wu@intel.com>,
        Tomohiro Kusumi <kusumi.tomohiro@gmail.com>,
        "Bryant G . Ly" <bryantly@linux.vnet.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        David Kershner <david.kershner@unisys.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Johan Hovold <johan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 at 08:11, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit adds hwmon documents for PECI cputemp and dimmtemp drivers.
>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> Reviewed-by: James Feist <james.feist@linux.intel.com>
> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Joel Stanley <joel@jms.id.au>
