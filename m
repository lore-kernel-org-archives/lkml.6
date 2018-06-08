Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LGNoEUXIGlv7RAAAmS7hNA
	; Fri, 08 Jun 2018 18:32:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 05CD0607DC; Fri,  8 Jun 2018 18:32:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=fortanix.onmicrosoft.com header.i=@fortanix.onmicrosoft.com header.b="bGWKc+m1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5C08C60275;
	Fri,  8 Jun 2018 18:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C08C60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=fortanix.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbeFHSc3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:32:29 -0400
Received: from mail-eopbgr700102.outbound.protection.outlook.com ([40.107.70.102]:22093
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752697AbeFHSc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector1-fortanix-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrtsXY0wrojbF96uW3DeNgUuZIfPbd+JLHK3n7a4Ql8=;
 b=bGWKc+m1eXkVtzALjJTWsntiVw7d1s0UFWztCPbYnAuV3H8tKgbQ9wV552HWotfgh+D0eF5CcqF9rSYPhMnZnFn5/Vsgc2vFJVIzh/G0Z9E6U8gAE8yWL8+YL+wQS6JrnJSBo1m/tl1E0kFIObkXb7VY3pJePnHDtPiKYPh8NCY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jethro@fortanix.com;
Received: from [10.198.0.221] (67.207.107.146) by
 BY1PR11MB0310.namprd11.prod.outlook.com (2a01:111:e400:5013::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.14; Fri, 8 Jun
 2018 18:32:21 +0000
Subject: Re: [PATCH v11 12/13] intel_sgx: driver documentation
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org
Cc: dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-13-jarkko.sakkinen@linux.intel.com>
From: Jethro Beekman <jethro@fortanix.com>
Message-ID: <6200618e-bcc8-23ba-afe8-4c6be8b364f0@fortanix.com>
Date: Fri, 8 Jun 2018 11:32:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180608171216.26521-13-jarkko.sakkinen@linux.intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060606030706060906050100"
X-Originating-IP: [67.207.107.146]
X-ClientProxiedBy: BYAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::34) To BY1PR11MB0310.namprd11.prod.outlook.com
 (2a01:111:e400:5013::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BY1PR11MB0310;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR11MB0310;3:Mp6isNwd1QYsR7S6cR2160pxGkeWPpKgzVoqAdrtU3a6R7xgpxF9w53zDeODQ+SwuwGpFHCVG1wgocfDLwvmQ7hcgcGTArP0LczPJuGF7O1VhOPP76HtCCIOz3dZdT2aygPGzJo0+nGAZ5datT7zqr8tvjQ9B94/FHl4qHz7lNMVXlJ9kXDD9ZC/JE/lpGle/Wxfz19keT/lyeWK3Q6A+1Rju/WYsolLPGSwpkbmzhGhz5mtkFHd3XX35lwlWAsd;25:kRYOo7ydiaVVlEuWzXawLer0LUVbbO8HSYg76a0YJV8rArUlSeiQL5IF1wCEBPcJGLaTnnxl/WiG/63sSQV4Ux3d42ReEawBMkOTdCNZRymg/Dqvawo6zrQ905eFiwnwyvOEt+ZXGVaHeut+2Fo49bE2td7E2mi4m2tLF02lQEhhBRvNF6mvbNAmCpv/gtn75oNd905hKQ12Al0ox1YdQ2t73HoM+ju29KjlqMNWKP+BehzeiMxs/Oqp2kzWciRskAGVnoe45p3oQnDVVJENZEYu9jh1pORG1TrBeGwVuW+yXF8ZCtZU4VMEM5lpBmy36OcrqZw8tX86S1WCcqa75Q==;31:JiCgiB4U+XJWN3tj/Kv8OPGV5jWFiprCzu5NwqGAyHjhMexZl/1ZJcZj6WSOYjxcmzdp5foOsCokKP9lcwJ2O024BaRhe1B3dhhLMDleUl3diWoHEsGj4TIvjUdyG2fZP40yN23s67hxUzV6d0IPlwFZIlqa1kWfoV4UqCWA2nQC7b7xcafAS0DY661M8eKM5ZiLaXGs4v/0lUo1/xXGU+yXOAK4T9MOd6kb/xbLCsI=
X-MS-TrafficTypeDiagnostic: BY1PR11MB0310:
X-Microsoft-Antispam-PRVS: <BY1PR11MB03108A12E5D1FA1B032A099CAA7B0@BY1PR11MB0310.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:BY1PR11MB0310;BCL:0;PCL:0;RULEID:;SRVR:BY1PR11MB0310;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR11MB0310;4:cr1CITnGkZmPo1gaZCsHted/zGbA6mhhcpthBxDLbCwowGwi00dxqRiTTMXvrc2C4bUirsgh3tE1KyhV52/Yhfk0OT6X3pYhJgKxhJ14mPdJW/W1aP+7mLBocZ0vPNOO1luVlR3bBbItzo1eore1rNk0GUdKOf3dBXDJILklS7p1ZYnYTBDnQ6EDIhfOxELpG5+0ud5ExVV69lYDvPuE4sLlSbVkosb0hVxhBcK+2feNnWcj7HwkR0nOhXdHfChshoP+0S7F5Bkdl2kWGW31+QMFIWXG7kTJBNO7jDHnUc/1agAoClouJxRmGdBjYWVQ
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39380400002)(366004)(376002)(39840400004)(396003)(43544003)(189003)(199004)(53936002)(86362001)(53546011)(229853002)(16576012)(65826007)(58126008)(386003)(2906002)(478600001)(476003)(305945005)(11346002)(486006)(6246003)(5890100001)(7736002)(31696002)(6486002)(76176011)(956004)(52116002)(2616005)(7416002)(446003)(33964004)(8936002)(36756003)(25786009)(8676002)(81156014)(81166006)(97736004)(65806001)(5660300001)(316002)(84326002)(65956001)(66066001)(16526019)(105586002)(186003)(16586007)(26005)(568964002)(68736007)(31686004)(77096007)(54906003)(4326008)(6666003)(106356001)(3846002)(6116002)(64126003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY1PR11MB0310;H:[10.198.0.221];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fortanix.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR11MB0310;23:r5T5pxNbbgV0biGTBbpRlzMPyvd9hl6IodpkFjdVN?=
 =?us-ascii?Q?b2D7fOUPukGSTeLFCTbcNCu2csewdntzzzkU1cEt8fWRvaD536vlQFuO0y+y?=
 =?us-ascii?Q?7QmsIpdJ1FfNpBAcffI4CK9Oot7LwcTeOBAo7l5IWB50gjJX/8uZmwelbe2t?=
 =?us-ascii?Q?JIyOK54pj+BGHeLnkFOKEJQ36/2g6THe3u3W+GdQ3U+PfPyYiZLuDsOR2kZh?=
 =?us-ascii?Q?fMb71ZFLz3KXyTc+jjwlyLsIU6HzzmR2btAnOpb3eGOBT3Sn+YHnejDGXeG3?=
 =?us-ascii?Q?V5I70b+nDeTY06b//TzEC62hX25JyyzesxIdsYoBrthEDTkzhzFC2pKadywG?=
 =?us-ascii?Q?ogtouIKE0J3SV49d/og4JmqCUQzP7cxg+6XI50sSfF44NpKw4yeU0JvtmuXv?=
 =?us-ascii?Q?Dt0JTnq+P4i3ri13VnkXFKRtQCsyNr8XitstgVOxAekqxr+iGu2I6Lvwas5d?=
 =?us-ascii?Q?EYhjw20bEDQGSmRc9azqXoRFB/pKRLCej7GW4BjRx7iMXqpspEcDLG4UXwDM?=
 =?us-ascii?Q?ZrqCgDeYBYy9Ci729qAlXjj3z0/oibaMIofG0qy7IJxqqbhPyQ11Sy0YCW+l?=
 =?us-ascii?Q?JNiZlAKlQCsz4hhcEsbG7b4wcVQ8Gb8PGHvQ7ob5e60mThrAuHINn3MCDX1E?=
 =?us-ascii?Q?NL5z6lWXGOeXKB87BmqaH9YK7DpJ/RO0LbyTILQc0ndEu+dbMfs5gI5YZI2f?=
 =?us-ascii?Q?x21MJVI8oirUJxkN1SvQXt2ONutp5TaH1DSCPLj6AfdvVJV8aRwKbwWN54+R?=
 =?us-ascii?Q?6RbuMUHJk8vmcFjXpIHTmifBOIIf2TgB4AuqYU39c4ry0qWpHkwjdUz14+51?=
 =?us-ascii?Q?j6XgApERqwrFa+DxVktbg6GDU2+lfT6/SSGseWax/TnALj4ZEWaVwugv4HBH?=
 =?us-ascii?Q?qN04fdRGQZrT7iDI0LxitIzT4DIoK5d50Fnx0DoMCFBXlB6b1WwKoHiqqOAB?=
 =?us-ascii?Q?QIsXB1U0Y8fTLbhhABxS0YYWe7qEcB2Ci318ja3WG6a70eui6MDKyXAMYATF?=
 =?us-ascii?Q?BJRWDmq00lnjLSFJVABGEQNiCyMY/qv00WO0VQ20jnQuJ6YaOVZSVRi+36es?=
 =?us-ascii?Q?y65hNK8Fqmom90nMPNdIL5U1eBMl3O09Ab0LPdG4ZUS+QHfXy1kZyerkSHrN?=
 =?us-ascii?Q?7yfWsxNmMQLW60UHBuWN/EAL5waqArEn1irf6s5tBP/4VlwJl+M5laNCrVjE?=
 =?us-ascii?Q?QEi2mclsvHHyS1JYcui5INhcl0iPR1lzsiP3D6CTDguTzkOMzLNN6XVGRds0?=
 =?us-ascii?Q?0PoDWaGNkhXrUviw3teMsjeTU19nCBvgfw9dITBshdJIKnDY431VvJLggHdA?=
 =?us-ascii?Q?I20ggWVJN4mH7HhLmcRnY0Oo7TJbT6mzJiFHiQg1+PDXTy2+E2HK5fYb5Pu/?=
 =?us-ascii?Q?qvRdDpBDOdC3ydaMebbYPUstQaWxfbhr+MrSpwJ0h57NYRYwPAvZyEQ7PT/r?=
 =?us-ascii?Q?SGx0dPoWl4mGhbL6RnBP0dbFpzzhoU=3D?=
X-Microsoft-Antispam-Message-Info: 0qzoR95RRIHHPHm2Ngyn1Hl8mdo3Jpw0+hkaOzWZI9VtQiYlBFXHwKz18hpRQA2ZWOEqPGNGB0caW6/Hu2WHhQ/RP3w2wtixIOefP9XQg5oOgNrt0JMYYpkrYWVgFhpp93IfGKXx7sc59NoPPtpevgwEX7tQKtaGFcQDknz7upIgl/PrfJiGT1zUG3OcQ86h
X-Microsoft-Exchange-Diagnostics: 1;BY1PR11MB0310;6:z4Bnm+GH/DQD6Qhcm2VIeGUs8M3ujajOLhTEvu/ozX5JGZs+vV759Mq7D5zTIz1TA9iJHhGVER1zhUrbMdmDuZjKW44EbA+xlq5N4DKli7YNXlorliAbW4ovuqk3ylLbnme3RXL29k6djUq9miegha2wfrAbnu4dmR2N3bb5n41aVp7uavWPJftUIyA8QEujymfPnEF/37ZsmqhRdA/WDCU2e3gTgXY1SV3lPE+IfoJPtIsBV+lg092RLdAhXSlx/YYeSgZ81llUfN3s3+LotkxROWOlItsEwmeu1jqTn47s4FBwcxYP0hnvcaFF7VATiKFDVIibpNPnzcUk50Kqydh0PBcCTdUQDE1g5tboXKH4J3WKDv4XBhKNMRcl6VdcSGhcidQZKu9+RCjg/B/rs3XoqyzrXJc7ygxzN5pE1rDCP3ORynYLnQoAFMoHrT1z7PpD8+g4o9Y369szf3Xgiw==;5:ePpXIqhNi4mOO+RTx9fKllkyNQ+br6on8yhKcHZazt2tIafH9ezvhhHWMQ2+8YOtib/DZRuado4ejRzDH28bkoMtcNE8ladS15Xo6ASXA70a+voe6DqCoyrtpnk26eEO8OOK7XehPqdN6L8/E4VP9PlSD9ZmRAKBNrarhFsRzxI=;24:0gYkGR+eOW3cWqQPhP8vZokdkeK9qjKIs2iGpJsq+vO3RhI6us/iKmpvXmBxv0Ey2ymBIxw26Pq62vA0+LE7D+rudoQ8MgpRbGxwMGZrMs8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR11MB0310;7:GxcuN1joOSX1CB/4+lUzunxIafNYn3uFoA4UtOodiFGX2kJ3D5tglOJ5vFf1Pv6QlXZ5fXDyHJlNPMf45pukglsiLEgaW07XX7U/iGf4NMUuTQn4LV9LUBVppoXf3Lq5eypMfNYSI2S6mulnM5KlvqkxGsVJB6RP/LrU+76RGesf9xXQ4Se8rQAm/uBrMILIg/FaysEOW7JUYmMQ/JGy1fawdWNjKuSjbFRXOA26++dJ8Q+FRYXinb7z2J8Be47A
X-MS-Office365-Filtering-Correlation-Id: ecc5b08e-70aa-4b28-a93e-08d5cd6e2c7e
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 18:32:21.3763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc5b08e-70aa-4b28-a93e-08d5cd6e2c7e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB0310
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060606030706060906050100
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2018-06-08 10:09, Jarkko Sakkinen wrote:
> +Launching enclaves
> +------------------
> +
> +For privileged enclaves the launch is performed simply by submitting t=
he
> +SIGSTRUCT for that enclave to ENCLS(EINIT). For unprivileged enclaves =
the
> +driver hosts a process in ring-3 that hosts a launch enclave signed wi=
th a key
> +supplied for kbuild.
> +
> +The current implementation of the launch enclave generates a token for=
 any
> +enclave. In the future it could be potentially extended to have ways t=
o
> +configure policy what can be lauched.
> +
> +The driver will fail to initialize if it cannot start its own launch e=
nclave.
> +A user space application can submit a SIGSTRUCT instance through the i=
octl API.
> +The kernel will take care of the rest.
> +
> +This design assures that the Linux kernel has always full control, whi=
ch
> +enclaves get to launch and which do not, even if the public key MSRs a=
re

As discussed previously at length, since the kernel needs to execute=20
ENCLS[EINIT], it has full control to deny the launching of enclaves=20
regardless of any launch enclave implementation. Please change this=20
misleading statement.

> +read-only. Having launch intrinsics inside the kernel also enables eas=
y
> +development of enclaves without necessarily needing any heavy weight S=
DK.
> +Having a low-barrier to implement enclaves could make sense for exampl=
e for
> +system daemons where amount of dependecies ought to be minimized.

--
Jethro Beekman | Fortanix


--------------ms060606030706060906050100
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CyAwggUyMIIEGqADAgECAhEA8MVmReo60XmFXNF7R8+qGDANBgkqhkiG9w0BAQsFADCBlzEL
MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0Eg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTcwOTE0MDAw
MDAwWhcNMTgwOTE0MjM1OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNqZXRocm9AZm9ydGFuaXgu
Y29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAz7i2PMd8+ac44evn+E/vAnvp
p3rSuGpPBG8a5a7TomxjN1KilgX7juFiY7LZjZZe955hCzCoou+lyNgCCSbZzcKsYuIyydkj
UBBGIcTSblxCbko21J3yyk0JwAwSoaxlZwKrsbjUTHSl/0E6SBQpybRZsAficbdSRz+s7jG7
f6DtnikAtTYof+mBxwZC30Gzxh3RQEjA0PwaSP35tXffrplfazeog099eiVWLIDYA/kSaiac
SgheMK02Wi0Iu0fGZ3Y9QMVaB2r5Bhm+hODvJv/WAjEUuZGwo3K4aR/934W79pq5bXwUReXy
/5VxE1acjz6rFnCqBJuNgrzDiGF4ywIDAQABo4IB6TCCAeUwHwYDVR0jBBgwFoAUgq9sjPjF
/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFH990qeqLXTAXNqiGOMUQIhUf9TWMA4GA1UdDwEB
/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZMBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMF
AjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAQEwKzApBggr
BgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2g
S4ZJaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRp
b25hbmRTZWN1cmVFbWFpbENBLmNybDCBiwYIKwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklo
dHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFu
ZFNlY3VyZUVtYWlsQ0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5j
b20wHgYDVR0RBBcwFYETamV0aHJvQGZvcnRhbml4LmNvbTANBgkqhkiG9w0BAQsFAAOCAQEA
BzIiuD+ggLjwfH5xKn7eotgwkH3V6qCWD21G1++PIxuLjCzRN87rMOZcmrMa2HJkDVz4NZYe
Er98p40JKNNVabKBI8+aF79Gfl0y3Mojr53ojV+x0wt2U04EmOXONuCHdLgxv5JvReFLXo6h
bIZQoe4Cwfgj541QPLDzoSuMrMUAcNSjt6o/SIeIu+Udv84ET2YckxiBXDiKUXRfW+GWet3w
1tUYrUSfwTA7Ho2YUbZu/L4FFRrUXQD6zYrB3f0sStDxWijKsRwLrdzqKVs0hsu42wZcNR/v
YzWnJQBVuCIpr0I/rTHY4E8w5h0Hz5mPABkNxLfOYKRJ1VUMQSgHGzCCBeYwggPOoAMCAQIC
EGqb4Tg7/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNVBAYTAkdCMRswGQYD
VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNP
TU9ETyBDQSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRpb24gQXV0
aG9yaXR5MB4XDTEzMDExMDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYTAkdC
MRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNV
BAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAvrOeV6wodnVAFsc4A5jTxhh2IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQ
PTRI5Or1u6zf+bGBSyD9aH95dDSmeny1nxdlYCeXIoymMv6pQHJGNcIDpFDIMypVpVSRsivl
JTRENf+RKwrB6vcfWlP8dSsE3Rfywq09N0ZfxcBa39V0wsGtkGWC+eQKiz4pBZYKjrc5NOpG
9qrxpZxyb4o4yNNwTqzaaPpGRqXB7IMjtf7tTmU2jqPMLxFNe1VXj9XB1rHvbRikw8lBoNoS
WY66nJN/VCJv5ym6Q0mdCbDKCMPybTjoNCQuelc0IAaO4nLUXk0BOSxSxt8kCvsUtQIDAQAB
o4IBPDCCATgwHwYDVR0jBBgwFoAUu69+Aj36pvE8hI6t7jiY7NkyMtQwHQYDVR0OBBYEFIKv
bIz4xf6WYXzoHz0rcUhexIvAMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEA
MBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8ERTBDMEGgP6A9hjtodHRwOi8vY3JsLmNvbW9k
b2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDBxBggrBgEFBQcB
AQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUFk
ZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wDQYJ
KoZIhvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2SQgG1NgvNc3fQP7TcePo
7EIMERoh42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs0j8CGpfb+SJA3GaB
Q+394k+z3ZByWPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDMKVmU/PUWNMKS
TvtlenlxBhh7ETrN543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+E2pvOUtY
+hPebuPtTbq7vODqzCM6ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfHM5td
hYF/8v5UY5g2xANPECTQdu9vWPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4
jkhJiA7EuTecP/CFtR72uYRBcunwwH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJ
M/1tyZR2niOYihZ+FCbtf3D9mB12D4ln9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJU
mpvVdZ4ognzgXtgtdk3ShrtOS1iAN2ZBXFiRmjVzmehoMof06r1xub+85hFQzVxZx5/bRaTK
TlL8YXLI8nAbR9HWdFqzcOoB/hxfEyIQpx9/s81rgzdEZOofSlZHynoSMYIEODCCBDQCAQEw
ga0wgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNV
BAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01P
RE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA8MVm
Reo60XmFXNF7R8+qGDANBglghkgBZQMEAgEFAKCCAlswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwNjA4MTgzMjE3WjAvBgkqhkiG9w0BCQQxIgQgVRgE
adROmDvovjccWEDwlJxklUQ7Hop0RboPwu5++1gwbAYJKoZIhvcNAQkPMV8wXTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG
9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBvgYJKwYBBAGCNxAEMYGwMIGtMIGX
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAPDFZkXqOtF5
hVzRe0fPqhgwgcAGCyqGSIb3DQEJEAILMYGwoIGtMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UE
CBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01P
RE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRp
b24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAPDFZkXqOtF5hVzRe0fPqhgwDQYJKoZIhvcNAQEB
BQAEggEATIo6aTpqOEsSzhh47mSjs+vds4ZuvhEIbzW/YIJIpKruM73BS2S6UK1QyVG1jkhg
XWhn03ca+CibD6M+4qTPuZDiBJrq+BPEzAEu+W7NPAu/NGSfNxe8QCp3NAo+eGBiEOyKo/qP
LHDwoNI1zHF3jgA34H7G2vaM8kchmz5lYMiWrLYeP9Bi3GUybefWCJ9sB2C06jEeCGw8wPrU
NL4JyfoD0adjnp5wncNu7cUIJz+FT6NEUUmguLe6zB3wXVb5RYuKqJ7nIsUmW/7O3kYa+Zfw
/7hNUXqBZoJnMgRV56A+28+9mr6jHnon3jWAo9v/p6ker0x2bTVzE/ocAJ0/JQAAAAAAAA==
--------------ms060606030706060906050100--
