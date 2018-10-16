Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3EEC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F1A208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F1A208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJPIXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:23:48 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:51370 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726914AbeJPIXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 04:23:47 -0400
Received: from mr4.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w9G0a5Vg009344
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 20:36:05 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w9G0a03b015674
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 20:36:05 -0400
Received: by mail-qt1-f199.google.com with SMTP id m1-v6so22622019qtb.18
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 17:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=v1f0bhPGF3wayMa5ufWuWVG1e0ox4szMoy4YrsmPrOo=;
        b=aH33P8ZgJilD6be+Zrjk4Zev+kSDhMlvcDcAJ8SHaRv8grzw/zsPmjT8qBDVuCcpbb
         W8cNxUQKiynnTpAkgYN/8lmLNv9pd6i1hwDyWynoOUBoxjJB/K+FGbIPntv4WxKbu/AC
         YYxbPMorgUIjOODQPFJvCaHe2l4vkX1NX+FnD7dBQkS/4tInze7XVDgx9Y5/Oya1aMdi
         3MVuLW9MLXhx7UFuF6fZBlWmcpcwHrNfowKAT6p2desjF/X2BtS0TZfVBGrhsX8x4L3R
         pQ0m5zK3sfdAV1Ly2rCeNNKgFEfEjTXDDqJSQocCXwJ1ve+Wa9Pl0Tno7oII5oURUWWK
         e9bA==
X-Gm-Message-State: ABuFfohl2yJz5U7ow05cws6NZeGToVyj9VmVdCXTDRGU8DYz5cbOwyyJ
        byFrMjQ/hpUv0FUU+blHF2hVMsRWxvGuoKKkoZo2TU/Fyxas+MLUyU9UgPtOjlvu/IYbgx01ryD
        p+4YZ2p1wq5fLZ9YA36muCHAwOIqyCgIek6o=
X-Received: by 2002:ac8:2278:: with SMTP id p53-v6mr18699048qtp.200.1539650160317;
        Mon, 15 Oct 2018 17:36:00 -0700 (PDT)
X-Google-Smtp-Source: ACcGV631rNyCeC3uIlG8m00pF/jZR335xYl1k3uzNss3CfUKx5ty5A4hUboMYpsvvNP2P9d2frV9Bw==
X-Received: by 2002:ac8:2278:: with SMTP id p53-v6mr18699033qtp.200.1539650160025;
        Mon, 15 Oct 2018 17:36:00 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2607:b400:24:0:3d3c:680f:afbc:c585])
        by smtp.gmail.com with ESMTPSA id n67-v6sm11387281qkh.66.2018.10.15.17.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 17:35:58 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     frowand.list@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH v2] of: overlay: user space synchronization
In-Reply-To: <1539649621-5518-1-git-send-email-frowand.list@gmail.com>
References: <1539649621-5518-1-git-send-email-frowand.list@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1539650157_2195P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Oct 2018 20:35:58 -0400
Message-ID: <5408.1539650158@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1539650157_2195P
Content-Type: text/plain; charset=us-ascii

On Mon, 15 Oct 2018 17:27:01 -0700, frowand.list@gmail.com said:
> From: Frank Rowand <frank.rowand@sony.com>
>
> When an overlay is applied or removed, the live devicetree visible in
> /proc/device-tree/, aka /sys/firmware/devicetree/base/, reflects the
> changes.  There is no method for user space to determine whether the
> live devicetree was modified by overlay actions.
>
> Provide a sysfs file, /sys/firmware/devicetree/tree_version,  to allow
> user space to determine if the live devicetree has remained unchanged
> while a series of one or more accesses of /proc/device-tree/ occur.
>
> The use of both dynamic devicetree modifications and overlay apply and
> removal are not supported during the same boot cycle.  Thus non-overlay
> dynamic modifications are not reflected in the value of tree_version.

Is there an easy way from userspace to detect "yes/no dynamic modifications
have been done since boot"?

--==_Exmh_1539650157_2195P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW8UybY0DS38y7CIcAQJaRAf+Il4+gH+j2Zi4KTT3qxKMlNjnKbA+UubA
BHOBGqTG9rD6GOTbR/0Cz2E/yXScYkcG+pmO2+DvhJgkYmAmpGr+epkIjmRBECBx
tA4fHPxH4mKcb09PrlqyjcmAfoRffGcfTkY2yAR9fSkwk9Kk7hOchiqIpE7YkUCR
KN6xkn6pX9xsA1iG7Xuk+L1SSupm4DounP/8km8Bml31ebL/uVMjSKI6+PllM3RN
ScxOHbW6vCy/9Z1F/ZUT0sOovBPl2GSZNyA6L6rbvdmaubVZIR2Yh9DunRIV45Gu
F+B3kWZ56baPpStLDKXr7BhPYv+SctGxyYMsJZgekKONdzqwd7Gy4A==
=AWoN
-----END PGP SIGNATURE-----

--==_Exmh_1539650157_2195P--
