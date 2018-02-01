Return-Path: <maxg@mellanox.com>
X-Cyrus-Session-Id: sloti22d1t05-3577380-1517487713-2-15134725181997677467
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H5 -1,
  RCVD_IN_MSPIKE_WL -0.01, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='40.107.2.70', Host='mail-eopbgr20070.outbound.protection.outlook.com',
  Country='AT', FromHeader='com', MailFrom='com',
  XOriginatingCountry='UNK'
X-Spam-charsets: plain='windows-1255'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: maxg@mellanox.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517487712; b=D81ijgH7pNZy6seLrIUyPwfrVY/Wuou5uFIciMlvYwemy70
    kmN2nq4TieR2EYnU+5UpRka3QFmJ0hwQzaws1jhXKh4evu/M9pa6VAJ6QfUeay3L
    iGwE1p0Fz60v6TNEKxrnd/S6+IKdN8AHuLULBLGE3VtyeKLmmojr/dOtjmmgfKw/
    q5tbQhsDz8vMoR1ymvoe/8rrbQAfOhtR99cfMPFyr5MwKKHtMYyuAZ6AAHArVJDL
    4TnCA3czc5pMB6avKy5n38Qcb1TSXp2g66Cg+wnxb8lP9ADyhvYgFLAwa78xNFLa
    oEQQJrBsFBp8UQQumq1WiRBXdVVFAQ6JEX5AfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding; s=arctest; t=1517487712; bh=fYWhmDZu
    987zoIK6IJUxdWlt5jMBz51BFyBS3HZjSI8=; b=stMvF+H7+Ode9Rz7gZK9hmWb
    sLJm+RI7s/zrq61oytkWYa5NlSKG5DR/hijDF//dOu8TCp4RMgEW5AqqpEKudqAr
    fz+aCQWZK5qNPH39zT5JI2Qtvmjw6JwpXiUPBpXGg+lLpEJkP/owPP56xiSZM1ax
    ffwYErUvzBzAzdEfbByuwm2aNQB8riLrJYJX4h1kFjG4U8r3pv2VnN+VevGvlfdg
    QM72bFNRHh5FJ85yPTZPZ7oRnTXUyPEHjgV9WCI2bT8KVcL3D2iDy/4zCCJ9Dz3j
    EPi1rAwTxcSVQ9YZ2X8+S9g5TwJLz2DeLR6f6WwUwXUuCQyI35uvqmJN4iJSkQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=mellanox.com header.i=@mellanox.com header.b=L8hGQ9Jq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,d=none) header.from=mellanox.com;
    iprev=pass policy.iprev=40.107.2.70 (mail-eopbgr20070.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=maxg@mellanox.com smtp.helo=EUR02-VE1-obe.outbound.protection.outlook.com;
    x-aligned-from=pass;
    x-ptr=fail x-ptr-helo=EUR02-VE1-obe.outbound.protection.outlook.com x-ptr-lookup=mail-eopbgr20070.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=mellanox.com smtp.result=pass smtp_is_org_domain=yes header.domain=mellanox.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=mellanox.com header.i=@mellanox.com header.b=L8hGQ9Jq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,d=none) header.from=mellanox.com;
    iprev=pass policy.iprev=40.107.2.70 (mail-eopbgr20070.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=maxg@mellanox.com smtp.helo=EUR02-VE1-obe.outbound.protection.outlook.com;
    x-aligned-from=pass;
    x-ptr=fail x-ptr-helo=EUR02-VE1-obe.outbound.protection.outlook.com x-ptr-lookup=mail-eopbgr20070.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=mellanox.com smtp.result=pass smtp_is_org_domain=yes header.domain=mellanox.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=mellanox.com;
Subject: Re: Backport Mellanox mlx5 patches to stable 4.9.y
To: Greg KH <greg@kroah.com>, Marta Rybczynska <mrybczyn@kalray.eu>
CC: <matanb@mellanox.com>, <leonro@mellanox.com>, <saeedm@mellanox.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sean.hefty@intel.com>,
	<hal.rosenstock@gmail.com>, <stable@vger.kernel.org>
References: <622645763.11304810.1517303571694.JavaMail.zimbra@kalray.eu>
 <20180201082116.GG15896@kroah.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <014aa659-a169-aae8-8923-aba3cac8822b@mellanox.com>
Date: Thu, 1 Feb 2018 14:21:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180201082116.GG15896@kroah.com>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Content-Language: he
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.223.3.143]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39380400002)(39860400002)(2980300002)(438002)(189003)(199004)(31696002)(76176011)(39060400002)(50466002)(2950100002)(336011)(83506002)(47776003)(229853002)(86362001)(67846002)(16526019)(106002)(31686004)(230700001)(58126008)(110136005)(356003)(316002)(54906003)(77096007)(186003)(16576012)(65826007)(5660300001)(7736002)(65806001)(64126003)(65956001)(2906002)(478600001)(81156014)(4326008)(305945005)(106466001)(81166006)(6246003)(966005)(6116002)(6306002)(36756003)(8676002)(26005)(53546011)(3846002)(8936002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3259;H:mtlcas13.mtl.com;FPR:;SPF:Pass;PTR:mail13.mellanox.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT043;1:2U1PGBhaTf6Y1vC2rD+e3HYpDamG65+UPQqTwfvbTpl9mu2Pnkl6GV9HU5U7XKwpfZZSvzoTz5PHwdmlLChq/IcJt/+ThAN0Nem6Z5rOFmt4+czJrCDUhnWhZrZ+T+Sv
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 328f9434-2afb-4657-f788-08d5696e5c73
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060)(7193020);SRVR:HE1PR05MB3259;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3259;3:tStQNq2eNvU7fWCGdd4WMkAa5/gH/MwMpNd2ocdNGfKwm1E/1pn0763j4Mf11Fjn3fiomZTwvSWUBSi/n5JKocJwSIiSPxIvb7F/6DKOEhH7fil3dW+UA154XgZm+ODnqEccOku5Z47GAglgcLNepFWan/t7msWjTc1BVZaC4Mhsewy20UlXEHowxgriHGxZP84SrKwoMmS1S6Ey95Gk3+K2tVpzET13dJ3kU8ovAOXp+f188f7dWccqa7GlcBCJCts/DNd81YO4/Z4nAzfTlzbuCFNjlhbnlCtXDJ5wHXxSLmeE6bNz+EMeBpYU7WrlwtnircJdUTlxPxa6KuhtX6X6Z2MhzWt6Plo7APlxl6w=;25:DzuF0sCZVU4vs2inkI7sm89gLAOUTqxI/OJNDK9N/IRh2TUYeDi5SQOoeVuiCPIzJtYFSnSpAEGwTSUhziP1SoLJBNhRxxJXx7pgwOCryZ8XH78YqUhHTMHuDzTZvkQ4O1AEtL+pMmctqzKzb/266hVRrqrnwJlPh598HGSN5+c7nUc7Gi3LQ8T4nGtiMwX38VW/wEdu7fTsH3tRdb/2CRpV9WuDX3yl+x/HKv334jMG3HjxUIZ4OAAJZ//3hhXAQT9fSeBNjAQGSGsm9OUmW/2BFDcuiWh3/v62NsrH1+GQQQDHS9rkRMibRRL5Y9lUGHiv4EPqnHHY85gPAsfPGA==
X-MS-TrafficTypeDiagnostic: HE1PR05MB3259:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3259;31:50N6V3ZOBmMQStAck3YTVi4XkVy5cwxTVyKsvtwD7ALwdKJM2/ApbW2bdGITzr2+cZWHuM7M4ekrvSF3L/0/6dAQ6GdSxOuDf7fYTbYWwZGpPkLnT0LSZYuTfxdVWS6QQytDvEliZl7GrVP/Ixp6+KRzKgxVvMtMhdgbiEeeJzS7SfWuIVkthzTRAlnn1xYrMKaW3itfCAcJasdsYajsMD1YdypLHcOomGhLquxZEnM=;20:NuNiprA6b4VlLoa50N9xYXSu2GGBx7x9LJ7tEyYMslO0hJFIf8nHHiH5nMgG2r0X36Psw32N4P5z5gtAAB4Y1YRhfj1jmv8y2aX6zl4ASBudWCYiMxQvYKsndblqy9VoLgUsfzPokB4SvWgMf1eCLbdZRJpeYQfdcFOyL6k+hORopbhRC0cqAhmu1L5mHMF//5dnZZYr0VwBQdV/wnPeOehLGXzYWH5jv6tdEl25+/sGzzLezwgojfBBeqHDRMPcZVziMkutZb+bDoRxKo8IfHmFN3647/FtFhKsNAIZBEs/1phQEPq3rwmvKQ5NdbLusBwMrwc824DtAv77P5hWnDj21layW4v1ulBRhU0Kw09SIxdXv8vz5+rIqRmXuerDVyFEp5V0rDUy9ByocU4FuFH/pYDAmcop6xpeoaA2bruIwvZIuBEC8fR65dwyEgZ5rJg20mh8pQM2ipt++htiHz4MvGWdSzG9Y7NGtQjJwHSNMW5OpsHfCzCvEu669UJ1
X-Microsoft-Antispam-PRVS: <HE1PR05MB325969CBFF43FB85DF0F3545B6FA0@HE1PR05MB3259.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231101)(2400082)(944501161)(93006095)(93004095)(6055026)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR05MB3259;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB3259;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3259;4:q6cGNrDmO00Jiby83vweNBTUGEWJcqM5ZXg0nGa3KrPPLX8NpYcNVsiVXKivwrJ7adIYM8YwP83kdKEeLa6zw1PpZVX5vs4EC/iHIfxIWuCuP0PmGGmMupPc52ch56y/9DaHcUka89PJEMRFQcChZirXTt0HkkNWq0Jd6/YdHuRqRaXwtgKwrqZRC1ATWOz1RhYujtB+exh4bcukqxV1nEE7sWQ8XcO/35eIIW/lZDMJsVd9iK768BMfEUkAt1OUyv74YlojAsUrhslTd2IhMW6SP3dreW3VvRfHrRl2Bs/ibq3Wbvbq7UPIegTXqFks
X-Forefront-PRVS: 0570F1F193
X-Microsoft-Exchange-Diagnostics: =?windows-1255?Q?1;HE1PR05MB3259;23:On3zRQQyZdwhylUsvDoz3dyurJdYVWRNtuQyl?=
 =?windows-1255?Q?d0VcA+2RtwAcDh5KXS1otGuo5CtQaTBFenisHCy4fEmIiDnz3h3jfMfm?=
 =?windows-1255?Q?5Nn4viIDtcRgIRrZMlDMxNuoN7N7UOgWVuyxirrOLe4hEJ4INpPjuTQd?=
 =?windows-1255?Q?eatw6d04o+HYBhLDr8UQckZNys3fJzbSF6o/wpe7tZdCWUd9T86ZhWbT?=
 =?windows-1255?Q?O0F6nxoGB/okfs1inGG2yzz9cPzRpbktRdFJyA/rTuyRBxaj+xrtYnzg?=
 =?windows-1255?Q?qEIy9fYijizrq7EvbZA8t0RfxIBcwXe1yXsEhQrg7BN0NIVsFg8X0p4p?=
 =?windows-1255?Q?NtaTXZmMx37IKpoZ5BItPF2RUERNholrr8KItBU4jSyFPsu3VCeRrD/N?=
 =?windows-1255?Q?0qlJ4/oyqKMfqXO5HiVwMILhtcQL2tjSH6aaiK0HEScQQTYE/BWzAlCd?=
 =?windows-1255?Q?yIq3W6ye4+9HlQGtpOhgbemYvB25CiR1EtSuOjaoCFvWbmKeUOGCEjqh?=
 =?windows-1255?Q?T1H0fabyGMkflWPKpYcMGvh+HZaTYemJ0SCEVud1kA9jSoEdo9V4Jhx8?=
 =?windows-1255?Q?8FbzibieuU4ZuJTPsIZvl4lG4ews9nO41ulyOB6wb7RP04ogp06YNkYV?=
 =?windows-1255?Q?XllY2Xt55UDBpiRiiOhjEZEILXUhbB5eH9xASLCV2UZdItxFSH9PNC37?=
 =?windows-1255?Q?o92wLpNPlwKIFJ0fh6izm8RGh0CKe/syimMVGFYOeVLR+J2atWMqtRSM?=
 =?windows-1255?Q?sFXZ2LhJPUOGBJI6WUtu/pXFQcerQ2u5mQEHUcnbqv1oYVDVd/Bz8Wl2?=
 =?windows-1255?Q?wHX0vNqF0dLiCvrU8f+IcY1GbQEXpP7tgVRJyPy1vVEy9N6+B9GBhPAV?=
 =?windows-1255?Q?E0TcpcWDZCcNb6+cC2LXNRWtrF6hWugEqsHVg1ptWQUdZDxacIg9ST/I?=
 =?windows-1255?Q?GDhZAHo1agVan57TedanMP6MsS2nHLVPDjAJEVBFundkPyUr1oXRiVaW?=
 =?windows-1255?Q?YDne1FfJYNAPbx+S5NfePxMwwzc8Csyyn1GBcIXFVb9suzeV3S28Rwf5?=
 =?windows-1255?Q?nmrRbskyiRFRz1j4wFoeUNNsgtwaP2KP3vAKy/Sta9ivhsvVdtGFzSbQ?=
 =?windows-1255?Q?X0zEucD9W05AiCU3UDvyEJoCjcw2yqMdoiAB8JSfMY+YgYAs6BUrzuAj?=
 =?windows-1255?Q?aDtNHCbO7JkjbltiIDSXCtqvMi0z9ldzhejcXmKd8hZknLNyLQ5zv8tR?=
 =?windows-1255?Q?cnJiROkat3sYtJt7ON6v6vwvyVOnw73luAePlK8RQBj4CJIG8QI4c1a2?=
 =?windows-1255?Q?knuIaYCjgjtn2bOoUF9Wr7krGajAN2Fl3a4lB+M2K+r3l9GKsiHNQAme?=
 =?windows-1255?Q?i5IfNGcQ5x4?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3259;6:085loKHDRvFkZIhry8xTGeXHPS7Kv56tW98Ob5aDsSrIGMZwshuPnTfwUQ2BLoIjLzRIcgx17MvmXE0VzvJrSKqueYVkuSbItN/3TWDeGbPeNJyjKul8V+8Jv41LSuYtB44bt+HZo1bfjJ/oHekLwHbzXrPHCyWB5IXWMM9uK1vs7W8xpnCTuqQNZ76j1P3dInh4Z5eVIx2AoXOu/GfTbshf6Vl2X7Rh21tm6INXYE1Zmwh50cLVjJMa65B2olUd16EP8Y/yBAv2iwMuBFK7y9Rp1d6OhhrrRWBenq2vGHFCdvIWygg+IyGxtyTOwB/eZgKoX1uS3P7/6RID5IwvbIZ7sn/AT5sgEesDHoVplFA=;5:7lQW02hmw4+DW3/AwhBk56IGDqZAu13n9/xs8NeKcN+s0tc+Bb6qp47w91XWjZ3NpJ5oSIobyyn9EkVTVGnrUYdpb+dm2cA6j0V4LO+93XfBGkPpEObImINmkJXkldmN3azd/G/eG9k1ydyMrPIMWyrhUDcOd5rXeAIie9M02+c=;24:TCP0QgMutsHwvbF/GxDH8nZNC4HCJxJvodyHFGKCEoRryuQ2NuwBEhzVXOHA5B80a6Hy/Z/3FUGPYIls4bAOQkcKV/ulHN+Swyi8xfKa+D8=;7:9Z2YDak+J/12IyrlyH3dbV6lWcD+4YC5lARTjrvCdpJr17Ko7yEkPGUhEdiwSErTETJjyS5LY/DfxCdqeN78Uv/UZOfSqIX4thxV4a/rQXCCN0FSrnChSYWrDEGCje5ad9Wjmjg7CpanAd7kjY6kQ7L3dS6VihQOkJTqtaUsOKPB0PNOjA+cF8KtLdEnzAV6WasxdRLIhm40HR+hUzuLb2v9grtWvXCgY38psC6LpgYyU+p1Y2pZ+Q4dY0VOF/zX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 12:21:45.7466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 328f9434-2afb-4657-f788-08d5696e5c73
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3259
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2/1/2018 10:21 AM, Greg KH wrote:
> On Tue, Jan 30, 2018 at 10:12:51AM +0100, Marta Rybczynska wrote:
>> Hello Mellanox maintainers,
>> I'd like to ask you to OK backporting two patches in mlx5 driver to 4.9 stable
>> tree (they're in master for some time already).
>>
>> We have multiple deployment in 4.9 that are running into the bug fixed by those
>> patches. We're deploying patched kernels and the issue disappears.
>>
>> The patches are:
>> 1410a90ae449061b7e1ae19d275148f36948801b net/mlx5: Define interface bits for fencing UMR wqe
>> 6e8484c5cf07c7ee632587e98c1a12d319dacb7c RDMA/mlx5: set UMR wqe fence according to HCA cap
> 
> Looks good, now queued up, thanks.

thanks Greg.

> 
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
