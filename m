Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C91C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4583B2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZi/+OYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4583B2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeIGWNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbeIGWNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:13:54 -0400
Received: from localhost (unknown [213.57.183.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AC062075E;
        Fri,  7 Sep 2018 17:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536341517;
        bh=SKgr04k4WyTwz24u5Mr0LsijSbaoYYq698Fx+fEPZ6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZi/+OYfOjayf2jByRSxXPukyWETQ0v3J3Bp3NmNOaC7jOp76g2c46V/evYW5qbpU
         ATQ3F+n/uZ6ljIT7Nl4b9J6NJCx21574gVmnqrJ3SbmE4L5LdtA85M8A2ID9EU1j1y
         7kEsEcWn/Gr8umbjgg9F2EL4uVIRDegHRDlny054=
Date:   Fri, 7 Sep 2018 20:31:54 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Chien Tung <chien.tin.tung@intel.com>,
        Roland Dreier <rolandd@cisco.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: nes: add unlikely() to assert()
Message-ID: <20180907173154.GT3142@mtr-leonro.mtl.com>
References: <20180831192418.12346-1-igor.stoppa@huawei.com>
 <20180905060106.GI2977@mtr-leonro.mtl.com>
 <811a6feca9fdea2db59ac392a4711cd897f46cc7.camel@redhat.com>
 <e7fac148-2347-1303-7725-41b7858a02e4@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sU4rRG038CsJurvk"
Content-Disposition: inline
In-Reply-To: <e7fac148-2347-1303-7725-41b7858a02e4@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sU4rRG038CsJurvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 07, 2018 at 06:25:03PM +0300, Igor Stoppa wrote:
> On 07/09/18 18:13, Doug Ledford wrote:
>
> > This patch was part of a larger series on lkml.  In that context, I
> > acked it so that the series could be applied by whomever took it (it
> > didn't belong on rdma-list as a series since only one patch out of some
> > large number touched rdma files).  Now it is being resent as not part of
> > a series, but my ack was preserved.
>
> Yes, apologies for the confusion (and maybe wrong process?).
> The patchset as a whole didn't seem to gain traction, so I decided to
> fallback to the more tedious process of submitting them individually.
>
> Since the specific patch was not altered, I assumed the ack was still
> valid - I am sorry if I did it wrongly

You didn't do anything wrong, I was curious because my gmail already
filtered some linux-rdma mails to wrong folder and I wasn't sure if
it is the case again.

Thanks

>
> --
> igor

--sU4rRG038CsJurvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbkrYJAAoJEORje4g2clinHsIP/RvHxeQ7AeGwLwmHGD18kGMo
r7znmJMf0kt7StfX8WsE7tMhNPAgY+fw0/kDvbp43zTEF7+OW/4cjZk1QwXzeEAI
iCSUPewLdG1nDdnEn9RctX7veZ0D+SBbJER438hPbLZ3bGlPQu+HbRIBTPIbhgYK
Rh7G1o4jKlKq0pg1eaKvfz41v5sMxk2lzwxFGmyoYYHvtjmXmxAiKtqurlnCPO+s
fEkG0K/FfUdkIepvPS1QywjN33TN2gT+npjzbz2R8aBoJt5XcnHadNwUBf/hB3Vh
DOARu4N8TeyFYs4XOeLHW8wB3I3vAL6qpVxm3Rx/OT5j7wkFP/1SGnqJ2A84WQ5Z
M94sRh4zSw87XytohyugxPUQURYfUAEPHSqMZgOlfxI5lA2gbwTmElUT5jzVUM9Y
DhahVi0w1VV6KHFjA3BhYAFDx6Q6Ms6+Y6LkloH1olJpkuJ3GpwVxD257Z0EEqqz
+q32dHQO1doWfAiE2zXMnCTuXvuAopGxzSeieRnMOvTVaD9g/am8ur1ByHrTefVY
45JLpUZrfagkyF25WCN+nzTlFcst4FTJLr0Sk+z4GqnROZOwXUoi454EEGdZEsAk
UTU0AdmxKH7UBCJuEtGHgP4c4Ec4FnLPVKvokfJ2GRW34wC8I1Jzyym7McM2RqVF
gAzrx9hzcmcvrJkY34yb
=JOh2
-----END PGP SIGNATURE-----

--sU4rRG038CsJurvk--
