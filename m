Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498E2C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F87206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7PaG/eG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F87206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732051AbeG0CRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 22:17:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43586 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731858AbeG0CRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 22:17:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id v13-v6so2174164pgr.10;
        Thu, 26 Jul 2018 17:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+uGrsLnOsXNMCg0gf6djvExHcNX5MV1mJce73DTFq/g=;
        b=h7PaG/eGlizqUCQxqfgBsX2Wu86cxCTpTQMgqOuhhou3VLyApc2k0ZLloN1x36tEiW
         Nnv1YuNSluRJR3dJNw4HGq0uYhJCeQRQJUKKk9IgaXXhvu+kVXVIYdQLMGwMXEIWN/k8
         wO8hm0bSUi0DmIj8oOj4izYOePIckjOmKslhTCpEZOn5/y/gZiSDVY6oggL9eHtChDLR
         3eScbxH1sTW3LheZKJRVdlXk9vR86OyxBCV1dK1C0tx0mfcviR6jXxxIbhNJXiCcZ/vq
         wvVbBlakQ+SgCWPI6Jgt13bsY9vYWGXUQe8dSWZtkUIgcHSdrbLHBUSec6ILnA3Vvv96
         lsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+uGrsLnOsXNMCg0gf6djvExHcNX5MV1mJce73DTFq/g=;
        b=Bplr1mw5v+h5Gjuk+IWKY6wv89/r8hET61+pB/9XM4LGlHUb1+ioJ5R0DuDp2q8seb
         2n+glO5+kn9T1Rh/kZt5bt/WDtm4PBug7Miscudjrpc1ySni2DPsAMHhWlj8Y7GJhhJD
         W6kDKp2peVHTCrWErcZBvVQe7c86ko6zGuTgdjTjJZp5P0tLA70lbYzIQq9obSwfI2bm
         P/SdfdzyuCx0iPuRlI6lBQ877PSY+67zAC8zIfV2kABVq1+A6VF5Pm8dT3dndmBy7k0e
         eyEjrwVToTdOu4DZlHU5fm/Jp2og7PBmi1bPPYj8WtB0UuH/Z/mdgNAf+8gZZSiWZjs8
         56Tg==
X-Gm-Message-State: AOUpUlGV7VLe/vGAlBOtEhgfu3mJbOLJq6la9whYW73OqR2R3TqBLchC
        AHWWP9YFPPkdOgmEacgmfdI=
X-Google-Smtp-Source: AAOMgpdq8ZKQ1hCLUk5fihEpXYHyVKJJf1l1Kf1tPrbMyvuBvao0fSI7nxLtYpTU1+znZpwOzUyeIg==
X-Received: by 2002:a62:8d7:: with SMTP id 84-v6mr4339136pfi.172.1532653065158;
        Thu, 26 Jul 2018 17:57:45 -0700 (PDT)
Received: from hobbes.alyptik.lan ([2605:e000:1117:c002:2e0:1bff:fe70:ea])
        by smtp.gmail.com with ESMTPSA id h69-v6sm9455760pfh.13.2018.07.26.17.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 17:57:44 -0700 (PDT)
Date:   Thu, 26 Jul 2018 14:57:42 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Joey Pabalinas <joeypabalinas@gmail.com>
Cc:     Richard Weinberger <richard@sigma-star.at>,
        Gao Xiang <gaoxiang25@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        miaoxie@huawei.com, yuchao0@huawei.com, sunqiuyang@huawei.com,
        fangwei1@huawei.com, liguifu2@huawei.com, weidu.du@huawei.com,
        chen.chun.yen@huawei.com, brooke.wangzhigang@hisilicon.com,
        dongjinguang@huawei.com
Subject: Re: [NOMERGE] [RFC PATCH 00/12] erofs: introduce erofs file system
Message-ID: <20180727005741.ihodwh4ovpe3nkpp@hobbes.alyptik.lan>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
 <CAFLxGvw5PXBLKuaaK5xipiwTOXohtdeenD0XQHgX6+r4rS=GqQ@mail.gmail.com>
 <aae078b7-c364-106a-dd56-91abc945d7bb@huawei.com>
 <1670077.cnVahIradn@blindfold>
 <20180727005511.igabkdzwpb64bniq@hobbes.alyptik.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x6pyytptpzk7cr47"
Content-Disposition: inline
In-Reply-To: <20180727005511.igabkdzwpb64bniq@hobbes.alyptik.lan>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x6pyytptpzk7cr47
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2018 at 02:55:11PM -1000, Joey Pabalinas wrote:
> I thought the exact same thing; opened the thread and was a bit confused
> at first. In my opinion the name feels slightly misleading.

Oooh, reading more of the thread I see there is some fun wordplay going
on which I didn't catch at first. I rescind my comment :)

--=20
Cheers,
Joey Pabalinas

--x6pyytptpzk7cr47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAltabgUACgkQruvLfWhy
VBl3ZxAAwHqCwtdhs/r4R+yY/MF9dVYe5Jqqe5oTHyiUbVIEI4Sa7/wH1DURPTY+
cBhJlOoHdsLBi7HzNe9MWtnZsPSV5SGxVKdpJpuFuILZIS8tE0bCaitxkH2I2kiO
lQJ3KmRZgbrJQ268xY4LV+dpoaJBqImH9fsBt+lEz4aibErOOCjmL1cdvnisPca9
xlZhaKF3BPJ0Ovq3av/ksNuHE+K8ERmSFfVEFFdYy3AEFPqES3iVKcUtAjINy0ft
+7n6iPJ5Q8WwQSaSmKhTN2ZvynqKRXj6BvdzUzvI1bNs0kOw8QBka0ZetVXLCLd+
t+hF3vAFsoWlyrUfFaBKtuNKq4tAKgEPNUrgc8pATFAcAIHEn9HP+cDNRsvpaJeg
oo9wZHORhoj/f5D9ZVkDj99xTzx3/lQrHkMfMgxmOidbX3nud32g4POmKx2Jsu4Z
xSVceSMHM4ejY7ld20yAWfmOOxVO5WLy6F3KHORhX88uoDZacnAH9PmHsUKpTDcA
0/cATl1qqCIY7WBhy+niEQCH7K/Vxx+xXNWTvanZLb3GVGTEks3zx5rskj8DZM8Y
++6drA+57zf6GfUyHL8VIYoa0bXAqMCBoQlDl50HiHRDd9So2H64K4/uJAR6ei9H
2ueHObBdHvPaf2rjvLqiReIIv9sOoCWaRa/ARsgEgm2Eo+Wv/18=
=j+TM
-----END PGP SIGNATURE-----

--x6pyytptpzk7cr47--
