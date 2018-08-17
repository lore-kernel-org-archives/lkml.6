Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6E6C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB6921A1C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjfQM5BO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB6921A1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeHQUwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:52:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbeHQUwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:52:18 -0400
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com [209.85.216.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 674A521A28;
        Fri, 17 Aug 2018 17:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534528080;
        bh=z/5ZXNrx3/HqKYWq60LZsUq86ZQ/t3YeMwxVJwm0pXA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XjfQM5BOb7INTZ7poHHVl1gHfPh+8AFiH1YGHXj22aZs19uLPOSzZK0nneewCl+HJ
         jM4ONfHE0RjsDkSRuW4sHS5mRBS2G5v1jcgl/H1JLJW7mPJyzqPjIoe2fiZI8rf4Tg
         yQ6MmnBssxvOjd3BfxmjK8PUrv1rU5Zha26ilGlI=
Received: by mail-qt0-f174.google.com with SMTP id n6-v6so9626803qtl.4;
        Fri, 17 Aug 2018 10:48:00 -0700 (PDT)
X-Gm-Message-State: AOUpUlGMOFnA1DZjqaFcjMfXfyJwNlXyB9aRzY9Xa2jx93jJuAio6PV5
        QFeBtKi5NKuW01gK2EeOgHusHsgVN73EKzCJxQ==
X-Google-Smtp-Source: AA+uWPxDBirz7aCXNQYezqBV9zey4a44bL4qEeeaOLJzrSZXSXuAmMB8AIBYSOqbvtQAMD6k6Wi7+B4OuKKky8lDsAE=
X-Received: by 2002:ac8:2c72:: with SMTP id e47-v6mr36502752qta.60.1534528079599;
 Fri, 17 Aug 2018 10:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <CADUUTHBZ---U7YNYYry7qJY=vt_QpXpytymqJQc9xLFE_NjsAg@mail.gmail.com>
 <c342562e-f915-a853-c2a8-eecefd94b88d@gmail.com>
In-Reply-To: <c342562e-f915-a853-c2a8-eecefd94b88d@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 17 Aug 2018 11:47:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLV5d5cL3o3Dx=--zGD37c5O09rL9AXyRFmceTfBHt3Zg@mail.gmail.com>
Message-ID: <CAL_JsqLV5d5cL3o3Dx=--zGD37c5O09rL9AXyRFmceTfBHt3Zg@mail.gmail.com>
Subject: Re: How delete node or property in overlayd dts?
To:     zbsdta@gmail.com, Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 7:26 PM Frank Rowand <frowand.list@gmail.com> wrote=
:
>
> On 08/14/18 07:46, =E5=BC=A0=E6=B3=A2 wrote:
> > /delete-node/ /delete-prop/ could be used in dtsi files without device
> > tree overlay.
> >
> > but with device tree overlay,  /delete-node/ and  /delete-prop/ are not=
 work.
> > How to delete property and node in overlay dts?
> >
> > for example,
> > in basel.dts have following node
> > node1 {
> >     property1;
> >     property3;
> >     node2 {
> >         property2;
> >     }
> > }
> >
> > in overlay.dts as following
> >  node1 {
> >     /delete-property/ property1;
> >     /delete-node/ node2;
> > }
> >
> > after overlay, property1 and node2 is not deleted.
> >
>
> The /delete-node/ and /delete-prop/ directives are only used by the
> dtc compiler within a single compilation.
>
> There is nothing in the format of a devicetree blob to represent the
> notion of deleting a property or a node.
>
> You can not delete a property or a node in an overlay dtb.

Though you can add/override 'status' with 'status =3D "disabled";' which
should be treated very similar to a node not being present. I say
similar because it's a source of bugs for the OS to fail to pay
attention to status property.

Rob
