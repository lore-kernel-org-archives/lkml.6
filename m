Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB157C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30372148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5JhvJU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30372148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeIXQGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:06:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52537 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeIXQGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:06:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id l7-v6so4224445wme.2;
        Mon, 24 Sep 2018 03:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gIJcpWbHbNHTaa5JmRfvZAm8Urcwd2xDE3D7bIusbZ4=;
        b=m5JhvJU44sH8y7ioLcm/3FlbGeqqL9Uz74iGgbsi8yl0RtAPswIe5QnTzEHCRR4QdB
         QlKwsNuWa1Ez5g/3jsmFVbBkZO8694iP3lpkB+2FQtdnVoN9USIJS4RTTA61U8BGjssC
         z3q5ImJPcioHIPJoxOV8dq20rkn1jskK5Um0qL1wQChrdQJv2oqmzSXPZYwH0mH9++b6
         2/FwdejQtEkViyz4YH+3Tgqqc8vTEuctjWJVB8yBc+6u2s2eD+w77gh+obRmDaXm3GEG
         /AN6za7OCx+Up2euvwelpWXmXzKIWlPKzX5o71Wz8bmDlDVR8APBFpjKBYMSEiIm991o
         4HJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gIJcpWbHbNHTaa5JmRfvZAm8Urcwd2xDE3D7bIusbZ4=;
        b=asAxicloh33Ej9YDa+IDMlEuhMM1qLCQOd7JX7bRWzMSSFLFQ0Ap5uDutFCE2fnmgl
         SEbyJjsdIFbmTiZhIflUE5iEss8j9m/o7l3lBTnKgJ52r0VAU2ERQo9WQirBiN+y+B5d
         eQb0PqQJGTYOAqQwIqs13yvTAjZCtz2JZu197ilelDVrrQG2JDhVuTawDb82jMsf6bEf
         k8NuDbRfikZdwMwQ73PWAYBKZWdPioB6iJDpSIgTRw8ypHsn35NrYOIwIr+DeVJq/JoP
         8HFRknd/oLw/o70OppDiasS0ei8CV3Lfs9maOmROlo9ADd37IlQT+hnCvpB3Lw+2zh5N
         0d2A==
X-Gm-Message-State: ABuFfoiN4Fcf9APnqwNfVMEIlfTkQjK2sV+DXiOAio+qX03HEqhLA7bw
        TprkDd3GCkI9dceKx7bK+cU=
X-Google-Smtp-Source: ACcGV61qWEs8AicWtT+envh7XYE2S9+zSiKAoL94O92PtgvZX+RCc22o9ss68C4j0/M5OZuc7dYtPQ==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26-v6mr6594100wmh.61.1537783527252;
        Mon, 24 Sep 2018 03:05:27 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id 132-v6sm10926732wmd.13.2018.09.24.03.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 03:05:26 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:05:25 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/20] iommu/tegra: gart: Ignore devices without IOMMU
 phandle in DT
Message-ID: <20180924100525.GE21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-4-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 24, 2018 at 03:41:36AM +0300, Dmitry Osipenko wrote:
> GART can't handle all devices, hence ignore devices that aren't related
> to GART. IOMMU phandle must be explicitly assign to devices in the device
> tree.

I think technically the GART can indeed handle all devices since it is
just a physical address region that can be used to remap other physical
addresses. That's not to say that doing so would be a good idea. So the
commit message here is slightly confusing, but other than that the idea
is good, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluotuUACgkQ3SOs138+
s6FALBAAihy4Koa8dQIhpVPATIDDQsyRjFl4jqvkGh5jHGBULZGdXN8uUyzuMj7/
5aOiJQ/HgbzR+U/eX/rwOLMQmcr6aLYw2TqwcpwcERhOvDyQNRI8U9PtTIAxcuhO
DFqTwYCX+aZGy2MCfF+P9hl3MKweAXFCqvj+ckBh1GIGkU5lqYM8r1sgfz/mB/xc
QDcODaJcIYy/umpDO5ADZK+Q9A6KC/ZGY6xdS4BppKlasG8wKGG6nC0PbiSKhpby
mjeIRFo2XULhp7/+0Nqj2V5gGDUcu+yRe2lKKMzmELeaIJ7LgxkD3uva4mQ4nxFK
mx/kuCeSZrvxWiV12whALZ0c2znYamDXzlLHb9orgEsV4zrb6OhBAh5LK733AQ/e
+5FpejQ+Tna8pWVzRDTkvx2GAeYS+EdmDXjZT+OLGVk2DvAPfx1ORFKIGaWrisZQ
B/yASM3fEXX4/fpQaz6WN6XLUtZu4SWRJR5QIF+E5t6jAPhBVHyaD6ItNGb+Vbpm
KoEHJfg4eIFwlN5r6aSV/UVS9Ik014fxUu5DtPr3U5+7jLcL6N7/rhYuF1fE01yv
A1B6bjK9NeCwo4qgUiU+xKHR/2VBw9OaL06qYakzz0K6XADzDbyBYsolqU/TdbMG
/NI2DduseQE3DzaSuvREtm3fQbJN4s/tbdcTW/VGygIvHL+RTU0=
=Cw72
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
