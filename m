Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D536C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B9221736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="ldo3N9yJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfAGN0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:26:14 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:57951 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727099AbfAGN0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:26:12 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id 19/1D-19160-073533C5; Mon, 07 Jan 2019 13:26:08 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfUwTZxjAee+u14P1tqNoeCBiWEcyA1z5ivE
  wRv3DLA2JyTYzY0wTdoWTdrZX7B0ZTN0QJYrFzC+WQKpAhoSACIIJCMYPJBswwYAaDYrU2cDK
  hhIdoxHi7PWKH//93vs9X++b5yhcP0vGU0KxLLhE3m4gowhrGrWWdW7LMqfPd6zn7o72YVzVE
  x/J/Xf3CMY1DZ9C3J0eD8lV9Pys4V79P4Vx7QutiPN3/oNtjjS1vywjTZdrJrSmjuYK0nR28C
  vT1dlG0tR26R5h6vxjr+llx+ovqZ0am2hxFn+rsf7lvkEUXtQWT7SOkKWonjyKoiiCacOh7M4
  cphz0zEkMxnuvao6iyODhKQL3DK8wyXBwasBLKryC2Q9/zg2EEnDmJA6jgdaQiAkGVT1+jatB
  2TDa4EUqZ8Jiz1KICSYJvCMHCYVphocDi9NatfNhBDfLh7SKiGRy4OAvXaEgxCTAvwdaQkVxJ
  hbGfbWYwsAw0HDlNq7ySvA/fa1R4wUYLHuA1O+pMHzfF2YDnD3TH+YEGKt1I6UxMOVaqDrfTK
  piK0wttBCqeITgsqdWu1zphOcIoTIHDe7yMG+AEW9XmAuh8n4gnPwEh+nFyXDyKvh1wo2pIqC
  Bbv8jpL5wHsydGdYeR2zNe9dTORXqel+QKqdAY/3feE3ozaJhsNpH1CGiGXEWl63AKjt4m53N
  SE9nMzKy2Ex27Toj/wPLG4UiNk8QZRcflEb+e8kolTjy7PlGUZA7UHD18vdg2d2o/VxBH4qjM
  MNKemN/pln/scWZX2LlJWuuq8guSH1oFUUZgC79Osusj3YJBULxLps9uL/LGiidYQUdo2haKu
  Qdkq1AVUOIpX6vmPfgekJ0ikJ8LB0VXHM9owRZi8S3JZb/gjGUEB9Do4iICL2uUHA5bPKHfgb
  FUsgQQ5cprXQ2UX7baSY4BBYcwq9LV4aQ+XcqvhRpvsPy/DQ5PzYt/Xitq3Fr/07H/KenJ3/b
  IaVtT5l2OA8//KR0ULdheGNi4ua6wOcploWfkkBfsy85+5qletI87iE1cbeKPBH9a45pP/tmq
  cL8xY29vVNRz3ZfqA/4knO3NIhE5eocvFJ2texoOu4teb5JdzOJjrvSJB+6cP2jnFwDIVn5jG
  TcJfFvAI6zZ40ABAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-40.tower-223.messagelabs.com!1546867567!2978082!1
X-Originating-IP: [104.47.8.53]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10870 invoked from network); 7 Jan 2019 13:26:07 -0000
Received: from mail-am5eur03lp2053.outbound.protection.outlook.com (HELO EUR03-AM5-obe.outbound.protection.outlook.com) (104.47.8.53)
  by server-40.tower-223.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 7 Jan 2019 13:26:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HX4IwB+t1/PKXFS4VEI8cPNOlgJovEFu4ZqcgFpP+A=;
 b=ldo3N9yJmk/K/QmZY4vf8tlcFsyL6C62UvYy7M7pWVAFBLO84JXeY3678PF2Z/S04zrpvQmqm+xsm0mBzU9UevOmRe0AgtPysSgTNCVB/gzAo/ulRlV4PZkNCNi6JSrXvMtRvGoxUbA3Z8yzRhGFXnhWASlUgGeH4+MvoZMZG60=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) by
 AM5PR1001MB1124.EURPRD10.PROD.OUTLOOK.COM (10.169.155.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 13:26:05 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::64d6:5112:2b55:6a5f]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::64d6:5112:2b55:6a5f%10]) with mapi id 15.20.1495.005; Mon, 7 Jan 2019
 13:26:05 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "tiwai@suse.de" <tiwai@suse.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 19/21] ASoC: da7219: use logical AND
