Return-Path: <kernel-hardening-return-12975-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+i7nhhDACREpddxcfbE3J4Sb+j9oDl3kbS58wBn7j2VNRvDu5RcqSaWCx7notm7GAsjs0E
ARC-Seal: i=1; a=rsa-sha256; t=1523460693; cv=none;
        d=google.com; s=arc-20160816;
        b=myAFX05X0BDIC4E1iZ0t5JmoJNjfujnx6mYXFbQCfiTd1YzZjRegj3/nKTVPH86oSV
         UhwTKc5h+izUQEvUswU3fDR3fswjTbJLjjBI+NSISs+S1k51Sj6bSYXkSXw/oeI3O3kD
         XhLUzdLeZlQJo1wNHXhLvklamJxLIDSKtIpuJxkmh13aCPgbPHZeQrGzBLe0rxy972yU
         1RJGiD3swJyl1vwDk7HnztPOGy5mO1S4YqoS26+8u921yumxi5idh0USUhLaPcwuFc5t
         BcKO3fIR7ksWrtDkZe/MvJMb5ZOsKq0xKlqNw2T9XfBbWG+UtfVsc85vZ1z1BCM4zvw3
         7lSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:organization:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=ZqWLmX7KJOWYFIw/L7so1ViL01KEktdU012fPLLF2yc=;
        b=wMHUT8L6sDqy1o1qwL45x7w8myXNg89Ue6MGNI0YdaYQNjZLh3gjF1bPO20ccgfmw7
         3Vit3gHn2ocaEB00QPoYcyRlsCubtuR6086zPekPSmgLXIIhUasJ12vRm8R0dfyz4riY
         chyAQAtVpajqHmJNU1ufsVSC06ETsEVyvhXERVZ98G/xbD0w8sTZcdo+ZJHvGgEr6x71
         AOxI/TD73AOvWNAbUnh5vMnsw/e0UshTmV0sZkksurfyPFKwsaUVUFUa9WiCbSFd+qnO
         aMmCrpGDPu24uvUMq8eiQlPSRiwwK3P2OrNSnML9PaTY1Jjp0B4k34VWp2RR9K8qDn/s
         8r/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=vUqWU+T+;
       spf=pass (google.com: domain of kernel-hardening-return-12975-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12975-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=vUqWU+T+;
       spf=pass (google.com: domain of kernel-hardening-return-12975-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12975-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com;
Subject: Re: [PATCHv2] drm/amdkfd: Remove vla
To: Laura Abbott <labbott@redhat.com>, Oded Gabbay <oded.gabbay@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com, Kees Cook <keescook@chromium.org>
References: <20180411010243.17771-1-labbott@redhat.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <e71e9512-d4cf-9aa2-fef2-075833fc8e40@amd.com>
Date: Wed, 11 Apr 2018 11:31:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411010243.17771-1-labbott@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::26) To BN6PR12MB1700.namprd12.prod.outlook.com
 (2603:10b6:404:106::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1700;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1700;3:3IVgYoqjnxTw8dqAJWNWB2d/sWWU++584mT5ewpP24lCDx0goWVsl+4yzGAdaLe6aOo32L9r+h/B0NeWmnQ7BvgAwvl5h/8fA/Hz19rV/8pkca1yPK3NCXdBit/UobtE+LgYmrCLNY5vopO5m14yLrTk1CJLxCB641tbBCH0lNwXMPe2Mih1vXUx9Ez/BLGX0aFhAn5MfWKNdlyUdfKYqjL/zaJaKzbqFfqx1SLurFiyuzEdrvd+ZsWby3eY5JO3;25:nW04CIjMff2g9698VyeFyU9ex3OqsPcxlct+cjslE8Qorynx7npI7qp6NctKsnfQ7i9b7qDJI+H1ap4CjhxuAoboiQ5w640S2wI8xEsk6WYC5GculAshO6zBjU/xIlNJpPL1fWJ9+YhoBH495opehU22cYoRXi65mXpGrdRWASMJVvo8lLuuPCB953Qb7VAebUcGx0yBXnlgzpi6AgHDdAD7d2UsNcRsJvYM42PPQ7puEdaGy8SCcGK04EKkwAyVO+YiP1NkQrfEHDAANSYJ1jSYLrtrYCQAaYYoTvk7O36HxxiK6yrA10b2Ksy4LFYzYfWRgUaPYDjC4S3u5yqWCQ==;31:jHaa92a782G6+/3VzILvNlEScFwBfeXPROJcoWZhiYUQLSG1bKm9p8SdGMYPvxJrXEK86Z8b7tGAatdvxOI/1O/+N/4veSHuELTl4tm/Puxclze17WeOWBvuynsY60rYML7G9YxLuX5PL6sLLOO+dRnmLGq2+s5jewamG/zgunTFjxFCWxHzbjOkUZOf3XoFXAJU8VwjMTWPLWQiU3rHABnTU/MCVNDSHfDO/qq5w34=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1700:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1700;20:YF5M9E3T1WxFhjlf+RB/zMJPY+hLNE+vpz8HhOKaYOEnqDBJWRAfa3Nv0jEd5QmIUvb7R9MK16VWjT0WLE61DEI9WuoqC7Rkyt4FmKda64pjOSK8zlZEGFbCjgQ9YL18R0niYoBHJL/83RMJyTMb+rP1LnXyzyCDfcEW4LdKZy3CD+nsLAcCHaFDcdQ/QyP0Fd1nsQTk4cCa8fQSCvvfxGRCewJrgicOR7XTwKHCxyRqe4Z41murQgBKdsH3mav8GfnmU6l/immfphnJ5guVQci0cL/XdHl29WRvSu9oFvkoLqjemWkqVk7RynCV/wcvFN7t14Jd8+/j6/cGpS/kEj+jtMqzu8CT28wQzDdOxJ4iD9xy/HfSd860nPAhVzGsqWpKH0/TAwS6lUxjD9wv1bI5vHYNLGFYFjt0pxg1MzwUlmKzj8pGqvAiPrtk/uvsca1Outv34BbZa+GpvjHQ3amDfgytuTN4uruKvzX0P91PqJzFG93bc9iRWvqUO2EP;4:BI+Ht8fAL5LKaIV3yVxEsuDRLbgscgSjJ7Zm79Wk9zdkFEJr2wnYHtdLeSNVwceAsPEPGm/RGmpoDHPhmI5bdy3xd94wAlRlnmNNnymUTKFXSqtjXPoPBs8B+S6A9C03AUmrjhhDRCS59PennqZCd8cbBjTx/lD9tThJ2xaM9axmQ3REupxXwH0TwSIcuWQ6GBfhsrIIlkvTbHK4TL51uvU5hmQvIaIbC/ab2Dn0nqVxtOfXORmqZ/yPpQN9cMSecjiDbFys9/9Dz7tm8SDCRjojDvL5BAuuqvdlM01zFUUJ2PqT9QbcAJvQWOhHe93W6uWD9FuJcgna5rmxTK2e2w==
X-Microsoft-Antispam-PRVS: <BN6PR12MB17008EB4DAC6EB39021C47F692BD0@BN6PR12MB1700.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(15185016700835)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1700;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1700;
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(396003)(39380400002)(366004)(376002)(39860400002)(199004)(189003)(377424004)(105586002)(66066001)(65956001)(39060400002)(6306002)(106356001)(53936002)(229853002)(4326008)(25786009)(52116002)(23676004)(2486003)(11346002)(2616005)(76176011)(52146003)(68736007)(47776003)(956004)(53546011)(26005)(97736004)(31686004)(6246003)(446003)(59450400001)(486006)(476003)(386003)(86362001)(65806001)(31696002)(36916002)(16576012)(36756003)(7736002)(81166006)(8936002)(54906003)(50466002)(81156014)(8676002)(305945005)(186003)(5660300001)(72206003)(58126008)(110136005)(65826007)(16526019)(77096007)(316002)(478600001)(966005)(64126003)(2906002)(2870700001)(6116002)(6486002)(6666003)(3846002)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1700;H:[172.27.225.16];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzAwOzIzOnNremtSRU5lNFNlU21zbE8xbGFuYzhPRXVs?=
 =?utf-8?B?bjlDaGhmejV0czNybFZGQ0dEQ1hpN2ZEeVB4bXIxTFlIRjhYMUl4Z2FhTnVv?=
 =?utf-8?B?V1cxVnhGeVpxeWVFTU9FbWJJeHp2VXpOcysyTHNIVHcrL2RUS2Q2Q281TDZp?=
 =?utf-8?B?bTdDbXdJTEYrNGlidGVXMHJGdnIwRTFzNUhWbmRwd3hzd1FLbnk4ZE5ISW5m?=
 =?utf-8?B?QXg2YXhyMXF5Y1ZzY2RpZ1M2SGtLZjBoU3BuVDR3QlNaTnBmTXFWNFhhWGUw?=
 =?utf-8?B?NlBTT1NkOGRLZHEzVUhQRGhjYmExdTF2ekllcUpSZkdkTWtSUG4rNWorZUpJ?=
 =?utf-8?B?TDBIU2VYa0wzaDZGbE0wYUQxeHd5S2c3akJzTWsxa1dWbTVadWNEZ2hqRUM1?=
 =?utf-8?B?bVNWNkM5dFF0WE1DYUcvaTZ5VUgvZzkrNXlNTDRnM1JMcVB3M2ZiVWt0Vmky?=
 =?utf-8?B?TjY5Ym5HVTQ3NnYvU1RHZkNIcjExS2dqdy96ZnhsWTdQUnpHUVJsR05odEdP?=
 =?utf-8?B?dm4ydmtsY0FVTFVyRldRTU9kSitYc3ZrUnFGUzduY0VxMDlTN0QzWGN6U3dK?=
 =?utf-8?B?dG51YjVsa3pDVmhHUEg1TVJ3bGYwQ2xhcEpFUlArZEl5Nm1hWWx2TDgzZlM2?=
 =?utf-8?B?MzZ3bzJINWkwbDlSdjZOaUZmWE5pWkJMNXgySVJiV3c0NjFjWG11MGxxL3pn?=
 =?utf-8?B?WmQvbm1rVzhZc2ZuR0x5ZnlSUklUakhic2QvdDRtQ01aTERJTlVZYzFYbFZT?=
 =?utf-8?B?S3hlZ0I4KzNsekdkWDFCYTcrT1NSN1UvaFBOYVE3S1VabG9TYmo3WE53dkJ6?=
 =?utf-8?B?Ti9jZU45MHpSa0NuOEJLVnF2VkFyRC9ZRjBrMVp0VkNSbko0RWNhblI4MGV2?=
 =?utf-8?B?WWRWT2VITld4Q1pRMUR4T2Fic3RodXNaanlwa0Q0QnZUd0l4L09HU3JpZUNh?=
 =?utf-8?B?LzEvWmRLY0w0eDZnazRHVzhoekNrVTZxdHduN2hYYklxQm1yQWcvL0RESDZp?=
 =?utf-8?B?TWRkNVg5djZ4THN4cjJZcGZVc2l0VDNrNjdnb2h3MUlSRTJwQzhoaGZ3eVRn?=
 =?utf-8?B?L1oyeE5rNjhOVHBTREFUSkt2UGM4NENBR3dFREZ1RDZiSTFma0xkRDM2c1Bv?=
 =?utf-8?B?eGI0L2JBYUFoeVBHY3pNSE5rbmNXMFBobXZMbDJHczRSRlFUbnZTM2w0RE5W?=
 =?utf-8?B?cldPa3NmZ2ZhT2ZzZ1doMUdxc2RmNlYyUS9tS2I0SDdBQlU1NHRtZk1ENlJv?=
 =?utf-8?B?T09qWHBXU1Q1elZFOW5KRG5rdDR4SDE3S09vZVhLMG9BTUtjaEsza2lKYzZH?=
 =?utf-8?B?TTRaYUhTcWhYZHV5V3I4dmlWZmhia2Nhc2lIbktqSUZxMStLZmlqOThGSmJx?=
 =?utf-8?B?SDU3OW1yRmhDN2dHZjdHN00xQnpvQ2ZPWDVPaG92MGFaMnVEa0lya1NYcTMw?=
 =?utf-8?B?UVF4MjRjYlBMbW4wSXprZ0hkNUxYN2JtTWJJaUJGT3M2TmVILzNoUjFadU5m?=
 =?utf-8?B?WllsL0hRZDFyMGk2aU04bmEvcW81K0J2bDVoaURxR0VFN2tVMUl2dVpTSjhU?=
 =?utf-8?B?OTRSMHhQVk1uUFMyVGVOZ3cwUExPTXNvUjR5cnRha1I5YzJHVUFyUkhCenRu?=
 =?utf-8?B?T2UyVS9LUXROTTRQcVpIYXY3Znc4TDRTRDVGZHd4Wmp0VXdpVEdyLzZvTHBy?=
 =?utf-8?B?SS82bnhJV3lmSkFqVFhkWWhad2VLR3o1ODIrYXUvcHNqbHR3QTkvMFlSendW?=
 =?utf-8?B?TzlFZ2xIaG8zNm9WZC81Qk5KV1AzQURaUHZmcjlMVzA2T3lJQmxSdzRWMkhH?=
 =?utf-8?B?K3FLak5ITHdud25PeGVjTVNFZ0ZMcUx0U253M1pDWXk3bUR1WHdxejFOWGh3?=
 =?utf-8?B?OFhjQ1lNSzc4ZVlZUDArYVc3NUNqZzltOVQwaXRSeTRobW9xOXltUWpER3RH?=
 =?utf-8?B?QzNHU3R2aEd1dm9ZbEFpUkFFVkZUenk0MUFhZVNtSWhnM1NQWXNObnRMcFdY?=
 =?utf-8?B?bW9Ha2V6cm40czlNRlZOd2VqWitOd3dBSm1zdDRIVEduNmFxNmFhc1NKVkx0?=
 =?utf-8?B?ek9vcXY1YVlDc0prVW5tbW5POEpsR0xBVUgxeVJLUFNmWlpySVpxS0NtSStu?=
 =?utf-8?B?ampIWHR5dDNvWW5xU2VwMGRsbFBNblFIQW55dWZjcGgwRUUxVHpGeDBqZ1VY?=
 =?utf-8?B?ekpFQTRFRGpIZU1ML0t2aWZRbXFnPT0=?=
X-Microsoft-Antispam-Message-Info: T84oN1n+/2qHsF3pgYmmCtlLsTZi5S1wfTjmZRlCimbgrxoNW2wmGRxTFNz49ApECSqD8yoaYIAJ9KKJFBltkg5GDBm0z/yh8Hmsvf4VmfbPFh8FpxKnigyUwDHFMo54R77Sg+Q465EHGqSxpGPgZ2uQi8s+p4DSKfxfC3WQhRpaqysHU+wKtL0OP9+MANHI
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1700;6:HSi1DZDXq+aJ71yToY7G+fP9yk+xPHESbIQejapA3/lb+fnUHNiEtUSM4TnbIf69gujnWHKrPo3R87hawjHZ0RRSyhksR5FSUnYANC8JtQKRDIiTCBymuJoRg/A2FER2N22QQsIb9dcJbCxylUbUoXvBMVpnigvgYPHCnmsBrz50qIXUCvYd5501P1DuLXamKkrd7lY216yNGbn7vN+GRyPGcIEPTxok8hrX/Bi/wZakserzUSrDehQZM0vL+fDr69pGqlwe3Qe+N/QAFyl8Rh9PzLyoy3WaIqXsphmTtABOKvfi2rBNNhAeGe7Ixwbq11/koOFs87Rinm1W66LxZMlJbWJ+ZBq5VGJYiLbazS5bP6C+foePDBsRJmloX+Bv9FrXevM3jvQ8E7R2ApMdvSzhoKp8pq9EPh54+vXXBFBTGokYrprWWXZyGbFLXBipCsQFjsDkwKG+TLb24T0XSQ==;5:MfOBzYCIRC/xqkVpygf+Tg/qZAGqlYQWDD97V1yGiOicbyNaJZWzF6ibD7zNrxuvS1p3S31+tyYZph+PEXv+M1Hd1SLxmwvLmgM6/VvrUn3LboeGD6b+BY7znEsZP62/gmLCnF+EVLQAPseZ7SNWxQD/auIcDQf2zKi5MCWdHmw=;24:QiPpzEVhmxpHpezyR/mxsHZqJQxfdyuEITxZ1OdrPsnskx8hgjoqWulr7ix2+G220790kpl/Mnw1kbpjaC1rxJJZFKqTQavCG1OmwSuRtHc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1700;7:MZrlf4pB5+Drk029vC5V23Iu6Kg3HuuAMOANT1553CxtKfRwxr9WIgn4N+n2O9AxibM6DsrwHGuWuKEGe2Yje3AxCVWwRdu2Ymq1B9Sa3FXSQrL7KaTR5KZVzBGnQpRzYk44g3T9IGWgcWFM0zziRRuBJUSuwMptzMtWJPij0lNmmAFYiPz2LN7kN34mxL8G2zmxgOEMjBnLSzX6VfnNSUGp0N2G2W+AmFPuysRirNF9CX8qPbJDgn1Z9Un0KU9t;20:a8ilHJegorPaA4LhJl2trOyY4MWZzWAa1HxRB1LyPbDE9EUvBonkCgEO8GuTYwQWrGQ1aPHtrZ5ABrXMsIlyIuGa9DhJuhP5QBKkb1DHXNgUBh+e5awffkC3DguRJBgbXXWAYh3ZXNklQ+gHA0reSTZNQnTeiETAOXNrpsFCC4CaxeQqzc1b+y8VZWCf/xABCWOi4XxZWHpVDZb43aoPxN3Q0vk+wvq4J4+XZQWa7eQTKuiPFnbi0yDGvZVxGkn2
X-MS-Office365-Filtering-Correlation-Id: 6136a045-3f04-4db5-ded3-08d59fc1424a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 15:31:12.3125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6136a045-3f04-4db5-ded3-08d59fc1424a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1700
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304222291643357?=
X-GMAIL-MSGID: =?utf-8?q?1597464320424710587?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-10 09:02 PM, Laura Abbott wrote:
> There's an ongoing effort to remove VLAs[1] from the kernel to eventually
> turn on -Wvla. Switch to a constant value that covers all hardware.
>
> [1] https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v2: Switch to a larger size to account for other hardware
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> index 035c351f47c5..c3a5a80e31ae 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> @@ -139,10 +139,12 @@ static void interrupt_wq(struct work_struct *work)
>  {
>  	struct kfd_dev *dev = container_of(work, struct kfd_dev,
>  						interrupt_work);
> +	uint32_t ih_ring_entry[8];
>  
> -	uint32_t ih_ring_entry[DIV_ROUND_UP(
> -				dev->device_info->ih_ring_entry_size,
> -				sizeof(uint32_t))];
> +	if (dev->device_info->ih_ring_entry_size > (8 * sizeof(uint32_t))) {
> +		dev_err(kfd_chardev(), "Ring entry too small\n");

When the ring entry size really is too small, this will potentially
flood the kernel log. Maybe a WARN_ONCE would be more helpful. With that
fixed, this patch is Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Regards,
  Felix

> +		return;
> +	}
>  
>  	while (dequeue_ih_ring_entry(dev, ih_ring_entry))
>  		dev->device_info->event_interrupt_class->interrupt_wq(dev,
