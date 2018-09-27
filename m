Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE46EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2A1204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSCTTCMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2A1204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeI1A7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:59:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38398 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeI1A7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:59:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so2516918pfh.5;
        Thu, 27 Sep 2018 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JgJ/2AD8ahhJBoPRdgoaFNwQcsiBN5OHnySxaJuuyC8=;
        b=SSCTTCMqbpy8AAQpqNJzXUx3ElEnJXSs5u9k9OxXZ1FsEDwGe2/zT5V18X83zYor+g
         4ndGoJeycGMORTirKAlkxO4Dsd779bCiG02CeqANk2tVOALX35G+BRpWWAp4UjmS6TV8
         s5Q6+NuAvwoVsM2X4HguM+Wp2qGfo3Jd4WYG+1Xfm1t8eqcWewu8pPoL6/JVYm0kqsIz
         kyLb6r+brQc9Ljt4DAjKZlorWZuM+oBJMvWlkcp3gcz+9USLEttW/64l+2NG5JXn4e0S
         D2i+FVk1813noJTgtI4tzgxeYT80LqzNsQJ+Vf4bkWmLXk8Tw9sNvUh/llXHWe1C+QmF
         RB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JgJ/2AD8ahhJBoPRdgoaFNwQcsiBN5OHnySxaJuuyC8=;
        b=lB6b98SoJaLoowRwaxPYj0hFwNP+w9j4XBCjsufWIJwBMz4IyDxgbCJgyoeH2pV1qi
         2IF/W5gMmcw2bRHhWwpALAL5ydPoc2RAAJ/ZB4keRbm4Y0LXv9fZeQCApEker18Z4xSA
         wR4PUW5DaFBXQ2vahPbmsfvt4GnJ9+uOFH5FlKbxnYP/KU0hHy8p6N0PfMGGEZpwUC3Q
         25MdxCgwTCGga4wB5B3fLbkpEy+BRxXhB8FAF23AlvcbZEr3KmcQyl8H0WEVtYwVG+IB
         qau6kg6xngd817JBCO78SOFbMvogdzO/BUIOHdbgFHb91c0UQOe5KIpFi7xmBs7wyLJs
         olYA==
X-Gm-Message-State: ABuFfojmbv3tcYDDQhKWLH2UAx+26SYwCJSbGTpgjjTS4rkeserpUFmz
        lQgr2lu4CmdXDHeJOgKcXN0gwneM
X-Google-Smtp-Source: ACcGV60iRrwOO9esztzdbAq9Fv+1bhF8eJD+ybDHy5yph1feJbYx/pqXilRNQ+RBYZPcpsxxrYECvw==
X-Received: by 2002:a63:441f:: with SMTP id r31-v6mr3300689pga.60.1538073598947;
        Thu, 27 Sep 2018 11:39:58 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id b14-v6sm4537215pfc.178.2018.09.27.11.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:39:58 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:39:56 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     jdelvare@suse.com, linux@roeck-us.net, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add ina3221 documentation
Message-ID: <20180927183955.GB15719@Asurada-Nvidia.nvidia.com>
References: <20180925225930.31886-1-nicoleotsuka@gmail.com>
 <20180925225930.31886-2-nicoleotsuka@gmail.com>
 <20180927174413.GB7587@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927174413.GB7587@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 12:44:13PM -0500, Rob Herring wrote:
> > +2) child nodes
> > +  Required properties:
> > +  - reg: Must be 0, 1 or 2, corresponding to IN1, IN2 or IN3 port of INA3221
> > +
> > +  Optional properties:
> > +  - label: Name of the input source
> > +  - shunt-resistor-micro-ohms: Shunt resistor value in micro-Ohm
> > +  - status: Should be "disabled" if no input source
> 
> Don't need to explicitly list status.

Will remove in v6.

> > +
> > +  Example:
> > +
> > +  input@0 {
> > +          reg = <0x0>;
> > +          status = "disabled";
> > +  };
> > +  input@1 {
> > +          reg = <0x1>;
> > +          shunt-resistor-micro-ohms = <5000>;
> > +  };
> > +  input@2 {
> > +          reg = <0x2>;
> > +          label = "VDD_5V";
> > +          shunt-resistor-micro-ohms = <5000>;
> > +  };
> 
> Please combine the examples into one complete example.

Will merge them in v6.

Thank you
Nicolin
