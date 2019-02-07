Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCB2C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8AF2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AMLmU1kw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfBGTri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:47:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36946 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfBGTri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:47:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so431366pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 11:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:in-reply-to:user-agent
         :subject:message-id:references:cc:from:date;
        bh=IRYtenou0nQZU/UrLSZo31LR0ze34XKDzqIcZlOhIjE=;
        b=AMLmU1kw+Rr5ZRun3SQwC0Hv7fbNirKNpTxbKl2XwX5Rh+49f2/jQyxyUp9F1O3D56
         6p5ubB0lwm+nBq5cgPddhXqvu7pHrK+eC9HApsa6Rm8wZUrNOhliRrGpMNcOxxJdWop6
         ZGS14pkBJfRM0YVf8+0S0rvG+GnkRTbqfK088=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to
         :in-reply-to:user-agent:subject:message-id:references:cc:from:date;
        bh=IRYtenou0nQZU/UrLSZo31LR0ze34XKDzqIcZlOhIjE=;
        b=fgu+Bgc4ECxcySJlym7U6k3Ace0nWTiwy6u/2Gg53n3uZk7EFu2gfRHAzDy4Tzh3gz
         3uOcECsn6ImRjPBzNYkrEQFT88QPzbR4KYwwyXjOkz7oHnvB4AAdMNSmZAgBL5M8IEZF
         5Y9zGKBtxmZyBtSdtCp9xf/lUyKoX1rSpu3Lu0bmn30dYUyvlZIHCjFhoJaGZfJtydOj
         HZ4+ipVVC8FrJZQd7GfbsKtE+iHTfP3/o1aS+SQfyX6+H6i517bwrIogXBWH0e7Yojxt
         YIYlEd4xsnIpP+O27TIy98wyVxILAfUV8Kvq0dF8xF/d96d++R3FT0yQVhjLtLDXzhu6
         5rcQ==
X-Gm-Message-State: AHQUAubSG9yfD/uwDvXGCa9q7JANORq2DHFlYMLguwPaQVlrNo1Ok3LX
        MdtSo+3eGk89mtX0c4+1fGcYHA==
X-Google-Smtp-Source: AHgI3IZEvPBOP2yMug1W4Z21u+jmRIB3hocEQAJUEwIIkqqqr3SIQVzHl8sFaQg7axKzVKLWvtgkLA==
X-Received: by 2002:a62:5182:: with SMTP id f124mr8024439pfb.238.1549568856381;
        Thu, 07 Feb 2019 11:47:36 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d13sm19679273pfd.58.2019.02.07.11.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 11:47:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <7af27aa5-3ff6-d4ee-1dc0-bac797c2bdbc@codeaurora.org>
User-Agent: alot/0.8
Subject: Re: [RFC/PATCH 0/5] DVFS in the OPP core
Message-ID: <154956885472.115909.8681514480591552850@swboyd.mtv.corp.google.com>
References: <20190129015547.213276-1-swboyd@chromium.org> <7af27aa5-3ff6-d4ee-1dc0-bac797c2bdbc@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Doug Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Thu, 07 Feb 2019 11:47:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-02-06 22:57:12)
>=20
> > 3) How do we handle devices that already have power-domains specified in
> > DT? The opp binding for required-opps doesn't let us specify the power
> > domain to target, instead it assumes that whatever power domain is
> > attached to a device is the one that OPP needs to use to change the
> > genpd performance state. Do we need a
> > dev_pm_opp_set_required_opps_name() or something to be explicit about
> > this? Can we have some way for the power domain that required-opps
> > correspond to be expressed in the OPP tables themselves?
>=20
> I was converting a few more drivers to use the proposed approach in this
> RFC, in order to identify all outstanding issues we need to deal with,
> and specifically for UFS, I end up with this exact scenario where UFS alr=
eady
> has an existing power domain (gdsc) and I need to add another one (rpmhpd=
) for
> setting the performance state.
>=20
> If I use dev_pm_opp_of_add_table() to add the opp table from DT, the opp
> layer assumes its the same device on which it can do a dev_pm_genpd_set_p=
erformance_state()
> with, however the device that's actually associated with the pm_domain wh=
en we
> have multiple power domains is infact the one (dummy) that we create when
> the driver makes a call to dev_pm_domain_attach_by_name/id().
>=20
> Any thoughts on whats a good way to handle this?
>=20

Ulf mentioned that we can use dev_pm_opp_set_genpd_virt_dev() for this.
Does that API work here?

