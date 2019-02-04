Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72D4C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A587E2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mUTMRtgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfBDKE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:04:59 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3194 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbfBDKE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:04:59 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c580e440000>; Mon, 04 Feb 2019 02:04:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 04 Feb 2019 02:04:58 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 04 Feb 2019 02:04:58 -0800
Received: from [10.26.11.58] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 4 Feb
 2019 10:04:53 +0000
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
To:     Sameer Pujar <spujar@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, <mkumard@nvidia.com>,
        <rlokhande@nvidia.com>, <sharadg@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
 <20190131143024.GO23438@ulmo> <2034694.JE9CgBysmF@aspire.rjw.lan>
 <e7597220-2be7-ca29-50b7-c515c06cbed7@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <80a45aa3-8a22-959c-0c73-03ad2d6b1f8c@nvidia.com>
Date:   Mon, 4 Feb 2019 10:04:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e7597220-2be7-ca29-50b7-c515c06cbed7@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549274692; bh=tacV9aTXTZ6U1taWrh3IDBot/ks3MtFe50Js+BXkZhs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mUTMRtggE50xAn35t83fnPvKoDHqfmY5F7EUHTNnjCGEmHgYwQQRsT9oB8al+6UDW
         Zs7rMWQp/ApcpuHUW+aN5Y8wpTbuhdSuvXGVzWGhuIjC8aybxsyC20AFTC5mSc0kj9
         gjCtmnIr4kz1zhrxCphmq/U83PYPLlw1LRNPrYTLQmH7/dZ9Esek1rw7zIgZwm/zjL
         bARMWW3lVZXDuR+LjTO/G7HjejUBdLLncWRp/6plV6vuo7PA3K4iYXxZhDfNohx3iE
         sVIt2UBCo0pGPEhjgGlEPZTGeb5Kii9X3K27gf+hS5dk1x8YFNM/IjjViECRSvd9CL
         rwKYa/0ScJ3VA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/02/2019 08:16, Sameer Pujar wrote:

...

> Objective is to have things working with or without CONFIG_PM enabled.
> From previous comments and discussions it appears that there is mixed
> response
> for calling hda_tegra_runtime_resume() or runtime PM APIs in probe()
> call. Need
> to have consensus regarding the best practice to be followed, which
> would eventually
> can be used in other drivers too.
>=20
> Rafael is suggesting to use CONFIG_PM check to do manual setup or
> runtime PM setup in probe,
> which would bring back the earlier above mentioned concern.
>=20
> if (IS_ENABLED(CONFIG_PM)) {
> do setup based on pm-runtime
> } else {
> =C2=A0=C2=A0=C2=A0 do manual setup
> }
> Both if/else might end up doing the same here.
> Do we really need CONFIG_PM check here?
>=20
> Instead does below proposal appear fine?
>=20
> probe() {
> =C2=A0=C2=A0=C2=A0 hda_tegra_enable_clock();
> }
>=20
> probe_work() {
> =C2=A0=C2=A0=C2=A0 /* hda setup */
> =C2=A0=C2=A0=C2=A0 . . .
> =C2=A0=C2=A0=C2=A0 pm_runtime_set_active(); /* initial state as active */
> =C2=A0=C2=A0=C2=A0 pm_runtime_enable();
> =C2=A0=C2=A0=C2=A0 return;
> }

I believe that this still does not work, because if there is a
power-domain that needs to be turned on, this does not guarantee this.
So I think that you need to call pm_runtime_get ...

 probe() {
 	if (!IS_ENABLED(CONFIG_PM))
 		hda_tegra_enable_clock();
 }


 probe_work() {
    	/* hda setup */
    	. . .
	pm_runtime_enable();
	pm_runtime_get_sync();
	return;
 }

The alternative here could just be ...

 probe() {
	pm_runtime_enable();
 	if (!pm_runtime_enabled())
 		ret =3D hda_tegra_enable_clock();
	else
		ret =3D pm_runtime_get_sync();

	if (ret < 0) {
		...
	}
 }

Very similar to what I was saying to begin with but not call the
pm_runtime_resume handler directly. Which I believe was Iwai-san's dislike.

Cheers
Jon

--=20
nvpublic
