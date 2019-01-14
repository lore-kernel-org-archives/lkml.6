Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3FCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079BF20660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="mF+vHs/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfANFfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 00:35:06 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40742 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfANFfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 00:35:06 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so9896231qki.7;
        Sun, 13 Jan 2019 21:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oaJnHgqxNLSmOeClaph1+naF1VsLXybulRXguvYvNko=;
        b=mF+vHs/b3gwFu7b+oacGUylpLkfQjRl4AkOOn9YE+Ca0J2kUHAA2XghIU9VX7cS51e
         7ElDMIIp1YUBbADVHsVA9wtvPn6uh8/H5yYo3Fu/KUpQ4RFxQRJ+Jjt///QGsfJEIb/r
         gd3HsN0UHLCo9RrpQlz/nmQmEwmenbkWtr58M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oaJnHgqxNLSmOeClaph1+naF1VsLXybulRXguvYvNko=;
        b=tjxz2sBQp2yymGXmhmlwofHD/eWtsYir3PsVieqnDH+WsJnoKr6QCUQOld3FjhPnaR
         kG/N6KcyhDo6Kj9a4/+w1PCZFf1QftPutU56EcLUNZXv8ijMtItnBNeLy/6tDpKe/0W4
         bUt2VpoEqIuwVDJxUkEuy08SH5B7VAyUMXfyZIvpN1LHhGKNXA/aNo9AkxPNjww57w+8
         BfunpK3ofgnuV4Ltm7bKppLFLJlskpLvacBC1cZNIyMOs8N9aKYS0XWStRx23xxjDyg4
         2amdS31YmMdP2pVyaOGdpIEVDiKAwz7HEyDezAL7IFNIun2HmsTxoyA5w56z37EB2Myg
         vVwg==
X-Gm-Message-State: AJcUukfUx1mnswZvVeHa0e4cfThp0hgCM7R72KPOd62JUf5Wt3/u0oig
        H5swSHmipRD//OV4KHpgJofK1CTb2QpecpaeLXY=
X-Google-Smtp-Source: ALg8bN7AotucbzagLEkUA9bBE23ZmB2lHcesb2pNRdmv6h/jGw9Q/hiKytIE4a0Gk3hlE5Rft3IETb54XrNZ+PQ4h7U=
X-Received: by 2002:ae9:dec5:: with SMTP id s188mr21107671qkf.127.1547444104492;
 Sun, 13 Jan 2019 21:35:04 -0800 (PST)
MIME-Version: 1.0
References: <20190107214136.5256-1-jae.hyun.yoo@linux.intel.com> <20190107214136.5256-2-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20190107214136.5256-2-jae.hyun.yoo@linux.intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 14 Jan 2019 16:04:53 +1030
Message-ID: <CACPK8Xe5H31M=U3JQQaOheoopFZQtS0ZegaGRx4Pmw7Ym9g5YQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/12] dt-bindings: Add a document of PECI subsystem
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
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 at 08:11, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit adds a document of generic PECI bus, adapter and client
> driver.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> Reviewed-by: James Feist <james.feist@linux.intel.com>
> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
