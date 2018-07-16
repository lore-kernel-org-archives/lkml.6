Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35512ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD247208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YRkL0k2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD247208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeGPN5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:57:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42846 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeGPN5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:57:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id x12-v6so4292037ljj.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 06:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hFpfV/8/4t41JlmGRDi2sHBMmsdmb+M1XJbK8bqJVxI=;
        b=YRkL0k2o0G68TKhE03GPOSZ1Vx0EfmgAX5u+TbwOrP+DNr4MrOz+OVutJPeP7ORI27
         7DCj26GMXBA9oadDG8msiStPG5/PRw7LCpog3VWvzpupRcjwWusk9iFNIE1WIdE0VOCR
         SMrmHIqYUKU+AdhXkovFS/jI9LX57jYncmEYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hFpfV/8/4t41JlmGRDi2sHBMmsdmb+M1XJbK8bqJVxI=;
        b=CSeSdvRW99OSahPfoWj2YcpiirHUlUMNN/91iOKk0+pCLwWtuLGCP+vCB3WwWgPSev
         F0wfCPxPgUDaC/g+C416BDbZSRZmvyPfSk4CUh1H4HGYZekhK8wAArfp6ZqxhwkQqHQa
         IG2DFSBpnjEMBS8lGO4CYQ0cy7gQ5gK5+vHJbznfdJlD5ATlS5XbPmDpheZXGWMA3f67
         PzfBYFsZncjiTkiL07h/YYUFNGUh6KP0N4si0j4fN27EZR7GwL+SAHpB/pKaKVRzjsrO
         XJG6ktxmp8lnCH/gyUH5fiIb/uDqrPgew44/2imzY3xn7nsD8ZQ6Ewshs4MROAFAnaTf
         m9NA==
X-Gm-Message-State: AOUpUlHLjo/1YCGdq3a0vE/AOn/UwMtE6rcFvvCQOSL3ZONJ4e+T3R7C
        6AC5JUf4sLBHu7jwqh0Jdz0ykw==
X-Google-Smtp-Source: AAOMgpfBx7/X327NXmS3z7+19r/rgW7qId8EFRzCnmfRnz6b9x/zMt57h/Du78wt9n+brP4n75uStg==
X-Received: by 2002:a2e:9105:: with SMTP id m5-v6mr10053622ljg.121.1531747774697;
        Mon, 16 Jul 2018 06:29:34 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id p20-v6sm608966lji.13.2018.07.16.06.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 06:29:34 -0700 (PDT)
Date:   Mon, 16 Jul 2018 15:29:31 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] regulator: qcom_spmi: Fix warning Bad of_node_put()
Message-ID: <20180716132931.GA866@centauri.lan>
References: <20180716113525.9335-1-niklas.cassel@linaro.org>
 <20180716113525.9335-2-niklas.cassel@linaro.org>
 <20180716120134.GL10204@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716120134.GL10204@localhost>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 02:01:34PM +0200, Johan Hovold wrote:
> Hi Niklas,
> 
> On Mon, Jul 16, 2018 at 01:35:22PM +0200, Niklas Cassel wrote:
> > For of_find_node_by_name(), you typically pass what the previous call
> > returned. Therefore, of_find_node_by_name() increases the refcount of
> > the returned node, and decreases the refcount of the node passed as the
> > first argument.
> > 
> > However, in this case we don't pass what the previous call returned,
> > so we have to increase the refcount of the first argument to compensate.
> 
> I don't think this is the right fix. of_find_node_by_name() should
> generally not be used by drivers in the first place as it searches the
> entire tree and can end up matching an entirely unrelated node.
> 
> I haven't looked at the device-tree binding in question, but you
> probably want to use something like of_get_child_by_name() instead.
> 

Hello Johan,

of_find_node_by_name() will only search the whole tree if the
first argument is NULL, which isn't the case here.

However, of_get_child_by_name() is indeed better suited here.
Will send out a v2.

Thank you for your feedback, it is much appreciated :)

Kind regards,
Niklas
