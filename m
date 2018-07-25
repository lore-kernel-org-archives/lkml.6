Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F2BC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28291204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.onmicrosoft.com header.i=@fortanix.onmicrosoft.com header.b="le+KNI0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28291204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fortanix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbeGYRFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:05:01 -0400
Received: from mail-eopbgr700135.outbound.protection.outlook.com ([40.107.70.135]:28288
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728341AbeGYRFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector1-fortanix-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n2MM2idnhFKMZwfTloVf8UsOuZkMxSUUZIoRAdW74g=;
 b=le+KNI0qEkaS/BvFpoqVrvBK0RObBaoUu+zlSmiPnwJyIbNMtoJO5Lrx4+EEVsYY+OgFS0CLnVP+LTqrNssXCnouXHQgKnVWTnpRgFGkkCGiABwLGyEvq/kCGzcQ9SCuZD118RefXXN0tBs2yZDiRtvcpnJmtlwPmGKlzJkkWYA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jethro@fortanix.com; 
Received: from [100.198.41.196] (172.56.42.178) by
 BN3PR11MB0308.namprd11.prod.outlook.com (2a01:111:e400:404c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.16; Wed, 25 Jul
 2018 15:52:34 +0000
Subject: Re: [PATCH v12 11/13] platform/x86: Intel SGX driver
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
 <20180703182118.15024-12-jarkko.sakkinen@linux.intel.com>
From:   Jethro Beekman <jethro@fortanix.com>
Message-ID: <2cd5def0-61f0-3d57-efa4-7d835d7bdb86@fortanix.com>
Date:   Wed, 25 Jul 2018 08:52:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703182118.15024-12-jarkko.sakkinen@linux.intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms040108080706030403070304"
X-Originating-IP: [172.56.42.178]
X-ClientProxiedBy: CO2PR04CA0128.namprd04.prod.outlook.com
 (2603:10b6:104:7::30) To BN3PR11MB0308.namprd11.prod.outlook.com
 (2a01:111:e400:404c::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b34dd69f-162d-4a54-7daa-08d5f246a53c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR11MB0308;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR11MB0308;3:CtLzA0+4FjREohgF28BQLolwZABEAO9UIcGZT3BbHjorTuAGvBK6BL50WUC1/TSUA+nbzibPG9SF8OIcWeikIIAeTt1ff3n8SuoOYQVnY5Ar/1PMmsMeRTAHOrjiPahoXypmjsW8ClDKsMMzONYu8M2jKx1rr6RZ1qoV1YXbSbgmtZxi+9Z+bOpW2eSplcQJtEoUNpYks0Nl/MKILYjBxC0mZX2UXEXNfmgVZeTIeEiZ0nTrNFqKj57bsbSDueTn;25:1eoztlii/EoTeuLcAgCtoGZZjHk9DynBnNCFP9C3yL4/A6wLEDvmPhPuIJnU2HX9/IqHc5l5ywflDvYOJRJwFkYygCblsph8Nh78ZVYlFpC1f0NFLAWf1AFQ5LZ9qUEJDJXc9W08PO0HcYfgKE89pEm6SDBA63xL0sFnKRm8QrOn43JaYumxfAtUliqUQGVpSteVQoCjj12Z9IUtxrZU15z6gWRfL+oeKAZKLQgDZzrIYD0kUcdXyz0eCQKbriqWAsevfVtXrir64SMNb5zqpUWrAA/W5p2dVOpZx1e6XlqX2ZhgokPflRzFnsB9HHwRQqTa9/jnNSZpwdTk30FAFQ==;31:4KJqn2T7JMtRuLe1LaH/0RN4pxONnXjlWQajZZldSG1OjnVUVNKV8XGpGbklFkVxR35BniLif1fXpxP7+4ajs5/3UFoh3QKJoGvWcRKv5EaPNZyAPZiaJzI9dOZY/1ZJIItFRN7coBAvBtdmuLvJyvS/r/Jk8L6I9ECoSQ5cXQiy7g1mvZRWWh9jA+ZPX/fKU7KiVX3Pyorq7WeYjdZ8buZlpuV2mcWbQfBYx72Lq/Y=
X-MS-TrafficTypeDiagnostic: BN3PR11MB0308:
X-Microsoft-Antispam-PRVS: <BN3PR11MB030889FB86BAE285DE4BD084AA540@BN3PR11MB0308.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011)(7699016);SRVR:BN3PR11MB0308;BCL:0;PCL:0;RULEID:;SRVR:BN3PR11MB0308;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR11MB0308;4:mScE9QRzqs9fGQonqd8ds5WdTykV67VxE5AlGR90wL4uGKaKMpRK2EubhOGcI3nPdyvkwz8D8VunUoaCHsl3Hc8fDZyk7T5NPWRDx/L3JedKQOSvvuOr6rUx8XvCsKeMPvOk/z4t/hLsZrHHogDd7ILySOxzt/4QJAf8i/Zy6VobWGlWrTeti4+ECTIPgZIngtk6c72eEeE2Q7RyXfitVHoNiwOUOWCaDon5uMxs2P9dEfJdHpL3dzsos1jH7kHN8oJDUoBMzsFOT9rBVTVpQA==
X-Forefront-PRVS: 0744CFB5E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(346002)(39840400004)(396003)(376002)(366004)(199004)(189003)(65826007)(6666003)(564344004)(54906003)(86362001)(76176011)(478600001)(58126008)(52116002)(105586002)(16576012)(16586007)(568964002)(316002)(31696002)(106356001)(97736004)(25786009)(5024004)(6246003)(31686004)(386003)(49976009)(53546011)(33964004)(65956001)(4326008)(65806001)(16526019)(186003)(26005)(68736007)(36756003)(66066001)(8936002)(11346002)(81166006)(53936002)(64126003)(8676002)(446003)(5000100001)(81156014)(2616005)(956004)(7416002)(486006)(6486002)(6116002)(229853002)(3846002)(305945005)(476003)(2906002)(84326002)(7736002)(5660300001)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR11MB0308;H:[100.198.41.196];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fortanix.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR11MB0308;23:H13BC942vrxebfJH/yynPNtoNhAnoiQM6pyJ6fIjd?=
 =?us-ascii?Q?/C1uv7MbXqr+/viRjG9F+/1cWfhJH1xaqvyL5xpRwfIS38mzO+t/Fj90WGUc?=
 =?us-ascii?Q?iqVRndQTg9by5lSszcjgkfzxcI4LzqQmO1TC3SylorFTEYuS+JvOTzThOxdT?=
 =?us-ascii?Q?7iC+wDGbfSLWznlt/WEfNK9gJeLhVsgy1GUeU40YXUiqxizjpGWakFpq/1+h?=
 =?us-ascii?Q?u1yQkhD13q+CRryv2/uCtE7g/qoivO6UxMSYYl6aNQaEQAwAuyRWXcTqc+uK?=
 =?us-ascii?Q?ObLeG+SknhFxUFZtqurCgS7hOo8yyhSSCqxRlHrsXSCnOoz6jzJvDAYPHwKm?=
 =?us-ascii?Q?M6YG0vSW0mLPw4fBD+B/lXXfTidXekvzvglAxpYxL/tKdZgeKa/B+BSG2LEW?=
 =?us-ascii?Q?rE8iPcDlhn2rGt/lyd6As2SEkguWcmIr9rsY6IXCggZGOl3J0qXKhdVy2/nD?=
 =?us-ascii?Q?hxBLLd8SHai9MnOLUcV+A9Z8uJKO267K7O2OnOiympAEgEbc68niebrcCs4D?=
 =?us-ascii?Q?VeccijgIl1GzCFj22+UCl7GxBIW/p8PKs100NK1CpjRvXq9Mw02rU3BSqhM+?=
 =?us-ascii?Q?OAsByHGiXpM1r6Ylid/hCzlk6jvvdAjgcDUsjNOklQvt2rDUy0MXDq0YjsfE?=
 =?us-ascii?Q?TwvUhuo/0KpeP4ZQEe9NUiirewujI3vXDT73Tl8sBBg+MnJ/ZLSbz6LJ8TJ0?=
 =?us-ascii?Q?aziExFlX0qeuVj6Wk9Dbx4CWXMhjRh4tKtUNckFecBqBMygcYvFlg3+biPYj?=
 =?us-ascii?Q?iVPF52fBkEzxMq3AY1WkfHsmaoP97cHAtpR72h6e4IX9hdoN3N2dRYc00SD+?=
 =?us-ascii?Q?pRSBKogU6009M9J25NsTfYrvyHn7UTEL7TaeLcub6OlCt6vdpgqEsiVyLcnS?=
 =?us-ascii?Q?NqhFy5+eALL1mdsJvkcqn39zklU2I6PNoOrdiddGC+Z2DEjkTg/u3cNwDuAk?=
 =?us-ascii?Q?aHa8i0z0YyzeSaKfD7XgMZgZplgepIPaSvPL76ske3pCCh7UBHTAPWwXQZH/?=
 =?us-ascii?Q?9QLTwQlyZC0poDBWGb+rrPHhjboww1XgZ4oyAs7sZW7D2WujVaPL3FgqMvHg?=
 =?us-ascii?Q?3+FyHOATzqjXi9Q/iL/FCMFBO4XMsjcbS6Fyta1EU50bxEC3x23ZNXJrBEyv?=
 =?us-ascii?Q?6P///hQj+BybhgK4v406G4XlYwMCXj3Y6uDxBbht178uu2H1TPPuoicWOaQA?=
 =?us-ascii?Q?MuV9rtxG7AhIuG8Cc6W5tZySsQY1CpaHCPGEXroBCPqnTj23qwyRD8y2qLL9?=
 =?us-ascii?Q?51om8m9hplKpmPgYbh00OnB5dt+88Hmt3bV8vnlgzI2LkBE06LDNn5jvmyhR?=
 =?us-ascii?Q?OexdRLC2bEKj8VEQr0CR42Hn8En83cGha7whP6eFcDHO6WYY3rTc6g31ARqf?=
 =?us-ascii?Q?NQLuIWdAHGwkZZOwaZcg4R2dBrp3DxApro5gCrnEMx9/x1ddDSrkc8gbSriR?=
 =?us-ascii?Q?6gNcssKQI8dkf2RYW0OVbXLzluYryNZ3eg/GfduC39jEkBuy/qjsuJrPL53w?=
 =?us-ascii?Q?em1oim/1Dvvjw=3D=3D?=
X-Microsoft-Antispam-Message-Info: FklJweZTkublOTUWTJROxQf5M+/SpjlvTUReqZ62kZwQCRXnGsUzx1RC4IKXZce5txnVzdbllD3whGFD21+UCkNX6xFPVfLdmwcphkS3ald/oLlz2Kpz1bNzdyi99RBr35XjaznGzZWjdttXo9dsWickcz51KO4033QhWFXotnY7bizuMC1rRvh5M7hdyFH2nUJYGlvenUo0pLAqgtCZe4LiU2SggZOCkBDdWyu9jduF7NohfM8rhu848BOYNkji3W1SK+SlXyd6SpnGgqis8nrvEIzEAvrYukCMNp9lucD4v/qtgDIpJLVA2jb/Pe1exz1mr/c8wNqZ1i7oFnPHZ2T3lLvYYsHAFSkQS2+HCgQ=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR11MB0308;6:g4n4EgwRhe0x3ZC29/72s08hGvFu3xXCF5AkH0iLxTu7kxSYPT4H9aOT2jnoIKDGZdCSidxgaUFowIoPymf3njoTqfTpJukuBuMKhNF/yujHVgNht6J67S3tLLgsjtRgkdzOAhowphF5q9J0cBLp+KSo1Myb6BTAcPszr9dJFyOGqjbqoe7HnDLamjOV9mPAS5OIr2cp+TczLjRx0dFxyBnxyC56aRkNknXaVwilSKWzcJRxGiiQIrg1RdW8BF/dqYzeqCOX2527Vi5zBckch2tOFjDZ6ER2NouWEYmkShk45LkKDzvOU62SwcSqwoRSzvAj7X/Rf+5RcU7pHHhMgLAWK6khs1cMFVymXeq+jEZiG11rc1lMqr4W44quWCk5otlqY0EVm3hYDrF5Jfp7UtxYaOY1/R6D43lHzQyR4JprPReKUNlGhTRwoKRIojmxMTr4MGIvtmzb/0+TYweOgw==;5:kF9UmiKC2jWXe2bBW2t11moNoE+6qwQipvzoLoGopWEcx8qUAG7ReYdqKjxhYJB4x6y/7daB9LuesrfzSbGP5A8Y7Ddm8C/BI3OW4GQ41SVgs9UveW/yPPSCB3/NWJQlIga8BFEPfp8ezaqgze+xaW2rzpNqx+HhY4d8x40cvAU=;7:B4CsgTfhG7f5TmuzNXPH+sstaqRrBrIUMfIjxqJk9etVb305di/1tQpZc1xOCo7SkScemgRSxS1iV2r5sQFEfKwjgKqXFBTS1H9idd0Bqg28UmSmNnb9kPtRrRZhz5UJELl9fu9SqmP2cqQx1mNnFPvta6cSHufpx7fC64ICxTEB/p7LmG2iG53PZ2f8QcZpzGD3864iYwRtCLAAkAJGYCMCl0CdHViy5nzbK/pTF2emTB9krQhrAmzEfPXD7our
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 15:52:34.0623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b34dd69f-162d-4a54-7daa-08d5f246a53c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR11MB0308
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms040108080706030403070304
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2018-07-03 11:19, Jarkko Sakkinen wrote:
> +/* IOCTL return values */
> +#define SGX_POWER_LOST_ENCLAVE		0x40000000
> +#define SGX_LE_ROLLBACK			0x40000001

I don't think SGX_LE_ROLLBACK is used anymore.

Jethro Beekman | Fortanix


--------------ms040108080706030403070304
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwNzI1MTU1MjI3WjAvBgkqhkiG9w0BCQQxIgQgx6I1
Q28dYmJr1p2e1Vh21HZjKJU69JguhkOS3x3m4lUwbAYJKoZIhvcNAQkPMV8wXTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG
9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBvgYJKwYBBAGCNxAEMYGwMIGtMIGX
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAPDFZkXqOtF5
hVzRe0fPqhgwgcAGCyqGSIb3DQEJEAILMYGwoIGtMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UE
CBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01P
RE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRp
b24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAPDFZkXqOtF5hVzRe0fPqhgwDQYJKoZIhvcNAQEB
BQAEggEAP2pWxO5DU1o68rBGh8/3mo1GhuS89OdH1T1l0TzGbMsV8rZbTkGZ7W94X19gMxsJ
/T8JzaA2zYH+YHePaP5pg1dwscea8rDzqJR9jmf+nIbevezghlW2x6rZ/P53kx4QPv/8cbwB
7v4DZBn7RxFlpMYRBK0gPBCNmZVJuozGm9DaK/iBxXVpm0hiTVRNh8EXESxQj65U+0TA1emU
1b6WBdmq3vo50X3G5ywwounuWvWp4SWdS2UOEhdkBjUXaYF7UUoQD8yClPY7GuRJtCUfWclT
nR+MraV2AgdMkp99Jqf275xEIsTvGi9Kn8JhCrMziyuio6Q9fFXe1CgDZTfeoQAAAAAAAA==
--------------ms040108080706030403070304--