Thread-Topic: [PATCH 19/21] ASoC: da7219: use logical AND
Thread-Index: AQHUpJsEv+sYWDu6uUy/odMW65+8CKWjz3PQ
Date:   Mon, 7 Jan 2019 13:26:05 +0000
Message-ID: <AM5PR1001MB099401B759C21332BC92403F80890@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
 <20190105020249.8639-20-pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20190105020249.8639-20-pierre-louis.bossart@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR1001MB1124;6:xGGaOO7MG4+0KsjcQJFXAd+qch0LGVo+I/5zD6jkbmBinOeS36ZDPVYnvWBXdFFyKekzbvx1I+QWaf5oIJr/zXDgSK3d/5YAzxwuZYyIgMIulPt1TwvBh7A8uTnrVjWpjNQBLmVFnN8ITzDBZTD91N/Tq7ngxLxW+atIJtPBG0ShhStPiGtUSIqrqrXtJpPNBEPk93QmeH7vhw5PSti9HI/cRAxgDN2QeQuB99NCNNNaBWvSgoc2I+fIURMuufdzGpHmP95TzecbBi2XHUhO/1zw0GKwemm60zNDMZyTXXBwxvHmJEcUtYKtF4Bn6aBPSbmDfeQ6KIsDiRrZgeD23Zo2STHxQYwlVwLWoNxmsmZxAStJoZJWPpMv+GeVHCndC6n5gnCeOcWAOwy7vNHbzyXsvw50GuQiU3KBUHW9iVBFLZ5iLP/xOFyxZ5NWt3hdgbds56ir3fI01DhNknMs0g==;5:2A23xQRrUKruT2Y3F4lWxH4oT4IYiu1OcicsCJIxJhlSsi30xuxW8IwWmQUG4KgZzgg2aFNnx/Ho/dmqyi6uXd7EN80hIihZPDEbfoejuls1z0FYZUfdLiOiMEBVYJUzF4aqiyZPXePjoq3fIGoBDcLYNUBHy6PImP5OoitKXzez2lpssjJuTWzuB6Q5SuI251+aso0I+XwhFp97M+9y2w==;7:MxlX7IeSEtktFU7ayoJ49Cq9JBQeH7VFQN8J8aU3OQs+c4K7H+tiBG38lqMHsWYilDbdabcWp2q2FEiA0zDV9jGExmJMM+JOJyZD2QSdkWL1hSAv/uoFPaxXU0SQ9ujWZZURh2auCpVagf3Yc2AU3g==
x-ms-office365-filtering-correlation-id: 40f3c9a9-2c67-4d67-c2f9-08d674a3ad60
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR1001MB1124;
x-ms-traffictypediagnostic: AM5PR1001MB1124:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c,ExtAddr
x-microsoft-antispam-prvs: <AM5PR1001MB1124AFF1982158796A1BFA8CA7890@AM5PR1001MB1124.EURPRD10.PROD.OUTLOOK.COM>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(823302103)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM5PR1001MB1124;BCL:0;PCL:0;RULEID:;SRVR:AM5PR1001MB1124;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39850400004)(199004)(189003)(14454004)(72206003)(478600001)(3846002)(6506007)(7696005)(102836004)(55236004)(76176011)(33656002)(2906002)(256004)(71190400001)(26005)(71200400001)(53546011)(14444005)(106356001)(476003)(316002)(105586002)(99286004)(486006)(186003)(446003)(11346002)(110136005)(6436002)(81156014)(8936002)(81166006)(8676002)(54906003)(305945005)(68736007)(7736002)(229853002)(2501003)(55016002)(66066001)(9686003)(5660300001)(4326008)(6116002)(74316002)(53936002)(39060400002)(6246003)(86362001)(97736004)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1124;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +EAh9YYIoG1Nb0QAh6p6g2U/BQ5BdmtF6TozTONVeKqsaplGFYGTqHKgJYO4kA/nw/00qMkBWbWotels8DOy6S9EvoCj73QX+Xsz7bVythHBFs2rOH8ofJislE7PF3rCYQIY47jfRre9WTRYjCO/MawYtuPoblv5JQNFhyE24OO4e+cmF9mvbnIgKTt+q+MIM2NGv6dJyphhmPeRxhwu70D+LDGpO7h1O7okeC9aL8I3szZaCpL41Q74jExJB3mhcWKj6LuBinDIQ/FLYbPJsIByLNYbNs+tFTHluMsogW3Hl0uhYJdbLTy2bKeLvsTF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f3c9a9-2c67-4d67-c2f9-08d674a3ad60
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 13:26:05.5503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 January 2019 02:03, Pierre-Louis Bossart wrote:

> Reported by Sparse:
> da7219.c:841:57: warning: dubious: x & !y
>=20
> Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com=
>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  sound/soc/codecs/da7219.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c index
> ce165047b9f9..513ec0368653 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -838,7 +838,7 @@ static int da7219_dai_event(struct snd_soc_dapm_widge=
t
> *w,
>  				++i;
>  				msleep(50);
>  			}
> -		} while ((i < DA7219_SRM_CHECK_RETRIES) & (!srm_lock));
> +		} while ((i < DA7219_SRM_CHECK_RETRIES) && (!srm_lock));
>=20
>  		if (!srm_lock)
>  			dev_warn(component->dev, "SRM failed to lock\n");
> --
> 2.17.1
